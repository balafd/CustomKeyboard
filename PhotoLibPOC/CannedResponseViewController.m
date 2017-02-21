//
//  CannedResponseViewController.m
//  PhotoLibPOC
//
//  Created by Bala on 15/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "CannedResponseViewController.h"

@interface CannedResponseViewController ()

@property (weak, nonatomic) IBOutlet UITableView *cannedResponseTableView;


@end

@implementation CannedResponseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.navigationController) {
        UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
        self.navigationItem.rightBarButtonItem = button;
    }
    NSLog(@"Self %@",self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapSearchBar:(id)sender {
    if ([_delegate respondsToSelector:@selector(didPressSearchBarInCannedResponse)]) {
        [_delegate didPressSearchBarInCannedResponse];
    }
}

- (void)close {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if ([_delegate respondsToSelector:@selector(doneSearching)]) {
            [_delegate doneSearching];
        }
    }];
}

- (void)dealloc {
    NSLog(@"Dealloced %@", NSStringFromClass([self class]));
}

@end
