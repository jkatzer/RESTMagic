//
//  RMAuthViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 2/20/13.
//
//

#import "RMAuthViewController.h"
#import "RMAPIManager.h"

@implementation RMAuthViewController

-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title withPreviousViewController:(UIViewController*)previousController
{
    self = [super initWithResourceAtUrl:url withTitle:title andIconNamed:nil];
    if (self) {
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissModal:)];
        self.navigationItem.rightBarButtonItem = anotherButton;
        previousViewController = previousController;
    }
    return self;
    
}

-(void)dismissModal:(id)sender{
    //TODO:check what happens when navigationcontroller has only one view
    [previousViewController dismissViewControllerAnimated:YES completion:^{}];
    if ([previousViewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)previousViewController popViewControllerAnimated:YES];
    }
}

- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //take over all clicks and keep them in this view for now
    
    if ([[[request URL] scheme] isEqualToString:@"cocoa"]) {
        [self handleCocoaMessageFromURL:[request URL]];
        [self loginSuccess:nil];
        return NO;
    }

    return YES;
}


-(void)handleJavascriptMessage:(NSString *)message withData:(id)data {
    [super handleJavascriptMessage:message withData:data];
    if ([[message lowercaseString] isEqualToString:@"loginSuccess"]) {
        [self loginSuccess:nil];
    }
}


-(void)loginSuccess:(id)sender{
    //TODO: figure out why this won't close while its still "loading"
    
    [previousViewController dismissViewControllerAnimated:YES completion:^{}];
    if ([previousViewController isKindOfClass:[UINavigationController class]]) {
        [[[(UINavigationController*)previousViewController viewControllers] lastObject] reloadData];
    } else {
        if ([previousViewController respondsToSelector:@selector(reloadData)]) {
            [(id)previousViewController reloadData];
        }
    }

}

@end
