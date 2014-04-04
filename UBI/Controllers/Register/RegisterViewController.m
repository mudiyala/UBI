//
//  RegisterViewController.m
//  UBI
//
//  Created by Krishna Mudiyala on 01/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "RegisterViewController.h"
#import "UBIAppDelegate.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize emailTextField,passwordTextField,contactNumberTextField,userNameTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:FALSE animated:TRUE];
    self.navigationItem.title = @"Register";
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
    
    self.navigationItem.leftBarButtonItem = barButton;
    
    emailTextField.textColor = [UIColor blackColor];
    passwordTextField.textColor = [UIColor blackColor];
    contactNumberTextField.textColor = [UIColor blackColor];
    userNameTextField.textColor = [UIColor blackColor];
    
    
    emailTextField.font=[UIFont fontWithName:@"Roboto-Italic" size:15];
    
    passwordTextField.font=[UIFont fontWithName:@"Roboto-Italic" size:15];
    
    contactNumberTextField.font = [UIFont fontWithName:@"Roboto-Italic" size:15];
    userNameTextField.font = [UIFont fontWithName:@"Roboto-Italic" size:15];

}


#pragma mark - screen actions
/* Method implementation for navigating to loginscreen */

-(IBAction)backButtonPressed{
    
    [self.navigationController setNavigationBarHidden:TRUE animated:TRUE];
    [self.navigationController popViewControllerAnimated:FALSE];
	
}


/* Validations when user click on login button */

-(IBAction)registerButtonPressed{
    
	NSString *emailStr = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *pass = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *uname = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *contactNumber = [self.contactNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    
    if([uname isEqual:@""] || [uname length]==0){
		
		[self errorOnEntry:kUserName];
		return;
		
	}
	if([emailStr isEqual:@""] || [emailStr length]==0){
		
		[self errorOnEntry:kEmailRequired];
		return;
		
	}
	BOOL emailValidation = [self validateEmail:emailStr];
	
	if (!emailValidation) {
        
		[self errorOnEntry:kEmailNotValid];
        
		return;
	}
    
	if([pass isEqual:@""] || [pass length]==0){
		
		[self errorOnEntry:kPasswordRequired];
		return;
		
	}
	else if([pass length]< 6){
		
		[self errorOnEntry:kPasswordNotValid];
		return;
		
	}
    else if([pass length] > 16){
		
		[self errorOnEntry:kPasswordNotValid];
		return;
		
	}
    else if([contactNumber intValue]==0){
		
		[self errorOnEntry:kContactNumberRequired];
		return;
		
	}
	else if([contactNumber length]< 9 || [contactNumber length]>13){
		
		[self errorOnEntry:kContactNumberNotValid];
		return;
		
	}
    
	[self processRegistration:NO];
    
}

/* error messages based on user defined error constants  */

- (void)errorOnEntry:(NSInteger)kFieldID{
	
	NSString *errorString = @"";
	
	switch (kFieldID) {
            
        case kUserName:
            errorString = @"Please enter user name.";
			break;
            
            
		case kEmailRequired:
			
			errorString = @"Please enter an email address.";
			break;
            
		case kEmailNotValid:
			
			errorString = @"Please enter a valid email address.";
			break;
		case kPasswordRequired:
			
			errorString = @"Please enter your password.";
			break;
		case kPasswordNotValid:
			
			errorString = @"Password should contain 6 to 16 characters";
			break;
		case kContactNumberRequired:
			
			errorString = @"Please enter your contact number.";
			break;
		case kContactNumberNotValid:
			
			errorString = @"Please enter valid contact number.";
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
    [emailTextField resignFirstResponder];
    
    [passwordTextField resignFirstResponder];
    
    [userNameTextField resignFirstResponder];
    
    [contactNumberTextField resignFirstResponder];
    
    NSString *emailStr = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pass = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *userStr = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *contactStr = [self.contactNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSDictionary *parameters = [NSDictionary new];
    
    parameters = @{@"userName":userStr,
                   @"password":pass,
                   @"email":emailStr,
                   @"contactNumber":contactStr,
                   @"address":@""};
    
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
            [emailTextField becomeFirstResponder];
            break;
        case 2:
            [passwordTextField becomeFirstResponder];
            break;
        case 3:
            [contactNumberTextField resignFirstResponder];
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
    if(textField.tag <4) {
        
      //  isKeypadOn = TRUE;
        
        switch (textField.tag) {
            case 1:
                [emailTextField becomeFirstResponder];
                break;
            case 2:
                [passwordTextField becomeFirstResponder];
                break;
            case 3:
                [contactNumberTextField becomeFirstResponder];
                break;
           }
        return NO;
    }
    else{
        [contactNumberTextField resignFirstResponder];
        
        return YES;
        
    }
}

- (void)processUserRegistration:(NSDictionary *)params usingFacebook:(BOOL)usingFaceBook
{
    UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *url = [NSString stringWithFormat:@"%@userSignup?",appDelegate.appBaseURL];
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
            /*
            if (usingFaceBook) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FaceBookUserRegistered" object:nil];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NewUserRegistration" object:nil];
                NSString *msg = [responseArray valueForKey:@"message"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Response" message:msg   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag=99;
                [alert show];
                
                NSString *userID  = [responseArray valueForKey:@"userID"];
                
              //  [self uploadImage:userID];
            }
            
            */
            
            
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

-(IBAction)selectedButtonPressed:(UIButton*)sender{
    
}

#pragma mark - PlayerDetailsViewControllerDelegate

- (void)registerViewControllerDidFail:(RegisterViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerViewControllerDidSuccessful:(RegisterViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
