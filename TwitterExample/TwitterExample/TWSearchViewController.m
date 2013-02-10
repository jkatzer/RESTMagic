//
//  TWSearchViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 9/8/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "TWSearchViewController.h"

@interface TWSearchViewController ()

@end

@implementation TWSearchViewController

- (NSString *)tableView:(UITableView *)tableView textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *object = objectArray[[indexPath row]];
    return [object objectForKey:@"text"];
}

- (NSString *)tableView:(UITableView *)tableView urlForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"http://api.twitter.com/1/users/show.json?user_id=%@",[objectArray[[indexPath row]] objectForKey:@"from_user_id"]];
}

@end
