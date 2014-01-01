//
//  RMScene.m
//  RMArrowNode
//
//  Created by 三原 亮介 on 2014/01/01.
//  Copyright (c) 2014年 Ryosuke Mihara. All rights reserved.
//

#import "RMScene.h"
#import "RMArrowNode.h"

@interface RMScene () {
    CGPoint startPoint_;
    BOOL secondTap_;
}
@end

@implementation RMScene

- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        [self setBackgroundColor:[SKColor colorWithWhite:1.0 alpha:1.0]];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint location = [[touches anyObject] locationInNode:self];
    [self putCircleAt:location];
    if (secondTap_) {
        RMArrowNode *node =
        [RMArrowNode arrowNodeWithStartPoint:startPoint_
                                    endPoint:location
                                   headWidth:_headWidth
                                  headLength:_headLength
                                  headMargin:_headMargin
                                   tailWidth:_tailWidth
                                  tailMargin:_tailMargin
                                       color:
         [SKColor colorWithRed:(arc4random()%256)/255.
                         green:(arc4random()%256)/255.
                          blue:(arc4random()%256)/255.
                         alpha:1.0]];
        [self addChild:node];
        secondTap_ = NO;
    }
    else {
        startPoint_ = location;
        secondTap_ = YES;
    }
}

- (void)putCircleAt:(CGPoint)position {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddEllipseInRect(pathRef, NULL, (CGRect){
        position.x - 5.0,
        position.y - 5.0,
        10.0,
        10.0});
    SKShapeNode *node = [SKShapeNode node];
    [node setPath:pathRef];
    [node setLineWidth:0.0];
    [node setFillColor:[SKColor colorWithWhite:0.9 alpha:1.0]];
    [self addChild:node];
    CGPathRelease(pathRef);
}

- (void)removeAllChildren {
    [super removeAllChildren];
    secondTap_ = NO;
}

@end
