//
//  RMViewController.m
//  RMArrowNode
//
//  Created by 三原 亮介 on 2014/01/01.
//  Copyright (c) 2014年 Ryosuke Mihara. All rights reserved.
//

#import "RMViewController.h"
#import "RMScene.h"

@interface RMViewController () {
    RMScene *scene_;
}
@end

@implementation RMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    scene_ = [RMScene sceneWithSize:self.view.bounds.size];
    scene_.scaleMode = SKSceneScaleModeAspectFill;
    [(SKView *)self.view presentScene:scene_];

    NSArray *values = @[@7.0, @14.0, @0.0, @1.0, @0.0];
    NSUInteger i = 1;
    for (NSNumber *value in values) {
        UISlider *slider = (UISlider *)[self.view viewWithTag:i++];
        [slider setValue:[value floatValue]];
        [self sliderValueDidChange:slider];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

- (IBAction)sliderValueDidChange:(UISlider *)slider {
    [(UILabel *)[self.view viewWithTag:slider.tag + 5] setText:
     [NSString stringWithFormat:@"%.0f", slider.value]];
    switch (slider.tag) {
        case 1: [scene_ setHeadWidth:slider.value]; break;
        case 2: [scene_ setHeadLength:slider.value]; break;
        case 3: [scene_ setHeadMargin:slider.value]; break;
        case 4: [scene_ setTailWidth:slider.value]; break;
        case 5: [scene_ setTailMargin:slider.value]; break;
    }
}

- (IBAction)clearButtonDidTap:(id)sender {
    [scene_ removeAllChildren];
}

@end
