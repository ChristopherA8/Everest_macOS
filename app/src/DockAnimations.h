#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

// Applies animation `index` (matching the popup order) to `layer`.
// Index 0 does nothing; index 1 resolves to a random real animation.
void ApplyDockAnimation(CALayer *layer, NSInteger index);