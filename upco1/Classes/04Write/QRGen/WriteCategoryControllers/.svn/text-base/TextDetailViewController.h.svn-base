//
//  TextDetailViewController.h
//  KrenMarketing
//
//  Created by amrit on 04/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOTextView.h"
#import "FontViewViewController.h"
#import "KrenMarketingAppDelegate.h"
#import "OtherOptionController.h"

@interface TextDetailViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate,dateSelectedDelegate,MFMailComposeViewControllerDelegate,OtherOptionDelegate,NSXMLParserDelegate>
{
	IBOutlet UILabel *lblHeader;
	IBOutlet UIImageView *ImageQRCode;
	IBOutlet UIButton *BtnEncode;
	
	UILabel *dateLabel;
	UILabel *TimeLabel;
	NSMutableAttributedString *strattr;
	int height;
	NSString *sampleString;
	
	EGOTextView *Ego_Textview;
	BOOL isBold,isItalic,isUnderline;
	FontViewViewController *obj_Font;
	KrenMarketingAppDelegate *appDel;
	IBOutlet UILabel *lblPlaceholder;
}


@property(nonatomic) BOOL Bold;
@property(nonatomic) BOOL Underline;
@property(nonatomic) BOOL Italic;

@property(nonatomic) int lastfontSize;
@property(nonatomic, readwrite)int lastFontIndex;
@property(nonatomic,readwrite)int styleIndex;
@property(nonatomic,readwrite)int alignIndex;
@property(nonatomic,readwrite)int colorIndex;
@property(nonatomic, retain)id<dateSelectedDelegate> delegate;

@property(nonatomic) BOOL isBold;
@property(nonatomic) BOOL isItalic;
@property(nonatomic) BOOL isUnderline;

-(IBAction)changeFont;
-(IBAction)DoneClicked;
-(IBAction)BackToRoot;
-(IBAction)GenerateQrCode;
@end
