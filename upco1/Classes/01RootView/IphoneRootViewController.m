//
//  IphoneRootViewController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 21/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "IphoneRootViewController.h"
#import "LibraryViewController.h"
#import "DashBoardViewController.h"
#import "QuizViewController.h"


@implementation IphoneRootViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	appDelegate = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
		
	[self performSelector:@selector(flipNewControll) withObject:nil afterDelay:0.5];
}

/*
-(void)callTabbar
{
	if (!self.tabBar)
        self.tabBar = [[InfiniTabBar alloc] initWithFrame:self.view.frame];
    
    // Don't show scroll indicator
	self.tabBar.showsHorizontalScrollIndicator = NO;
	self.tabBar.infiniTabBarDelegate = self;
	self.tabBar.bounces = NO;
    [self.view addSubview:self.tabBar];
    [self.view bringSubviewToFront:self.tabBar];
	
	UIScreen *screen = [UIScreen mainScreen];
	CGRect sbounds = screen.applicationFrame;
	
	LibraryViewController *Lib_Vct =[[LibraryViewController alloc] initWithNibName:@"LibraryViewController" bundle:nil];
    //[vctrl1 changeTexte:@"0"];
    
    //as a matter of fact an UIViewControler manage a lazy UITabBarItem, it can be used here !
    Lib_Vct.tabBarItem.image=[UIImage imageNamed:@"icon1.png"];
    Lib_Vct.tabBarItem.title= @"Library";
    Lib_Vct.tabBarItem.tag= 0;
	
	Lib_Vct.view.frame = CGRectMake(0, 0, sbounds.size.width, sbounds.size.height- 49.0);
	
	DashBoardViewController *Dashboard_Vct =[[DashBoardViewController alloc] initWithNibName:@"DashBoardViewController" bundle:nil];
    //[vctrl1 changeTexte:@"0"];
    
    //as a matter of fact an UIViewControler manage a lazy UITabBarItem, it can be used here !
    Dashboard_Vct.tabBarItem.image=[UIImage imageNamed:@"icon1.png"];
    Dashboard_Vct.tabBarItem.title= @"Dashboard";
    Dashboard_Vct.tabBarItem.tag= 1;
	
	Dashboard_Vct.view.frame = CGRectMake(0, 0, sbounds.size.width, sbounds.size.height- 49.0);
	
	QuizViewController *Quiz_Vct =[[QuizViewController alloc] initWithNibName:@"QuizViewController" bundle:nil];
    //[vctrl1 changeTexte:@"0"];
    
    //as a matter of fact an UIViewControler manage a lazy UITabBarItem, it can be used here !
    Quiz_Vct.tabBarItem.image=[UIImage imageNamed:@"icon1.png"];
    Quiz_Vct.tabBarItem.title= @"Quiz";
    Quiz_Vct.tabBarItem.tag= 2;
	
	Quiz_Vct.view.frame = CGRectMake(0, 0, sbounds.size.width, sbounds.size.height- 49.0);
	
	
	
	
	//UITabBarItem *favorites = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
	//UITabBarItem *topRated = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
	//UITabBarItem *featured = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:2];
	UITabBarItem *recents = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:3];
	UITabBarItem *contacts = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:4];
	UITabBarItem *history = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:5];
	UITabBarItem *bookmarks = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:6];
	UITabBarItem *search = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:7];
	UITabBarItem *downloads = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:8]; downloads.badgeValue = @"M";
	UITabBarItem *mostRecent = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:9];
	UITabBarItem *mostViewed = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:10];
	
	[self.tabBar setItems:[NSArray arrayWithObjects:Lib_Vct.tabBarItem,
                           Dashboard_Vct.tabBarItem,
                           Quiz_Vct.tabBarItem,
                           recents,
                           contacts,
                           history,
                           bookmarks,
                           search,
                           downloads,
                           mostRecent,mostViewed,
						   nil] animated:YES];
    
//	[favorites release];
	
	//[topRated release];
	//[featured release];
	[recents release];
	[contacts release];
	[history release];
	[bookmarks release];
	[search release];
	[downloads release];
	[mostRecent release];
	[mostViewed release];
	
	UINavigationController * Lib_Nav;
    Lib_Nav = [[UINavigationController alloc] initWithRootViewController:Lib_Vct];
    Lib_Nav.navigationBarHidden=YES;
	
	UINavigationController * Dashboard_Nav;
    Dashboard_Nav = [[UINavigationController alloc] initWithRootViewController:Dashboard_Vct];
    Dashboard_Nav.navigationBarHidden=YES;
	
	UINavigationController * Quiz_Nav;
    Quiz_Nav = [[UINavigationController alloc] initWithRootViewController:Quiz_Vct];
    Quiz_Nav.navigationBarHidden=YES;
	
    [self setViewControllers:[NSArray arrayWithObjects:Lib_Nav,
                              Dashboard_Nav,Quiz_Nav,nil] animated:YES];
	
	[Lib_Vct release];
	[Lib_Nav release];
	[Dashboard_Vct release];
	[Dashboard_Nav release];
	[Quiz_Vct release];
	[Quiz_Nav release];
	
	[self selectItem];
	
}
 */

-(IBAction)NavigateToTabBar:(id)sender
{
	UIButton *temp=(UIButton*)sender;
	appDelegate.count = temp.tag;
	
	NSLog(@"%d",appDelegate.count);

	SecondView.hidden = TRUE;
	
	obj_tabBar = [[MainTabBar alloc] initWithNibName:@"MainTabbarMy" bundle:nil];
	obj_tabBar.view.frame = CGRectMake(0, 0, 320, 480);
	
	//UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:obj_tabBar];
//	
//	nav.navigationBarHidden = TRUE;
//	
//	nav.view.frame = CGRectMake(0, 0, 320, 460);
	//obj_tabBar.view.backgroundColor = [UIColor redColor];
	[self.view addSubview:obj_tabBar.view];
	
	//[self callTabbar];
}

-(IBAction)flipNewControll
{
	[UIView beginAnimations:@"animation" context:nil];
	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO]; 
	[UIView setAnimationDuration: 1.0];
	[UIView commitAnimations];
	FirstView.hidden = TRUE;	
}

/*
- (void)selectItem {
	[self.tabBar selectItemWithTag:appDelegate.count];
}

- (void)infiniTabBar:(InfiniTabBar *)atabBar didSelectItemWithTag:(int)tag {
    [super infiniTabBar:atabBar didSelectItemWithTag:tag];
    if (self.selectedViewController){
        NSString *str =[NSString stringWithFormat:@"tag=%i",tag];
       
    }
}
*/



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
