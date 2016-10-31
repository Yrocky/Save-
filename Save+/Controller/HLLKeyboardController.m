//
//  HLLKeyboardController.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLKeyboardController.h"
#import "HLLKeyBoardInputButton.h"
#import "HLLKeyboardSplitView.h"

@interface HLLKeyboardController ()

@property (nonatomic ,strong) IBOutletCollection(HLLKeyBoardInputButton) NSArray * numberInputButton;

@property (nonatomic ,strong) IBOutlet HLLKeyBoardInputButton * deleteButton;

@property (nonatomic ,strong) IBOutlet HLLKeyBoardInputButton * sureButton;

@property (nonatomic ,strong) CAShapeLayer * lineLayer;

@end
@implementation HLLKeyboardController

- (void)loadView{

    [super loadView];
    
    _lineLayer             = [CAShapeLayer layer];
    _lineLayer.lineWidth   = 2 / [UIScreen mainScreen].scale;
    _lineLayer.fillColor   = [UIColor clearColor].CGColor;
    _lineLayer.strokeColor = [UIColor colorWithHexString:@"E9ECEF"].CGColor;
    [self.view.layer addSublayer:_lineLayer];
    
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    [self addLine];
    
    [self.sureButton hll_setBackgroundImageWithColor:[UIColor colorWithHexString:@"#21AF73"] forState:UIControlStateNormal];
    [self.sureButton hll_setBackgroundImageWithColor:[UIColor colorWithHexString:@"5a9367"] forState:UIControlStateHighlighted];
    
    UIImage * sureImage = [[UIImage imageNamed:@"checkmark.png"] tintedGradientImageWithColor:[UIColor colorWithHexString:@"F2F2F2"]];
    [self.sureButton setImage:sureImage forState:UIControlStateNormal];
    [self.sureButton setImage:sureImage forState:UIControlStateHighlighted];
    
    UIImage * deleteImage = [[UIImage imageNamed:@"number_button_backspace_fg_selected.png"] tintedGradientImageWithColor:[UIColor colorWithHexString:@"555555"]];
    [self.deleteButton setImage:deleteImage forState:UIControlStateNormal];
    [self.deleteButton setImage:deleteImage forState:UIControlStateHighlighted];
    
}

#pragma mark - Action

- (IBAction)keyboardInputNumber:(HLLKeyBoardInputButton *)button{

    NSLog(@"Tag:%ld",(long)button.tag);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardController:didInputNumber:)]) {
        
        [self.delegate keyboardController:self didInputNumber:button.tag - 10];
    }
}

- (IBAction)keyboardInputSure:(HLLKeyBoardInputButton *)button{
    
    NSLog(@"确定");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardControllerDidCommitInput:)]) {
        [self.delegate keyboardControllerDidCommitInput:self];
    }
}

- (IBAction)keyboardInputDelete:(HLLKeyBoardInputButton *)button{
    
    NSLog(@"删除");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardControllerDidDeleteNumber:)]) {
        [self.delegate keyboardControllerDidDeleteNumber:self];
    }
}
#pragma mark - Method

- (void) addLine{
    
    
    CGRect rect         = self.view.bounds;
    CGFloat width       = CGRectGetWidth(rect);
    CGFloat height      = 216.0f;
    CGFloat vertical    = height / 4.0f;
    CGFloat horizontal  = width / 3.0f;
    
    self.lineLayer.frame = rect;
    UIBezierPath * path = [[UIBezierPath alloc] init];
    
    // 画水平线
    for (NSInteger index = 0; index < 4; index ++) {
        
        UIBezierPath * horizontalPath = [[UIBezierPath alloc] init];
        [horizontalPath moveToPoint:CGPointMake(0, index * vertical)];
        [horizontalPath addLineToPoint:CGPointMake(width, index * vertical)];
        
        [path appendPath:horizontalPath];
    }
    
    // 画垂直线
    for (NSInteger index = 1; index < 3; index ++) {
        
        UIBezierPath * verticalPath = [[UIBezierPath alloc] init];
        [verticalPath moveToPoint:CGPointMake(index * horizontal, 0)];
        [verticalPath addLineToPoint:CGPointMake(index * horizontal, height)];
        
        [path appendPath:verticalPath];
    }
    
    self.lineLayer.path = path.CGPath;
}
@end
