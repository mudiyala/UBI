//
//  ForgotPasswordViewController.h
//  UBI
//
//  Created by Krishna Mudiyala on 01/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBIAppDelegate.h"

@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{
    
    UITextField *emailTextField;
    
}

@property(nonatomic, retain) IBOutlet UITextField *emailTextField;

- (IBAction)forgotButtonPressed;
- (void)processReset:(BOOL)usingFaceBook;
- (IBAction)textFieldDoneEditing:(UITextField*)sender;
- (IBAction)textFieldDidBeginEditing:(UITextField*)sender;
- (void)errorOnEntry:(NSInteger)kFieldID;
- (BOOL)validateEmail:(NSString *)candidate;

#define kEmailRequired          1
#define kEmailNotValid          2
@end
