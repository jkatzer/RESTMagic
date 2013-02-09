//
//  TWTrendsViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 2/4/13.
//  Copyright (c) 2013 Jason Katzer. All rights reserved.
//

#import "TWTrendsViewController.h"
#import "RMAppDelegate.h"

@interface TWTrendsViewController ()

@end

@implementation TWTrendsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Trends";
        self.tabBarItem.image = [UIImage imageNamed:@"trends"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([objectDict objectForKey:@"trends"]) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([objectDict objectForKey:@"trends"]) {
        return [[objectDict objectForKey:@"trends"] count];
    }

    return 0;
}

- (NSString *)tableView:(UITableView *)tableView textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *object = [objectDict objectForKey:@"trends"][[indexPath row]];
    return [object objectForKey:@"name"];
}


- (NSString *)tableView:(UITableView *)tableView urlForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@",[[objectDict objectForKey:@"trends"][[indexPath row]] objectForKey:@"query"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];    
}



@end
