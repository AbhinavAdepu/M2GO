//
//  PreviewShareView_iPhone.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 05/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PreviewShareView_iPhone : UIViewController {
	
	UIImage *imageBCard;
	IBOutlet UIImageView *imgViewBCard;
	IBOutlet UILabel *lblHeading;
	KrenMarketingAppDelegate *appDel;
	NSString *strFlag;
	IBOutlet UIButton *btnCall;
	NSString *phoneNumber;
	int align;

}
-(IBAction)btnbackPressed:(id)sender;
-(IBAction)btnAddPressed:(id)sender;
-(IBAction)btnTwitterClicked:(id)sender;
-(IBAction)btnFacebookClicked:(id)sender;
-(IBAction)btnEmailClicked:(id)sender;
-(IBAction)DeleteQRCode;
-(IBAction)btnCallPressed:(id)sender;
@property (nonatomic,readwrite)int align;
@property (nonatomic,retain)UIImage *imageBCard;
@property (nonatomic,retain)NSString *strFlag;
@property (nonatomic,retain)NSString *phoneNumber;
@end
