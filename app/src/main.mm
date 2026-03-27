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

        MainWindow *window = [[MainWindow alloc] initWithContentRect:CGRectMake(0, 0, 400, 200)];
        
        [window setOpaque:NO];
        [window setBackgroundColor:[NSColor clearColor]];
        [window setTitle:@"test"];
        [window setLevel:NSFloatingWindowLevel];
        [window setCollectionBehavior:NSWindowCollectionBehaviorDefault];
        // [window setIgnoresMouseEvents:YES];
        [window makeKeyAndOrderFront:nil];

        // NSVisualEffectView *blurEffectView = [[NSVisualEffectView alloc] initWithFrame:[window frame]];
        // blurEffectView.

        ViewController *viewController = [[ViewController alloc] init];
        [window setContentViewController:viewController];

        [app activateIgnoringOtherApps:YES];
        [app run];
    }
}