//
//  RMFirstViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 6/30/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "RMFirstViewController.h"
#import "GRMustache.h"

@interface RMFirstViewController ()

@end

@implementation RMFirstViewController
@synthesize mustacheTestWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Renders "Hello Arthur!"
    NSString *rendering = [GRMustacheTemplate renderObject:@{@"name":@"Jason"}
                fromString:@"Hello {{name}}!"
                     error:NULL];
    
    [mustacheTestWebView loadHTMLString:rendering baseURL:[NSURL URLWithString:@"http://restmagic.org"]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidUnload {
    [self setMustacheTestWebView:nil];
    mustacheTestWebView = nil;
    [super viewDidUnload];
}
@end
