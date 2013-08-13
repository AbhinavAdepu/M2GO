//
//  TemplateViewController.h
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coverflowshow.h"
#import "LibraryViewController.h"
#import "OHAttributedLabel.h"
#import "DatePickerCourseInfo.h"

@interface TemplateViewController : UIViewController<UIPopoverControllerDelegate,UIGestureRecognizerDelegate> {
	IBOutlet UIImageView *Topimage;
	KrenMarketingAppDelegate *appDel;
	LibraryViewController *obj_LibraryViewController;
	IBOutlet UIButton *btn_UDT,*btn_UCD;
	IBOutlet UIButton *btn_Event,*btn_BusinessCard,*btn_Invitation,*btn_IDBadge,*btn_ContactInfo;
	IBOutlet UIButton *btn_Back;
	NSString *str_TM_SelectedItem;
	IBOutlet UILabel *lbl_TemplateTitle;
	IBOutlet UIImageView *iv_SeperationLine,*iv_SeperationBorder;
	//For MainView  OpenFlow and libraryview
	IBOutlet UIView *mainView;
	IBOutlet UIButton *btnCreate;
	NSString *strFlag,*strFlagForTextfield;
	NSString *str_date,*str_Flag_Gradient;
	BOOL FlagForCoverFlow;
	IBOutlet UIButton *btn_OpenCamera_UCD;
	
	//For image pick view == CoverFlow and Library
	IBOutlet UIView *coverFloWView,*libraryView;
	UIImagePickerController *imagePickerController;
	UIImageView *ivCoverFlow,*ivLibrary;
	coverflowshow *vc;
	
	IBOutlet UIButton *btn_Plus;
	
	//For EventView
	IBOutlet UIView *eventView;
	///this buttons only for providing border to eventtitle;
	IBOutlet UIButton *btneventTitle,*btnstart,*btnend,*btnaddress,*btnnotes;
	IBOutlet UILabel *lblNotes;
	IBOutlet UIImageView *ivBarcode,*ivAddressBackGround;
	IBOutlet UIScrollView *scrl_Event;
	NSString *strAddressTOpassLibrary_Event;
	
	//NSString *str_EventName,*str_StartTime,*str_EndTime,*str_Address,*str_Notes;
	
	IBOutlet UITextField *txt_EventTitle,*txt_Address,*txt_City,*txt_State,*txt_ZipCode,*txt_Country;
	IBOutlet UILabel *txt_Start,*txt_End;
	IBOutlet UITextField *tv_Notes;
	IBOutlet UIButton *btn_Continue;
	
	//For BusinessView
	IBOutlet UIView *businessView;
	IBOutlet UITextField *txt_CompanyName,*txt_Name,*txt_JobTitle,*txt_Email,*txt_Phone,*txt_Add,*txt_City_BusinessCard,*txt_State_BusinessCard,*txt_ZipCode_BusinessCard,*txt_Country_BusinessCard;
	IBOutlet UIImageView *ivBarcode_BusinessCard,*ivAddressBackGround_BusinessCard;
	IBOutlet UIButton *btn_Continue_BarcodeView;
	IBOutlet UIScrollView *scrl_BusinessCard;
	NSString *strAddressTOpassLibrary_BusinessCard;
	//For InvitationView
	IBOutlet UIView *invitationView;
	IBOutlet UITextField *txt_Title_Invitation,*txt_Add_Invitation,*txt_City_Invitation,*txt_State_Invitation,*txt_ZipCode_Invitation,*txt_Country_Invitation;
	IBOutlet UIImageView *ivBarcode_Invitation,*ivPhoto_Invitation,*ivAddressBackGround_Invitation;
	IBOutlet UILabel *lbl_Title_Invitation,*lbl_TitleStatic_Invitation,*lbl_AddressStatic_Invitation,*lbl_Address_Invitation;
	IBOutlet UIButton *btn_Barcode_Invitation;
	NSString *strAddressTOpassLibrary_Invitaion;
	//For IDBadgeView
	IBOutlet UIView *idbadgeView;
	IBOutlet UITextField *txt_Company_IDBadge,*txt_Name_IDBadge,*txt_JobTitle_IDBadge;
	BOOL FlagForPhotoFromInvitation;
	IBOutlet UIImageView *ivBarcode_IDBadge,*ivPhoto_IDBadge;
	IBOutlet UILabel *lbl_Company_IDBadge,*lbl_CompanyStatic_IDBadge,*lbl_Name_IDBadge,*lbl_NameStatic_IDBadge,*lbl_JobTitle_IDBadge,*lbl_JobTitleStatic_IDBadge;
	IBOutlet UIButton *btn_ivPhoto_IDBadge;
	
	//For CourseInfoView
	IBOutlet UIView *courseinfoView;
	IBOutlet UITextField *txt_CourseName,*txt_CourseCode,*txt_Professor,*txt_DateTime;
	IBOutlet UIButton *btn_DateTime;
	IBOutlet UIImageView *ivBarcode_CourseInfo;
	IBOutlet UILabel *lbl_CourseName,*lbl_CourseNameStatic,*lbl_CourseCode,*lbl_CourseCodeStatic,*lbl_Professor,*lbl_ProfessorStatic,*lbl_DateTime,*lbl_DateTimeStatic;
	
	//For image ProcessingView
	IBOutlet UIView *imageProcessingView;
	IBOutlet UIImageView *ivMainImage,*ivAlignment,*ivColor,*ivTransparency,*ivGradient;
	IBOutlet UIButton *btn_Create_ImageProcessing;
	IBOutlet UIButton *btn_Right,*btn_Left,*btn_Top,*btn_Bottom,*btn_Black,*btn_White;
	IBOutlet UISlider *slider;
	BOOL flagForBackClick;
	BOOL flagImgPrcsBack;
	NSString *str_flagForAlignmentClick;
	IBOutlet UIButton *btn_ColorPicker,*btn_OpenCamera;
		//For EventCards 
	IBOutlet UILabel *lbl_EventTitleStatic,*lbl_EventTitle,*lbl_Start,*lbl_StartStatic,*lbl_End,*lbl_EndStatic,*lbl_Address,*lbl_AddressStatic,*lbl_NotesStatic,*lbl_Notes;
	IBOutlet UIImageView *barCodeImgView;
	IBOutlet UIImageView *iv_photoLibImg;
	int colorSelected;
	//For Barcode
	NSMutableArray *array_catagory,*arrImg;
	IBOutlet  UIView *barcodeView;
	IBOutlet UITableView *tbl_Barcode;
	int selectedRow;
	IBOutlet UIButton *btn_Barcode_ImageProcessingView;
	NSMutableArray *selectedindexes;
	
	
	// for BusinessCard  ///////14/12/2011 start
	IBOutlet UILabel *lbl_CompanyStatic,*lbl_Company,*lbl_JobTitle,*lbl_JobTitleStatic,*lbl_NameStatic,*lbl_Name,*lbl_EmailStatic,*lbl_Email,*lbl_Phone,*lbl_PhoneStatic,*lbl_AddressStatic_BusinessCard,*lbl_Address_BusinessCard;
	///////14/12/2011 end
	//for idbadge view
	IBOutlet UIImageView *imgInvitation;//jayna1512116.18
	//For preview and share by jayna
	IBOutlet UIView *PreviewShareView;
	UIImageView *imgtemplate;
	IBOutlet UIView *shareKitView;
	IBOutlet UIImageView *imgBGShare;

	//jayna141211
	BOOL firstTime;
	BOOL oncePort;
	UIImage *imageCopy;
	
	IBOutlet UIButton *btnTrash,*btnFacebook,*btnTwitter,*btnEmail;//jayna16121114.44
	
	///FLAGS FOR KEYBOARD APPEAR PROBLEM IN EACH VIEW.
	BOOL FlagEvent,FlagBusinessCard,FlagInvitation,FlagIDBadge,FlagCourseInfo;
	
	UIImageView *ftbimage;
	
	
	//For adding UILongGestures to remove barcode
	IBOutlet UIButton *btn_Barcode_EventView,*btn_Barcode_BusinessView,*btn_Barcode_InvitationView,*btn_Barcode_IDBadgeView,*btn_Barcode_CourseInfo;
	UILongPressGestureRecognizer *longpressGestureEvent,*longpressGestureBusiness,*longpressGestureInvitation,*longpressGestureIDBadge,*longpressGestureCourseInfo;
	
	
	// For image processing view change color of image
	IBOutlet UIView *colorView;
	UITextField *activetxt;
	UITextView *activetxtview;
	
	//IBOutlet UITextView *tv_EventView;
	IBOutlet OHAttributedLabel *tv_EventView;
	NSMutableAttributedString* attrStr1,*attrStr_Business,*attrStr_Invitation,*attrStr_IDBadge,*attrStr_CourseInfo;
	DatePickerCourseInfo *obj_DatePickerCourseInfo;
	////kerin marketin//////

	
	
	
	//iPhone
	
	NSArray *arrCategory_iPhone;
	IBOutlet UITableView *tbl_allCat;

	NSMutableArray *array_NormalImages;
	NSMutableArray *array_SelectedImages;
	
	

}
@property (nonatomic, retain) NSString *str_TM_SelectedItem,*str_date;
-(void)createPhotoBrowser;
-(void)imageDidLoad:(NSArray *)arguments;
-(IBAction)onClickUDT:(id)sender;
-(IBAction)onClickUCD:(id)sender;
-(IBAction)onEventClick;
-(IBAction)onBusinessCardClick;
-(IBAction)onInvitaitonClick;
-(IBAction)onIDBadgeClick;
-(IBAction)onContactInfoClick;
-(IBAction)onCreateClick;
-(IBAction)onContinueClick;
-(IBAction)onBackClick;
-(IBAction)onContinueClick_BusinessCard;
-(IBAction)onContinueClick_Invitation;
-(IBAction)onContinueClick_IDBadge;
-(IBAction)onContinueClick_CourseInfo;
-(IBAction)onCreateClick_ImageProcessing;
-(IBAction)onAlignmentLeftClick;
-(IBAction)onAlignmentRightClick;
-(IBAction)onAlignmentTopClick;
-(IBAction)onAlignmentBottomClick;
-(IBAction)onFontBlackClick;
-(IBAction)onFontWhiteClick;
-(IBAction)onBarcodeClick_Event;
-(IBAction)onColorPickerClick;
-(IBAction)onOpenCameraClick;
-(IBAction)onOpenCameraClick_UCD;
-(IBAction)onBtnStartClick_Event;
-(IBAction)onBtnEndClick_Event;
-(IBAction)onBtnDateTimeClick_CourseInfo;
-(IBAction)onBarcodeClick_ImageProcessingView;
-(IBAction)onPlusClick;
//Jayna
-(IBAction)buttonFacebooKClicked:(id)sender;
-(IBAction) buttonTwitterClicked:(id)sender;
-(IBAction)emailbtn_click:(id)sender;
- (void) didRotate:(NSNotification *)notification;
-(IBAction)btnTrashClick:(id)sender;
-(void)event3respond;
-(void)tv_NotesBecomeFirst;
/***********/
@end
