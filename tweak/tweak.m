#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@interface DockBar
-(void)appLaunchedForTile:(id)tile;
@end

static void (*orig_handleDockEventAppLaunch)(id self, SEL _cmd, id tile, BOOL alreadyExists, BOOL appLaunch, void *context);

static void hook_handleDockEventAppLaunch_noAnim(id self, SEL _cmd, id tile, BOOL alreadyExists, BOOL appLaunch, void *context) {
    NSLog(@"[Tweak] App icon pressed tile=%@", tile);

    // Launch the app
    if (appLaunch) {
        if ([self respondsToSelector:@selector(appLaunchedForTile:)]) {
            [self appLaunchedForTile:tile];
        }
    }

    CALayer *layer = nil;
    @try {
        layer = [tile valueForKey:@"layer"];
    } @catch (NSException *e) {
        NSLog(@"[Tweak] tile has no layer property: %@", e);
    }

    if (layer) {
        CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        bounce.values = @[@0, @-10, @10, @-5, @5, @0];
        bounce.keyTimes = @[@0, @0.2, @0.4, @0.6, @0.8, @1];
        bounce.duration = 0.6;
        bounce.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

        CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scale.values = @[@1.0, @1.1, @0.95, @1.05, @1.0];
        scale.keyTimes = @[@0, @0.2, @0.5, @0.8, @1];
        scale.duration = 0.6;
        scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[bounce, scale];
        group.duration = 0.6;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = YES;

        [layer addAnimation:group forKey:@"customBounce"];
    }

    #pragma mark - future work
    // Perform PSN / actAsProcess logic if needed
    // might have to call [tile psn] and [tile actAsProcess:psn] depending on Dock version
}

__attribute__((constructor))
static void tweak_init() {
    Class cls = objc_getClass("DockBar");
    SEL sel = @selector(handleDockEventAppLaunch:alreadyExists:appLaunch:context:);
    Method m = class_getInstanceMethod(cls, sel);
    // orig_handleDockEventAppLaunch = (void *)method_getImplementation(m);
    method_setImplementation(m, (IMP)hook_handleDockEventAppLaunch_noAnim);
}