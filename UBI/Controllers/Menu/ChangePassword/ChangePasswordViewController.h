//
//  ChangePasswordViewController.h
//  UBI
//
//  Created by Krishna Mudiyala on 10/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBIAppDelegate.h"
#import "User.h"

@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *oldPasswordTextField;
    UITextField *passwordTextField;
    UITextField *confirmPasswordTextField;

}

@property(strong, retain) IBOutlet UITextField *oldPasswordTextField;
@property(strong, retain) IBOutlet UITextField *passwordTextField;
@property(strong, retain) IBOutlet UITextField *confirmPasswordTextField;

- (IBAction)submitButtonPressed;
- (IBAction)textFieldDoneEditing:(UITextField*)sender;
- (IBAction)textFieldDidBeginEditing:(UITextField*)sender;
- (void)errorOnEntry:(NSInteger)kFieldID;

#define kPasswordRequired       1
#define kPasswordNotValid       2
#define kPasswordMismatch       3
#define kPasswordInValid        4



@end
