//
//  UBIViewController.m
//  UBI
//
//  Created by Krishna Mudiyala on 01/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "UBIViewController.h"

@interface UBIViewController ()

@end

@implementation UBIViewController

@synthesize emailTextField,passwordTextField;

@synthesize latitude,locationManager,longitude;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.latitude = [[UILabel alloc] initWithFrame:self.emailTextField.bounds];
    self.longitude = [[UILabel alloc] initWithFrame:self.emailTextField.bounds];
    
    self.locationManager = [[CLLocationManager alloc] init];
    // locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];

    
    emailTextField.font=[UIFont fontWithName:@"Roboto-Italic" size:15];
    
    passwordTextField.font=[UIFont fontWithName:@"Roboto-Italic" size:15];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)forgotPasswordButtonClicked{


}
-(void)registerButtonClicked{


}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:TRUE];
    
    [self.navigationController setNavigationBarHidden:TRUE animated:TRUE];


}
-(void)loginButtonClicked{



}
/* Validations when user click on login button */

-(IBAction)loginButtonPressed
{
	NSString *email = [emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pass = [passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

//    if (!self.faceBookID) {
        if([email isEqual:@""] || [email length]==0){
            
            [self errorOnEntry:kEmailRequired];
            return;
        }
        
        else if([pass isEqual:@""]||[pass length]==0){
            
            [self errorOnEntry:kLoginPassword];
            return;
        }
        else if([pass length]< 6){
            
            [self errorOnEntry:kLoginPassword2];
            return;
        }
        else if([pass length] > 16){
            
            [self errorOnEntry:kLoginPassword2];
            return;
        }
	//}
	[self SignInButtonPressed];
    
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
		case kLoginPassword:
			
			errorString = @"Please enter your password.";
			break;
		case kLoginPassword2:
			
			errorString = @"Password should contain 6 to 16 characters";
			break;
			
		default:
			errorString = @"Unknown errorOnEntry().";
			break;
	}
	
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	
	[alert show];
	
}



/* Method implementation for email validation */

- (BOOL)validateEmail:(NSString *)candidate {
	
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
	return [emailTest evaluateWithObject:candidate];
}

/* changing textfield images & keypad on/off when done editing */

-(IBAction)textFieldDidBeginEditing:(UITextField *)sender{
    
    
    
    
}

/*
 -(IBAction)textFieldDoneEditing:(UITextField*)sender{
 
 if (sender.tag==1) {
 
 
 [userPassword becomeFirstResponder];
 
 [UIView animateWithDuration:0.2  //
 animations:^{  //
 
 CGRect frame = loginView.frame;
 
 
 frame.origin.y = frame.origin.y-40;
 
 
 loginView.frame = frame;
 
 
 }
 completion:^(BOOL finished){
 
 loginView.hidden = FALSE;
 
 }];
 
 }
 else if (sender.tag==2){
 
 
 [sender resignFirstResponder];
 
 [UIView animateWithDuration:0.2  //
 animations:^{  //
 
 CGRect frame = loginView.frame;
 
 
 frame.origin.y = frame.origin.y+40;
 
 
 loginView.frame = frame;
 
 
 }
 completion:^(BOOL finished){
 
 
 }];
 }
 else{
 
 [sender resignFirstResponder];
 }
 
 }
 */

/* changing textfield images & keypad on/off when begin editing */
/*
 -(IBAction)textFieldDidBeginEditing:(UITextField*)sender{
 
 if (sender.tag==1) {
 
 [emailButton setImage:[UIImage imageNamed:@"loginTextFieldSelected.png"] forState:UIControlStateNormal];
 [passwordButton setImage:[UIImage imageNamed:@"loginTextField.png"]  forState:UIControlStateNormal];
 }
 else if (sender.tag==2){
 
 [emailButton setImage:[UIImage imageNamed:@"loginTextField.png"] forState:UIControlStateNormal];
 [passwordButton setImage:[UIImage imageNamed:@"loginTextFieldSelected.png"]  forState:UIControlStateNormal];
 
 
 }
 
 
 }
 */

-(void)textFieldDoneEditing:(UITextField *)sender{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField.tag ==1) {
        
        
        [passwordTextField becomeFirstResponder];
        
        
    } else if(textField.tag == 2) {
        
        
        [self SignInButtonPressed];
    }
    
    return NO;
}

-(IBAction)SignInButtonPressed
{
  //  self.faceBookID = @"0";
    [self processLoginRequest];
    
}



/* Method implementation for login request. Called after successful validation */

-(void)processLoginRequest
{
    // resing keypads
    [emailTextField resignFirstResponder];
    
    [passwordTextField resignFirstResponder];
    
    UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *url = [NSString stringWithFormat:@"%@checkUserLogin",appDelegate.appBaseURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    /*
    if (!self.faceBookID) {
        
        self.faceBookID=@"0";
    }
    appDelegate.appToken=@"0";
    
    self.faceBookID=@"0";
    */
    NSDictionary *parameters = [NSDictionary new];
    /*
    if (self.faceBookUser == nil) {
        parameters = @{@"email":userEmail.text,
                       @"password":userPassword.text,
                       @"latitude":latitude.text,
                       @"longitude":longitude.text,
                       @"companyID":@"11",
                       @"userID":@"58"};
    } else {*/
        parameters = @{@"email":emailTextField.text,
                       @"password":passwordTextField.text
                   //    @"latitude":latitude.text,
                     //  @"longitude":longitude.text,
                       //@"userID":@"58"
                       };
    //}
    
  //  if (!appDelegate.isAutoLogin) {
        
    //    [MBHUDView hudWithBody:@"Please wait..." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:14.0 show:YES];
        
    //}
    
    
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
            
          //  [self showLoginView];
            return;
            
        }
        if ([result intValue]==1) {

            UBISingleton *sharedObj = [UBISingleton sharedInstance];
            
            User *user = [[User alloc] init];

            NSString *userID = [responseArray valueForKey:@"userId"];

            [user setUserPass:passwordTextField.text];
            
            [user setUserEmail:emailTextField.text];

            [user setUserID:userID];
            
            [sharedObj.users removeAllObjects];

            [sharedObj.users addObject:user];

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
       // [self showLoginView];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription]   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        return;
        
        
    }];
    
}


#pragma mark -
#pragma mark CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *currentLatitude = [[NSString alloc]
                                 initWithFormat:@"%g",
                                 newLocation.coordinate.latitude];
    latitude.text = currentLatitude;
    
    NSString *currentLongitude = [[NSString alloc]
                                  initWithFormat:@"%g",
                                  newLocation.coordinate.longitude];
    
    longitude.text = currentLongitude;
    
    appDelegate.appLatitude = [NSString stringWithFormat:@"%@",latitude.text];
    
    appDelegate.appLongitude = [NSString stringWithFormat:@"%@",longitude.text];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginLocationUpdate" object:nil];
    
    [self.locationManager stopUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error
{
    NSLog(@"Error : %@",error.localizedFailureReason);
}

@end
