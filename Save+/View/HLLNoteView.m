//
//  HLLNoteView.m
//  Save+
//
//  Created by Youngrocky on 16/6/26.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLNoteView.h"
#import "UIPlaceHolderTextView.h"

@interface HLLNoteView ()<UITextViewDelegate>

@property (nonatomic ,strong) IBOutlet UILabel * titleLabel;

@property (nonatomic ,strong) IBOutlet UIPlaceHolderTextView * noteTextView;

@property (nonatomic ,assign) CGRect originalFrame;

@property (nonatomic ,strong ,readwrite) NSString * note;
@end
@implementation HLLNoteView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.noteTextView.text = @"";
    self.noteTextView.placeholder = @"填写本次记账的用途等等任何想写的东西";
    self.noteTextView.delegate = self;
}

#pragma mark - Method

- (void) clearNote{

    self.noteTextView.text = @"";
    self.note = @"";
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{

    NSLog(@"%@",textView.text);
    self.note = textView.text;
}

#pragma mark - HLLNibProtocol

+ (instancetype)hll_loadWithNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:[HLLNoteView hll_nibName] owner:self options:nil] firstObject];
}

+ (NSString *)hll_nibName{
    
    return @"HLLNoteView";
}

#pragma mark - HLLAnimationProtocol

- (void)showAnimaiton{
    
    CGRect frame = self.frame;
    self.originalFrame = CGRectMake(0, self.y, self.width, self.height);
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    self.frame = frame;
    
    self.alpha = 0.0f;
    
    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.alpha = 1.0f;
        self.frame = self.originalFrame;
    } completion:^(BOOL finished) {
        
        self.originalFrame = frame;
    }];
}

- (void)hidenAnimation{
    
    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.alpha = 0.0f;
        self.frame = self.originalFrame;
    } completion:^(BOOL finished) {
    }];
}

@end
