#include "ViewController.hh"
#include <AppKit/AppKit.h>
#include <AppKit/NSViewController.h>
#include <CoreGraphics/CGGeometry.h>
#include <Foundation/Foundation.h>

#include "SettingsCell.hh"
#include "SettingsDropdownCell.hh"

@implementation ViewController
- (id)init {
   self = [super init];
   return self;
}
- (void)viewDidLoad {
   [super viewDidLoad];

   [self setupPlist];
   NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:self.plistPath];

   self.settingsOptions = @[
      [[SettingsItem alloc] initWithTitle:@"Enabled" enabled:[dict[@"Enabled"] boolValue]],
   ];

   self.blurView = [[BlurView alloc] initWithFrame:self.view.bounds];
   self.blurView.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
   [self.view addSubview:self.blurView];

   self.headerView = [[SettingsHeaderView alloc] init];
   self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
   [self.view addSubview:self.headerView];

   // Create scroll view
   self.scrollView = [[NSScrollView alloc] init];
   self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
   self.scrollView.drawsBackground = NO;
   self.scrollView.backgroundColor = NSColor.clearColor;
   self.scrollView.contentView.drawsBackground = NO;
   self.scrollView.contentView.layer.backgroundColor = NSColor.clearColor.CGColor;
   self.scrollView.hasVerticalScroller = YES;

   // Create table view
   self.tableView = [[SettingsTableView alloc] initWithFrame:self.scrollView.bounds];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   self.tableView.headerView = nil;
   self.tableView.rowHeight = 42;
   self.tableView.style = NSTableViewStyleInset;
   self.tableView.backgroundColor = NSColor.clearColor;
   self.tableView.enclosingScrollView.drawsBackground = NO;
   self.tableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;

   // Add a column
   NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"SettingsColumn"];
   column.title = @"Settings Column Title";
   [self.tableView addTableColumn:column];

   self.scrollView.documentView = self.tableView;
   [self.view addSubview:self.scrollView];

   [self setupLayouts];
}

- (void)setupPlist {
   NSString *appName = @"EverestSettings";
   NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
   NSString *appSupportDir = [paths firstObject];
   NSString *appDir = [appSupportDir stringByAppendingPathComponent:appName];

   NSError *error = nil;
   [[NSFileManager defaultManager] createDirectoryAtPath:appDir
                           withIntermediateDirectories:YES
                                             attributes:nil
                                                   error:&error];

   self.plistPath = [appDir stringByAppendingPathComponent:@"settings.plist"];

   NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:self.plistPath];
   NSLog(@"%@", self.plistPath);
   if (!dict) {
      NSDictionary *dict = @{
         @"Enabled": @1,
         @"Animation": @0
      };
      [dict writeToFile:self.plistPath atomically:YES];
   }
}

- (void)setupLayouts {
   [NSLayoutConstraint activateConstraints:@[
      [self.headerView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
      [self.headerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
      [self.headerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
      [self.headerView.heightAnchor constraintEqualToConstant:200],

      [self.scrollView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
      [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
      [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
      [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
   ]];
}

- (void)addSubviews {
   [self.view addSubview:self.tableView];
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.settingsOptions.count + 1;
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
   if (row == self.settingsOptions.count) { // last row
      NSString *identifier = @"DropdownCell";
      SettingsDropdownCell *cell = [tableView makeViewWithIdentifier:identifier owner:self];
      if (!cell) {
         cell = [[SettingsDropdownCell alloc] initWithFrame:NSMakeRect(0, 0, tableView.bounds.size.width, 32)];
         cell.identifier = identifier;
      }

      NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:self.plistPath];
      NSInteger savedIndex = [dict[@"Animation"] integerValue];

      cell.titleLabel.stringValue = @"Animation";
      [cell.popUp removeAllItems];
      [cell.popUp addItemsWithTitles:@[@"None", @"Bounce", @"Bounce in place", @"Shrink"]];
      [cell.popUp selectItemAtIndex:savedIndex];
      [cell.popUp setTarget:self];
      [cell.popUp setAction:@selector(dropdownChanged:)];

      return cell;
   }
          
   SettingsCell *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
   
   if (!cell) {
      cell = [[SettingsCell alloc] initWithFrame:NSMakeRect(0, 0, tableView.bounds.size.width, 32)];
      cell.identifier = tableColumn.identifier;
   }
   
   cell.layer.backgroundColor = NSColor.clearColor.CGColor;
   cell.titleLabel.stringValue = self.settingsOptions[row].title;
   cell.toggle.state = self.settingsOptions[row].enabled;
   [cell.toggle setTarget:self];
   [cell.toggle setAction:@selector(cellToggled:)];
   
   return cell;
}

- (void)cellToggled:(NSSwitch *)sender {
   #pragma clang diagnostic ignored "-Wincompatible-pointer-types"
   SettingsCell *cell = sender.superview;
   #pragma clang diagnostic ignored "-Wformat"
   NSLog(@"Selected: %@ State: %d", cell.titleLabel.stringValue, sender.state);

   NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:self.plistPath];
   NSMutableDictionary *tmp = [dict mutableCopy];
   tmp[cell.titleLabel.stringValue] = @(sender.state);
   [tmp writeToFile:self.plistPath atomically:YES];
}

- (void)dropdownChanged:(NSPopUpButton *)sender {
   #pragma clang diagnostic ignored "-Wincompatible-pointer-types"
   SettingsCell *cell = sender.superview;
   NSLog(@"Selected: %@", sender.titleOfSelectedItem);

   NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:self.plistPath];
   NSMutableDictionary *tmp = [dict mutableCopy];
   tmp[cell.titleLabel.stringValue] = @(sender.indexOfSelectedItem);
   [tmp writeToFile:self.plistPath atomically:YES];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
   //  NSInteger selectedRow = self.tableView.selectedRow;
   //  if (selectedRow >= 0) {
   //      NSLog(@"Selected setting: %@", self.settingsOptions[selectedRow]);
   //  }
}

@end