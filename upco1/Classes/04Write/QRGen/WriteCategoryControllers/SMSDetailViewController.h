//
//  SMSDetailViewController.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SMSDetailViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>
{
	IBOutlet UILabel *lblHeader;
	IBOutlet UIImageView *ImageQRCode;
	IBOutlet UIButton *BtnEncode;
	
	UILabel *dateLabel;
	UILabel *TimeLabel;
	NSMutableAttributedString *strattr;
	int height;
	NSString *sampleString;
	
	IBOutlet UITextField *txtMobileNumber;
	IBOutlet UITextView *txtMessage;
	
	IBOutlet UILabel *lblPlaceholder;
	
}
-(IBAction)GenerateQrCode;
-(IBAction)BackToRoot;
-(void)textFieldDidChange:(id)sender;

@end
