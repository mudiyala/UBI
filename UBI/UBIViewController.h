//
//  UBIViewController.h
//  UBI
//
//  Created by Krishna Mudiyala on 01/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBIAppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface UBIViewController : UIViewController<CLLocationManagerDelegate>{

    
    UITextField *emailTextField;
    UITextField *passwordTextField;
    CLLocationManager *locationManager;
    UILabel *latitude;
    UILabel *longitude;

}

@property(nonatomic, retain) IBOutlet UITextField *emailTextField;
@property(nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *longitude;

-(void)forgotPasswordButtonClicked;
-(void)registerButtonClicked;
-(void)loginButtonClicked;
-(IBAction)loginButtonPressed;

#define kEmailRequired      0
#define kEmailNotValid      1
#define kLoginPassword		2
#define kLoginPassword2		3

@end
