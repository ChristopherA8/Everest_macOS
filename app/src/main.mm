#include <AppKit/AppKit.h>
#include <AppKit/NSImage.h>
#include <AppKit/NSWindow.h>
#include <Cocoa/Cocoa.h>
#include <CoreGraphics/CGGeometry.h>

#include "MainWindow.hh"
#include "ViewController.hh"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        [app setActivationPolicy:NSApplicationActivationPolicyAccessory];

        MainWindow *window = [[MainWindow alloc] initWithContentRect:CGRectMake(200, 800, 100, 100)];
        
        [window setOpaque:NO];
        [window setBackgroundColor:[NSColor clearColor]];
        [window setTitle:@"Everest Settings"];
        [window setLevel:NSNormalWindowLevel];
        [window setCollectionBehavior:NSWindowCollectionBehaviorDefault];
        [window makeKeyAndOrderFront:nil];

        ViewController *viewController = [[ViewController alloc] init];
        [window setContentViewController:viewController];

        [app activateIgnoringOtherApps:YES];
        [app run];
    }
}