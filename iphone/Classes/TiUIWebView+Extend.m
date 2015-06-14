//
//  TiUIWebView+Extend.m
//  ExtWebView
//
//  Created by Martin Wildfeuer on 12.02.15.
//
//

#import "TiUIWebView+Extend.h"
#import "TiUtils.h"
#import <objc/runtime.h>

@implementation TiUIWebView (Extend)

-(void)setZoomScale_:(id)value
{
    CGFloat scale = [TiUtils floatValue:value def:0.0f];
    [[self scrollview] setZoomScale:scale animated:YES];
}

- (void)scrollToTop:(id)args
{
    BOOL animated = [TiUtils boolValue:@"animated" properties:[args objectAtIndex:0] def:YES];
    [[self scrollview] setContentOffset:CGPointZero animated:animated];
}

-(void)scrollTo:(id)args
{
    CGFloat offsetX = [TiUtils floatValue:@"x" properties:[args objectAtIndex:0] def:0];
    CGFloat offsetY = [TiUtils floatValue:@"y" properties:[args objectAtIndex:0] def:0];
    BOOL animated = [TiUtils boolValue:@"animated" properties:[args objectAtIndex:0] def:YES];
    CGPoint newOffset = CGPointMake(offsetX, offsetY);
    [[self scrollview] setContentOffset:newOffset animated:animated];

}

-(void)scrollToBottom:(id)args
{
    BOOL animated = [TiUtils boolValue:@"animated" properties:[args objectAtIndex:0] def:YES];
    
    UIScrollView *currScrollView = [self scrollview];
                                    
    CGSize svContentSize = currScrollView.contentSize;
    CGSize svBoundSize = currScrollView.bounds.size;
    CGFloat svBottomInsets = currScrollView.contentInset.bottom;
    
    CGFloat bottomHeight = svContentSize.height - svBoundSize.height + svBottomInsets;
    CGFloat bottomWidth = svContentSize.width - svBoundSize.width;
    
    CGPoint newOffset = CGPointMake(bottomWidth, bottomHeight);
    
    [currScrollView setContentOffset:newOffset animated:animated];
}

- (void)disableScrolling:(id)value
{
    BOOL allowed = ![TiUtils boolValue:value def:YES];
    [[self scrollview] setScrollEnabled:allowed];    
}

-(void)enableCookieAcceptPolicyAlways:(id)args
{
    // via outdated fork : https://github.com/cmartyniuk/titanium-module-extended-webview    
    // http://stackoverflow.com/questions/14448373/3rd-party-cookies-in-an-ios6-uiwebview/14465407#14465407    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    storage.cookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;    
}

-(void)setUserAgent:(id)userAgent
{
    // via outdated fork : https://github.com/cmartyniuk/titanium-module-extended-webview 
    // http://stackoverflow.com/questions/8487581/uiwebview-ios5-changing-user-agent
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[TiUtils stringValue:userAgent], @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

@end
