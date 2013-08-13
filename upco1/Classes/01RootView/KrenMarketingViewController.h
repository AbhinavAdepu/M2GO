//
//  KrenMarketingViewController.h
//  KrenMarketing
//
//  Created by Silvertouch on 14/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRScanViewController.h"
#import "DashBoardViewController.h"
#import "QuizViewController.h"
#import "TemplateViewController.h"
#import "TwitterViewController.h"
#import "LibraryViewController.h"
#import "AboutViewController.h"
#import "QRScan.h"
#import "ZBarReaderViewController.h"
#import "ZBarReaderView.h"
#import "KrenMarketingAppDelegate.h"
#import "QRGenViewController.h"
#import "generalcalculations.h"
#import "TemplateViewController.h"
@class TemplateViewController;
@interface KrenMarketingViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZBarReaderViewDelegate,ZBarReaderDelegate>
{
 UIButton *btnScan;
 UIButton *btnDashBoard;
 UIButton *btnWrite;	
 UIButton *btnTemplate;
 UIButton *btnTwitter;
 UIButton *btnLibrary;
 UIButton *btnAbout;
 UIButton *btnQuiz;
 UIButton *btnNext;
 UIButton *btnPrevious;
    UIButton *actionbut;
 UIImageView *imageBtnBack;	
 IBOutlet UIImageView *imagebottombar;	
 IBOutlet UIImageView *TopRed;	
 IBOutlet UIImageView *imageQR;	
 IBOutlet UIButton *facebook;	
 IBOutlet UIButton *twitter;	
 IBOutlet UIButton *Mail;	
 IBOutlet UIButton *trash;
 IBOutlet UILabel *LBlHeading;
 IBOutlet UILabel *dateLabel;
 IBOutlet UILabel *TimeLabel;
 //IBOutlet UILabel *LabelQRCode;
	IBOutlet UITextView *LabelQRCode;
    IBOutlet OHAttributedLabel *Scanstrshow;
	
    NSString *linksdata;
	IBOutlet UIView *MainMenuView;
	IBOutlet UIImageView *mainImageView;
	BOOL MainmenuAppear;
	DashBoardViewController  *DashBoardViewController_obj;
	QRScanViewController *QRScanViewController_obj;
	QuizViewController *QuizViewController_obj;
	TwitterViewController *TwitterViewController_obj;
	LibraryViewController *	LibraryViewController_obj;
	AboutViewController *AboutViewController_obj;
	TemplateViewController *TemplateViewController_obj;
    generalcalculations *geni;
	UINavigationController *nav_QR;
	UINavigationController *nav_Write;
	UINavigationController *nav_About;
	UINavigationController *nav_Dash;
	UINavigationController *nav_Quiz;
	UINavigationController *nav_Lib;
	UINavigationController *nav_Twitter;
	UINavigationController *nav_Template;
    UIPopoverController *popReader;
	IBOutlet QRScan *scanView;
	UIImageView *Cameraimage;
	NSMutableArray *ArrayView;
	int counter;
	UIScrollView *ScrlTabButtn;	
	
	BOOL found, paused, continuous;
	ZBarReaderViewController *reader;
	IBOutlet UIButton *btnPhotoAlbum,*btnBack,*btnCamera;
	KrenMarketingAppDelegate *appDel;
	CGFloat zoom;
	UIView *overlay;
	UIBarButtonItem *manualBtn;
	UILabel *typeLabel, *dataLabel;
	UILabel *typeOvl, *dataOvl;
	IBOutlet UIButton *BtnQRcodeText;
    NSArray *masks;
	NSInteger dataHeight;
	QRGenViewController *QRGenViewController_obj;
	
	IBOutlet ZBarReaderView *readerView;
	
	BOOL Photosel;
	BOOL AlbumSel;
    BOOL flagmet;
    
    //--*
    BOOL flagcon;
    BOOL flagphon;
    BOOL flageven;
    BOOL flagtrav;

	
	UIImagePickerController * picker ;
	
	
	IBOutlet UIImageView *imgHighlight;
	
	ZBarSymbolSet *GsymData;
	UIImage *GImage;

	BOOL flag;
	//For Event
	NSString *stDate,*enDate,*BegEvent,*EndEvent,*summary;
	//For SMS
	NSString *phoneNumber,*msg;
	//For Mail
	NSString *EMailID,*subject,*Body;
	//For TelNo
	NSString *tel;
	
	//int count;
	//NSString *globalData;
	UIView *viewMainMenusButns;
	BOOL fromAnimation;
	CGFloat x,x_menuView;
	NSTimer *T1;
	IBOutlet UILabel *lblIntroText;
	
	UIImage *glbImage;
	IBOutlet UIImageView *lblIntroImage;
}
@property (nonatomic, retain)IBOutlet UIImageView *imagecamera;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain)IBOutlet UILabel *TimeLabel;


-(IBAction)BtnScanClicked:(id)sender;
-(IBAction)BtnDashBoardClicked:(id)sender;
-(IBAction)BtnWriteClicked:(id)sender;
-(IBAction)BtnTemplateClicked:(id)sender;
-(IBAction)BtnTwitterClicked:(id)sender;
-(IBAction)BtnLibraryClicked:(id)sender;
-(IBAction)BtnAboutClicked:(id)sender;
-(IBAction)BtnquizClicked:(id)sender;
//-(IBAction)btnNextClicked:(id)sender;
//-(IBAction)btnPreviousClicked:(id)sender;
-(IBAction)Trash_click:(id)sender;
- (void) initReader: (NSString*) clsName;
- (void)TimeandDate;//Current Date & Time
- (void) updateCropMask;
- (void) presentResult: (ZBarSymbol*) sym;
-(IBAction)btnQRCodePressed:(id)sender;
-(IBAction) getPhoto:(id) sender;
-(IBAction) getPhoto_Album:(id) sender;
-(void)saveQrCode:(UIImage *)img;
-(IBAction)btnScanURL:(id)sender;


@end

