//
//  RMTableViewController.h
//  RESTMagic
//
//  Created by Jason Katzer on 9/8/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMWebView.h"
#import "RMWebViewDelegate.h"
#import "RMAPIManager.h"
#import "RMAppDelegate.h"

@interface RMTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    
    RMWebView *rmWebView;
    NSURL *URL;
    NSData *objectData;
    NSString *objectName;
    NSDictionary *objectDict;
    NSArray *objectArray;
    
}

-(id)initWithResourceAtPath:(NSString *)path;
-(id)initWithResourceAtUrl:(NSString *)url;
-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title;
-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title andIconNamed:(NSString *)iconName;

- (NSString *)tableView:(UITableView *)tableView urlForRowAtIndexPath:(NSIndexPath *)indexPath;


//-(id)object;
-(void)loadObject;

@end
