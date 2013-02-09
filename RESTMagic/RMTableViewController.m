//
//  RMTableViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 9/8/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "RMTableViewController.h"
#import "TWAppDelegate.h"
#import "JSONKit.h"

@interface RMTableViewController ()

@end

@implementation RMTableViewController

-(id)initWithResourceAtUrl:(NSString *)url {
    
    //this is bad code
    objectName = [url componentsSeparatedByString:@"/"][0];
    
    return [self initWithResourceAtUrl:url withTitle:objectName andIconNamed:objectName];
    
    
    
    
}

-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title
{
    
    return [self initWithResourceAtUrl:url withTitle:title andIconNamed:title];
    
    
}


-(id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title andIconNamed:(NSString *)iconName
{
    self = [super init];
    if (self) {
        
        URL = [NSURL URLWithString:url];
        //make this another incoming param
        objectName = title;
        self.title = title;
        self.tabBarItem.image = [UIImage imageNamed:iconName];
        
        [self loadObject];
    }
    return self;
    
}



-(void)loadObject
{
    //make asynchronous
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLResponse* response = nil;
    NSError *err = nil;
    
    objectData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    [self objectDidLoad];
}



-(void)objectDidLoad
{
    objectDict = [objectData objectFromJSONData];
    
    NSDictionary *dictToRender = [objectDict objectForKey:objectName];
    
    NSDictionary* objectToRender;
    
    if (dictToRender != nil) {
        
        if ([dictToRender isKindOfClass:[NSDictionary class]]) {
            NSArray* arrayToRender = [(NSDictionary *)dictToRender allValues][0];
            objectToRender = @{objectName: arrayToRender};
        }
        
    } else {
        objectToRender  = objectDict;
    }

    
    
    objectDict = objectToRender;
    objectArray = [objectDict objectForKey:@"results"];
    
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (objectArray) {
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (objectDict) {
        NSLog(@"rowcount: %i", [objectArray count]);
        return [objectArray count];
    }
    
    return 0;
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [self tableView:tableView textForRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
    
    NSString * url = [self tableView:tableView urlForRowAtIndexPath:indexPath];
    if ([url length] != 0) {
        [(TWAppDelegate *)[[UIApplication sharedApplication] delegate] openURL:[NSURL URLWithString:url]];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView urlForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"";
}

- (NSString *)tableView:(UITableView *)tableView textForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"";
}

@end
