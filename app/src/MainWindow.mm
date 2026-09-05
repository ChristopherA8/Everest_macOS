#include "MainWindow.hh"

@implementation MainWindow

- (id)initWithContentRect:(NSRect)rect {
    self = [super initWithContentRect:rect
                            styleMask:(NSWindowStyleMaskTitled |
                                       NSWindowStyleMaskClosable)
                              backing:NSBackingStoreBuffered
                                defer:NO];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)setContentViewController:(NSViewController *)contentViewController {
    [super setContentViewController:contentViewController];

    NSSize size = contentViewController.preferredContentSize;
    if (size.width > 0 && size.height > 0) {
        [self setContentSize:size];
        self.contentMinSize = size;
        self.contentMaxSize = size;
    }
    [self center];
}

- (void)windowWillClose:(NSNotification *)notification {
    [NSApp terminate:nil];
}

@end