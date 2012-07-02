//
//  RMViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 7/1/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "RMViewController.h"
#import "JSONKit.h"
#import "GRMustache.h"

@interface RMViewController ()

@end

@implementation RMViewController


-(id)initWithResourceAtUrl:(NSString *)url {
    
    self = [super init];
    if (self) {
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/1/%@",url]];
        
        //this is bad code
        objectName = [url componentsSeparatedByString:@"/"][0];
        self.title = objectName;
        self.tabBarItem.image = [UIImage imageNamed:objectName];

    }
    return self;
    
}


- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    rmWebView = [[RMWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 411)];
    
    rmWebView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    rmWebView.delegate = self;
    [rmWebView loadHTMLString:@"LOADING" baseURL:[NSURL URLWithString:@"/"]];
    
    [self.view addSubview:rmWebView];
    
    [self loadObject];
}


- (id)objectDictionary
{    
    if (objectDictionary) {
        return objectDictionary;
    } else {
        [self loadObject];
        return nil;
    }
}

-(void)loadObject
{
    //make asynchronous
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLResponse* response = nil;
    NSError *err = nil;

    objectData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    objectDictionary = [objectData objectFromJSONData];
    [self objectDidLoad];
}

-(void)objectDidLoad
{
    
    NSArray *anArray = [[objectDictionary objectForKey:objectName] objectForKey:@"2012-07-01 04:20"];

    
    NSString *template = [NSString stringWithFormat:@"<ul>{{#%@}}<li>{{name}}</li>{{/%@}}</ul>", objectName, objectName];
    NSString *rendering = [GRMustacheTemplate renderObject:@{objectName:anArray} fromString:template error:NULL];
    
    
    [rmWebView loadHTMLString:rendering baseURL:[NSURL URLWithString:@"/"]];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
