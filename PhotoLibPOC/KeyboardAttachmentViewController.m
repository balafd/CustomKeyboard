//
//  KeyboardAttachmentViewController.m
//  PhotoLibPOC
//
//  Created by Bala on 20/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "KeyboardAttachmentViewController.h"
#import "KeyboardAttachmentViewModel.h"
#import "AttachmentPhotoCellProtocol.h"

@import Photos;

@interface KeyboardAttachmentViewController () <UITableViewDelegate, UITableViewDataSource> {
    KeyboardAttachmentViewModel *viewModel;
}

@property (weak, nonatomic) IBOutlet UITableView *attachmentOptionsTableView;

@end

@implementation KeyboardAttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    viewModel = [[KeyboardAttachmentViewModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return [viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id <AttachmentPhotoCellProtocol>cell = [tableView dequeueReusableCellWithIdentifier:[viewModel identifierForItemAtRow:indexPath.row inSection:indexPath.section] forIndexPath:indexPath];
    id cellData = [viewModel dataForItemAtRow:indexPath.row inSection:indexPath.section];
    if ([cell conformsToProtocol:@protocol(AttachmentPhotoCellProtocol)]) {
        [cell configureCell:cellData withDelegate:nil];
    }
    return (UITableViewCell *)cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [viewModel heightForItemAtRow:indexPath.row inSection:indexPath.section];
}

@end
