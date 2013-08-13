//
//  LibraryDetailViewController.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 22/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

@class KrenMarketingAppDelegate;
@interface LibraryDetailViewController : UIViewController 
{
	 UILabel *createdDate;
	 UIImageView *qrcodeImage;
	UILabel *topLabel;
	OHAttributedLabel *txtDisplay;
	int changeColor;
	NSMutableArray *array_catagory;
	UILabel *catDes;
	int height;
	CGFloat y_pos;
	UIScrollView *txtScroll;
	KrenMarketingAppDelegate *appDel;
	UIButton *actbutl;
	 NSString *strImage;
    BOOL flagcon;
    BOOL flagphon;
    BOOL flageven;
    UITextView *lblcalendarnote;
   
}

@property (nonatomic,retain)NSMutableArray *array_catagory;
@property (readwrite) int changeColor;

-(id)initWithImage:(UIImage *)QRImage text:(NSString*)textLable topText:(NSString *)toptextLable string:(NSMutableAttributedString*)str index:(int)index;
-(IBAction)BackToLibrary;
-(void)MainDescription;
-(IBAction)btnEmailClicked;
-(IBAction)btnTwitterClicked;
-(IBAction)btnFacebookClicked;

-(IBAction)DeleteQRCode;

@end
