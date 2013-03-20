//
//  RMAuthViewController.h
//  RESTMagic
//


#import "RMViewController.h"
#import "RMWebViewDelegate.h"

@interface RMAuthViewController : RMViewController <RMWebViewDelegate>{
    UIViewController* previousViewController;
}

- (id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title withPreviousViewController:(UIViewController*)previousController;
- (void)loginSuccess:(id)sender;
- (void)dismissModal:(id)sender;

@end
