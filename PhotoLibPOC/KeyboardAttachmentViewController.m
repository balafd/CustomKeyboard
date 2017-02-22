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

@interface KeyboardAttachmentViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    KeyboardAttachmentViewModel *viewModel;
}
@property (nonatomic) UIImagePickerController *imagePickerController;
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

- (IBAction)showImagePickerForCamera:(id)sender
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        // Denies access to camera, alert the user.
        // The user has previously denied access. Remind the user that we need camera access to be useful.
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"Unable to access the Camera"
                                            message:@"To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app."
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // The user has not yet been presented with the option to grant access to the camera hardware.
        // Ask for it.
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^( BOOL granted ) {
            // If access was denied, we do not set the setup error message since access was just denied.
            if (granted)
            {
                // Allowed access to camera, go ahead and present the UIImagePickerController.
                [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
            }
        }];
    } else {
        // Allowed access to camera, go ahead and present the UIImagePickerController.
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
}

- (IBAction)showImagePickerForPhotoPicker:(id)sender
{
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.modalPresentationStyle = (sourceType == UIImagePickerControllerSourceTypeCamera) ? UIModalPresentationFullScreen : UIModalPresentationPopover;
    _imagePickerController = imagePickerController; // we need this for later
    
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    [mainWindow.rootViewController presentViewController:self.imagePickerController animated:YES completion:^{
        
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [viewModel didTapItemAtRow:indexPath.row inSection:indexPath.section];
    [self showImagePickerForPhotoPicker:nil];
}

#pragma mark - UITableViewDataSource

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

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[info[@"UIImagePickerControllerReferenceURL"]] options:nil];
    PHAsset *imageAsset = [result lastObject];

    [picker dismissViewControllerAnimated:YES completion:nil];
    _imagePickerController = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        //.. done dismissing
    }];
    
}

@end
