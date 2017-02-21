//
//  PhotoAttachmentTableViewCell.m
//  PhotoLibPOC
//
//  Created by Bala on 21/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "PhotoAttachmentTableViewCell.h"
#import "AttachmentsControllerViewModel.h"

@interface PhotoAttachmentTableViewCell () {

    AttachmentsControllerViewModel *viewModel;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PhotoAttachmentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCell:(id)data {
    
}

@end
