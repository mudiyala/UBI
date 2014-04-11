//
//  MallViewController.m
//  UBI
//
//  Created by Krishna Mudiyala on 03/04/14.
//  Copyright (c) 2014 Krishna Mudiyala. All rights reserved.
//

#import "MallViewController.h"

@interface MallViewController ()

@end

@implementation MallViewController

@synthesize mallListArray,mallTable;


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
    
    self.navigationItem.title = @"Malls";
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
    
    self.navigationItem.leftBarButtonItem = barButton;
   
    
    self.mallListArray = [[NSMutableArray alloc] init];
    
    
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

#pragma mark - mall table view delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [mallListArray count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellType = @"menuTableViewCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
    if (cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
    }
    // if (cell == nil) {
    //NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellType owner:nil options:nil];
  //  cell = (menuTableViewCell*)[nib objectAtIndex:0];
    // }
    
    
    
    cell.textLabel.textColor=[UIColor whiteColor];
    
    // if(indexPath.section==[VariableStore sharedInstance].selectedTabIndex-1){
    // [cell setSelected:TRUE];
    
    //  }
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor blackColor]];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self menuSelected:[NSString stringWithFormat:@"%d",indexPath.section]];
    
}
#pragma mark - MenuViewController Delegate

-(void)menuSelected:(NSString*)menuOption{
    
    UIViewController *vc = nil;
    
   
    for(UIView *v in self.view.subviews){
        
        if(v.tag==998 || v.tag==999)
            [v removeFromSuperview];
        
    }
    if ([menuOption intValue]==5) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Would you like to logout?"   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
        
        alert.tag=49;
        [alert show];
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
