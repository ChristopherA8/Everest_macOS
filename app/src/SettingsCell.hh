#include <AppKit/AppKit.h>

@interface SettingsCell : NSTableCellView
@property (strong) NSTextField *titleLabel;
@property (strong) NSSwitch *toggle;
@end