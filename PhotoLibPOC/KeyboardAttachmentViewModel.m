//
//  KeyboardAttachmentViewModel.m
//  PhotoLibPOC
//
//  Created by Bala on 21/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "KeyboardAttachmentViewModel.h"
#import "PhotoAttachmentViewModel.h"

NSString *const kPhotoAttachmentCell = @"PhotoAttachmentCell";
NSString *const kOtherAttachmentCell = @"OtherAttachmentCell";

@interface KeyboardAttachmentViewModel () {
    NSMutableArray *attachmentsOptions;
}

@end

@implementation KeyboardAttachmentViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        attachmentsOptions = [NSMutableArray new];
        
        PhotoAttachmentViewModel *photoAttachmentViewModel = [PhotoAttachmentViewModel new];
        [attachmentsOptions addObject:photoAttachmentViewModel];
        [attachmentsOptions addObject:@"Choose from Photos"];
        [attachmentsOptions addObject:@"Another Option"];
    }
    return self;
}

- (NSArray *)cellIdentifiers {
    return nil;
}

- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return attachmentsOptions.count;
}

- (NSString *)identifierForItemAtRow:(NSInteger)row inSection:(NSInteger)section {
    
    if (row == 0) {
        return @"PhotoAttachmentCell";
    }
    return @"OtherAttachmentCell";
    return nil;
}

- (id)dataForItemAtRow:(NSInteger)row inSection:(NSInteger)section {
    return attachmentsOptions[row];
}

- (void)didTapItemAtRow:(NSInteger)row inSection:(NSInteger)section {
    
}

- (CGFloat)heightForItemAtRow:(NSInteger)row inSection:(NSInteger)section {
    if (row == 0) {
        return 160;
    }
    return 45;
}

@end
