//
//  User.h
//  UBI
//
//  Created by Krishna Mudiyala on 03/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *userType;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *userEmail;
@property (strong, nonatomic) NSString *userPass;
@property (strong, nonatomic) NSString *userImage;
@property (strong, nonatomic) NSString *userThumbImage;
@property (strong, nonatomic) NSString *userAddress;
@property (strong, nonatomic) NSString *userContactNumber;


@end
