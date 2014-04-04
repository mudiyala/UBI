//
//  UBISingleton.h
//  UBI
//
//  Created by Krishna Mudiyala on 03/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UBISingleton : NSObject{
    
    NSMutableArray *users;
    
    NSMutableArray *targetUser;
    
}

@property(nonatomic, retain)    NSMutableArray *users;

@property(nonatomic, retain)    NSMutableArray *targetUser;


+ (id)sharedInstance;

@end