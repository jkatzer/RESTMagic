//
//  RMViewController.h
//  RESTMagic
//
//  Created by Jason Katzer on 7/1/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMWebView.h"
#import "RMWebViewDelegate.h"


@interface RMViewController : UIViewController <RMWebViewDelegate> {
    
    RMWebView *rmWebView;
    NSURL *URL;
    NSData *objectData;
    NSString *objectName;

}


-(id)initWithResourceAtUrl:(NSString *)url;
-(id)object;
-(void)loadObject;


-(void)presentTemplate:(NSString *)url withJSONData:(NSData *)jsonData;

@end
