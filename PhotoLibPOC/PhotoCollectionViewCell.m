//
//  PhotoCollectionViewCell.m
//  PhotoLibPOC
//
//  Created by Bala on 20/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "PhotoAttachmentCellViewModel.h"
@import Photos;

@interface PhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UIImageView *selectionStateView;

@end

@implementation PhotoCollectionViewCell

- (void)configureCell:(id)data withDelegate:(id)delegate {

    if ([data isKindOfClass:[PhotoAttachmentCellViewModel class]]) {
        PhotoAttachmentCellViewModel *viewModel = data;
        if (viewModel.imageAsset != nil) {
            [[PHImageManager defaultManager] requestImageForAsset:viewModel.imageAsset
                                                       targetSize:self.thumbnailView.bounds.size
                                                      contentMode:PHImageContentModeDefault
                                                          options:PHImageRequestOptionsVersionCurrent
                                                    resultHandler:^(UIImage *result, NSDictionary *info) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.thumbnailView.image = result;
                                                        });
                                                    }];
        }
        _selectionStateView.backgroundColor =  viewModel.isSelected ? [[UIColor greenColor] colorWithAlphaComponent:.4] : [[UIColor greenColor] colorWithAlphaComponent:0.0];
    }
}

@end
