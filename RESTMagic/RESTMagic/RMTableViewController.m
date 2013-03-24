//
//  RMTableViewController.m
//  RESTMagic
//


#import "RMTableViewController.h"

@implementation RMTableViewController

- (id)initWithResourceAtUrl:(NSString *)url
{
  //this is bad code
  objectName = [url componentsSeparatedByString:@"/"][0];
  return [self initWithResourceAtUrl:url withTitle:objectName andIconNamed:objectName];
}

- (id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title
{
  return [self initWithResourceAtUrl:url withTitle:title andIconNamed:title];
}

- (id)initWithResourceAtUrl:(NSString *)url withTitle:(NSString *)title andIconNamed:(NSString *)iconName
{
  self = [super init];
  if (self) {
      URL = [NSURL URLWithString:url];
      objectName = title;
      self.title = [title capitalizedString];
      self.tabBarItem.image = [UIImage imageNamed:[iconName lowercaseString]];
      NSLog(@"iconNamed: %@", [iconName lowercaseString]);
  }
  return self;
}

-(void)viewDidLoad{
  [self loadObject];
}

- (void)loadObject
{
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  
  [NSURLConnection sendAsynchronousRequest:request
                                     queue:queue
                         completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
    if (error) {
      [[RMAPIManager sharedAPIManager] handleError:error
                                fromViewController:self];
      [self objectDidNotLoad];
    } else {
      objectData = data;
    }
    [self objectDidLoad];
  }];
}

- (void)objectDidLoad
{
  objectDict = [NSJSONSerialization JSONObjectWithData:objectData
                                               options:NSJSONReadingMutableContainers
                                                 error:nil];
  
  NSDictionary *dictToRender = objectDict[objectName];
  NSDictionary* objectToRender;
  
  if (dictToRender != nil) {
    if ([dictToRender isKindOfClass:[NSDictionary class]]) {
        NSArray* arrayToRender = [(NSDictionary *)dictToRender allValues][0];
        objectToRender = @{objectName: arrayToRender};
    }
  } else {
      objectToRender  = objectDict;
  }
  
  objectDict = [objectToRender copy];
  objectArray = objectDict[@"results"];
  
  [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                   withObject:nil
                                waitUntilDone:NO];
}

- (void)objectDidNotLoad{
  NSLog(@"object did not load");
}

- (void)reloadData{
  [self loadObject];
}

- (void)showError:(NSError*)error{
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  if (objectArray) {
    return 1;
  }
  return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (objectDict) {
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
  
  cell.textLabel.text = [NSString stringWithFormat:@"%@",
                         [self tableView:tableView textForRowAtIndexPath:indexPath]];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
  
  NSString * url = [self tableView:tableView urlForRowAtIndexPath:indexPath];
  if ([url length] != 0) {
    [apiManager  openURL:[NSURL URLWithString:url]
withNavigationController:self.navigationController];
  }
  
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView urlForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"";
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if ([[self tableView:tableView urlForRowAtIndexPath:indexPath] length]!= 0) {
    return indexPath;
  }
  return nil;
}

- (NSString *)tableView:(UITableView *)tableView textForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"";
}

@end
