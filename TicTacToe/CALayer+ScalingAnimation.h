//
//  CALayer+ScalingAnimation.h
//  TarmeezLogoAnimation
//
//  Created by Dahiri Farid on 4/17/14.
//  Copyright (c) 2014 Dahiri Farid. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (ScalingAnimation)

- (void)animateScaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY numberOfBounces:(NSInteger)bounces;

- (void)animateTranslate:(CGPoint)position numberOfBounces:(NSInteger)bounces;

@end
