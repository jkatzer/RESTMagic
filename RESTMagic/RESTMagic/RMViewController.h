//
//  RMViewController.h
//  RESTMagic
//

#import <UIKit/UIKit.h>
#import "RMWebView.h"
#import "RMWebViewDelegate.h"


@interface RMViewController : UIViewController <RMWebViewDelegate> {
    RMWebView *rmWebView;
    NSURL *URL;
    NSData *objectData;
    NSString *objectName;
    NSString *template;
    id objectToRender;
}


//init methods
-(id)initWithResourceAtUrl:(NSString *)url;
-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title;
-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title andIconNamed:(NSString *)iconName;

//methods that deal with loading data and the template
-(void)loadObject;
-(void)loadTemplate;
-(void)reloadData;

-(void)objectDidLoad;
-(void)templateDidLoad;
-(void)presentTemplate:(NSString *)url withJSONData:(NSData *)jsonData;

//decode and handle messages from javascript
-(void)handleCocoaMessageFromURL:(NSURL*)cocoaURL;
-(void)handleJavascriptMessage:(NSString *)message withData:(id)data;

//Native methods that get called from JavaScript
-(void)displayAuth;
-(void)popViewController;
-(void)displayAuthWithData:(id)data fromViewController:(RMViewController *)viewController;

@end
