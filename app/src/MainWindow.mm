#include "MainWindow.hh"

@implementation MainWindow
- (id)initWithContentRect:(NSRect)rect {
    self = [super initWithContentRect:rect
                            styleMask:(NSWindowStyleMaskTitled |
                                       NSWindowStyleMaskResizable)
                              backing:NSBackingStoreBuffered
                                defer:NO];
    if (self) {
        // custom window setup here
    }
    return self;
}
@end