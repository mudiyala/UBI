//
//  MallTableViewCell.h
//  UBI
//
//  Created by Krishna Mudiyala on 08/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallTableViewCell : UITableViewCell{

    UIImageView *mallImage;
    UILabel *mallName;
    UILabel *mallStoresCount;
}

@property(nonatomic, retain) IBOutlet UIImageView *mallImage;
@property(nonatomic, retain) IBOutlet UILabel *mallName;
@property(nonatomic, retain) IBOutlet UILabel *mallStoresCount;


@end
