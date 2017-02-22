//
//  PhotoAttachmentViewModel.h
//  PhotoLibPOC
//
//  Created by Bala on 20/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;
#import "CollectionViewModelProtocol.h"

@interface PhotoAttachmentViewModel : NSObject <CollectionViewModelProtocol>

- (void)loadRecentPhotos:(void(^)(void))onCompletion;

- (BOOL)canHaveBottomBorderForViewAtSection:(NSInteger)section;

- (void)didTapPhotoAtRow:(NSInteger)row inSection:(NSInteger)section;

@end
