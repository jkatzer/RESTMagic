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
#import "RMAPIManager.h"


@interface RMViewController : UIViewController <RMWebViewDelegate> {
    
    RMWebView *rmWebView;
    NSURL *URL;
    NSData *objectData;
    NSString *objectName;

}

-(id)initWithResourceAtPath:(NSString *)path;
-(id)initWithResourceAtUrl:(NSString *)url;
-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title;
-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title andIconNamed:(NSString *)iconName;

//-(id)object;
-(void)loadObject;
-(void)objectDidLoad;
-(NSString *)template;

-(void)handleJavascriptMessage:(NSString *)message withData:(id)data;
-(void)presentTemplate:(NSString *)url withJSONData:(NSData *)jsonData;

@end
