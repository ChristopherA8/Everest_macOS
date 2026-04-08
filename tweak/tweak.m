#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static NSString *plistPath;

@interface DockBar
-(void)appLaunchedForTile:(id)tile;
@end

static void (*orig_handleDockEventAppLaunch)(id self, SEL _cmd, id tile, BOOL alreadyExists, BOOL appLaunch, void *context);

static void hook_handleDockEventAppLaunch(id self, SEL _cmd, id tile, BOOL alreadyExists, BOOL appLaunch, void *context) {
    NSLog(@"[Tweak] App icon pressed tile=%@", tile);

    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    if ([dict[@"Enabled"] isEqualToNumber:@0]) {
        orig_handleDockEventAppLaunch(self, _cmd, tile, alreadyExists, appLaunch, context);
        return;
    };

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
        if ([dict[@"Animation"] isEqualToNumber:@1]) {
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
        } else if ([dict[@"Animation"] isEqualToNumber:@2]) {
            CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            scale.values = @[@1.0, @1.1, @0.95, @1.05, @1.0];
            scale.keyTimes = @[@0, @0.2, @0.5, @0.8, @1];
            scale.duration = 0.6;
            scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            scale.fillMode = kCAFillModeForwards;
            scale.removedOnCompletion = YES;

            [layer addAnimation:scale forKey:@"customScale"];
        } else if ([dict[@"Animation"] isEqualToNumber:@3]) {
            CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            scale.values = @[@1.0, @0.0];
            scale.keyTimes = @[@0, @1];
            scale.duration = 0.6;
            scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            scale.fillMode = kCAFillModeForwards;
            scale.removedOnCompletion = YES;

            [layer addAnimation:scale forKey:@"customScale"];
        } else if ([dict[@"Animation"] isEqualToNumber:@4]) {
            CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            scale.values = @[@1.0, @2.0, @0.0, @1.0];
            scale.keyTimes = @[@0, @0.5, @0.7, @1.0];
            scale.duration = 0.6;
            scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            scale.fillMode = kCAFillModeForwards;
            scale.removedOnCompletion = YES;

            [layer addAnimation:scale forKey:@"customScale"];
        } else if ([dict[@"Animation"] isEqualToNumber:@5]) {
            CABasicAnimation *transformRotationZAnimation = [CABasicAnimation animation];
            transformRotationZAnimation.duration = 0.5;
            transformRotationZAnimation.fillMode = kCAFillModeForwards;
            transformRotationZAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transformRotationZAnimation.removedOnCompletion = YES;
            transformRotationZAnimation.keyPath = @"transform.rotation.z";
            transformRotationZAnimation.toValue = @(12.56637061435917); // 720
            // transformRotationZAnimation.toValue = @(18.84956); // 1080
            transformRotationZAnimation.fromValue = @(0);

            [layer addAnimation:transformRotationZAnimation forKey:@"customScale"];
        } else if ([dict[@"Animation"] isEqualToNumber:@6]) {
            CABasicAnimation *transformRotationZAnimation = [CABasicAnimation animation];
            transformRotationZAnimation.duration = 0.5;
            transformRotationZAnimation.fillMode = kCAFillModeForwards;
            transformRotationZAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transformRotationZAnimation.removedOnCompletion = YES;
            transformRotationZAnimation.keyPath = @"transform.rotation.z";
            // transformRotationZAnimation.toValue = @(12.56637061435917); // 720
            transformRotationZAnimation.toValue = @(18.84956); // 1080
            transformRotationZAnimation.fromValue = @(0);

            [layer addAnimation:transformRotationZAnimation forKey:@"customScale"];
        } else if ([dict[@"Animation"] isEqualToNumber:@7]) {
            CABasicAnimation *transformRotationZAnimation = [CABasicAnimation animation];
            transformRotationZAnimation.duration = 0.5;
            transformRotationZAnimation.fillMode = kCAFillModeForwards;
            transformRotationZAnimation.removedOnCompletion = YES;
            transformRotationZAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transformRotationZAnimation.keyPath = @"transform.rotation.z";
            transformRotationZAnimation.toValue = @(18.84955592153876);
            transformRotationZAnimation.fromValue = @(0);

            CABasicAnimation *positionYAnimation = [CABasicAnimation animation];
            positionYAnimation.duration = 0.5;
            positionYAnimation.fillMode = kCAFillModeForwards;
            positionYAnimation.removedOnCompletion = YES;
            positionYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            positionYAnimation.keyPath = @"transform.translation.y";
            positionYAnimation.fromValue = @(0);
            positionYAnimation.toValue = @(-80);

            CABasicAnimation *transformScaleXyAnimation = [CABasicAnimation animation];
            transformScaleXyAnimation.duration = 0.5;
            transformScaleXyAnimation.fillMode = kCAFillModeForwards;
            transformScaleXyAnimation.removedOnCompletion = YES;
            transformScaleXyAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.7446 :0.173844 :0.972543 :0.07438];
            transformScaleXyAnimation.keyPath = @"transform.scale.xy";
            transformScaleXyAnimation.toValue = @(0);
            transformScaleXyAnimation.fromValue = @(1);

            [layer addAnimation:transformScaleXyAnimation forKey:@"transformScaleXyAnimation"];
            [layer addAnimation:positionYAnimation forKey:@"positionYAnimation"];
            [layer addAnimation:transformRotationZAnimation forKey:@"transformRotationZAnimation"];
        } else if ([dict[@"Animation"] isEqualToNumber:@8]) {
            CASpringAnimation *transformRotationZAnimation = [CASpringAnimation animation];
            transformRotationZAnimation.duration = 0.99321;
            transformRotationZAnimation.fillMode = kCAFillModeForwards;
            transformRotationZAnimation.removedOnCompletion = YES;
            transformRotationZAnimation.keyPath = @"transform.rotation.z";
            transformRotationZAnimation.toValue = @(6.283185307179586);
            transformRotationZAnimation.fromValue = @(0);
            transformRotationZAnimation.stiffness = 200;
            transformRotationZAnimation.damping = 10;
            transformRotationZAnimation.mass = 0.7;
            transformRotationZAnimation.initialVelocity = 4;

            [layer addAnimation:transformRotationZAnimation forKey:@"transformRotationZAnimation"];
        } else if ([dict[@"Animation"] isEqualToNumber:@9]) {
            CALayer *newLayer = layer;
            CGPoint oldOrigin = newLayer.frame.origin;

            newLayer.anchorPoint = CGPointMake(0.5, 0.5);
            newLayer.position = CGPointMake(oldOrigin.x + newLayer.bounds.size.width / 2.0, oldOrigin.y + newLayer.bounds.size.height / 2.0);

            // Vertical collapse
            CABasicAnimation *vertical = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
            vertical.fromValue = @1.0;
            vertical.toValue = @0.02;
            vertical.duration = 0.5;
            vertical.fillMode = kCAFillModeForwards;
            vertical.removedOnCompletion = YES;
            vertical.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

            // Vertical collapse
            CABasicAnimation *horizontal = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
            horizontal.fromValue = @1.0;
            horizontal.toValue = @0.9;
            // horizontal.toValue = @0.02;
            horizontal.duration = 0.5;
            horizontal.fillMode = kCAFillModeForwards;
            horizontal.removedOnCompletion = YES;
            horizontal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

            [newLayer addAnimation:horizontal forKey:@"horizontal"];
            [newLayer addAnimation:vertical forKey:@"vertical"];
        }
    }

    #pragma mark - future work
    // Perform PSN / actAsProcess logic if needed
    // might have to call [tile psn] and [tile actAsProcess:psn] depending on Dock version
}

__attribute__((constructor))
static void tweak_init() {
    // If plist doesn't exist create it
    NSString *path = @"~/Library/Application Support/EverestSettings/settings.plist";
    plistPath = [path stringByExpandingTildeInPath];

    // Ensure the folder exists
    NSString *dir = [plistPath stringByDeletingLastPathComponent];
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:dir
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error) {
        NSLog(@"Failed to create Application Support folder: %@", error);
    }

    // If file is empty, setup default values
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    if (!dict) {
        NSDictionary *dict = @{
            @"Enabled": @1,
            @"Animation": @0
        };
        [dict writeToFile:plistPath atomically:YES];
    }

    // Start swizzling
    Class cls = objc_getClass("DockBar");
    SEL sel = @selector(handleDockEventAppLaunch:alreadyExists:appLaunch:context:);
    Method m = class_getInstanceMethod(cls, sel);
    orig_handleDockEventAppLaunch = (void *)method_getImplementation(m);
    method_setImplementation(m, (IMP)hook_handleDockEventAppLaunch);
}
