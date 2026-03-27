#include <AppKit/AppKit.h>

@interface SettingsDropdownCell : NSTableCellView
@property (strong) NSTextField *titleLabel;
@property (strong) NSPopUpButton *popUp;
@end