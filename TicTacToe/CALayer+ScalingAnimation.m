//
//  CALayer+ScalingAnimation.m
//  TarmeezLogoAnimation
//
//  Created by Dahiri Farid on 4/17/14.
//  Copyright (c) 2014 Dahiri Farid. All rights reserved.
//

#import "CALayer+ScalingAnimation.h"

@implementation CALayer (ScalingAnimation)

- (void)animateScaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY numberOfBounces:(NSInteger)bounces
{
    NSString *keyPath = @"transform";
	CATransform3D transform = self.transform;
	id finalValue = [NSValue valueWithCATransform3D:
                     CATransform3DScale(transform, scaleX, scaleY, 1.0f)
                     ];
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
	bounceAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(self.transform, 0.1, 0.1, 0.1)];
	bounceAnimation.toValue = finalValue;
	bounceAnimation.duration = 1.5f;
	bounceAnimation.numberOfBounces = bounces;
	bounceAnimation.shouldOvershoot = YES;
    bounceAnimation.stiffness = SKBounceAnimationStiffnessHeavy;
	
	[self addAnimation:bounceAnimation forKey:@"scalingWithBouncingAnimation"];
	
	[self setValue:finalValue forKeyPath:keyPath];
}


- (void)animateTranslate:(CGPoint)position numberOfBounces:(NSInteger)bounces
{
    NSString *keyPath = @"position";
	id finalValue = [NSValue valueWithCGPoint:position];
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
	bounceAnimation.fromValue = [NSValue valueWithCGPoint:self.position];
	bounceAnimation.toValue = finalValue;
	bounceAnimation.duration = 2.5f;
	bounceAnimation.numberOfBounces = bounces;
	bounceAnimation.shouldOvershoot = YES;
    bounceAnimation.stiffness = SKBounceAnimationStiffnessMedium;
	
	[self addAnimation:bounceAnimation forKey:@"translationWithBouncingAnimation"];
	
	[self setValue:finalValue forKeyPath:keyPath];
}

@end
