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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *object = objectArray[[indexPath row]];
    cell.textLabel.text = [object objectForKey:@"text"];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];

    NSString *url = [NSString stringWithFormat:@"http://api.twitter.com/1/users/show.json?user_id=%@",[objectArray[[indexPath row]] objectForKey:@"from_user_id"]];
    
    
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:[apiManager viewControllerForResourceAtURL:[NSURL URLWithString:url]] animated:YES];
     
}

@end
