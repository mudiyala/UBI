//
//  MallListViewController.h
//  UBI
//
//  Created by Krishna Mudiyala on 08/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "UBIAppDelegate.h"
#import "Mall.h"

@interface MallListViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *mallTable;
    NSMutableArray *mallListArray;
    UIImageView *backgroundImage;
    
}

@property(nonatomic, retain) IBOutlet UITableView *mallTable;
@property(nonatomic, retain) NSMutableArray *mallListArray;
@property(nonatomic, retain)     UIImageView *backgroundImage;
@end
