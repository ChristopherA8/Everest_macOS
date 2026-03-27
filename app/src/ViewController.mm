#include "ViewController.hh"
#include <AppKit/AppKit.h>
#include <AppKit/NSViewController.h>
#include <CoreGraphics/CGGeometry.h>

@implementation ViewController
-(id)init {
   self = [super init];
   return self;
}
-(void)viewDidLoad {
   [super viewDidLoad];

   self.blurView = [[BlurView alloc] initWithFrame:[self view].frame];
   self.blurView.translatesAutoresizingMaskIntoConstraints = NO;

   // Create a label (NSTextField)
   self.textField = [[NSTextField alloc] initWithFrame:[self view].frame];
   self.textField.translatesAutoresizingMaskIntoConstraints = NO;

   // Set the text
   self.textField.stringValue = @"Everest";

   // Make it look like a label (non-editable)
   self.textField.bezeled = NO;
   self.textField.drawsBackground = NO;
   self.textField.editable = NO;
   self.textField.selectable = NO;

   // Optional: text alignment
   self.textField.alignment = NSTextAlignmentCenter;

   // Optional: font & color
   self.textField.font = [NSFont systemFontOfSize:24 weight:NSFontWeightBold];
   self.textField.textColor = [NSColor labelColor];

   
   [self addSubviews];
   [self setupLayouts];

}

-(void)setupLayouts {
   [NSLayoutConstraint activateConstraints:@[
      [self.blurView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
      [self.blurView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
      [self.blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
      [self.blurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

      [self.textField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
      [self.textField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
      [self.textField.topAnchor constraintEqualToAnchor:self.view.topAnchor],
   ]];
}
-(void)addSubviews {
   [self.view addSubview:self.blurView];
   [self.view addSubview:self.textField];
}
@end