//
//  CannedResponseViewController.h
//  PhotoLibPOC
//
//  Created by Bala on 15/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CannedResponseKeyboardDelegate <NSObject>

- (void)didPressSearchBarInCannedResponse;
- (void)doneSearching;

@end

@interface CannedResponseViewController : UIViewController

@property (nonatomic, weak) id <CannedResponseKeyboardDelegate> delegate;

@end
