//
//  RMListViewController.h
//  RESTMagic
//

#import "RMTableViewController.h"

@interface RMListViewController : RMTableViewController <UITableViewDataSource, UITableViewDelegate> {
    NSString* listTitle;
}
@end
