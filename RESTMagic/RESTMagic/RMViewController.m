//
//  RMViewController.m
//  RESTMagic
//

#import "RMViewController.h"
#import "RMAPIManager.h"
#import "GRMustache.h"

@implementation RMViewController


#pragma mark init methods

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


#pragma mark viewController methods
- (void)loadView
{
    //TODO: make this set automatically based on whats on the screen
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    rmWebView = [[RMWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    rmWebView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    rmWebView.delegate = self;
    rmWebView.scalesPageToFit=YES;

    //TODO: figure out why this doesn't work
    [[rmWebView scrollView] setScrollsToTop:YES];
    
    [self.view addSubview:rmWebView];
    
    [self loadObject];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //TODO: move this kind of stuff into either the RMWebView class, or if its not for everyone, into the RMViewcontroller subclass
    [rmWebView.scrollView setContentSize: CGSizeMake(rmWebView.frame.size.width, rmWebView.scrollView.contentSize.height)];
}

#pragma mark data and template loading methods

-(void)loadObject
{
    //TODO: handle empty responses
    //TODO: handle error responses
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        objectData = data;
        
        NSString* contentTypeKey = @"";
        NSString* contentType = @"application/json";
        for (NSString* key in [[(NSHTTPURLResponse*)response allHeaderFields] allKeys]) {
            if ([[key lowercaseString] isEqualToString:@"content-type"]) {
                contentTypeKey = key;
            }
        }
        if (contentTypeKey) {
            contentType = [[(NSHTTPURLResponse*)response allHeaderFields] objectForKey:contentTypeKey];
        }
        if ([[[contentType lowercaseString] componentsSeparatedByString:@";"][0] isEqualToString:@"text/html"]) {
            NSString *htmlString = [[NSString alloc] initWithData:objectData encoding:kCFStringEncodingUTF8];
            [rmWebView loadHTMLString:htmlString baseURL:URL];
        } else {
            [self objectDidLoad];
        }

    }];
}


-(void)loadTemplate
{
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
    NSURL* templateURL;
    
    if ([[apiManager settings] objectForKey:@"TemplateBaseURL"]) {
        //TODO: make asynchronous
        templateURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.html",[apiManager templateUrlForResourceAtUrl:URL]] relativeToURL:[NSURL URLWithString:[[apiManager settings] objectForKey:@"TemplateBaseURL"]]];
        NSLog(@"RMViewcontroller: templateURL: %@",[templateURL absoluteString]);
    } else {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"templates/%@", [apiManager templateUrlForResourceAtUrl:URL] ] ofType:@"html"];
        NSLog(@"RMViewcontroller: templateURL: templates/%@.html",[apiManager templateUrlForResourceAtUrl:URL]);
        template = [NSString stringWithContentsOfFile:filePath encoding:kCFStringEncodingUTF8 error:nil];
        [self templateDidLoad];
    }
    
    if (templateURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:templateURL];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
            template = [[NSString alloc] initWithData:data encoding:kCFStringEncodingUTF8];
            [self templateDidLoad];
        }];
    }
}

-(void)reloadData {
    [self loadObject];
}

-(void)objectDidLoad
{
    
    //TODO: add some way to check data before rendering it, such as for messages from the server. make this as easily subclassable method
    
    
    [self presentTemplate:template withJSONData:objectData];
}

-(void)templateDidLoad{
    if (objectToRender) {
        NSString *rendering = [GRMustacheTemplate renderObject:objectToRender fromString:template error:NULL];
        [rmWebView loadHTMLString:rendering baseURL:URL];
    } else {
        [rmWebView loadHTMLString:template baseURL:URL];
    }
}

-(void)presentTemplate:(NSString *)templateString withJSONData:(NSData *)jsonData {
    
    //the point here is that someone can subclass to use a different templating engine, since new templating engines come out everyday on hackernews and github
    
    //handle a couple different cases automagically
    // 1. result is a dictionary named for the object
    // 2. result is an array with one item, a dictionary in it
    // 3. result is an array but not mapped in a dictionary of results
    // if it is none of these just pass the json right to the template
    id object = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:nil];
    objectToRender = object;
    
    
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
    if (templateString) {
        template = templateString;
    }
    if (template){
        [self templateDidLoad];
    } else {
        [self loadTemplate];
    }
}


#pragma mark UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //take over all clicks and send them to the appdelegate to decide what to do with them.
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
    
    if ([[[request URL] scheme] isEqualToString:@"cocoa"]) {
        [self handleCocoaMessageFromURL:[request URL]];
        return NO;
    }
    
    if (navigationType == UIWebViewNavigationTypeReload) {
        return YES;
    }
    
    if (navigationType != UIWebViewNavigationTypeOther) {
        RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
        [apiManager openURL:request.URL withNavigationController:self.navigationController];
        return NO;
    }

    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];

    NSString* pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([pageTitle length]) {
        self.title = pageTitle;
    }

}

#pragma mark javascript bridge

-(void)handleCocoaMessageFromURL:(NSURL*)cocoaURL{
    NSString* query = [cocoaURL query];
    if ([[query componentsSeparatedByString:@"="] count] > 1) {
        NSString* jsonToParse = [[query componentsSeparatedByString:@"="][1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        id data = [NSJSONSerialization JSONObjectWithData:[jsonToParse dataUsingEncoding:NSUnicodeStringEncoding] options:nil error:nil];
        [self handleJavascriptMessage:[cocoaURL host] withData:data];
    } else {
        [self handleJavascriptMessage:[cocoaURL host] withData:nil];
    }
}

-(void)handleJavascriptMessage:(NSString *)message withData:(id)data {
    NSLog(@"RMViewcontroller: recieved JS message:%@",message);
    if ([[message lowercaseString] isEqualToString:@"displayauth"]) {
        [self displayAuthWithData:data fromViewController:self];
    }
    if ([[message lowercaseString] isEqualToString:@"popviewcontroller"]) {
        [self popViewController];
    }
    
}

-(void)popViewController{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [[self parentViewController] dismissModalViewControllerAnimated:YES];
    }
}

-(void)displayAuth{
    [self displayAuthWithData:nil fromViewController:self];
}

-(void)displayAuthWithData:(id)data fromViewController:(RMViewController *)viewController {
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
    UINavigationController *authNavigationController = [UINavigationController alloc];
    if ([[apiManager settings] objectForKey:@"loginUrl"]) {
        [self presentModalViewController:[authNavigationController initWithRootViewController:[apiManager authViewControllerForResourceAtPath:[[apiManager settings] objectForKey:@"loginUrl"] withPreviousViewController:self.navigationController]] animated:YES];
    } else {
        [self presentModalViewController:[authNavigationController initWithRootViewController:[apiManager authViewControllerForResourceAtPath:@"login" withPreviousViewController:self.navigationController]] animated:YES];
    }
}


@end
