//
//  RMViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 7/1/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "RMViewController.h"

@interface RMViewController ()

@end

@implementation RMViewController


-(id)initWithResourceAtUrl:(NSString *)url {
    
    self = [super init];
    if (self) {
        
        self.title = [[NSURL URLWithString:url] path];
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
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
