//
//  OtherAttachmentOptionsTableCell.m
//  PhotoLibPOC
//
//  Created by Bala on 22/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "OtherAttachmentOptionsTableCell.h"

@interface OtherAttachmentOptionsTableCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation OtherAttachmentOptionsTableCell

- (void)configureCell:(id)data withDelegate:(id)delegate {
    
    if ([data isKindOfClass:[NSString class]]) {
        _titleLable.text = data;
    }
}

@end
