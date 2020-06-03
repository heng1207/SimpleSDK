//
//  UIButtonEnlarge.m
//  BDUIKit
//
//  Created by hanweiyang on 2017/1/18.
//
//

#import "UIButtonEnlarge.h"

@implementation UIButtonEnlarge

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.enlargeEdge = UIEdgeInsetsZero;
    }
    return self;
}

- (CGRect)enlargedRect
{
    UIEdgeInsets enlargeEdge = self.enlargeEdge;
    if (UIEdgeInsetsEqualToEdgeInsets(enlargeEdge, UIEdgeInsetsZero)){
        return self.bounds;
    } else {
        return CGRectMake(self.bounds.origin.x - enlargeEdge.left,
                          self.bounds.origin.y - enlargeEdge.top,
                          self.bounds.size.width + enlargeEdge.left + enlargeEdge.right,
                          self.bounds.size.height + enlargeEdge.top + enlargeEdge.bottom);
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)){
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point);
}

@end
