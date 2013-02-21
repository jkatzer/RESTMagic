//
//  RMAuthViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 2/20/13.
//
//

#import "RMAuthViewController.h"

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
        [(UINavigationController *)previousViewController popViewControllerAnimated:NO];
    }
}

@end
