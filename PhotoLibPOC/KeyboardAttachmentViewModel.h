//
//  KeyboardAttachmentViewModel.h
//  PhotoLibPOC
//
//  Created by Bala on 21/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;
#import "TableViewModelProtocol.h"

@interface KeyboardAttachmentViewModel : NSObject <TableViewModelProtocol>

@property (nonatomic, strong) NSArray *attachedPhotos;

@end
