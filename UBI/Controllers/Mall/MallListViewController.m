//
//  MallListViewController.m
//  UBI
//
//  Created by Krishna Mudiyala on 08/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "MallListViewController.h"
#import "MallTableViewCell.h"

@interface MallListViewController ()

@end

@implementation MallListViewController

@synthesize mallListArray,mallTable,backgroundImage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
   
    //    [self.view sendSubviewToBack:img];
        
    }
    return self;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:YES];
     
     self.navigationController.navigationBar.topItem.hidesBackButton = YES;
 }

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Malls";
    [self.navigationController setNavigationBarHidden:FALSE animated:TRUE];

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
    
//    self.navigationItem.leftBarButtonItem = barButton;
    

    backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    backgroundImage.image = [UIImage imageNamed:@"Default-568h.png"];
    
    // [self.mallTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h.png"]]];
   // mallTable.alpha=0.0;
    [self.view addSubview:backgroundImage];
    
    self.mallListArray = [[NSMutableArray alloc] init];
    
    mallTable.delegate=self;
    
    mallTable.dataSource=self;
    
    [self processMallsRequest:@"0" :TRUE];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - screen actions
/* Method implementation for navigating to loginscreen */

-(IBAction)backButtonPressed{
    
    [self.navigationController popViewControllerAnimated:TRUE];
	
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mallListArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"mallTableViewCell";
    MallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    //add AsyncImageView to cell
    
    cell.mallImage.layer.cornerRadius = 20.0f;
    
    
    Mall *obj = [mallListArray objectAtIndex:indexPath.row];
    
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.mallImage];
    
    NSURL *url = [NSURL URLWithString:obj.thumb];
    
    //load the image
    cell.mallImage.imageURL = url;

    NSLog(@"%@",url);
    
    cell.mallName.font=[UIFont fontWithName:@"Roboto-Bold" size:26];

    cell.mallName.numberOfLines=2;
    cell.mallName.text = obj.mallName;
    
    // if (cell == nil) {
    //NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellType owner:nil options:nil];
    //  cell = (menuTableViewCell*)[nib objectAtIndex:0];
    // }
    
    //    [cell.subView setBackgroundColor:[UIColor colorWithRed:37.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1]];
    
    //  cell.backgroundColor=[UIColor redColor];
    
    //   CALayer *layer1 = [cell.img layer];
  //  [layer1 setMasksToBounds:YES];
   // [layer1 setCornerRadius:0];
    
    //  [cell.img setContentMode:UIViewContentModeCenter];
    
    
    // if(indexPath.section==[VariableStore sharedInstance].selectedTabIndex-1){
    // [cell setSelected:TRUE];
    cell.imageView.layer.cornerRadius=20;
    //  }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self menuSelected:[NSString stringWithFormat:@"%d",indexPath.section]];
    
}
#pragma mark - MenuViewController Delegate

-(void)menuSelected:(NSString*)menuOption{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Stores are not available for selected mall"   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
    
    alert.tag=49;
    [alert show];
   // UIViewController *vc = nil;
    /*
    switch([menuOption intValue]){
            
        case 0:
            vc =[[GetHopProViewController alloc] initWithNibName:@"GetHopProViewController" bundle:nil];
            break;
        case 1:
            vc =[[EditProfileViewController alloc] initWithNibName:nil bundle:nil];
            break;
        case 2:
            vc =[[ManagePhotosViewController alloc] initWithNibName:@"ManagePhotosViewController" bundle:nil];
            break;
        case 3:
            vc =[[AccountViewController alloc] initWithNibName:@"AccountViewController" bundle:nil];
            break;
        case 4:
            vc =[[InviteViewController alloc] initWithNibName:@"InviteViewController" bundle:nil];
            break;
        case 5:
            break;
    }
    */
    /*if([menuOption intValue]<5){
        
        [self.navigationController pushViewController:vc animated:TRUE];
        
    }
    
    for(UIView *v in self.view.subviews){
        
        if(v.tag==998 || v.tag==999)
            [v removeFromSuperview];
        
    }
    if ([menuOption intValue]==5) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Would you like to logout?"   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
        
        alert.tag=49;
        [alert show];
    }
    */
    
    
}

/* Method implementation for login request. Called after successful validation */

-(void)processMallsRequest:(NSString*)offset :(BOOL)refresh
{
    if (refresh) {
        
        [mallListArray removeAllObjects];
        
        [mallTable reloadData];
    }
    
    UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UBISingleton *sharedObj = [UBISingleton sharedInstance];
    
  //  User *uObj = [sharedObj.users objectAtIndex:0];
    
    NSString *url = [NSString stringWithFormat:@"%@malls",appDelegate.appBaseURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [MBHUDView hudWithBody:@"Please wait..." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:14.0 show:YES];

    
    NSDictionary *parameters = [NSDictionary new];
    
    parameters = @{@"userID":@"0",
                   @"offset":offset
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
            
            return;
            
        }
        if ([result intValue]==1) {
            
            NSMutableDictionary *userDic  = [responseArray valueForKey:@"0"];

            
            Mall *mObj = [[Mall alloc] init];
            
            for (NSString *key in userDic) {
                
                if ([mObj respondsToSelector:NSSelectorFromString(key)]) {
                    
                    [mObj setValue:[userDic valueForKey:key] forKey:key];
                }
            }
            for (int i=0; i<1; i++) {
                [mallListArray addObject:mObj];
 
            }
            
            
        }
        
        [mallTable reloadData];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
        
        img.image = [UIImage imageNamed:@"Default-568h.png"];
        
       // [self.mallTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h.png"]]];
        
        [self.mallTable setBackgroundView:img];
        
        if ([mallListArray count]>0) {
            
            mallTable.backgroundColor = [UIColor clearColor];
            mallTable.alpha=1.0;
            
            backgroundImage.alpha=0.0;
        }
//        [self.view addSubview:img];
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
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription]   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        return;
        
        
    }];
    
}



#pragma mark - scollview actions
/*
 - (void)scrollViewDidScroll:(UIScrollView *)aScrollView
 {
 
 }
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView{
 
 CGPoint offset = aScrollView.contentOffset;
 CGRect bounds = aScrollView.bounds;
 CGSize size = aScrollView.contentSize;
 UIEdgeInsets inset = aScrollView.contentInset;
 float y = offset.y + bounds.size.height - inset.bottom;
 float h = size.height;
 float reload_distance = 0; // Distance from bottom.
 if (y >= h + reload_distance )
 {
 if (!isQuery && isAvailable) {
 [self processBuddiesRequest:FALSE];
 }
 NSLog(@"You have reached the end of the scroll view.");
 // Extra code
 }
 }
 
 */
#pragma mark - screen actions
/* Method implementation for navigating to loginscreen */

-(IBAction)menuButtonPressed{
    
    [self.navigationController popViewControllerAnimated:TRUE];
	
}


@end
