#include <AppKit/AppKit.h>
#include "DockPreviewView.h"

#include "SettingsHeaderView.hh"
#include "SettingsTableView.hh"
#include "SettingsItem.hh"

@interface ViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>
@property (nonatomic, strong) DockPreviewView *dockPreview;
@property (nonatomic, strong) NSTextField *previewLabel;
@property (retain) NSString *plistPath;
@property (retain) SettingsHeaderView *headerView;
@property (retain) SettingsTableView *tableView;
@property (strong) NSScrollView *scrollView;
@property (strong) NSArray<SettingsItem *> *settingsOptions;
-(id)init;
-(void)viewDidLoad;
@end