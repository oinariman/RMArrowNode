//
//  RMArrowNode.h
//
//  Created by 三原 亮介 on 2013/12/22.
//  Copyright (c) 2013年 Ryosuke Mihara. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface RMArrowNode : SKSpriteNode

+ (id)arrowNodeWithStartPoint:(CGPoint)startPoint
                     endPoint:(CGPoint)endPoint
                    headWidth:(CGFloat)headWidth
                   headLength:(CGFloat)headLength
                   headMargin:(CGFloat)headMargin
                    tailWidth:(CGFloat)tailWidth
                   tailMargin:(CGFloat)tailMargin
                        color:(SKColor *)color;

- (id)initWithStartPoint:(CGPoint)startPoint
                endPoint:(CGPoint)endPoint
               headWidth:(CGFloat)headWidth
              headLength:(CGFloat)headLength
              headMargin:(CGFloat)headMargin
               tailWidth:(CGFloat)tailWidth
              tailMargin:(CGFloat)tailMargin
                   color:(SKColor *)color;

@end
