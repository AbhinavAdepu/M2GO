//
//  QRGenDetailViewController.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 02/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "KrenMarketingAppDelegate.h"

@interface QRGenDetailViewController : UIViewController <MFMailComposeViewControllerDelegate,UIGestureRecognizerDelegate>
{
	IBOutlet UILabel *lblHeader;
	NSString *text_QR;
	OHAttributedLabel *txtDisplay;
	UILabel *dateLabel;
	UILabel *TimeLabel;
	UIImageView *imgQR;
	UIScrollView *txtScroll;
	UIButton *actionbutton;
	KrenMarketingAppDelegate *appDel;
    BOOL addcon;
    BOOL addphon;
    BOOL addeven;
    BOOL flagevent;
}

-(IBAction)BackToRoot;
-(IBAction)DeleteQRCode;
-(IBAction)BackToHome;
-(IBAction)btnEmailClicked;
-(IBAction)btnTwitterClicked;
-(IBAction)btnFacebookClicked;

@end
