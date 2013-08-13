//
//  WriteDetailViewController.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 02/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

@interface WriteDetailViewController : UIViewController <OHAttributedLabelDelegate>
{
	IBOutlet UIView *URLView;
		
	IBOutlet UILabel *lblHeader;
	
	IBOutlet UIImageView *ImageQRCode;
	
	//URL
	
	IBOutlet UIButton *btnEncode;
	
	IBOutlet UITextField *txtURL;
	IBOutlet UILabel *txtShortenURL;
	
	NSString *sampleString;
	NSString *text_QR;
	OHAttributedLabel *txtDisplay;
	NSMutableAttributedString *strattr;
	int height;
	UILabel *dateLabel;
	UILabel *TimeLabel;
	
	//parsing
	
	NSXMLParser *xmlParser;
    NSInteger depth;
    NSMutableString *currentName;
    NSString *currentElement;
	NSMutableData *myWebData;
	NSURLConnection *con;
	NSObject *MainHandler;
	NSMutableData *responseData ;
	int prevvalue;
	
	IBOutlet UIImageView *Imagecheck;
	
}

-(void)textFieldDidChange:(id)sender;
-(IBAction) QrGenerateCode:(id) sender;
-(id)initwithIndex:(NSString*)index;
-(IBAction)BackToRoot;
-(IBAction)shortenurlclick;

-(UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
@end
