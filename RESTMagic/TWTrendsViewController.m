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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if ([objectDict objectForKey:@"trends"]) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if ([objectDict objectForKey:@"trends"]) {
        return [[objectDict objectForKey:@"trends"] count];
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *object = [objectDict objectForKey:@"trends"][[indexPath row]];
    cell.textLabel.text = [object objectForKey:@"name"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
    
    NSString *url = [[NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@",[[objectDict objectForKey:@"trends"][[indexPath row]] objectForKey:@"query"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url is %@", url);
    
    
    [(RMAppDelegate *)[[UIApplication sharedApplication] delegate] openURL:[NSURL URLWithString:url]];
}

@end
