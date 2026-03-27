#import <AppKit/AppKit.h>

@interface SettingsItem : NSObject
@property (retain) NSString *title;
@property BOOL enabled;
- (id)initWithTitle:(NSString *)title enabled:(BOOL)enabled;
@end