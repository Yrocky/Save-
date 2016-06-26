//
//  ViewController.m
//  Save+
//
//  Created by Youngrocky on 16/6/17.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "ViewController.h"
#import "HLLBill.h"
#import "HLLInputView.h"
#import "HLLCategoryView.h"
#import "HLLKeyboardView.h"
#import "HLLKeyboardController.h"
#import "HLLNoteView.h"
#import "HLLCommitView.h"


@interface ViewController ()<HLLCategoryViewDelegate,HLLKeyboardControllerDelegate,HLLCommitViewDelegate>

@property (weak, nonatomic) IBOutlet HLLInputView *inputAmountView;

@property (weak, nonatomic) IBOutlet HLLCategoryView *categoryView;

@property (weak, nonatomic) IBOutlet HLLKeyboardView *keyboardView;

@property (nonatomic ,weak) HLLKeyboardController * keyboardController;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;

@property (weak, nonatomic) IBOutlet HLLCommitView *commitView;

@property (weak, nonatomic) IBOutlet HLLNoteView *noteView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categoryView.delegate = self;
    self.commitView.delegate = self;
    
    [self.view addGestureRecognizer:self.swipeGesture];
}


- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    RLMResults<HLLCategory *> * categories = [HLLCategory allObjects];

    for (HLLCategory * category in categories) {
        
        NSLog(@"category:%@",category);
    }
}

#pragma mark - Action

- (IBAction)swipeGestureHandle:(UISwipeGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
}

#pragma mark - HLLCategoryViewDelegate

- (void) categoryView:(HLLCategoryView *)categoryView didSelectedCategoryItem:(HLLCategory *)category{

    [self.inputAmountView updateCategoryIconWithImageName:category.categoryIcon
                                                withColor:[UIColor colorWithHexString:category.categoryColor]];
}

- (void) categoryViewDidSetupCategories{

    NSLog(@"跳转进行设置分类视图");
}

#pragma mark - HLLKeyboardControllerDelegate

- (void) keyboardController:(HLLKeyboardController *)keyboard didInputNumber:(NSInteger)number{

    NSLog(@"你小子输入的是：%ld",(long)number);

    [self.inputAmountView updateAmountWithNumber:number];
}

- (void) keyboardControllerDidDeleteNumber:(HLLKeyboardController *)keyboard{

    [self.inputAmountView delelteNumber];
}

- (void) keyboardControllerDidCommitInput:(HLLKeyboardController *)keyboard{

    if (self.inputAmountView.nextCommit) {
        
        [self.categoryView hidenAnimation];
        [self.keyboardView hidenAnimation];
        
        [self.commitView showAnimaiton];
        [self.noteView showAnimaiton];
    }else{
    
        NSLog(@"啥都不做，后期加特效");
    }
}

#pragma mark - HLLCommitViewDelegate

- (void) commitViewDidSelectedCommitButton:(HLLCommitView *)commitView{

    [self.noteView hidenAnimation];
    [self.noteView clearNote];
    
    [self.commitView hidenAnimation];
    
    [self.categoryView showAnimaiton];
    [self.keyboardView showAnimaiton];
    
    [self.inputAmountView clearInput];
}

- (void) commitViewDidSelectedCancelButton:(HLLCommitView *)commitView{
    
    [self.commitView hidenAnimation];
    [self.noteView hidenAnimation];
    
    [self.categoryView showAnimaiton];
    [self.keyboardView showAnimaiton];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"keyboardIdentifier"])
    {
        self.keyboardController = segue.destinationViewController;
        self.keyboardController.delegate = self;
    }
}

- (IBAction)addRealmData:(UIButton *)addButton {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
       
        RLMRealm * defaultRealm = [RLMRealm defaultRealm];
        NSLog(@"Path:%@",defaultRealm.configuration.fileURL);
        [defaultRealm beginWriteTransaction];
        
        HLLCategory * category = [[HLLCategory alloc] init];
        category.type = @0;
        category.categoryIcon = @"icon";
        category.categoryRank = 10;
        category.categoryName = @"Shop";
        category.categoryColor = @"#346534";
//        category.active = YES;
        
        HLLBill * bill = [[HLLBill alloc] init];
        bill.category = category;
        bill.amount = @123;
        bill.note = @"3xxxxyyyyzzz";
        bill.date = [NSDate date];
        
        [defaultRealm addObject:bill];
        
        [defaultRealm commitWriteTransaction];
        
    });
 
}

- (IBAction)showRealmDataCount:(UIButton *)showButton {
 
    RLMResults<HLLBill *> * result = [HLLBill allObjects];
    
//    self.realmCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)result.count];
    
    HLLBill * bill = [result lastObject];
    
    NSLog(@"dateString:%@",bill.dateString);
    NSLog(@"dateDetailString:%@",bill.dateDetailString);
}

- (void) creatRealmObj{

    RLMRealm * defaultRealm = [RLMRealm defaultRealm];
    
    // * 1 以KVC的形式用Dictionary进行初始化
    [defaultRealm beginWriteTransaction];
    
    [HLLBill createInRealm:defaultRealm withValue:@{@"ID":@2,
                                                    @"type":@1,
                                                    @"category":@12,
                                                    @"amount":@100,
                                                    @"note":@"xxxxxyyyyyyzzzzz"}];
    [defaultRealm commitWriteTransaction];
    
    // * 2 以Array的形式将属性的值进行初始化
    [defaultRealm beginWriteTransaction];
    
    [HLLBill createInRealm:defaultRealm withValue:@[@2,
                                                    @1,
                                                    @12,
                                                    @100,
                                                    @"xxxxxyyyyyyzzzzz"]];
    [defaultRealm commitWriteTransaction];
    
    
    // * 3 以一个常规的方法初始化，然后添加
    [defaultRealm beginWriteTransaction];
    
    HLLBill * bill = [[HLLBill alloc] init];
    bill.ID = @3;
    bill.amount = @123;
    bill.note = @"3xxxxyyyyzzz";
    
    [defaultRealm addObject:bill];
    
    [defaultRealm commitWriteTransaction];
    
    
}
@end
