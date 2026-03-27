#include "MainWindow.hh"

@implementation MainWindow

- (id)initWithContentRect:(NSRect)rect {
    self = [super initWithContentRect:rect
                            styleMask:(NSWindowStyleMaskTitled |
                                       NSWindowStyleMaskResizable |
                                       NSWindowStyleMaskClosable)
                              backing:NSBackingStoreBuffered
                                defer:NO];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)windowWillClose:(NSNotification *)notification {
    [NSApp terminate:nil];
}

@end