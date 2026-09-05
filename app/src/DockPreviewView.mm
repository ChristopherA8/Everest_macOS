#include "DockPreviewView.h"
#include "DockAnimations.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat kIconSize = 48.0;
static const CGFloat kIconGap  = 14.0;
static const CGFloat kDockPad  = 12.0;

@interface DockPreviewView ()
@property (nonatomic, strong) CALayer *dockBackground;
@property (nonatomic, strong) NSArray<CALayer *> *iconLayers;
@end

@implementation DockPreviewView

- (instancetype)initWithFrame:(NSRect)frame {
   self = [super initWithFrame:frame];
   if (!self) return nil;

   self.wantsLayer = YES;
   self.layer.backgroundColor = NSColor.clearColor.CGColor;

   self.dockBackground = [CALayer layer];
   self.dockBackground.backgroundColor = [[NSColor whiteColor] colorWithAlphaComponent:0.10].CGColor;
   self.dockBackground.borderColor = [[NSColor whiteColor] colorWithAlphaComponent:0.15].CGColor;
   self.dockBackground.borderWidth = 1.0;
   self.dockBackground.cornerRadius = 18.0;
   [self.layer addSublayer:self.dockBackground];

   NSMutableArray *layers = [NSMutableArray array];
   for (NSImage *icon in [self previewIcons]) {
      CALayer *iconLayer = [CALayer layer];
      iconLayer.contents = icon;
      iconLayer.contentsGravity = kCAGravityResizeAspect;
      iconLayer.anchorPoint = CGPointMake(0.5, 0.5);
      iconLayer.bounds = CGRectMake(0, 0, kIconSize, kIconSize);
      [self.layer addSublayer:iconLayer];
      [layers addObject:iconLayer];
   }
   self.iconLayers = layers;

   return self;
}

- (NSArray<NSImage *> *)previewIcons {
   NSArray *bundleIDs = @[@"com.apple.finder", @"com.apple.Safari", @"com.apple.mail",
                          @"com.apple.iCal", @"com.apple.Music"];
   NSWorkspace *ws = [NSWorkspace sharedWorkspace];
   NSMutableArray *icons = [NSMutableArray array];
   for (NSString *bid in bundleIDs) {
      NSURL *url = [ws URLForApplicationWithBundleIdentifier:bid];
      NSImage *img = url ? [ws iconForFile:url.path]
                         : [NSImage imageNamed:NSImageNameApplicationIcon];
      if (img) [icons addObject:img];
   }
   return icons;
}

- (void)layout {
   [super layout];

   NSUInteger count = self.iconLayers.count;
   if (count == 0) return;

   CGFloat stripWidth = count * kIconSize + (count - 1) * kIconGap;
   CGFloat dockWidth  = stripWidth + kDockPad * 2;
   CGFloat dockHeight = kIconSize + kDockPad * 2;
   CGFloat centerY    = NSMidY(self.bounds);
   CGFloat startX     = NSMidX(self.bounds) - stripWidth / 2.0 + kIconSize / 2.0;
   CGFloat scale      = self.window.backingScaleFactor ?: 2.0;

   // Layout changes shouldn't animate implicitly.
   [CATransaction begin];
   [CATransaction setDisableActions:YES];

   self.dockBackground.bounds = CGRectMake(0, 0, dockWidth, dockHeight);
   self.dockBackground.position = CGPointMake(NSMidX(self.bounds), centerY);
   self.dockBackground.contentsScale = scale;

   [self.iconLayers enumerateObjectsUsingBlock:^(CALayer *l, NSUInteger i, BOOL *stop) {
      l.position = CGPointMake(startX + i * (kIconSize + kIconGap), centerY);
      l.contentsScale = scale;
   }];

   [CATransaction commit];
}

- (void)mouseDown:(NSEvent *)event {
   NSPoint p = [self convertPoint:event.locationInWindow fromView:nil];
   for (CALayer *l in self.iconLayers) {
      if (CGRectContainsPoint(l.frame, p)) {
         NSInteger index = self.animationProvider ? self.animationProvider() : 0;
         ApplyDockAnimation(l, index);
         return;
      }
   }
}

@end