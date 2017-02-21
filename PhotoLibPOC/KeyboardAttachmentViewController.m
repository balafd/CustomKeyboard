//
//  KeyboardAttachmentViewController.m
//  PhotoLibPOC
//
//  Created by Bala on 20/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "KeyboardAttachmentViewController.h"
#import "AttachmentsControllerViewModel.h"
#import "AttachmentPhotoCellProtocol.h"

@import Photos;

@interface KeyboardAttachmentViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    AttachmentsControllerViewModel *viewModel;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation KeyboardAttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    viewModel = [[AttachmentsControllerViewModel alloc] init];
    
    //TODO: ⚠️ Warning: Return reuse identifier from viewModel class
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AttachmentHeaderView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AttachmentFooterView"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadRecentPhotos];
}

- (void)loadRecentPhotos {
    
    [viewModel loadRecentPhotos:^{
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [viewModel numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id <AttachmentPhotoCellProtocol>cell = [collectionView dequeueReusableCellWithReuseIdentifier:[viewModel identifierForItemAtSection:indexPath.section] forIndexPath:indexPath];
    id cellData = [viewModel dataForItemAtRow:indexPath.row inSection:indexPath.section];
    if ([cell conformsToProtocol:@protocol(AttachmentPhotoCellProtocol)]) {
        [cell configureCell:cellData withDelegate:nil];
    }
    return (UICollectionViewCell *)cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [viewModel didTapPhotoAtRow:indexPath.row inSection:indexPath.section];
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [viewModel sizeForItemAtSection:indexPath.section ofFullSize:[collectionView bounds].size];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [viewModel minimumLineSpacingForSectionAtIndex:section];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [viewModel minimumInteritemSpacingForSectionAtIndex:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [viewModel referenceSizeForHeaderInSection:section withFullSize:[collectionView bounds].size];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return [viewModel referenceSizeForFooterInSection:section withFullSize:[collectionView bounds].size];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView * reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        //TODO: ⚠️ Warning: Return reuse identifier from viewModel class
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier :@"AttachmentHeaderView" forIndexPath:indexPath];
           headerView.backgroundColor = [UIColor redColor];
        reusableview = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        //TODO: ⚠️ Warning: Return reuse identifier from viewModel class
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier :@"AttachmentFooterView" forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor blueColor];
        reusableview = footerView;
    }
    return reusableview;
}

@end
