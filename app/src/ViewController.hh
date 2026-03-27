#include <AppKit/AppKit.h>

#include "BlurView.hh"
#include "SettingsHeaderView.hh"
#include "SettingsTableView.hh"
#include "SettingsItem.hh"

@interface ViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>
@property (retain) BlurView *blurView;
@property (retain) NSString *plistPath;
@property (retain) SettingsHeaderView *headerView;
@property (retain) SettingsTableView *tableView;
@property (strong) NSScrollView *scrollView;
@property (strong) NSArray<SettingsItem *> *settingsOptions;
-(id)init;
-(void)viewDidLoad;
@end