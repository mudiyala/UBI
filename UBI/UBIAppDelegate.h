//
//  UBIAppDelegate.h
//  UBI
//
//  Created by Krishna Mudiyala on 01/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
#import "MBHUDView.h"
#import "UBISingleton.h"
#import "User.h"
@interface UBIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *appBaseURL;
@property (strong, nonatomic) NSString *appLatitude;
@property (strong, nonatomic) NSString *appLongitude;

@end
