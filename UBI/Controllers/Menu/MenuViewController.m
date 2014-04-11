//
//  MenuViewController.m
//  UBI
//
//  Created by Krishna Mudiyala on 09/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize menuListArray,menuTable,backgroundImage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
  
    if (self) {
   
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Menu";
    [self.navigationController setNavigationBarHidden:FALSE animated:TRUE];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
    
    self.navigationItem.leftBarButtonItem = barButton;
        [self.navigationController.navigationItem setHidesBackButton:FALSE];
    self.menuListArray = [[NSMutableArray alloc] init];
    
    [menuListArray addObject:@"Account"];
    
    [menuListArray addObject:@"Change Password"];
    
    [menuListArray addObject:@"Signout"];
    
    menuTable.delegate=self;
    
    menuTable.dataSource=self;
    
    backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    backgroundImage.image = [UIImage imageNamed:@"Default-568h.png"];
    
    // [self.mallTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h.png"]]];
    // mallTable.alpha=0.0;
    [self.view addSubview:backgroundImage];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    img.image = [UIImage imageNamed:@"Default-568h.png"];
    
    // [self.mallTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h.png"]]];
    
    [self.menuTable setBackgroundView:img];
    
    if ([menuListArray count]>0) {
        
        menuTable.backgroundColor = [UIColor clearColor];
        menuTable.alpha=1.0;
        
        backgroundImage.alpha=0.0;
    }
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
    return [menuListArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"menuTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.font=[UIFont fontWithName:@"Roboto-Bold" size:18];

    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"account.png"];
            cell.textLabel.text = @"Account";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"changepass.png"];
            cell.textLabel.text = @"Change Password";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"signout_btn.png"];
            cell.textLabel.text = @"Signout";
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            break;
            
        default:
            break;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self menuSelected:[NSString stringWithFormat:@"%d",indexPath.row]];
    
}
#pragma mark - MenuViewController Delegate

-(void)menuSelected:(NSString*)menuOption{
    
    UIViewController *vc = nil;
   
    
     switch([menuOption intValue]){
     
     case 0:
     vc =[[self storyboard] instantiateViewControllerWithIdentifier:@"AccountViewController"];
     break;
     case 1:
     vc =[[self storyboard] instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
     break;
     
         default:
            
             break;
     }
     
    
    if([menuOption intValue]<2){
        [self.navigationController pushViewController:vc animated:YES];

        
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Would you like to signout?"   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
        
        alert.tag=49;
        [alert show];
        
        
    
    }
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag==49) {
        
        if (buttonIndex==1) {
            
            UBIAppDelegate *appDelegate = (UBIAppDelegate*)[[UIApplication sharedApplication] delegate];
            
            UBISingleton *sharedObj = [UBISingleton sharedInstance];
            
            [sharedObj.users removeAllObjects];
            
            [self.navigationController popToRootViewControllerAnimated:TRUE];
        }
    }

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
