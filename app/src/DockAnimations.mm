#include "DockAnimations.h"

static const NSInteger kFirstRealAnimation = 2;
static const NSInteger kLastRealAnimation  = 14;

void ApplyDockAnimation(CALayer *layer, NSInteger index) {
    if (!layer || index <= 0) return;

    if (index == 1) {
        static NSInteger lastPick = 0;
        NSInteger pick;
        uint32_t range = (uint32_t)(kLastRealAnimation - kFirstRealAnimation + 1);
        do {
            pick = kFirstRealAnimation + arc4random_uniform(range);
        } while (pick == lastPick);
        lastPick = pick;
        index = pick;
    }

    switch (index) {
        case 2: {
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
            break;
        }
        case 3: {
            CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            scale.values = @[@1.0, @1.1, @0.95, @1.05, @1.0];
            scale.keyTimes = @[@0, @0.2, @0.5, @0.8, @1];
            scale.duration = 0.6;
            scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            scale.fillMode = kCAFillModeForwards;
            scale.removedOnCompletion = YES;
            [layer addAnimation:scale forKey:@"customScale"];
            break;
        }
        case 4: {
            CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            scale.values = @[@1.0, @0.0];
            scale.keyTimes = @[@0, @1];
            scale.duration = 0.6;
            scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            scale.fillMode = kCAFillModeForwards;
            scale.removedOnCompletion = YES;
            [layer addAnimation:scale forKey:@"customScale"];
            break;
        }
        case 5: {
            CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            scale.values = @[@1.0, @2.0, @0.0, @1.0];
            scale.keyTimes = @[@0, @0.5, @0.7, @1.0];
            scale.duration = 0.6;
            scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            scale.fillMode = kCAFillModeForwards;
            scale.removedOnCompletion = YES;
            [layer addAnimation:scale forKey:@"customScale"];
            break;
        }
        case 6:
        case 7: {
            CABasicAnimation *spin = [CABasicAnimation animation];
            spin.duration = 0.5;
            spin.fillMode = kCAFillModeForwards;
            spin.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            spin.removedOnCompletion = YES;
            spin.keyPath = @"transform.rotation.z";
            spin.fromValue = @(0);
            spin.toValue = (index == 6) ? @(12.56637061435917) : @(18.84956); // 720 / 1080
            [layer addAnimation:spin forKey:@"customScale"];
            break;
        }
        case 8: {
            CABasicAnimation *rot = [CABasicAnimation animation];
            rot.duration = 0.5;
            rot.fillMode = kCAFillModeForwards;
            rot.removedOnCompletion = YES;
            rot.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            rot.keyPath = @"transform.rotation.z";
            rot.toValue = @(18.84955592153876);
            rot.fromValue = @(0);

            CABasicAnimation *posY = [CABasicAnimation animation];
            posY.duration = 0.5;
            posY.fillMode = kCAFillModeForwards;
            posY.removedOnCompletion = YES;
            posY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            posY.keyPath = @"transform.translation.y";
            posY.fromValue = @(0);
            posY.toValue = @(-80);

            CABasicAnimation *scaleXy = [CABasicAnimation animation];
            scaleXy.duration = 0.5;
            scaleXy.fillMode = kCAFillModeForwards;
            scaleXy.removedOnCompletion = YES;
            scaleXy.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.7446 :0.173844 :0.972543 :0.07438];
            scaleXy.keyPath = @"transform.scale.xy";
            scaleXy.toValue = @(0);
            scaleXy.fromValue = @(1);

            [layer addAnimation:scaleXy forKey:@"transformScaleXyAnimation"];
            [layer addAnimation:posY forKey:@"positionYAnimation"];
            [layer addAnimation:rot forKey:@"transformRotationZAnimation"];
            break;
        }
        case 9: {
            CASpringAnimation *spring = [CASpringAnimation animation];
            spring.duration = 0.99321;
            spring.fillMode = kCAFillModeForwards;
            spring.removedOnCompletion = YES;
            spring.keyPath = @"transform.rotation.z";
            spring.toValue = @(6.283185307179586);
            spring.fromValue = @(0);
            spring.stiffness = 200;
            spring.damping = 10;
            spring.mass = 0.7;
            spring.initialVelocity = 4;
            [layer addAnimation:spring forKey:@"transformRotationZAnimation"];
            break;
        }
        case 10: {
            CGPoint oldOrigin = layer.frame.origin;
            layer.anchorPoint = CGPointMake(0.5, 0.5);
            layer.position = CGPointMake(oldOrigin.x + layer.bounds.size.width / 2.0,
                                         oldOrigin.y + layer.bounds.size.height / 2.0);

            CABasicAnimation *vertical = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
            vertical.fromValue = @1.0;
            vertical.toValue = @0.02;
            vertical.duration = 0.5;
            vertical.fillMode = kCAFillModeForwards;
            vertical.removedOnCompletion = YES;
            vertical.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

            CABasicAnimation *horizontal = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
            horizontal.fromValue = @1.0;
            horizontal.toValue = @0.9;
            horizontal.duration = 0.5;
            horizontal.fillMode = kCAFillModeForwards;
            horizontal.removedOnCompletion = YES;
            horizontal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

            [layer addAnimation:horizontal forKey:@"horizontal"];
            [layer addAnimation:vertical forKey:@"vertical"];
            break;
        }
        case 11: {
            NSArray *jellyTimes = @[@0, @0.15, @0.35, @0.55, @0.78, @1];

            CAKeyframeAnimation *squashX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
            squashX.values = @[@1.0, @1.35, @0.75, @1.18, @0.92, @1.0];
            squashX.keyTimes = jellyTimes;
            squashX.duration = 0.7;
            squashX.fillMode = kCAFillModeForwards;
            squashX.removedOnCompletion = YES;
            squashX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

            CAKeyframeAnimation *squashY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
            squashY.values = @[@1.0, @0.70, @1.30, @0.85, @1.08, @1.0];
            squashY.keyTimes = jellyTimes;
            squashY.duration = 0.7;
            squashY.fillMode = kCAFillModeForwards;
            squashY.removedOnCompletion = YES;
            squashY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

            [layer addAnimation:squashX forKey:@"squashX"];
            [layer addAnimation:squashY forKey:@"squashY"];
            break;
        }
        case 12: {
            CAKeyframeAnimation *flip = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
            flip.values = @[@1.0, @0.0, @1.0, @0.0, @1.0];
            flip.keyTimes = @[@0, @0.25, @0.5, @0.75, @1];
            flip.duration = 0.65;
            flip.fillMode = kCAFillModeForwards;
            flip.removedOnCompletion = YES;
            flip.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [layer addAnimation:flip forKey:@"cardFlip"];
            break;
        }
        case 13: {
            CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            shake.values = @[@0, @-12, @10, @-7.5, @5.5, @-3, @1.5, @0];
            shake.keyTimes = @[@0, @0.12, @0.27, @0.42, @0.57, @0.72, @0.87, @1];
            shake.duration = 0.55;
            shake.fillMode = kCAFillModeForwards;
            shake.removedOnCompletion = YES;
            shake.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

            CAKeyframeAnimation *tilt = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
            tilt.values = @[@0, @0.12, @(-0.10), @0.07, @(-0.05), @0.02, @0];
            tilt.keyTimes = @[@0, @0.12, @0.27, @0.42, @0.57, @0.78, @1];
            tilt.duration = 0.55;
            tilt.fillMode = kCAFillModeForwards;
            tilt.removedOnCompletion = YES;
            tilt.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

            [layer addAnimation:shake forKey:@"rubberShake"];
            [layer addAnimation:tilt forKey:@"rubberTilt"];
            break;
        }
        case 14: {
            NSArray *loopTimes = @[@0, @0.125, @0.25, @0.375, @0.5, @0.625, @0.75, @0.875, @1];

            CAKeyframeAnimation *loopX = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            loopX.values = @[@0, @7.07, @10, @7.07, @0, @(-7.07), @(-10), @(-7.07), @0];
            loopX.keyTimes = loopTimes;

            CAKeyframeAnimation *loopY = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
            loopY.values = @[@0, @(-2.93), @(-10), @(-17.07), @(-20), @(-17.07), @(-10), @(-2.93), @0];
            loopY.keyTimes = loopTimes;

            CABasicAnimation *loopSpin = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            loopSpin.fromValue = @(0);
            loopSpin.toValue = @(2 * M_PI);

            CAAnimationGroup *loop = [CAAnimationGroup animation];
            loop.animations = @[loopX, loopY, loopSpin];
            loop.duration = 0.8;
            loop.fillMode = kCAFillModeForwards;
            loop.removedOnCompletion = YES;
            loop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

            [layer addAnimation:loop forKey:@"loopTheLoop"];
            break;
        }
        default:
            break;
    }
}