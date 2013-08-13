//
//  QRGenViewController.h
//  QRGen
//
//  Created by Patrick Hogan on 7/26/11.
//  Copyright 2011 Kuapay LLC. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "KrenMarketingAppDelegate.h"
#import "OHAttributedLabel.h"
#import "FontViewViewController.h"
#import "EGOTextView.h"
#import "NSAttributedString+Attributes.h"
#import <CFNetwork/CFNetwork.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "OtherOptionController.h"
#import "StartEndDayController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <EventKit/EventKit.h>

//macros for detection of version of ios

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



@class OtherOptionController;

@interface QRGenViewController : UIViewController <UIPopoverControllerDelegate,UIScrollViewDelegate, UITextFieldDelegate,dateSelectedDelegate,MFMailComposeViewControllerDelegate,OtherOptionDelegate,NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
	IBOutlet UIImageView *imageview;
	IBOutlet UIImageView *ImageTop;
	IBOutlet UIImageView *imageSetting;
	IBOutlet UIImageView *imageSeperator;
	IBOutlet UIImageView *imageBottomBar;
	IBOutlet UIImageView *imageButonBack;
	IBOutlet UIButton *ButonBack;


    IBOutlet UILabel *LblTop;
	IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *TimeLabel;
	IBOutlet UIButton *BtnEncode;
	KrenMarketingAppDelegate *appDel;
	IBOutlet UILabel *lblName;

	NSString *sampleString;
	int CounterBtn;
	
	//BOTTOM TAB BUTTONs
	IBOutlet UIButton *BtnURL;
	IBOutlet UIButton *BtnContact;
	IBOutlet UIButton *BtnEvent;
	IBOutlet UIButton *BtnMap;
	IBOutlet UIButton *BtnSMS;
	IBOutlet UIButton *BtnPhone;
	IBOutlet UIButton *BtnEmail;
	IBOutlet UIButton *BtnText; 
	
	
	
	
	IBOutlet UIButton *BtnFacebook;
	IBOutlet UIButton *BtnTwitter;
	IBOutlet UIButton *BtnMail;
	IBOutlet UIButton *BtnTrash;
		
	//TAB URL
	IBOutlet UIView *URLView;
	IBOutlet UILabel *LblUrl;
	IBOutlet UILabel *LblUrl2;
	
	IBOutlet UITextField *txturl1;
	IBOutlet UIButton *BtnUrl2;
	IBOutlet UIImageView *ImageUrl;
	IBOutlet UIImageView *ImageUrl1;
	IBOutlet UIImageView *Imagecheck;
	
	
	//TAB Contact DEtail		
	IBOutlet UIView *ContactView;
	IBOutlet UILabel *LblContact;
	//UIButton *btnDelete;
	
	//EVENT
	IBOutlet UIView *EventView;
	IBOutlet UILabel *LblEvent;
	IBOutlet UIScrollView *SclEvent;
	IBOutlet UITextField *txtevent1;
	IBOutlet UITextField *txtevent3;
	IBOutlet UITextField *txtevent4;
	IBOutlet UITextField *txtevent5;
	IBOutlet UITextField *txtevent6;
	IBOutlet UITextField *txtevent7;
	IBOutlet UITextField *txtevent8;
	IBOutlet UIImageView *ImageEventText;
	IBOutlet UIButton *BtnStarts;
	IBOutlet UIButton *BtnEnds;
	IBOutlet UILabel *Lblstart;
	IBOutlet UILabel *LblEnd;
	IBOutlet UILabel *LblDate1;
	IBOutlet UILabel *LblDate2;
	IBOutlet UILabel *LblTime1;
	IBOutlet UILabel *LblTime2;
	IBOutlet UIImageView *Imageevent1;
	IBOutlet UIImageView *Imageevent3;
	IBOutlet UIImageView *ImageEvent4;
	NSMutableArray* arrLocal;
	BOOL Start;
	BOOL END;
    NSMutableString *tmpst;
	
	
	//MAp
	IBOutlet UIView *Mapview;
	IBOutlet UILabel *LblMap;
	IBOutlet UIScrollView *Sclmap;
	IBOutlet UITextField *Txtmap1;
	IBOutlet UITextField *Txtmap2;
	IBOutlet UITextField *Txtmap3;
	IBOutlet UITextField *Txtmap4;
	IBOutlet UITextField *Txtmap5;
	IBOutlet UITextField *Txtmap6;
	IBOutlet UIImageView *ImageMap1;
	IBOutlet UIImageView *ImageMap2;

	//SMS
	IBOutlet UIView *SMSView;
	IBOutlet UILabel *Lblsms;
	IBOutlet UITextField *Txtsms;
	IBOutlet UITextView *txtsmsMessage;
	IBOutlet UIImageView *imgsmsBack;
	IBOutlet UIImageView *Imagesms1;
	IBOutlet UILabel *LblsmsMessage;
	
	
	//Phone
	IBOutlet UIView *PhoneView;
	IBOutlet UILabel *Lblphone;
	IBOutlet UITextField *txtPhone;
	IBOutlet UIImageView *ImagePhone;

	
	//EMAIL
	IBOutlet UIView *EmailView;
	IBOutlet UILabel *LblEmail;
	IBOutlet UITextField *txtemail1;
	IBOutlet UITextField *txtemail2;
	IBOutlet UIImageView *ImageEmail1;
	IBOutlet UIImageView *ImageEmail2;
	IBOutlet UITextView *txtviewemail3;
	IBOutlet UIImageView *imgEmail;
	IBOutlet UILabel *LblMailMessage;
	
	
	//TEXT
	IBOutlet UIView *ViewText;
	IBOutlet UILabel *LblText;
	IBOutlet UILabel *LblPlaceholder;
	EGOTextView *Ego_Textview;
	IBOutlet UIScrollView *ScrlText;	
	IBOutlet UIImageView *imgtxtBack;
	IBOutlet UIButton* btnFont;
	FontViewViewController* objFontView;
	BOOL isBold,isItalic,isUnderline;
	UIButton *button;
	NSString *ResultString;
	EGOTextView *_egoTextView;
	NSMutableAttributedString* attrStr;
    NSString *realph;
	 NSString *realph1;
    NSString *temploc;
    NSString *tempevennotes;
    NSString *tempevenloc;
	
	//View For PopOVer in contact Screen
	
	IBOutlet UITableView *tblContact;
	
	
	//LABEL FOR DECODED DATA
	IBOutlet UIScrollView *ScrllLabel;
	IBOutlet OHAttributedLabel *txtDisplayWEb;	
	IBOutlet UITextView *txtViewDisplay;
	IBOutlet UIButton *btnurlopen;
	
	
	BOOL oncePort;
	BOOL firstTime;
    
    //--*
    BOOL flagcon;
    BOOL flagphon;
    BOOL flageven;
    
	
	UIPopoverController* dateSelection;
	
	//POP CODEING	
	
	UIScrollView *scrollView;
    UIScrollView *scrolldata;
    UIButton *actionButton;
	
    NSMutableArray *arrField;
    
    UIButton *btnName;
    int height ;
    
    UIPopoverController *newPopOver;
    OtherOptionController *obj_OtherOptionController;
    UIButton *addbtn;
    
    UILabel *showLebel ;    
    NSMutableArray *AddButton;
	NSMutableArray *OtherButton;
    
    UITextField* activetxt;
	UITextView* activetxtview;

	
	UIPopoverController* fontPicker;
	
	
	UIView *MaskView;
	UIImage *Imagesaved;
	
	EGOTextView *view1;
	int ctr;

	//XML PARSING
	NSXMLParser *xmlParser;
    NSInteger depth;
    NSMutableString *currentName;
    NSString *currentElement;
	NSMutableData *myWebData;
	NSURLConnection *con;
	NSObject *MainHandler;
	NSMutableData *responseData ;
	int prevvalue;
   
	
	//Iphone
	
	IBOutlet UITableView *tblWrite_iphone;
	NSMutableArray *arr_iphoneData;
	int selectedRow;
	NSMutableArray *array_NormalImages;
	NSMutableArray *array_SelectedImages;
}
@property(nonatomic,retain) EGOTextView *egoTextView;
@property(nonatomic) BOOL isBold;
@property(nonatomic) BOOL isItalic;
@property(nonatomic) BOOL isUnderline;


@property (nonatomic, retain)IBOutlet UIImageView *imageview;

@property (nonatomic, retain)IBOutlet UITextField *txtName;
@property (nonatomic, retain)NSString *realph;
@property (nonatomic, retain)NSString *realph1;
@property (nonatomic, retain)NSMutableString *tmpst;
-(IBAction)BackButtonClick:(id) sender;
-(void)TimeandDate;
-(IBAction)DecodeClick:(id)sender;
-(void)setFrameOrientation_Portrait;
-(void)setFrameOrientation_LandScap;


-(IBAction) buttonTwitterClicked:(id)sender;
-(IBAction)emailbtn_click:(id)sender;
-(IBAction)Trash_click:(id)sender;
-(IBAction)buttonFacebooKClicked:(id)sender;
- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage ;


-(IBAction)URLClicked:(id)sender;
-(IBAction)ContactClicked:(id)sender;
-(IBAction)EventClicked:(id)sender;
-(IBAction)MapClicked:(id)sender;
-(IBAction)SMSClicked:(id)sender;
-(IBAction)PhoneClicked:(id)sender;
-(IBAction)MailCicked:(id)sender;
-(IBAction)TextCicked:(id)sender;


//Button in Event screen
-(IBAction)StartsClick:(id)sender;
-(IBAction)EndsClick:(id)sender;
-(void)imageDraw;
-(IBAction) fontButtonClick:(id) sender;
-(void)generateQR;
-(IBAction)btnScanURL:(id)sender;

-(void) dismissdatePopOver;
-(void) didmissfontpicker;
-(void) dismissPopOver;
//DIsplay Method
-(BOOL)PhoneDisplay;
-(BOOL)ContactDisplay;
-(BOOL)smsdisplay;
-(BOOL)Eventdisplay;
-(BOOL)Maildisplay;
-(BOOL)generatedDisplay;
-(BOOL)Mapdisplay;

-(void)ReleaseEgo_Text;
-(void)calledendclick;
-(void)event3respond;
- (void)start;
-(IBAction)shortenurlclick;



//Images of TextFeild
-(void)Images_Landscape_Text;
-(void)Images_Portrait_Text;
@end
