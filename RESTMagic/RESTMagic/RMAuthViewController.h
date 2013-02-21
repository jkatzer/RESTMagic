//
//  RMAuthViewController.h
//  RESTMagic
//
//  Created by Jason Katzer on 2/20/13.
//
//

#import "RMViewController.h"
#import "RMWebViewDelegate.h"

@interface RMAuthViewController : RMViewController <RMWebViewDelegate>{
    UIViewController* previousViewController;
}


-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title withPreviousViewController:(UIViewController*)previousController;

@end
