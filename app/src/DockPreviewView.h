#import <AppKit/AppKit.h>

@interface DockPreviewView : NSView
// Called on press; return the currently selected animation index.
@property (nonatomic, copy) NSInteger (^animationProvider)(void);
@end