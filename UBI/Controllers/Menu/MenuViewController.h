//
//  MenuViewController.h
//  UBI
//
//  Created by Krishna Mudiyala on 09/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountViewController.h"
#import "ChangePasswordViewController.h"
#import "UBIAppDelegate.h"

@interface MenuViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    UITableView *menuTable;
    NSMutableArray *menuListArray;
    UIImageView *backgroundImage;
    
    
}

@property(nonatomic, retain) IBOutlet UITableView *menuTable;
@property(nonatomic, retain) NSMutableArray *menuListArray;
@property(nonatomic, retain)     UIImageView *backgroundImage;

@end
