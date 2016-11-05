//
//  HLLSortCategoryViewController.m
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLSortCategoryViewController.h"
#import "HLLCategorySettingCell.h"
#import "HLLCustomColorViewController.h"
#import "HLLCategoryHelper.h"
#import "HLLBillManager.h"

@interface HLLSortCategoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) NSMutableArray * dataSource;

@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;

@end

@implementation HLLSortCategoryViewController

- (void)loadView{

    [super loadView];

    self.dataSource = [NSMutableArray array];
    
    [self.dataSource addObjectsFromArray:[[HLLCategoryHelper shareCategoryHelper] allCategory]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.categoryCollectionView registerNib:[HLLCategorySettingCell hll_nib]
                  forCellWithReuseIdentifier:[HLLCategorySettingCell hll_cellIdentifier]];
    
    self.categoryCollectionView.alwaysBounceVertical = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.isDefaultSetup) {
        UIBarButtonItem * saveButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(saveDefaultConfigureCategory)];
        
        self.navigationItem.rightBarButtonItem = saveButton;
    }
}

- (void) saveDefaultConfigureCategory{

    AppDelegate * delegate = [AppDelegate appDelegate];
    
    [delegate performSelector:@selector(setupRootViewControllerWithCheckViewController) withObject:nil afterDelay:0.25];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    HLLCategorySettingCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HLLCategorySettingCell hll_cellIdentifier] forIndexPath:indexPath];
    
    id data = self.dataSource[indexPath.item];
    [cell hll_configureCellWithData:data];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    HLLCategoryHelper * categoryHelper = [HLLCategoryHelper shareCategoryHelper];
    HLLCategory * category = self.dataSource[indexPath.item];

    if (!category.active) {
        
        UIColor * color = [UIColor colorWithHexString:category.categoryColor];
        
        HLLCustomColorViewController * customColorVC = (HLLCustomColorViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"Check" storyBoardID:CustomColorViewControllerStoryBoardID];
        
        customColorVC.categoryName = [NSString stringWithFormat:@"%@",category.categoryName];
        customColorVC.categoryIcon = category.categoryIcon;
        customColorVC.categoryColor = [color isKindOfClass:[NSNull class]] ? @"" : category.categoryColor;
        customColorVC.customHandle = ^(NSString * categoryName,NSString * categoryColor){
   
            [categoryHelper updateCategory:category action:^void {
                
                category.categoryName = categoryName;
                category.active = YES;
                category.categoryColor = categoryColor;
            }];
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        };
        [self.navigationController pushViewController:customColorVC animated:YES];
    }else{
    
        [categoryHelper updateCategory:category action:^void {
            
            category.active = NO;
        }];

        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((kScreen_Width - 4 * 10 ) / 3, 100.0f);
    return CGSizeMake(kScreen_Width, 60);
//    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10, 10, 10, 10);
    return UIEdgeInsetsZero;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 10.0f;
}



#pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

@end
