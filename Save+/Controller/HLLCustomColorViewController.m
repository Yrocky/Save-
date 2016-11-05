//
//  HLLCustomColorViewController.m
//  Save+
//
//  Created by Rocky Young on 16/11/4.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCustomColorViewController.h"
#import "DRColorPickerWheelView.h"
#import "HLLLimitTextField.h"
#import "DRColorPicker+UIColor.h"

@interface HLLCustomColorViewController ()

@property (weak, nonatomic) IBOutlet HLLLimitTextField *categoryNameTetField;
@property (weak, nonatomic) IBOutlet UIImageView *categoryNormalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *categorySelectedImageView;
@property (weak, nonatomic) IBOutlet DRColorPickerWheelView *categoryColorPickerView;
@property (weak, nonatomic) IBOutlet UIView *categorySelectedContentView;

@end

@implementation HLLCustomColorViewController

- (void)loadView{

    [super loadView];
    
    self.categoryNameTetField.text = self.categoryName;
    
    UIColor * color = [UIColor colorWithHexString:self.categoryColor];
    if (!color) {
        color = [UIColor randomColor];
        self.categoryColor = color.hexStringFromColorNoAlpha;
    }
    UIImage * image = [[UIImage imageNamed:self.categoryIcon] tintedGradientImageWithColor:color];
    
    self.categoryColorPickerView.color = color;
    
    self.categoryNormalImageView.backgroundColor = [UIColor clearColor];
    self.categoryNormalImageView.image = image;
    
    self.categorySelectedImageView.backgroundColor = [UIColor clearColor];
    self.categorySelectedImageView.image = [[UIImage imageNamed:self.categoryIcon] tintedGradientImageWithColor:[UIColor whiteColor]];
    
    self.categorySelectedContentView.layer.masksToBounds = YES;
    self.categorySelectedContentView.layer.cornerRadius = 25.0f;
    self.categorySelectedContentView.backgroundColor = color;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.categoryNameTetField addTarget:self action:@selector(editCategoryName:) forControlEvents:UIControlEventEditingChanged];
    
    self.categoryColorPickerView.colorChangedBlock = ^(UIColor * color){
    
        self.categoryColor = color.hexStringFromColorNoAlpha;
        UIImage * image = [[UIImage imageNamed:self.categoryIcon] tintedGradientImageWithColor:color];
        self.categoryNormalImageView.image = image;
        self.categorySelectedContentView.backgroundColor = color;
    };
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    
    if (self.customHandle) {
        self.customHandle(self.categoryName,self.categoryColor);
    }
}

#pragma mark -
#pragma mark Action

- (void) editCategoryName:(HLLLimitTextField *)textField{
    
    self.categoryName = textField.text;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
