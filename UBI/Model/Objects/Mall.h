//
//  Mall.h
//  UBI
//
//  Created by Krishna Mudiyala on 03/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mall : NSObject {

    NSString *mallName;
    
    NSString *numOfStores;
    
    NSString *image;

    NSString *thumb;
    
    NSString *mallid;


}

@property(nonatomic, retain)    NSString *mallName;

@property(nonatomic, retain)    NSString *numOfStores;

@property(nonatomic, retain)    NSString *image;

@property(nonatomic, retain)    NSString *thumb;

@property(nonatomic, retain)    NSString *mallid;

@end
