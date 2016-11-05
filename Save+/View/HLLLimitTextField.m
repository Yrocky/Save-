//
//  HLLLimitTextField.m
//  Save+
//
//  Created by Rocky Young on 16/11/4.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLLimitTextField.h"

@interface HLLLimitTextField ()<UITextFieldDelegate>

@end

@implementation HLLLimitTextField

- (void)awakeFromNib{
 
    [super awakeFromNib];
    self.delegate = self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.delegate = self;
    }
    return self;
}


#pragma mark -
#pragma mark UITextFieldDelegate


- (BOOL) textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    return ([textField.text stringByReplacingCharactersInRange:range withString:string].length <= self.limitLength);
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return NO;
}

@end
