#include "BlurView.hh"

@implementation BlurView
-(id)initWithFrame:(NSRect)frame {
   self = [super initWithFrame:frame];
   if (self) {
      [self setWantsLayer:YES];

      NSVisualEffectView *visualEffectView = [[NSVisualEffectView alloc] init];
      visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
      visualEffectView.alphaValue = 0.2;
      visualEffectView.material = NSVisualEffectMaterialHUDWindow;
      visualEffectView.blendingMode = NSVisualEffectBlendingModeBehindWindow;
      visualEffectView.state = NSVisualEffectStateActive;

      [self addSubview:visualEffectView];

      [NSLayoutConstraint activateConstraints:@[
         [visualEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
         [visualEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
         [visualEffectView.topAnchor constraintEqualToAnchor:self.topAnchor],
         [visualEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
      ]];

      [self.layer setBackgroundColor:[NSColor blackColor].CGColor];
      [self setAlphaValue:0.5];
   }
   return self;
}
@end