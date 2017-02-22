//
//  FDReplyKeyboardToolBar.h
//  PhotoLibPOC
//
//  Created by Bala on 09/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

//https://github.com/PaulSolt/CustomUIView

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, FDReplyKeyboardInputType) {
    FDReplyKeyboardPlainInputType, // Regular Text Keyboard
    FDReplyKeyboardCannedResponseInputType,
    FDReplyKeyboardSolutionsInputType,
    FDReplyKeyboardAttachmentsInputType
};

@protocol FDReplyKeyboardProtocol <NSObject>

- (void)didChangeKeyboardInputType:(FDReplyKeyboardInputType)type;

@end

@interface FDReplyKeyboardToolBar : UIView

@property (nonatomic, weak) id <FDReplyKeyboardProtocol> delegate;
@property (nonatomic) FDReplyKeyboardInputType keyboardInputType;

+ (instancetype)loadView;

@end
