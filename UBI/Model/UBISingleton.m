//
//  UBISingleton.m
//  UBI
//
//  Created by Krishna Mudiyala on 03/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "UBISingleton.h"

@implementation UBISingleton

@synthesize users,targetUser;

static UBISingleton *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (UBISingleton *)sharedInstance {
    if (sharedInstance == nil) {
        
        sharedInstance = [[super allocWithZone:NULL] init];
        
    }
    
    return sharedInstance;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        
        users = [[NSMutableArray alloc] init];
        
        targetUser =[[NSMutableArray alloc] init];
        // Work your initialising magic here as you normally would
    }
    
    return self;
}

// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).


// We don't want to allocate a new instance, so return the current one.
//+ (id)allocWithZone:(NSZone*)zone {
//  return [[self sharedInstance] retain];
//}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end