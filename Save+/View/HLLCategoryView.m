//
//  HLLCategoryView.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCategoryView.h"
#import "HLLCategoryCollectionViewCell.h"
#import "HLLCategory.h"


@interface HLLCategoryView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//@property (nonatomic ,strong) NSMutableArray * categories;

@property (nonatomic ,strong) RLMResults<HLLCategory *> * categoryResults;

@property (nonatomic ,strong) IBOutlet UICollectionView * categoryCollectionView;

@property (nonatomic ,strong) IBOutlet UIPageControl * pageControl;

@property (nonatomic ,assign) CGRect originalFrame;
@end
@implementation HLLCategoryView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];

    _categoryResults = [[HLLCategory allObjects] sortedResultsUsingProperty:@"categoryRank" ascending:YES];
    
    _categoryCollectionView.delegate = self;
    _categoryCollectionView.dataSource = self;
    _categoryCollectionView.backgroundColor = [UIColor clearColor];
    [_categoryCollectionView registerNib:[HLLCategoryCollectionViewCell hll_nib] forCellWithReuseIdentifier:[HLLCategoryCollectionViewCell hll_cellIdentifier]];
    
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.hidden = YES;
    
}

- (void)didMoveToWindow{

    [super didMoveToWindow];
    NSInteger items = [self.categoryCollectionView numberOfItemsInSection:0];
    self.pageControl.numberOfPages = items / 15;
    
}
#pragma mark - HLLNibProtocol

+ (instancetype)hll_loadWithNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:[HLLCategoryView hll_nibName] owner:self options:nil] firstObject];
}

+ (NSString *)hll_nibName{
    
    return @"HLLInputView";
}


#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.categoryResults.count;
}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HLLCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HLLCategoryCollectionViewCell hll_cellIdentifier] forIndexPath:indexPath];
    
    if (self.categoryResults.count > 0) {
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        HLLCategory * category = self.categoryResults[indexPath.item];
        
        [cell hll_configureCellWithData:category];
    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HLLCategory * category = self.categoryResults[indexPath.item];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:didSelectedCategoryItem:)]) {
        [self.delegate categoryView:self didSelectedCategoryItem:category];
    }
}

#pragma mark - UIScrollerDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    [self.pageControl setCurrentPage:index];
}
#pragma mark - UICollectionViewDelegateFlowLayout
//定义展示的UICollectionViewCell的Size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat sectionInset_H = 0.0f;//collectionViewLayout.sectionInset.left + collectionViewLayout.sectionInset.right;
    CGFloat sectionInset_V = 0.0f;//collectionViewLayout.sectionInset.top + collectionViewLayout.sectionInset.bottom;
    CGFloat rowMargin = 0;//collectionViewLayout.minimumLineSpacing;
    
    CGFloat width = (collectionView.width - sectionInset_H - 4 * rowMargin)/5.0;
    CGFloat height = (collectionView.height - sectionInset_V - 2 * rowMargin) / 3;
    
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 0.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0.0f;
}
#pragma mark - HLLAnimationProtocol

- (void)showAnimaiton{

    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.frame = self.originalFrame;
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidenAnimation{

    CGRect frame = self.frame;
    self.originalFrame = self.frame;
    frame.origin.x -= frame.size.width;
    
    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.frame = frame;
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - API

- (void) reloadCategoryView{

    [self.categoryCollectionView reloadData];
}

- (void) clearCategory{

    [self.categoryCollectionView reloadData];
}
@end
