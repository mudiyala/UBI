//
//  RegisterViewController.h
//  UBI
//
//  Created by Krishna Mudiyala on 01/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{

    UITextField *emailTextField;
    UITextField *passwordTextField;
    UITextField *userNameTextField;
    UITextField *contactNumberTextField;

}

@property(nonatomic, retain) IBOutlet UITextField *emailTextField;
@property(nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property(nonatomic, retain) IBOutlet UITextField *userNameTextField;
@property(nonatomic, retain) IBOutlet UITextField *contactNumberTextField;

- (IBAction)registerButtonPressed;
- (void)processRegistration:(BOOL)usingFaceBook;
- (IBAction)textFieldDoneEditing:(UITextField*)sender;
- (IBAction)textFieldDidBeginEditing:(UITextField*)sender;
- (void)errorOnEntry:(NSInteger)kFieldID;
- (BOOL)validateEmail:(NSString *)candidate;
- (IBAction)selectedButtonPressed:(UIButton*)sender;

#define kUserName               0
#define kEmailRequired          1
#define kEmailNotValid          2
#define kPasswordRequired       3
#define kContactNumberRequired	4
#define kPasswordNotValid       5
#define kContactNumberNotValid  6


@end
