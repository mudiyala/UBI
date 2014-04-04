//
//  ForgotPasswordViewController.m
//  UBI
//
//  Created by Krishna Mudiyala on 01/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

@synthesize emailTextField;


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
    self.navigationItem.title = @"Forgot Password";
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
    
    self.navigationItem.leftBarButtonItem = barButton;
    
    emailTextField.textColor = [UIColor blackColor];
    
    
    emailTextField.font=[UIFont fontWithName:@"Roboto-Italic" size:15];
    
    
}


#pragma mark - screen actions
/* Method implementation for navigating to loginscreen */

-(IBAction)backButtonPressed{
    
    [self.navigationController setNavigationBarHidden:TRUE animated:TRUE];
    [self.navigationController popViewControllerAnimated:FALSE];
	
}


/* Validations when user click on login button */

-(IBAction)forgotButtonPressed{
    
	NSString *emailStr = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
  	if([emailStr isEqual:@""] || [emailStr length]==0){
		
		[self errorOnEntry:kEmailRequired];
		return;
		
	}
	BOOL emailValidation = [self validateEmail:emailStr];
	
	if (!emailValidation) {
        
		[self errorOnEntry:kEmailNotValid];
        
		return;
	}
    
	
	[self processReset:NO];
    
}

/* error messages based on user defined error constants  */

- (void)errorOnEntry:(NSInteger)kFieldID{
	
	NSString *errorString = @"";
	
	switch (kFieldID) {
            
		case kEmailRequired:
			
			errorString = @"Please enter an email address.";
			break;
            
		case kEmailNotValid:
			
			errorString = @"Please enter a valid email address.";
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

- (void)processReset:(BOOL)usingFaceBook
{
    [emailTextField resignFirstResponder];
    
    NSString *emailStr = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSDictionary *parameters = [NSDictionary new];
    
    parameters = @{@"email":emailStr};
    
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
            [emailTextField resignFirstResponder];
            break;
            
    }
}

-(IBAction)textFieldDidBeginEditing:(UITextField *)sender{
    

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [emailTextField resignFirstResponder];
        
    return YES;
        
    
}

- (void)processUserRegistration:(NSDictionary *)params usingFacebook:(BOOL)usingFaceBook
{
    UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *url = [NSString stringWithFormat:@"%@forgotPassword?",appDelegate.appBaseURL];
    
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
            

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Error"
                                                                message:msg
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            
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




@end
