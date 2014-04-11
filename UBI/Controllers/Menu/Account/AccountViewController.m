//
//  AccountViewController.m
//  UBI
//
//  Created by Krishna Mudiyala on 10/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize emailTextField,passwordTextField,contactNumberTextField,userNameTextField;


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
    
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    
    
    //initWithImage:[UIImage imageNamed:@"back_btn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];

    self.navigationItem.rightBarButtonItem = editButton;
    
    emailTextField.textColor = [UIColor grayColor];
    passwordTextField.textColor = [UIColor grayColor];
    contactNumberTextField.textColor = [UIColor grayColor];
    userNameTextField.textColor = [UIColor grayColor];
    
    emailTextField.userInteractionEnabled=FALSE;
    passwordTextField.userInteractionEnabled=FALSE;
    userNameTextField.userInteractionEnabled=FALSE;
    contactNumberTextField.userInteractionEnabled=FALSE;

    
    emailTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfield-left-email.png"]];
    
    emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfield-left-key.png"]];
    
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    userNameTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfield-left-user.png"]];
    
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    contactNumberTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textfield-left-call.png"]];
    
    contactNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    emailTextField.font=[UIFont fontWithName:@"Roboto-Italic" size:15];
    
    passwordTextField.font=[UIFont fontWithName:@"Roboto-Italic" size:15];
    
    contactNumberTextField.font = [UIFont fontWithName:@"Roboto-Italic" size:15];
    userNameTextField.font = [UIFont fontWithName:@"Roboto-Italic" size:15];
    
    [self fetchProfileInfoRequest];
}


#pragma mark - screen actions
/* Method implementation for navigating to loginscreen */

-(IBAction)backButtonPressed{
    
    [self.navigationController setNavigationBarHidden:TRUE animated:TRUE];
    [self.navigationController popViewControllerAnimated:FALSE];
	
}

-(void)editButtonPressed{

    emailTextField.userInteractionEnabled=FALSE;
    passwordTextField.userInteractionEnabled=FALSE;
    userNameTextField.userInteractionEnabled=TRUE;
    contactNumberTextField.userInteractionEnabled=TRUE;
    userNameTextField.textColor = [UIColor blackColor];
    contactNumberTextField.textColor = [UIColor blackColor];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(submitButtonPressed)];
    
    
    //initWithImage:[UIImage imageNamed:@"back_btn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
    
    self.navigationItem.rightBarButtonItem = editButton;

}


/* Validations when user click on login button */

-(IBAction)submitButtonPressed{
    
	//NSString *emailStr = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
  //  NSString *pass = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *uname = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *contactNumber = [self.contactNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if([uname isEqual:@""] || [uname length]==0){
		
		[self errorOnEntry:kUserName];
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
    
    
    UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UBISingleton *sharedObj = [UBISingleton sharedInstance];
    
    User *uObj = [sharedObj.users objectAtIndex:0];

    NSDictionary *parameters = [NSDictionary new];
    
    parameters = @{@"userId":uObj.userID,
                   @"userName":userStr,
                   @"contactNumber":contactStr,
                   @"address":uObj.userAddress};
    
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
    NSString *url = [NSString stringWithFormat:@"%@editProfile?",appDelegate.appBaseURL];
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
            
            UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
            
            
            //initWithImage:[UIImage imageNamed:@"back_btn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
            
            
            NSString *url = [NSString stringWithFormat:@"%@userProfileDetails",appDelegate.appBaseURL];
            
            UBISingleton *sharedObj = [UBISingleton sharedInstance];

            self.navigationItem.rightBarButtonItem = editButton;
            
            emailTextField.textColor = [UIColor grayColor];
            passwordTextField.textColor = [UIColor grayColor];
            contactNumberTextField.textColor = [UIColor grayColor];
            userNameTextField.textColor = [UIColor grayColor];
            
            emailTextField.userInteractionEnabled=FALSE;
            passwordTextField.userInteractionEnabled=FALSE;
            userNameTextField.userInteractionEnabled=FALSE;
            contactNumberTextField.userInteractionEnabled=FALSE;
            
            User *uObj2 = [sharedObj.users objectAtIndex:0];
            
            [uObj2 setUserContactNumber:contactNumberTextField.text];
            [uObj2 setUserName:userNameTextField.text];

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchProfileInfoRequest
{

    [self.view setUserInteractionEnabled:FALSE];
    
    UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *url = [NSString stringWithFormat:@"%@userProfileDetails",appDelegate.appBaseURL];
   
    UBISingleton *sharedObj = [UBISingleton sharedInstance];
    [MBHUDView hudWithBody:@"Please wait..." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:14.0 show:YES];

    User *uObj = [sharedObj.users objectAtIndex:0];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = [NSDictionary new];
    
    parameters = @{@"userId":uObj.userID
                   };
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseArray  = (NSDictionary *)responseObject;
        
        [MBHUDView dismissCurrentHUD];
        
        if (responseArray == nil) {
            
            NSString *msg = [responseArray valueForKey:@"message"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alert show];
            
            return;
            
        }
        
        NSString *result = [responseArray valueForKey:@"result"];
        
        if ([result intValue]==0) {
            
            NSString *msg = [responseArray valueForKey:@"message"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
            [self.view setUserInteractionEnabled:TRUE];
            return;
            
        }
        if ([result intValue]==1) {
            
            UBISingleton *sharedObj = [UBISingleton sharedInstance];
            
            User *user = [[User alloc] init];
            
            NSString *userName = [responseArray valueForKey:@"userName"];
            NSString *email = [responseArray valueForKey:@"email"];
            NSString *contactNumber = [responseArray valueForKey:@"contactNumber"];
            NSString *address = [responseArray valueForKey:@"address"];

            User *uObj2 = [sharedObj.users objectAtIndex:0];
            
            [uObj2 setUserAddress:address];
            
            emailTextField.text = [NSString stringWithFormat:@"%@",email];
            contactNumberTextField.text = contactNumber;
            userNameTextField.text = userName;
            passwordTextField.text = uObj2.userPass;
            
            [self.view setUserInteractionEnabled:TRUE];
            
        }
        
        /*
         
         NSMutableDictionary *userDic  = [responseArray valueForKey:@"orderList"];
         
         UBISingleton *sharedObj = [UBISingleton sharedInstance];
         
         User *user = [[User alloc] init];
         
         for (NSString *key in userDic) {
         
         if ([user respondsToSelector:NSSelectorFromString(key)]) {
         
         [user setValue:[userDic valueForKey:key] forKey:key];
         }
         }
         
         /*
         
         NSString *name = [user.firstName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
         
         if([name isEqual:@""] || [name length]==0){
         
         NSString *email = [emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
         
         
         NSString *name = [[email componentsSeparatedByString:@"@"] objectAtIndex:0];
         
         int count2 = [[name componentsSeparatedByString:@"."] count];
         
         
         if (count2>1) {
         
         [user setFirstName:[[name componentsSeparatedByString:@"."] objectAtIndex:0]];
         [user setLastName:[[name componentsSeparatedByString:@"."] objectAtIndex:1]];
         
         }
         else
         [user setFirstName:name];
         }
         
         NSString *name2 = [user.lastName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
         
         if([name2 isEqual:@""] || [name2 length]==0){
         
         
         [user setLastName:@""];
         }
         */
        
        
        /*
         NSString *sqlNSString1 = [NSString stringWithFormat:@"DELETE from `Tbl_UserInfo`;"];
         const char *sqlString1 = [sqlNSString1 UTF8String];
         char *sqlError1;
         sqlite3_exec( appDelegate.database, sqlString1, NULL, NULL, &sqlError1 );
         
         
         NSString *checkLoginType = @"TRUE";
         NSString *sqlNSString2 = [NSString stringWithFormat:@"INSERT INTO `Tbl_UserInfo`  VALUES(NULL, '%@','%@', '%@', '%@','%@', '%@', '%@','%@','%@','%@');",user.userID,user.userEmail,user.userName,user.userName,user.userName,user.userName,user.userID,userPassword.text,user.userID,checkLoginType];
         const char *sqlString2 = [sqlNSString2 UTF8String];
         char *sqlError2;
         sqlite3_exec( appDelegate.database, sqlString2, NULL, NULL, &sqlError2);
         */
        
        /*
         HomeViewController *hvc = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPhone" bundle:nil];
         userEmail.text=@"";
         userPassword.text=@"";
         
         if (appDelegate.isAutoLogin) {
         [self.navigationController pushViewController:hvc animated:FALSE];
         }
         else{
         [self.navigationController pushViewController:hvc animated:TRUE];
         }
         */
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBHUDView dismissCurrentHUD];
                    [self.view setUserInteractionEnabled:TRUE];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription]   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        return;
        
        
    }];
    
}


@end
