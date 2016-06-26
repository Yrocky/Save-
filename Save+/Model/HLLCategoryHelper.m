//
//  HLLCategoryHelper.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCategoryHelper.h"
#import "HLLCategory.h"

@implementation HLLCategoryHelper

+ (void) loadCategory{

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        RLMRealm * defaultRealm = [RLMRealm defaultRealm];

        [defaultRealm beginWriteTransaction];
        
        for (NSInteger index = 0; index < [[HLLCategoryHelper categoryIcon] count]; index ++) {
            
            HLLCategory * category = [[HLLCategory alloc] init];
            category.type = @0;
            category.categoryIcon = [HLLCategoryHelper categoryIcon][index];
            category.categoryRank = index;
            category.categoryName = @"Shop";
            category.categoryColor = [HLLCategoryHelper categoryColor][index];
            
            [defaultRealm addObject:category];
        }
        
        [defaultRealm commitWriteTransaction];
        
    });
    

}

+ (NSArray<NSString *> *) categoryIcon{

    NSArray * icons = @[@"category_icon_accommodation.png",
                        @"category_icon_bills.png",
                        @"category_icon_business.png",
                        @"category_icon_car.png",
                        @"category_icon_cinema.png",
                        @"category_icon_clothing.png",
                        @"category_icon_drink.png",
                        @"category_icon_education.png",
                        @"category_icon_entertainment.png",
                        @"category_icon_family.png",
                        @"category_icon_food.png",
                        @"category_icon_gifts.png",
                        @"category_icon_groceries.png",
                        @"category_icon_healthcare.png",
                        @"category_icon_hobbies.png",
                        @"category_icon_home.png",
                        @"category_icon_income_extra.png",
                        @"category_icon_income_other.png",
                        @"category_icon_itunes.png",
                        @"category_icon_kids.png",
                        @"category_icon_love.png",
                        @"category_icon_pets.png",
                        @"category_icon_rent.png",
                        @"category_icon_savings.png",
                        @"category_icon_shopping.png",
                        @"category_icon_transport.png",
                        @"category_icon_travel.png",
                        @"category_icon_utilities.png"];
    return icons;
}

+ (NSArray<NSString *> *) categoryColor{
    
    return @[@"#a5dff9",
             @"#30a9de",
             @"#a593e0",
             @"#60c5ba",
             @"#79bd9a",
             @"#a3a1a1",
             @"#4ea1d3",
             @"#abd0ce",
             @"#00dffc",
             @"#a5d296",
             @"#fadad8",
             @"#56a902",
             @"#dedcee",
             @"#1f4e5f",
             @"#fd999a",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de",
             @"#30a9de"
             ];
}

+ (NSArray<NSString *> *) categoryName{
    
    return @[];
}

/*
 @[@"category_icon_accommodation.png",
 @"category_icon_bills.png",
 @"category_icon_business.png",
 @"category_icon_car.png",
 @"category_icon_cinema.png",
 @"category_icon_clothing.png",
 @"category_icon_drink.png",
 @"category_icon_education.png",
 @"category_icon_entertainment.png",
 @"category_icon_expense_gifts.png",
 @"category_icon_expense_other.png",
 @"category_icon_family.png",
 @"category_icon_food.png",
 @"category_icon_gifts.png",
 @"category_icon_groceries.png",
 @"category_icon_healthcare.png",
 @"category_icon_hobbies.png",
 @"category_icon_home.png",
 @"category_icon_income_extra.png",
 @"category_icon_income_other.png",
 @"category_icon_itunes.png",
 @"category_icon_kids.png",
 @"category_icon_loan.png",
 @"category_icon_love.png",
 @"category_icon_pets.png",
 @"category_icon_rent.png",
 @"category_icon_salary.png",
 @"category_icon_savings.png",
 @"category_icon_shopping.png",
 @"category_icon_transport.png",
 @"category_icon_travel.png",
 @"category_icon_utilities.png"]
*/
@end

