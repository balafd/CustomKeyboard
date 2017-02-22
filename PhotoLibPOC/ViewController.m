//
//  ViewController.m
//  PhotoLibPOC
//
//  Created by Bala on 09/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import "ViewController.h"
#import "FDReplyKeyboardToolBar.h"
#import "UIWebView+InputAccessoryView.h"
@import WebKit;
#import "CannedResponseViewController.h"
#import "KeyboardAttachmentViewController.h"

@interface ViewController () <UITextFieldDelegate, FDReplyKeyboardProtocol, UIWebViewDelegate, CannedResponseKeyboardDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sampleTextField;
 //TODO: ⚠️ Warning: Change it to WKWebView
@property (weak, nonatomic) IBOutlet UIWebView *sampleWebView;
@property (strong, nonatomic) CannedResponseViewController *cannedResponseVC;
@property (strong, nonatomic) KeyboardAttachmentViewController *attachmentsVC;
@property (weak, nonatomic) FDReplyKeyboardToolBar *toolBarView;
@property (strong, nonatomic) UIView *keyboardCustomView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _toolBarView = [FDReplyKeyboardToolBar loadView];
    _toolBarView.delegate = self;
    _sampleTextField.inputAccessoryView = _toolBarView;
    _keyboardCustomView = [UIView new];
    _keyboardCustomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _keyboardCustomView.backgroundColor = [UIColor redColor];
    self.sampleWebView.keyboardDisplayRequiresUserAction = NO; // put in viewDidLoad
    [self.sampleWebView loadHTMLString:@"<div>; /n \n ;;; </div>" baseURL:nil];
    _sampleWebView.cjw_inputAccessoryView = _toolBarView;
}

- (UIViewController *)cannedResponseViewController {

    if (!_cannedResponseVC) {
        
        _cannedResponseVC = (CannedResponseViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CannedResponseViewController"];
        _cannedResponseVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _cannedResponseVC.view.translatesAutoresizingMaskIntoConstraints = NO;
        _cannedResponseVC.delegate = self;
    }
    return _cannedResponseVC;
}

- (KeyboardAttachmentViewController *)attachmentsViewController {
    
    if (!_attachmentsVC) {
        
        _attachmentsVC = (KeyboardAttachmentViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"KeyboardAttachmentViewController"];
        _attachmentsVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _attachmentsVC.view.translatesAutoresizingMaskIntoConstraints = NO;
//        _attachmentsVC.delegate = self;
    }
    return _attachmentsVC;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self reloadInputViewForKeyboardInputType:_toolBarView.keyboardInputType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)reloadInputViewForKeyboardInputType:(FDReplyKeyboardInputType)type {
     //TODO: ⚠️ Warning: Change according to Finite State Pattern
    if (type != FDReplyKeyboardPlainInputType) {
        
        _sampleWebView.cjw_inputView = _keyboardCustomView;
        _sampleTextField.inputView = _keyboardCustomView;
        [[_keyboardCustomView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        if (type == 2) {
            [self addSubview:[[self cannedResponseViewController] view] toView:_keyboardCustomView];
        } else if (type == 3) {
            [self addSubview:[[self attachmentsViewController] view] toView:_keyboardCustomView];
        } else  {
            UIView *redView = [UIView new];
            if (type == 1) { // Solution
                redView.backgroundColor = [UIColor redColor];
            } else { // 
                redView.backgroundColor = [UIColor yellowColor];
            }
            redView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            redView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:redView toView:_keyboardCustomView];
        }
    } else {
        // Assigning nil to inputView, will displays the standard system keyboard when it becomes first responder.
        _sampleTextField.inputView = nil;
        _sampleWebView.cjw_inputView = nil;
    }
    
    [_sampleTextField reloadInputViews];
    [_sampleWebView reloadInputViews];
}

- (void)addSubview:(UIView *)subView toView:(UIView*)parentView {
    [parentView addSubview:subView];
    NSDictionary * views = @{@"subView" : subView,};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|"
                                                                   options:0
                                                                   metrics:0
                                                                     views:views];
    [parentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|"
                                                          options:0
                                                          metrics:0
                                                            views:views];
    [parentView addConstraints:constraints];
}

#pragma mark - UIWebView Delegates

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.setAttribute('contentEditable','true')"];
    [_sampleWebView stringByEvaluatingJavaScriptFromString:@"document.body.focus()"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}

#pragma mark - CannedResponseKeyboardDelegate

- (void)didPressSearchBarInCannedResponse {
    
    NSLog(@" Need to do Custom Transitions");
    [[[self cannedResponseViewController] view] removeFromSuperview];
    [[self cannedResponseViewController] view].translatesAutoresizingMaskIntoConstraints = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[self cannedResponseViewController]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)doneSearching {
    
    [self.sampleWebView reload];
}

- (void)didChangeKeyboardInputType:(FDReplyKeyboardInputType)type {
    
    [self reloadInputViewForKeyboardInputType:type];
}


@end
