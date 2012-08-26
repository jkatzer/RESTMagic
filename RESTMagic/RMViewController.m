//
//  RMViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 7/1/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "RMViewController.h"
#import "RMAppDelegate.h"
#import "JSONKit.h"
#import "GRMustache.h"


@implementation RMViewController


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
        
    }
    return self;

}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    rmWebView = [[RMWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 411)];
    rmWebView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    rmWebView.delegate = self;
    [rmWebView loadHTMLString:@"LOADING" baseURL:[NSURL URLWithString:@"/"]];
    
    [self.view addSubview:rmWebView];
    
    [self loadObject];
}


/*- (id)objectDictionary
{    
    if (objectDictionary) {
        return objectDictionary;
    } else {
        [self loadObject];
        return nil;
    }
}*/

-(void)loadObject
{
    //make asynchronous
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLResponse* response = nil;
    NSError *err = nil;

    objectData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    [self objectDidLoad];
}


-(NSString *)template
{
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
    
    NSLog(@"%@",[apiManager templateUrlForResourceAtUrl:URL]);
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[apiManager templateUrlForResourceAtUrl:URL] ofType:@"html"];
    
    
    return [NSString stringWithContentsOfFile:filePath encoding:kCFStringEncodingUTF8 error:nil];
    
}

-(void)objectDidLoad
{
    [self presentTemplate:[self template] withJSONData:objectData];
}


- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //while developing we are just going to take over all clicks

    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        [(RMAppDelegate *)[[UIApplication sharedApplication] delegate] openURL:[request URL]];
        
        return NO;
    }
    return YES;

    // Determine if we want the system to handle it.
   /* 
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
    NSURL *url = request.URL;
    
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
            return NO;
        }
    }
    return YES;*/
}


-(void)presentTemplate:(NSString *)template withJSONData:(NSData *)jsonData {
    
    //the point here is that someone can subclass to use a different templating engine, since new templating engines come out everyday on hackernews and github
    
    NSDictionary* objectDictionary = [jsonData objectFromJSONData];

    NSDictionary *dictToRender = [objectDictionary objectForKey:objectName];
    
    NSDictionary* objectToRender;
    
    if (dictToRender != nil) {
        
        if ([dictToRender isKindOfClass:[NSDictionary class]]) {
            NSArray* arrayToRender = [(NSDictionary *)dictToRender allValues][0];
            objectToRender = @{objectName: arrayToRender};
        }

    } else {
        objectToRender  = objectDictionary;
    }

    

    
    NSString *rendering = [GRMustacheTemplate renderObject:objectToRender fromString:template error:NULL];
    
    NSLog(@"%@",rendering);
    [rmWebView loadHTMLString:rendering baseURL:URL];
    
    
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
