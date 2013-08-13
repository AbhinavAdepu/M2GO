//
//  MainTabBar.m
//  CashCollie
//
//  Created by digicorp on 11/27/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MainTabBar.h"

#import <QuartzCore/QuartzCore.h>


@implementation MainTabBar
@synthesize isFirstTimeLoggedIn,nvCtr2;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
		appDelegate = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
		isFirstTimeLoggedIn=YES;
		
		obj_Scan = [[ScanViewController alloc] initWithNibName:@"ScanViewController" bundle:nil];
		obj_Dashboard = [[DashBoardViewController alloc] initWithNibName:@"DashBoardViewController" bundle:nil];
		obj_Write = [[QRGenViewController alloc] initWithNibName:@"QRGenViewController" bundle:nil];
		obj_Quiz = [[QuizViewController alloc] initWithNibName:@"QuizViewController" bundle:nil];
		obj_Template = [[TemplateViewController alloc] initWithNibName:@"TemplateViewController_iphone" bundle:nil];
		obj_Twitter = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
		obj_Library = [[LibraryViewController alloc] initWithNibName:@"LibraryViewController" bundle:nil];
		obj_About = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
		
		
		nvCtr1=[[UINavigationController alloc] initWithRootViewController:obj_Scan];
		nvCtr2=[[UINavigationController alloc] initWithRootViewController:obj_Dashboard];
		nvCtr3 = [[UINavigationController alloc] initWithRootViewController:obj_Write];
		nvCtr4 = [[UINavigationController alloc] initWithRootViewController:obj_Quiz];
		nvCtr5 = [[UINavigationController alloc] initWithRootViewController:obj_Template];
		nvCtr6 = [[UINavigationController alloc] initWithRootViewController:obj_Twitter];
		nvCtr7 = [[UINavigationController alloc] initWithRootViewController:obj_Library];
		nvCtr8 = [[UINavigationController alloc] initWithRootViewController:obj_About];
        
		[nvCtr1 setNavigationBarHidden:TRUE];
		[nvCtr2 setNavigationBarHidden:TRUE];
		[nvCtr3 setNavigationBarHidden:TRUE];
		[nvCtr4 setNavigationBarHidden:TRUE];
		[nvCtr5 setNavigationBarHidden:TRUE];
		[nvCtr6 setNavigationBarHidden:TRUE];
		[nvCtr7 setNavigationBarHidden:TRUE];
		[nvCtr8 setNavigationBarHidden:TRUE];
		
        // Custom initialization
		/*
		[nvCtr1 setNavigationBarHidden:YES];
		[nvCtr2 setNavigationBarHidden:YES];
		[nvCtr3 setNavigationBarHidden:YES];
		[nvCtr4 setNavigationBarHidden:YES];
		*/
		
		
		
		
		tabBarMain=[[UITabBarController alloc] init];
		
		[tabBarMain.tabBar setHidden:TRUE];
		tabBarMain.moreNavigationController.navigationBarHidden = TRUE; 
		
		
		[tabBarMain setViewControllers:[NSArray arrayWithObjects:nvCtr1,nvCtr2,nvCtr3,nvCtr4, nvCtr5,nvCtr6,nvCtr7,nvCtr8,nil]];
		
		UIImageView *imageBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Tabbar-Background.png"]];
		imageBackground.frame = CGRectMake(0, 393, 320, 67);
		[tabBarMain.view addSubview:imageBackground];
		
	
		UIScrollView *btnScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 393, 320, 67)];
		
		if(appDelegate.count > 3)
		{
			btnScroll.contentOffset = CGPointMake(320,0);
		}
		
		aero1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Untitled-2_0005_left-arrow.png"]];
		aero1.frame = CGRectMake(8, 30, 7, 12);
		[btnScroll addSubview:aero1];
		
		btn1=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn1 setFrame:CGRectMake(25, 11, 60, 56)];
		[btn1 addTarget:self action:@selector(tab1Pressed) forControlEvents:UIControlEventTouchUpInside];
		[btn1 setImage:[UIImage imageNamed:@"Scan-Normal.png"] forState:UIControlStateNormal];
		[btn1 setImage:[UIImage imageNamed:@"Scan-Selected.png"] forState:UIControlStateSelected];
		btn1.selected=YES;
		[btnScroll addSubview:btn1];
		
		btn2=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn2 setFrame:CGRectMake(95, 11, 60,56)];
		[btn2 addTarget:self action:@selector(tab2Pressed) forControlEvents:UIControlEventTouchUpInside];
		[btn2 setImage:[UIImage imageNamed:@"Dashboard-Normal.png"] forState:UIControlStateNormal];
		[btn2 setImage:[UIImage imageNamed:@"Dashboard-Selected.png"] forState:UIControlStateSelected];
		[btnScroll addSubview:btn2];
		
		btn3=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn3 setFrame:CGRectMake(165, 11, 60, 56)];
		[btn3 addTarget:self action:@selector(tab3Pressed) forControlEvents:UIControlEventTouchUpInside];
		[btn3 setImage:[UIImage imageNamed:@"Write-Normal.png"] forState:UIControlStateNormal];
		[btn3 setImage:[UIImage imageNamed:@"Write-Selected.png"] forState:UIControlStateSelected];
		[btnScroll addSubview:btn3];
		
		btn4=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn4 setFrame:CGRectMake(235, 11, 60, 56)];
		[btn4 addTarget:self action:@selector(tab4Pressed) forControlEvents:UIControlEventTouchUpInside];
		[btn4 setImage:[UIImage imageNamed:@"Quiz-Normal.png"] forState:UIControlStateNormal];
		[btn4 setImage:[UIImage imageNamed:@"Quiz-Selected.png"] forState:UIControlStateSelected];
		[btnScroll addSubview:btn4];
		
		aero2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Untitled-2_0004_right-arrow.png"]];
		aero2.frame = CGRectMake(300, 30, 7, 12);
		[btnScroll addSubview:aero2];
		
		aero3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Untitled-2_0007_left-arrow-copy.png"]];
		aero3.frame = CGRectMake(330, 30, 7, 12);
		[btnScroll addSubview:aero3];
		
		btn5=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn5 setFrame:CGRectMake(350, 11, 60, 56)];
		[btn5 addTarget:self action:@selector(tab5Pressed) forControlEvents:UIControlEventTouchUpInside];
		[btn5 setImage:[UIImage imageNamed:@"Template-normalstate.png"] forState:UIControlStateNormal];
		[btn5 setImage:[UIImage imageNamed:@"Template-SelectedState.png"] forState:UIControlStateSelected];
		[btnScroll addSubview:btn5];
		
		btn6=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn6 setFrame:CGRectMake(420, 11, 60, 56)];
		[btn6 addTarget:self action:@selector(tab6Pressed) forControlEvents:UIControlEventTouchUpInside];
		[btn6 setImage:[UIImage imageNamed:@"MTwitter-Normal.png"] forState:UIControlStateNormal];
		[btn6 setImage:[UIImage imageNamed:@"MTwitter-Selected.png"] forState:UIControlStateSelected];
		[btnScroll addSubview:btn6];
		
		btn7=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn7 setFrame:CGRectMake(490, 11, 60, 56)];
		[btn7 addTarget:self action:@selector(tab7Pressed) forControlEvents:UIControlEventTouchUpInside];
		[btn7 setImage:[UIImage imageNamed:@"Library-Normal.png"] forState:UIControlStateNormal];
		[btn7 setImage:[UIImage imageNamed:@"Library-Selected.png"] forState:UIControlStateSelected];
		[btnScroll addSubview:btn7];
		
		btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn8 setFrame:CGRectMake(560, 11, 60, 56)];
		[btn8 addTarget:self action:@selector(tab8Pressed) forControlEvents:UIControlEventTouchUpInside];
		[btn8 setImage:[UIImage imageNamed:@"AboutUs-Normal.png"] forState:UIControlStateNormal];
		[btn8 setImage:[UIImage imageNamed:@"AboutUs-Selected.png"] forState:UIControlStateSelected];
		[btnScroll addSubview:btn8];
		
		aero4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Untitled-2_0006_right-arrow-copy-3.png"]];
		aero4.frame = CGRectMake(625, 30, 7, 12);
		[btnScroll addSubview:aero4];
		
		btnScroll.showsHorizontalScrollIndicator = NO;
		btnScroll.bounces = NO;
		btnScroll.pagingEnabled = YES;
		btnScroll.delegate = self;
		
		[tabBarMain.view addSubview:btnScroll];
		btnScroll.contentSize = CGSizeMake(640, 0);
    }
    return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView    
{
	aero1.hidden = TRUE;
	aero2.hidden = TRUE;
	aero3.hidden = TRUE;
	aero4.hidden = TRUE;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	aero1.hidden = FALSE;
	aero2.hidden = FALSE;
	aero3.hidden = FALSE;
	aero4.hidden = FALSE;
}
/*
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:TRUE];
	
	[nvCtr1 viewWillAppear:TRUE];
	[nvCtr2 viewWillAppear:TRUE];
	
}
*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[appDelegate setMainTabBar:self];
	//nxtStatusViewCtr.isFirstTimeLoggedIn=self.isFirstTimeLoggedIn;
	tabBarMain.view.frame=self.view.frame;
	//tabBarMain.view.frame = CGRectMake(0,870, 768, 200);
	[self.view addSubview:tabBarMain.view];
	
	//tabBarMain.selectedIndex = appDelegate.count;
	
		if(appDelegate.count == 0)
			[self tab1Pressed];
		else if(appDelegate.count == 1)
			[self tab2Pressed];
		else if(appDelegate.count == 2)
			[self tab3Pressed];
		else if(appDelegate.count == 3)
			[self tab4Pressed];
		else if(appDelegate.count == 4)
			[self tab5Pressed];
		else if(appDelegate.count == 5)
			[self tab6Pressed];
		else if(appDelegate.count == 6)
			[self tab7Pressed];
		else if(appDelegate.count == 7)
			[self tab8Pressed];
	
}

/*-(PendingViewCtr*)getPendingViewCtr{
	return nxtPendingViewCtr;
}
-(ToGetVCtr*)getToGetVCtr{
	return nxtToGetViewCtr;
}
-(ToPayViewCtr*)getToPayViewCtr{
	return nxtToPayViewCtr;
}
-(CreateViewCtr*)getCreateViewCtr{
	return nxtCreateViewCtr;
}
-(StatusViewCtr*)getStatusViewCtr{
	return nxtStatusViewCtr;
}
-(UITabBarController*)getTabBarRef{
	return tabBarMain;
}*/

-(void)tab1Pressed
{
	[nvCtr1 popToRootViewControllerAnimated:NO];
	[nvCtr1 viewWillAppear:TRUE];
	tabBarMain.selectedIndex=0;
	
	btn1.selected = TRUE;
	btn2.selected = FALSE;
	btn3.selected = FALSE;
	btn4.selected = FALSE;
	btn5.selected = FALSE;
	btn6.selected = FALSE;
	btn7.selected = FALSE;
	btn8.selected = FALSE;
}

-(void)tab2Pressed
{
	[nvCtr2 viewWillAppear:TRUE];
	//[nvCtr2 popToRootViewControllerAnimated:NO];
	tabBarMain.selectedIndex=1;
	btn1.selected = FALSE;
	btn2.selected = TRUE;
	btn3.selected = FALSE;
	btn4.selected = FALSE;
	btn5.selected = FALSE;
	btn6.selected = FALSE;
	btn7.selected = FALSE;
	btn8.selected = FALSE;
}

-(void)tab3Pressed
{
	NSLog(@"View===%@",nvCtr3.viewControllers);
	[nvCtr3 popToRootViewControllerAnimated:NO];
	[nvCtr3 viewWillAppear:YES];
    tabBarMain.selectedIndex = 2;
	btn1.selected =FALSE;
	btn2.selected = FALSE;
	btn3.selected = TRUE;
	btn4.selected = FALSE;
	btn5.selected = FALSE;
	btn6.selected = FALSE;
	btn7.selected = FALSE;
	btn8.selected = FALSE;
}

-(void)tab4Pressed
{
	[nvCtr4 popToRootViewControllerAnimated:NO];
	[nvCtr4 viewWillAppear:TRUE];
	tabBarMain.selectedIndex = 3;
	btn1.selected = FALSE;
	btn2.selected = FALSE;
	btn3.selected = FALSE;
	btn4.selected = TRUE;
	btn5.selected = FALSE;
	btn6.selected = FALSE;
	btn7.selected = FALSE;
	btn8.selected = FALSE;
}

-(void)tab5Pressed
{
	[nvCtr5 popToRootViewControllerAnimated:NO];
	[nvCtr5 viewWillAppear:YES];
	tabBarMain.selectedIndex = 4;
	btn1.selected = FALSE;
	btn2.selected = FALSE;
	btn3.selected = FALSE;
	btn4.selected = FALSE;
	btn5.selected = TRUE;
	btn6.selected = FALSE;
	btn7.selected = FALSE;
	btn8.selected = FALSE;
	
}

-(void)tab6Pressed
{
	[nvCtr6 popToRootViewControllerAnimated:YES];
	[nvCtr6 viewWillAppear:TRUE];
	tabBarMain.selectedIndex = 5;
	btn1.selected = FALSE;
	btn2.selected = FALSE;
	btn3.selected = FALSE;
	btn4.selected = FALSE;	
	btn5.selected = FALSE;
	btn6.selected = TRUE;
	btn7.selected = FALSE;
	btn8.selected = FALSE;
}
-(void)tab7Pressed
{
	[nvCtr7 popToRootViewControllerAnimated:NO];
	//[nvCtr7 viewWillAppear:TRUE];
	tabBarMain.selectedIndex = 6;
	btn1.selected = FALSE;
	btn2.selected = FALSE;
	btn3.selected = FALSE;
	btn4.selected = FALSE;	
	btn5.selected = FALSE;
	btn6.selected = FALSE;
	btn7.selected = TRUE;
	btn8.selected = FALSE;
}
-(void)tab8Pressed
{
	[nvCtr8 popToRootViewControllerAnimated:NO];
	//[nvCtr8 viewWillAppear:TRUE];
	tabBarMain.selectedIndex = 7;
	btn1.selected = FALSE;
	btn2.selected = FALSE;
	btn3.selected = FALSE;
	btn4.selected = FALSE;	
	btn5.selected = FALSE;
	btn6.selected = FALSE;
	btn7.selected = FALSE;
	btn8.selected = TRUE;
	
}
/*-(void)FromStatus_ToGet{
	NCtr4IndexAnim=3;
	[nvCtr3 popToRootViewControllerAnimated:NO];
	[nvCtr1.view addSubview:nvCtr3.view];
	CATransition *trn=[CATransition animation]; trn.duration=0.45;
	trn.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	trn.type=kCATransitionPush; trn.subtype=kCATransitionFromRight;
	transitioning=YES; trn.delegate=self;
	btn1.selected=NO; btn2.selected=NO; btn3.selected=YES; btn4.selected=NO; btn5.selected=NO;
	[nvCtr1.view.layer addAnimation:trn forKey:nil];	
}

-(void)FromStatus_ToPay{
	NCtr4IndexAnim=4;
	[nvCtr4 popToRootViewControllerAnimated:NO];
	[nvCtr1.view addSubview:nvCtr4.view];
	CATransition *trn=[CATransition animation]; trn.duration=0.45;
	trn.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	trn.type=kCATransitionPush; trn.subtype=kCATransitionFromRight;
	transitioning=YES; trn.delegate=self;
	btn1.selected=NO; btn2.selected=NO; btn3.selected=NO; btn4.selected=YES; btn5.selected=NO;
	[nvCtr1.view.layer addAnimation:trn forKey:nil];	
}

-(void)FromStatus_ToPending{
	NCtr4IndexAnim=5;
	[nvCtr5 popToRootViewControllerAnimated:NO];
	[nvCtr1.view addSubview:nvCtr5.view];
	CATransition *trn=[CATransition animation]; trn.duration=0.45;
	trn.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	trn.type=kCATransitionPush; trn.subtype=kCATransitionFromRight;
	transitioning=YES; trn.delegate=self;
	btn1.selected=NO; btn2.selected=NO; btn3.selected=NO; btn4.selected=NO; btn5.selected=YES;
	[nvCtr1.view.layer addAnimation:trn forKey:nil];	
}

-(void)FromToGet_Status{
	NCtr4IndexAnim=0;
	[nvCtr1 popToRootViewControllerAnimated:NO];
	[nvCtr3.view addSubview:nvCtr1.view];
	CATransition *trn=[CATransition animation]; trn.duration=0.45;
	trn.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	trn.type=kCATransitionPush; trn.subtype=kCATransitionFromLeft;
	transitioning=YES; trn.delegate=self;
	btn1.selected=YES; btn2.selected=NO; btn3.selected=NO; btn4.selected=NO; btn5.selected=NO;
	[nvCtr3.view.layer addAnimation:trn forKey:nil];	
}

-(void)FromToPay_Status{
	NCtr4IndexAnim=0;
	[nvCtr1 popToRootViewControllerAnimated:NO];
	[nvCtr4.view addSubview:nvCtr1.view];
	CATransition *trn=[CATransition animation]; trn.duration=0.45;
	trn.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	trn.type=kCATransitionPush; trn.subtype=kCATransitionFromLeft;
	transitioning=YES; trn.delegate=self;
	btn1.selected=YES; btn2.selected=NO; btn3.selected=NO; btn4.selected=NO; btn5.selected=NO;
	[nvCtr4.view.layer addAnimation:trn forKey:nil];	
}

-(void)FromToPending_Status{
	NCtr4IndexAnim=0;
	[nvCtr1 popToRootViewControllerAnimated:NO];
	[nvCtr5.view addSubview:nvCtr1.view];
	CATransition *trn=[CATransition animation]; trn.duration=0.45;
	trn.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	trn.type=kCATransitionPush; trn.subtype=kCATransitionFromLeft;
	transitioning=YES; trn.delegate=self;
	btn1.selected=YES; btn2.selected=NO; btn3.selected=NO; btn4.selected=NO; btn5.selected=NO;
	[nvCtr5.view.layer addAnimation:trn forKey:nil];	
}



-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	switch (NCtr4IndexAnim) {
		case 0: [nvCtr1.view removeFromSuperview]; [tabBarMain setSelectedIndex:0]; break;
		case 3: [nvCtr3.view removeFromSuperview]; [tabBarMain setSelectedIndex:2]; break;
		case 4: [nvCtr4.view removeFromSuperview]; [tabBarMain setSelectedIndex:3]; break;
		case 5: [nvCtr5.view removeFromSuperview]; [tabBarMain setSelectedIndex:4]; break;
		default: break;
	}
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


/*- (void)dealloc {
	if(nxtPendingViewCtr!=nil && [nxtPendingViewCtr retainCount]>0) { [nxtPendingViewCtr release]; nxtPendingViewCtr=nil; }
	if(nxtToGetViewCtr!=nil && [nxtToGetViewCtr retainCount]>0) { [nxtToGetViewCtr release]; nxtToGetViewCtr=nil; }
	if(nxtToPayViewCtr!=nil && [nxtToPayViewCtr retainCount]>0) { [nxtToPayViewCtr release]; nxtToPayViewCtr=nil; }
	if(nxtCreateViewCtr!=nil && [nxtCreateViewCtr retainCount]>0) { [nxtCreateViewCtr release]; nxtCreateViewCtr=nil; }
	if(nxtStatusViewCtr!=nil && [nxtStatusViewCtr retainCount]>0) { [nxtStatusViewCtr release]; nxtStatusViewCtr=nil; }
	
	if(nvCtr1!=nil && [nvCtr1 retainCount]>0) { [nvCtr1 release]; nvCtr1=nil; }
	if(nvCtr2!=nil && [nvCtr2 retainCount]>0) { [nvCtr2 release]; nvCtr2=nil; }
	if(nvCtr3!=nil && [nvCtr3 retainCount]>0) { [nvCtr3 release]; nvCtr3=nil; }
	if(nvCtr4!=nil && [nvCtr4 retainCount]>0) { [nvCtr4 release]; nvCtr4=nil; }
	if(nvCtr5!=nil && [nvCtr5 retainCount]>0) { [nvCtr5 release]; nvCtr5=nil; }
	
	if(nxtPendingViewCtr!=nil && [nxtPendingViewCtr retainCount]>0) { [nxtPendingViewCtr release]; nxtPendingViewCtr=nil; }
    [super dealloc];
}*/


@end
