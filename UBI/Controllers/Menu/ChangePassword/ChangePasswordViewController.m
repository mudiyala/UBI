//
//  ChangePasswordViewController.m
//  UBI
//
//  Created by Krishna Mudiyala on 10/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

@synthesize oldPasswordTextField;
@synthesize confirmPasswordTextField,passwordTextField;


//@synthesize oldPasswordTextField,passwordTextField,confirmPasswordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:FALSE animated:TRUE];
    self.navigationItem.title = @"Account";

    oldPasswordTextField.textColor = [UIColor grayColor];
    passwordTextField.textColor = [UIColor blackColor];
    confirmPasswordTextField.textColor = [UIColor blackColor];
    
    oldPasswordTextField.font=[UIFont fontWithName:@"Roboto-Italic" size:15];
    
    passwordTextField.font=[UIFont fontWithName:@"Roboto-Italic" size:15];
    
    confirmPasswordTextField.font = [UIFont fontWithName:@"Roboto-Italic" size:15];
    
    
    UBISingleton *sharedObj = [UBISingleton sharedInstance];
    

    User *uObj2 = [sharedObj.users objectAtIndex:0];
    
    oldPasswordTextField.text = [NSString stringWithFormat:@"%@",uObj2.userPass];
    
    oldPasswordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfield-left-key.png"]];
    
    oldPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfield-left-key.png"]];
    
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    confirmPasswordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfield-left-key.png"]];
    
    confirmPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
	// Do any additional setup after loading the view.
}

/* Validations when user click on login button */

-(IBAction)submitButtonPressed{
    
	//NSString *emailStr = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //  NSString *pass = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *npass = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *cpass = [self.confirmPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([npass isEqual:@""] || [npass length]==0){
		
		[self errorOnEntry:kPasswordRequired];
		return;
		
	}
	else if([npass length]< 6){
		
		[self errorOnEntry:kPasswordNotValid];
		return;
		
	}
    else if([npass length] > 16){
		
		[self errorOnEntry:kPasswordNotValid];
		return;
		
	}
    if([cpass isEqual:@""] || [cpass length]==0){
		
		[self errorOnEntry:kPasswordRequired];
		return;
		
	}
	else if([cpass length]< 6){
		
		[self errorOnEntry:kPasswordNotValid];
		return;
		
	}
    else if([cpass length] > 16){
		
		[self errorOnEntry:kPasswordNotValid];
		return;
		
	}
    
    else if([oldPasswordTextField.text isEqual:npass]){
		
		[self errorOnEntry:kPasswordInValid];
		return;
		
	}
    else  if(![npass isEqual:cpass]){
		
		[self errorOnEntry:kPasswordMismatch];
		return;
		
	}
	[self processRegistration:NO];
    
}

/* error messages based on user defined error constants  */

- (void)errorOnEntry:(NSInteger)kFieldID{
	
	NSString *errorString = @"";
	
	switch (kFieldID) {
            

		case kPasswordRequired:
			
			errorString = @"Please enter your password.";
			break;
		case kPasswordNotValid:
			
			errorString = @"Password should contain 6 to 16 characters";
			break;
		case kPasswordInValid:
			
			errorString = @"New password cannot be old password.";
			break;
		case kPasswordMismatch:
			
			errorString = @"New password doesn't match.";
			break;
			
		default:
			errorString = @"Unknown errorOnEntry().";
			break;
	}
	
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	
	[alert show];
	
}



/* Method implementation for email validation */

- (BOOL)validateEmail:(NSString *)candidate
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:candidate];
}


/* Method implementation for registration request. Called after successful validation */

- (void)processRegistration:(BOOL)usingFaceBook
{
    
    [passwordTextField resignFirstResponder];
    
    [confirmPasswordTextField resignFirstResponder];
    
    
    NSString *npass = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *oldpass = [self.oldPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UBISingleton *sharedObj = [UBISingleton sharedInstance];
    
    User *uObj = [sharedObj.users objectAtIndex:0];
    
    NSDictionary *parameters = [NSDictionary new];
    
    parameters = @{@"userId":uObj.userID,
                   @"oldPassword":oldpass,
                   @"newPassword":npass};
    
    // [[NSNotificationCenter defaultCenter] addObserver:self
    //                            selector:@selector(dismissUserRegView:)
    //                              name:@"NewUserRegistration"
    //                          object:nil];
    
    [self processUserRegistration:parameters usingFacebook:FALSE];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==99) {
        
        if (buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:FALSE];
        }
    }
}

-(IBAction)textFieldDoneEditing:(UITextField*)sender
{
    switch(sender.tag){
        case 1:
            [confirmPasswordTextField resignFirstResponder];
            break;
            
    }
}

-(IBAction)textFieldDidBeginEditing:(UITextField *)sender{
    
    if(sender.tag>4 ){
        
        //  isKeypadOn=TRUE;
        if (self.view.frame.origin.y==0) {
            
            
            
            [UIView animateWithDuration:0.3
                             animations:^{
                                 if (TRUE) {
                                 }
                                 else {
                                     CGRect frame = self.view.frame;
                                     frame.origin.y = -70;
                                     self.view.frame = frame;
                                 }
                             }
                             completion:^(BOOL finished){
                             }];
        }
    }
    else{
        
        if (self.view.frame.origin.y<0) {
            [UIView animateWithDuration:0.3
                             animations:^{
                                 CGRect rect = self.view.frame;
                                 rect.origin.y = 0;
                                 int x = 460;
                                 if(TRUE){
                                     
                                     x = x+88;
                                 }
                                 rect.size.height = x;
                                 
                                 self.view.frame = rect;
                             }completion:^(BOOL finished){
                                 
                             }];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag <2) {
        
        //  isKeypadOn = TRUE;
        
        switch (textField.tag) {
            case 1:
                [confirmPasswordTextField becomeFirstResponder];
                break;
        }
        return NO;
    }
    else{
        [confirmPasswordTextField resignFirstResponder];
        
        return YES;
        
    }
}

- (void)processUserRegistration:(NSDictionary *)params usingFacebook:(BOOL)usingFaceBook
{
    UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *url = [NSString stringWithFormat:@"%@changePassword?",appDelegate.appBaseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [MBHUDView hudWithBody:@"Please wait..." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:14.0 show:YES];
    
    __block BOOL loggedIn;
    
    loggedIn = NO;
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseArray  = (NSDictionary *)responseObject;
        
        [MBHUDView dismissCurrentHUD];
        
        if (!usingFaceBook) {
            if (responseArray == nil) {
                NSString *msg = [responseArray valueForKey:@"message"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
                [alert show];
                return;
            }
        }
        
        NSString *result = [responseArray valueForKey:@"result"];
        NSLog(@"the result is: %@", result);
        if ([result intValue]==0) {
            NSString *msg  = [responseArray valueForKey:@"message"];
            
            if ((([msg isEqualToString:@"User already exists with this Email."]) ||
                 ([msg isEqualToString:@"User already exists with this User Name."])) && (usingFaceBook)){
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Error"
                                                                message:msg
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            return;
        }
        else if ([result intValue]==1){
            
            loggedIn = YES;
            
            UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
            
            
            //initWithImage:[UIImage imageNamed:@"back_btn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
            
            
            
            UBISingleton *sharedObj = [UBISingleton sharedInstance];
            
          
            
            User *uObj2 = [sharedObj.users objectAtIndex:0];
            
            [uObj2 setUserPass:confirmPasswordTextField.text];
            
            NSString *msg = [responseArray valueForKey:@"message"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:msg   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=99;
            [alert show];
            
            
            return;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBHUDView dismissCurrentHUD];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription]   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
