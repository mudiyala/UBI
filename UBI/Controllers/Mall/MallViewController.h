//
//  MallViewController.h
//  UBI
//
//  Created by Krishna Mudiyala on 03/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mall.h"

@interface MallViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView *mallTable;
    NSMutableArray *mallListArray;

}

@property(nonatomic, retain) IBOutlet UITableView *mallTable;
@property(nonatomic, retain) IBOutlet NSMutableArray *mallListArray;

@end
