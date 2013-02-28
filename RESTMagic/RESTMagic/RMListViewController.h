//
//  RMListViewController.h
//  RESTMagic
//

#import "RMTableViewController.h"

@interface RMListViewController : RMTableViewController <UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate> {
    NSString* listTitle;
}
@end
