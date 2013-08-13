//
//  ScannedResultViewController.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 02/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "generalcalculations.h"
@class KrenMarketingAppDelegate;
@interface ScannedResultViewController : UIViewController {
    BOOL flagcontact;
    BOOL flagphone;
    BOOL flagevent;
	
	IBOutlet UIImageView *imgView_scanQR;
	UIImage *img_iPhone_fromScan;
	NSString *result_scan;
	IBOutlet UILabel *dtLabel;
	IBOutlet UILabel *TimeLabel;
	IBOutlet OHAttributedLabel *ScanDataLabel;
	IBOutlet UILabel *lblHeading;
	IBOutlet UIScrollView *ScrScanResult;
	KrenMarketingAppDelegate *appDel;
	UIAlertView *alert_SaveQR;
    UIButton *actionbuts;
    UILabel *lbldisplaycal;
    NSString *tempstrcopy;
    NSString *linksdata;
    generalcalculations *geni;
   
   	
	IBOutlet UIButton *btnBackTOsmwhere;
}
-(IBAction)btnBack_CameraView:(id)sender;
-(IBAction)btnBackPressed:(id)sender;
-(IBAction)btnTwitterClicked:(id)sender;
-(IBAction)btnEmailClicked:(id)sender;
-(IBAction)btnFacebookClicked:(id)sender;
-(IBAction)DeleteQRCode;
-(void)TimeandDate;
@property (nonatomic,retain)UIImage *img_iPhone_fromScan;
@property (nonatomic,retain)NSString *result_scan;

@end
