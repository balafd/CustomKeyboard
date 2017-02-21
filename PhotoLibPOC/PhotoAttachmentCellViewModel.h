//
//  PhotoAttachmentCellViewModel.h
//  PhotoLibPOC
//
//  Created by Bala on 21/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Photos;

@interface PhotoAttachmentCellViewModel : NSObject
@property (nonatomic, strong) PHAsset *imageAsset;
@property (nonatomic) BOOL isSelected;

@end
