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

    
}


-(id)initWithResourceAtUrl:(NSString *)url;


@end
