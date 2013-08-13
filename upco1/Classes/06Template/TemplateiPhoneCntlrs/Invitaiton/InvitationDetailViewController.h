//
//  InvitationDetailViewController.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 14/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InvitationDetailViewController : UIViewController <UITextFieldDelegate>
{
	IBOutlet UILabel *lblHeader;
	IBOutlet UIImageView *ImageQRCode;
	IBOutlet UIButton *BtnContinue;
	
	IBOutlet UIScrollView *scrollTexts;
	
	IBOutlet UITextField *txtEventTitle;
	IBOutlet UITextField *txtStreet;
	IBOutlet UITextField *txtCity;
	IBOutlet UITextField *txtState;
	IBOutlet UITextField *txtZipCode;
	IBOutlet UITextField *txtCountry;
	
	UIImage *image_Card;
	UIImage *img_picLib;
	int btnIndex;
	IBOutlet UIButton *btnQRCode;
	IBOutlet UIButton *btnPhotoLibImage;
	KrenMarketingAppDelegate *appDel;
}
@property (nonatomic,retain)UIImage *image_Card;
@property (nonatomic,readwrite)int btnIndex;
-(IBAction)btnHomePressed:(id)sender;
-(IBAction)BtnContinueClicked;
-(IBAction)btnLibraryClicked;
-(IBAction)btnPhotoLibraryClicked;
-(void)textFieldDidChange:(id)sender;
-(IBAction)BackToRoot;

@end
