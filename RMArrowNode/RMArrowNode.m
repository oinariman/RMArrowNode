//
//  RMArrowNode.m
//
//  Created by 三原 亮介 on 2013/12/22.
//  Copyright (c) 2013年 Ryosuke Mihara. All rights reserved.
//

#import "RMArrowNode.h"

@implementation RMArrowNode

+ (id)arrowNodeWithStartPoint:(CGPoint)startPoint
                     endPoint:(CGPoint)endPoint
                    headWidth:(CGFloat)headWidth
                   headLength:(CGFloat)headLength
                   headMargin:(CGFloat)headMargin
                    tailWidth:(CGFloat)tailWidth
                   tailMargin:(CGFloat)tailMargin
                        color:(UIColor *)color

{
    RMArrowNode *node =
    [[RMArrowNode alloc] initWithStartPoint:startPoint
                                    endPoint:endPoint
                                   headWidth:headWidth
                                  headLength:headLength
                                  headMargin:headMargin
                                   tailWidth:tailWidth
                                  tailMargin:tailMargin
                                       color:color];
    return node;
}

- (id)initWithStartPoint:(CGPoint)startPoint
                endPoint:(CGPoint)endPoint
               headWidth:(CGFloat)headWidth
              headLength:(CGFloat)headLength
              headMargin:(CGFloat)headMargin
               tailWidth:(CGFloat)tailWidth
              tailMargin:(CGFloat)tailMargin
                   color:(SKColor *)color
{
    self = [super init];
    if (self) {
        CGPoint translation;
        CGPathRef pathRef = createArrowShapePath(startPoint,
                                                 endPoint,
                                                 headWidth,
                                                 headLength,
                                                 headMargin,
                                                 tailWidth,
                                                 tailMargin,
                                                 &translation);

        CGSize size = CGPathGetBoundingBox(pathRef).size;
        UIGraphicsBeginImageContextWithOptions(size,
                                               NO,
                                               [[UIScreen mainScreen] scale]);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextAddPath(context, pathRef);
        CGContextFillPath(context);
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        UIGraphicsEndImageContext();

        [self setTexture:[SKTexture textureWithCGImage:imageRef]];
        [self setSize:size];
        [self setPosition:(CGPoint){
            startPoint.x + size.width * 0.5 - translation.x,
            startPoint.y - size.height * 0.5 + translation.y}];
        
        CGPathRelease(pathRef);
    }
    return self;
}

void axisAlignedArrowPoints(CGPoint *points,
                            CGFloat length,
                            CGFloat headWidth,
                            CGFloat headLength,
                            CGFloat tailWidth)
{
    headWidth *= 0.5;
    tailWidth *= 0.5;
    points[0] = CGPointMake(0.0, -tailWidth);
    points[1] = CGPointMake(length - headLength, -tailWidth);
    points[2] = CGPointMake(length - headLength, -headWidth);
    points[3] = CGPointMake(length, 0.0);
    points[4] = CGPointMake(length - headLength, headWidth);
    points[5] = CGPointMake(length - headLength, tailWidth);
    points[6] = CGPointMake(0.0, tailWidth);
}

CGPathRef createArrowShapePath(CGPoint startPoint,
                               CGPoint endPoint,
                               CGFloat headWidth,
                               CGFloat headLength,
                               CGFloat headMargin,
                               CGFloat tailWidth,
                               CGFloat tailMargin,
                               CGPoint *translation)
{
    CGFloat length =
    hypot(endPoint.x - startPoint.x, endPoint.y - startPoint.y)
    - headMargin - tailMargin;
    CGPoint points[7];
    axisAlignedArrowPoints(points, length, headWidth, headLength, tailWidth);
    
    CGFloat angle = -atan2(endPoint.y - startPoint.y, endPoint.x - startPoint.x);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddLines(pathRef, &transform, points, sizeof(points)/sizeof(*points));
    CGPathCloseSubpath(pathRef);
    
    CGRect boundingBox = CGPathGetBoundingBox(pathRef);
    CGFloat minX = CGRectGetMinX(boundingBox);
    CGFloat minY = CGRectGetMinY(boundingBox);
    CGFloat w = (minX < 0.0) ? minX * -1.0 : 0.0;
    CGFloat h = (minY < 0.0) ? minY * -1.0 : 0.0;
    transform = CGAffineTransformTranslate(CGAffineTransformIdentity, w, h);
    CGPathRef translatedPathRef =
    CGPathCreateCopyByTransformingPath(pathRef, &transform);
    CGPathRelease(pathRef);
    
    w -= cos(angle) * tailMargin;
    h -= sin(angle) * tailMargin;
    *translation = CGPointMake(w, h);
    return translatedPathRef;
}

@end
