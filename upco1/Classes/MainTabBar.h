//
//  MainTabBar.h
//  CashCollie
//
//  Created by digicorp on 11/27/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Modal_TabBarAppDelegate.h"
#import "KrenMarketingAppDelegate.h"

#import "ScanViewController.h"
#import "DashBoardViewController.h"
#import "QRGenViewController.h"
#import "QuizViewController.h"
#import "TemplateViewController.h"
#import "TwitterViewController.h"
#import "LibraryViewController.h"
#import "AboutViewController.h"

@interface MainTabBar : UIViewController <UIScrollViewDelegate>
{
	ScanViewController *obj_Scan;
	DashBoardViewController *obj_Dashboard;
	QuizViewController *obj_Quiz;
	QRGenViewController *obj_Write;
	TemplateViewController *obj_Template;
	TwitterViewController *obj_Twitter;
	LibraryViewController *obj_Library;
	AboutViewController *obj_About;
	
    
	KrenMarketingAppDelegate *appDelegate;
	
	UINavigationController *nvCtr1;
	UINavigationController *nvCtr2;
	UINavigationController *nvCtr3;
	UINavigationController *nvCtr4;
	UINavigationController *nvCtr5;
	UINavigationController *nvCtr6;
	UINavigationController *nvCtr7;
	UINavigationController *nvCtr8;
	
	UITabBarController *tabBarMain;
	
	UIButton *btn1;
	UIButton *btn2;
	UIButton *btn3;
	UIButton *btn4;
	UIButton *btn5;
	UIButton *btn6;
	UIButton *btn7;
	UIButton *btn8;
	
	BOOL transitioning;
	NSInteger NCtr4IndexAnim;

	BOOL isFirstTimeLoggedIn;
	
	UIImageView *aero1;
	UIImageView *aero2;
	UIImageView *aero3;
	UIImageView *aero4;
}
@property(nonatomic,readwrite) BOOL isFirstTimeLoggedIn;
@property (nonatomic,retain) UINavigationController *nvCtr2;
//-(UITabBarController*)getTabBarRef;
/*-(PendingViewCtr*)getPendingViewCtr;
-(ToGetVCtr*)getToGetVCtr;
-(ToPayViewCtr*)getToPayViewCtr;
-(CreateViewCtr*)getCreateViewCtr;
-(StatusViewCtr*)getStatusViewCtr;*/
-(void)tab1Pressed;
-(void)tab2Pressed;
-(void)tab3Pressed;
-(void)tab4Pressed;
-(void)tab5Pressed;
-(void)FromStatus_ToGet;
-(void)FromStatus_ToPay;
-(void)FromStatus_ToPending;
-(void)FromToGet_Status;
-(void)FromToPay_Status;
-(void)FromToPending_Status;
@end
