//
//  RMViewController.m
//  RESTMagic
//
//  Created by Jason Katzer on 7/1/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "RMViewController.h"
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
    rmWebView = [[RMWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    rmWebView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    rmWebView.delegate = self;
    rmWebView.scalesPageToFit=YES;
    [rmWebView loadHTMLString:@"LOADING" baseURL:[NSURL URLWithString:@"/"]];
    
    [self.view addSubview:rmWebView];
    
    [self loadObject];
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


-(NSString *)template
{
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
    
    if ([[apiManager settings] objectForKey:@"TemplateBaseURL"]) {
        //TODO: make asynchronous
        NSURL *templateURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.html",[apiManager templateUrlForResourceAtUrl:URL]] relativeToURL:[NSURL URLWithString:[[apiManager settings] objectForKey:@"TemplateBaseURL"]]];
        NSLog(@"%@",[templateURL absoluteString]);
        return [NSString stringWithContentsOfURL:templateURL  encoding:kCFStringEncodingUTF8 error:nil];
    } else {
        NSString *filePath = [NSString stringWithFormat:@"templates%@", [[NSBundle mainBundle] pathForResource:[apiManager templateUrlForResourceAtUrl:URL] ofType:@"html"]];
        
        NSLog(@"%@",[apiManager templateUrlForResourceAtUrl:URL]);
        return [NSString stringWithContentsOfFile:filePath encoding:kCFStringEncodingUTF8 error:nil];
    }
    
    return @"";
}

-(void)objectDidLoad
{
    [self presentTemplate:[self template] withJSONData:objectData];
}


- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //take over all clicks and send them to the appdelegate to decide what to do with them.

    
    if ([[[request URL] scheme] isEqualToString:@"cocoa"]) {
        NSString* query = [[request URL] query];
        if ([[query componentsSeparatedByString:@"="] count] > 1) {
            NSString* jsonToParse = [[query componentsSeparatedByString:@"="][1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            id data = [NSJSONSerialization JSONObjectWithData:[jsonToParse dataUsingEncoding:NSUnicodeStringEncoding] options:nil error:nil];
            [self handleJavascriptMessage:[[request URL] host] withData:data];
        } else {
            [self handleJavascriptMessage:[[request URL] host] withData:nil];
        }
        return NO;
    }
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
        [apiManager openURL:request.URL withNavigationController:self.navigationController];
        return NO;
    }
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString* pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (pageTitle) {
        self.title = pageTitle;
    }
}


-(void)presentTemplate:(NSString *)template withJSONData:(NSData *)jsonData {
    
    //the point here is that someone can subclass to use a different templating engine, since new templating engines come out everyday on hackernews and github
    
    //handle a couple different cases automagically
    // 1. result is a dictionary named for the object
    // 2. result is an array with one item, a dictionary in it
    // 3. result is an array but not mapped in a dictionary of results
    // if it is none of these just pass the json right to the template
    id object = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:nil];
    id objectToRender = object;


    if ([(NSDictionary *)object respondsToSelector:@selector(objectForKey:)]) {
        //handle case #1
        NSDictionary *dictToRender = [object objectForKey:objectName];
        if (dictToRender != nil) {
            if ([dictToRender isKindOfClass:[NSDictionary class]]) {
                NSArray* arrayToRender = [(NSDictionary *)dictToRender allValues][0];
                objectToRender = @{objectName: arrayToRender};
                
            }
        }
    }
    
     else {
         //handle case #2
        if ([object isKindOfClass:[NSArray class]]) {
            if ([(NSArray *) object count] == 0) {
                objectToRender = [(NSArray *)object objectAtIndex:0];
            } else {
                //handle case #3
                objectToRender = [NSDictionary dictionaryWithObject:object forKey:@"results"];
            }
        }
    }

    if (objectToRender) {
        NSString *rendering = [GRMustacheTemplate renderObject:objectToRender fromString:template error:NULL];
        [rmWebView loadHTMLString:rendering baseURL:URL];
    } else {
        [rmWebView loadHTMLString:template baseURL:URL];
    }
}

-(void)handleJavascriptMessage:(NSString *)message withData:(id)data {
    NSLog(@"recieved from JS message:%@",message);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
