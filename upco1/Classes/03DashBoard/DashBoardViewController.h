//
//  DashBoardViewController.h
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KrenMarketingAppDelegate;

@interface DashBoardViewController : UIViewController 
{
	KrenMarketingAppDelegate *appDel;
	//////
	UIView *dashBoardView;
	UIImageView *topViewImage;
	UIImageView *mainViewImage;
	UIImageView *MSGView;
	UILabel *topViewLable;
	
	UIButton *btnContinue;
	
	UIImageView *topImage;
	UIImageView	*mainImage;
	UIImageView *MainMsg;
	UILabel *topLable;
	UIImageView *circle;
	UIImageView *aero;
	UIImageView *whiteLayer;
	UILabel *labelWhite;
	
	UIButton *btn2;
	UIButton *btn10;
	UIButton *btn12;
	UIButton *btn14;
	UIButton *btn15;
	UIButton *btn16;
	UIButton *btn17;
	UIButton *btn18;
	UIButton *btn20;
	UIButton *btn21;
	
	NSMutableArray *btnArrays;
	//BOOL dashboadviewflag;
	
	int tagme;
	
	BOOL firstTime;
	BOOL oncePort;
	NSMutableArray *btnArrays1;
	
	IBOutlet UIView *iphone_DashboardView;
}

-(IBAction)btnCountPressed:(id)sender;
-(IBAction)openSafari:(id)sender;
- (void) didRotate:(NSNotification *)notification;
-(IBAction)dashboard_view;
@end
