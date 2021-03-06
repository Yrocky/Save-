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
#import "StoryBoardUtilities.h"
#import "HLLTouchIDHelper.h"
#import "HLLSetting.h"
#import "HLLCategory.h"
#import "HLLLocationView.h"
#import "FSCalendar.h"
#import "HLLBillManager.h"


@interface ViewController ()<HLLCategoryViewDelegate,HLLKeyboardControllerDelegate,HLLCommitViewDelegate>

// UI
@property (weak, nonatomic  ) IBOutlet HLLInputView             *inputAmountView;

@property (weak, nonatomic  ) IBOutlet HLLCategoryView          *categoryView;

@property (weak, nonatomic  ) IBOutlet HLLKeyboardView          *keyboardView;

@property (nonatomic ,weak  ) HLLKeyboardController    * keyboardController;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;

@property (weak, nonatomic  ) IBOutlet HLLCommitView            *commitView;

@property (weak, nonatomic  ) IBOutlet HLLNoteView              *noteView;
@property (weak, nonatomic  ) IBOutlet HLLLocationView          *locationView;

// data
@property (nonatomic ,strong) HLLCategory              * category;
@end

@implementation ViewController

- (void)loadView{

    [super loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryDidFinish) name:kLoadCategoryFinishNotication object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categoryView.delegate = self;
    self.commitView.delegate   = self;
    
    [self.view addGestureRecognizer:self.swipeGesture];
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.categoryView reloadCategoryView];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    RLMResults<HLLBill *> * billes = [HLLBill allObjects];
    
    for (HLLBill * bill in billes) {
        
        NSLog(@"bill'time:%@",bill.dateDetailString);
    }
    
    RLMResults<HLLSetting *> * result = [HLLSetting allObjects];
    
    HLLSetting * setting = [result firstObject];
    
    if (setting.location){
        
        [self.locationView loadCurrentLocationInfo];
    }
}

#pragma mark - Method

- (void) categoryDidFinish{
    
    [self.categoryView reloadCategoryView];
}

- (void) saveBill{
    
    FSCalendar * calendar = [[FSCalendar alloc] init];

    NSInteger amount = self.inputAmountView.amountNumber;
    
    // 使用 NSPredicate 查询
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"categoryIcon = %@ ",self.category.categoryIcon];
    RLMResults * categoriesResult = [HLLCategory objectsWithPredicate:pred];
    HLLCategory * category = [categoriesResult firstObject];
    
    HLLBill * bill = [[HLLBill alloc] init];
    bill.category = category;
    bill.amount = [NSNumber numberWithInteger:amount];
    
    bill.note = self.noteView.note;
    bill.date = [NSDate date];
//        bill.date = [calendar yesterdayOfDate: [NSDate date]];
//    bill.date = [calendar beginingOfMonthOfDate: [NSDate date]];
    bill.longitude = self.locationView.longitude;
    bill.latitude = self.locationView.latitude;
    bill.locationInfo = self.locationView.loctionInfo;
    
    HLLBillManager * billManager = [HLLBillManager sharedManager];
    
    [billManager addBill:bill];
    
    [self.inputAmountView clearInput];
    [self.noteView clearNote];
    [self.categoryView clearCategory];
}

- (void) gotoChartAndSetting{
    UINavigationController * viewController = (UINavigationController *)[StoryBoardUtilities viewControllerForStoryboardName:@"Check" storyBoardID:CheckNavigationViewControllerStoryBoardID];
    
    [self.navigationController presentViewController:viewController animated:YES completion:nil];
}
#pragma mark - Action

- (IBAction)showCheckViewControllerHandle:(UIBarButtonItem *)sender {
    
    RLMResults<HLLSetting *> * result = [HLLSetting allObjects];
    
    HLLSetting * setting = [result firstObject];
    
    if (!setting.verify || (setting.verifyForTouchID == NO && setting.verifyForPassword == NO)) {
        
        [self gotoChartAndSetting];
    }
    
    if (setting.verifyForTouchID) {
        
        [HLLTouchIDHelper evaluateWithTouchID:^(BOOL success, NSError *error) {
            
            if (success) {
                
                [self gotoChartAndSetting];
            }else{
                
                NSLog(@"Error:%@",error);
            }
        }];
    }
    if(setting.verifyForPassword){//
    
        [self gotoChartAndSetting];
    }
}

- (IBAction)swipeGestureHandle:(UISwipeGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
}

#pragma mark - HLLCategoryViewDelegate

- (void) categoryView:(HLLCategoryView *)categoryView didSelectedCategoryItem:(HLLCategory *)category{

    [self.inputAmountView updateCategoryIconWithImageName:category.categoryIcon
                                                withColor:[UIColor colorWithHexString:category.categoryColor]];
    
    self.category = category;
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

    RLMResults<HLLSetting *> * result = [HLLSetting allObjects];
    
    HLLSetting * setting = [result firstObject];
    
    if (self.inputAmountView.nextCommit && setting.remarks) {
        
        [self.categoryView hidenAnimation];
        [self.keyboardView hidenAnimation];
        
        [self.commitView showAnimaiton];
        [self.noteView showAnimaiton];
        
        if (setting.location) {
            self.locationView.hidden = NO;
            [self.locationView loadCurrentLocationInfo];
            [self.locationView showAnimaiton];
        }else{
            self.locationView.hidden = YES;
            [self.locationView hidenAnimation];
        }
    }else{
    
        NSLog(@"直接记账");
        if (self.inputAmountView.amountNumber) {
            
            [self saveBill];
        }else{
            NSLog(@"弹出来一个警告！！");
        }
    }
}

#pragma mark - HLLCommitViewDelegate

- (void) commitViewDidSelectedCommitButton:(HLLCommitView *)commitView{

    // 记账
    [self saveBill];
//    [self addRealmData:nil];
    
    // UI
    [self.noteView hidenAnimation];
    [self.locationView hidenAnimation];
    [self.commitView hidenAnimation];
    
    [self.categoryView showAnimaiton];
    [self.keyboardView showAnimaiton];
    
}

- (void) commitViewDidSelectedCancelButton:(HLLCommitView *)commitView{
    
    [self.noteView hidenAnimation];
    [self.locationView hidenAnimation];
    [self.commitView hidenAnimation];
    
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
        
        NSInteger amount = self.inputAmountView.amountNumber;
        HLLBill * bill = [[HLLBill alloc] init];
        bill.category = self.category;
        bill.amount = [NSNumber numberWithInteger:amount];
        
        bill.note = self.noteView.note;
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
