//
//  ViewController.m
//  Save+
//
//  Created by Youngrocky on 16/6/17.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "ViewController.h"
#import "HLLBill.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *realmCountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
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
        category.categoryRank = @10;
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
    
    self.realmCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)result.count];
    
    HLLBill * bill = [result lastObject];
    
    NSLog(@"dateString:%@",bill.dateString);
    NSLog(@"dateDetailString:%@",bill.dateDetailString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
