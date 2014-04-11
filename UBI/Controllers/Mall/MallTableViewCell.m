//
//  MallTableViewCell.m
//  UBI
//
//  Created by Krishna Mudiyala on 08/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "MallTableViewCell.h"

@implementation MallTableViewCell

@synthesize mallImage,mallName,mallStoresCount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
