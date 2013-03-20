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

@interface RMTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    
    RMWebView *rmWebView;
    NSURL *URL;
    NSData *objectData;
    NSString *objectName;
    NSMutableDictionary *objectDict;
    NSArray *objectArray;
    
}
- (id)initWithResourceAtUrl:(NSString *)url;
- (id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title;
- (id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title andIconNamed:(NSString *)iconName;
- (void)loadObject;
- (void)objectDidLoad;
- (NSString *)tableView:(UITableView *)tableView urlForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(UITableView *)tableView textForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
