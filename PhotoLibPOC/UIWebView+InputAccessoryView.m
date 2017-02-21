//
//  UIWebView+InputAccessoryView.m
//  PhotoLibPOC
//
//  Created by Bala on 10/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

//http://stackoverflow.com/questions/18031231/how-to-avoid-keyboard-hide-show-when-focus-changes-from-uitextfield-and-uiwebv/25415378#25415378



#import <objc/runtime.h>
#import "UIWebView+InputAccessoryView.h"

@implementation UIWebView (InputAccessoryView)

static const char * const hackishFixClassName = "UIWebBrowserViewMinusAccessoryView";
static const char * const hackishFixClassNameIPV = "UIWebBrowserViewMinusInputView";
static Class hackishFixClass = Nil;
static Class hackishFixClassIPV = Nil;

#pragma mark - inputAccessoryView

- (UIView *)cjw_inputAccessoryView {
    return objc_getAssociatedObject(self, @selector(cjw_inputAccessoryView));
}

- (void)setCjw_inputAccessoryView:(UIView *)view {
    objc_setAssociatedObject(self, @selector(cjw_inputAccessoryView), view, OBJC_ASSOCIATION_RETAIN);
    
    UIView *browserView = [self hackishlyFoundBrowserView];
    if (browserView == nil) {
        return;
    }
    [self ensureHackishSubclassExistsOfBrowserViewClass:[browserView class]];
    
    object_setClass(browserView, hackishFixClass);
    
    // This is how we will return the accessory view if we want to
    // Class normalClass = objc_getClass("UIWebBrowserView");
    // object_setClass(browserView, normalClass);
    
    [browserView reloadInputViews];
}

- (UIView *)hackishlyFoundBrowserView {
    UIScrollView *scrollView = self.scrollView;
    
    UIView *browserView = nil;
    for (UIView *subview in scrollView.subviews) {
        if ([NSStringFromClass([subview class]) hasPrefix:@"UIWebBrowserView"]) {
            browserView = subview;
            break;
        }
    }
    return browserView;
}

- (id)methodReturningCustomInputAccessoryView {
    UIView *view = self;
    UIView *customInputAccessoryView = nil;
    
    while (view && ![view isKindOfClass:[UIWebView class]]) {
        view = view.superview;
    }
    
    if ([view isKindOfClass:[UIWebView class]]) {
        UIWebView *webView = (UIWebView*)view;
        customInputAccessoryView = [webView cjw_inputAccessoryView];
    }
    
    return customInputAccessoryView;
}

- (void)ensureHackishSubclassExistsOfBrowserViewClass:(Class)browserViewClass {
    if (!hackishFixClass) {
        Class newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        IMP nilImp = [self methodForSelector:@selector(methodReturningCustomInputAccessoryView)];
        class_addMethod(newClass, @selector(inputAccessoryView), nilImp, "@@:");
        objc_registerClassPair(newClass);
        
        hackishFixClass = newClass;
    }
}

#pragma mark - InputView

- (void)ensureHackishSubclassExistsOfBrowserViewClassForInputView:(Class)browserViewClass {
    if (!hackishFixClassIPV) {
        Class newClass = objc_allocateClassPair(browserViewClass, hackishFixClassNameIPV, 0);
        newClass = objc_allocateClassPair(browserViewClass, hackishFixClassNameIPV, 0);
        IMP nilImp = [self methodForSelector:@selector(methodReturningCustomInputView)];
        class_addMethod(newClass, @selector(inputView), nilImp, "@@:");
        objc_registerClassPair(newClass);
        
        hackishFixClassIPV = newClass;
    }
}

- (id)methodReturningCustomInputView {
    UIView *view = self;
    UIView *customInputView = nil;
    
    while (view && ![view isKindOfClass:[UIWebView class]]) {
        view = view.superview;
    }
    
    if ([view isKindOfClass:[UIWebView class]]) {
        UIWebView *webView = (UIWebView*)view;
        customInputView = [webView cjw_inputView];
    }
    
    return customInputView;
}

- (void)setCjw_inputView:(UIView *)view {
    objc_setAssociatedObject(self, @selector(cjw_inputView), view, OBJC_ASSOCIATION_RETAIN);
    
    UIView *browserView = [self hackishlyFoundBrowserView];
    if (browserView == nil) {
        return;
    }
    [self ensureHackishSubclassExistsOfBrowserViewClassForInputView:[browserView class]];
    
    object_setClass(browserView, hackishFixClassIPV);
    
    // This is how we will return the accessory view if we want to
    // Class normalClass = objc_getClass("UIWebBrowserView");
    // object_setClass(browserView, normalClass);
    
    [browserView reloadInputViews];
}

- (UIView *)cjw_inputView {
    return objc_getAssociatedObject(self, @selector(cjw_inputView));
}

@end
