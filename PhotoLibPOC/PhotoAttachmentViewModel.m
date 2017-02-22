//
//  PhotoAttachmentViewModel.m
//  PhotoLibPOC
//
//  Created by Bala on 20/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "PhotoAttachmentViewModel.h"
#import "PhotoAttachmentCellViewModel.h"
@import Photos;

NSString * const kAttachmentPhotoCollectionViewCellIdentifier = @"PhotoCollectionViewCell";
static const NSInteger kRecentPhotosFetchLimitCount = 20;

@interface PhotoAttachmentViewModel () {
    // Recent 20 photos, Sorted by creation date
    NSMutableArray *recentPhotos;
    
    // Array of Selected Photo Assets localIdentifier.
    NSMutableArray *selectedPhotos;
    
    NSMutableArray *sections;
}

@end

@implementation PhotoAttachmentViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        selectedPhotos = [NSMutableArray new];
    }
    return self;
}

- (void)loadRecentPhotos:(void(^)(void))onCompletion {
    
    recentPhotos = [NSMutableArray new];
    
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    // fetching only ImageType
    PHFetchResult *allPhotosResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
    if (allPhotosResult != nil) {
        [allPhotosResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
            if (recentPhotos.count == kRecentPhotosFetchLimitCount) {
                return;
            }
            PhotoAttachmentCellViewModel *photoCellViewModel = [PhotoAttachmentCellViewModel new];
            photoCellViewModel.imageAsset = asset;
            if ([selectedPhotos containsObject:asset.localIdentifier]) {
                photoCellViewModel.isSelected = YES;
            }
            [recentPhotos addObject:photoCellViewModel];
        }];
    }
    
    if (!sections) {
        sections = [NSMutableArray new];
        [sections addObject:recentPhotos];
    } else  if (sections.count >= 1) {
        [sections replaceObjectAtIndex:0 withObject:recentPhotos];
    }
    
    if (onCompletion) {
        onCompletion();
    }
}

#pragma mark - CollectionView

- (NSArray *)cellIdentifiers {
    return @[kAttachmentPhotoCollectionViewCellIdentifier];
}

- (NSInteger)numberOfSections {
    return sections.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)sectionIndex {
    if (sectionIndex < sections.count) {
        NSArray *options = sections[sectionIndex];
        return options.count;
    }
    return 0;
}

- (NSString *)identifierForItemAtSection:(NSInteger)section {
    return kAttachmentPhotoCollectionViewCellIdentifier;
}

- (id)dataForItemAtRow:(NSInteger)row inSection:(NSInteger)section {
    PhotoAttachmentCellViewModel *cellViewModel = sections[section][row];
    return cellViewModel;
}

- (CGSize)sizeForItemAtSection:(NSInteger)section ofFullSize:(CGSize)fullSize {
    CGFloat width = 130;
    CGFloat height = 130;
    return CGSizeMake(width, height);
}

- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0f;
}

- (CGSize)referenceSizeForHeaderInSection:(NSInteger)section withFullSize:(CGSize)fullSize {
    
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(fullSize.width, 10);
}

- (CGSize)referenceSizeForFooterInSection:(NSInteger)section withFullSize:(CGSize)fullSize {
    
    CGFloat width = 10;
    CGFloat height = 10;
    return CGSizeMake(width, height);
}

- (void)didTapPhotoAtRow:(NSInteger)row inSection:(NSInteger)section {
    
    PhotoAttachmentCellViewModel *cellViewModel = sections[section][row];
     PHAsset *imageAsset = cellViewModel.imageAsset;
    if ([selectedPhotos containsObject:imageAsset.localIdentifier]) {
        [selectedPhotos removeObject:imageAsset.localIdentifier];
        cellViewModel.isSelected = NO;
    } else {
        [selectedPhotos addObject:imageAsset.localIdentifier];
        cellViewModel.isSelected = YES;
    }
}

- (BOOL)canHaveBottomBorderForViewAtSection:(NSInteger)section {
    return YES;
}

@end
