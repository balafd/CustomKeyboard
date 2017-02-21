//
//  FDReplyKeyboardToolBar.m
//  PhotoLibPOC
//
//  Created by Bala on 09/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "FDReplyKeyboardToolBar.h"

@interface FDReplyKeyboardToolBar ()

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation FDReplyKeyboardToolBar


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"BAR");
    }
    return self;
}

+ (instancetype) loadView {
    
    FDReplyKeyboardToolBar *myCustomXIBViewObj = [[[NSBundle mainBundle] loadNibNamed:@"FDReplyKeyboardToolBar" owner:self                                                                                  options:nil] lastObject];
    return myCustomXIBViewObj;                     
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"TOOL BAR");
        FDReplyKeyboardToolBar *myCustomXIBViewObj = [[[NSBundle mainBundle] loadNibNamed:@"FDReplyKeyboardToolBar" owner:self options:nil] objectAtIndex:0];
        [self addSubview:myCustomXIBViewObj];

    }
    return self;
}

- (IBAction)tappedButton:(id)sender {
    
    NSInteger tag = [sender tag];
    _keyboardInputType = tag;
    switch (tag) {
        case 0:
            NSLog(@"Normal Plain Keyboard");
            break;
        case 1:
            NSLog(@"Canned");
            break;
        case 2:
            NSLog(@"Solution Article");
            break;
        case 3:
            NSLog(@"Attachments");
            break;
        default:
            break;
    }
    
    if ([_delegate conformsToProtocol:@protocol(FDReplyKeyboardProtocol)]) {
        [_delegate didChangeKeyboardInputType:tag];
    }
}

@end
