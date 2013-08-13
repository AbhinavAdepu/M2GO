//
//  ImageProcessingView_iPhone.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 05/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"

 
@interface ImageProcessingView_iPhone : UIViewController {
	
	IBOutlet UIView *view_Alignment;
	IBOutlet UIView *view_color;
	IBOutlet UIView *view_background;
	IBOutlet UIScrollView *scrl_imageProcessing;
	
	IBOutlet OHAttributedLabel *lblEventTitle;

	IBOutlet UILabel *lblNotes;
	IBOutlet OHAttributedLabel *lblstreetAdress;
	IBOutlet UILabel *lblcity;
	IBOutlet UILabel *lblState;
	IBOutlet UILabel *lblZip;
	IBOutlet UILabel *lblcountry;
	
	IBOutlet UIButton *btnBackground;
	
	
	NSString *EventTitle;
	NSString *StDate;
	NSString *EnDate;
	NSString *Notes;
	NSString *streetAdress;
	NSString *city;
	NSString *State;
	NSString *Zip;
	NSString *country;
	NSString *phoneNo;
	
	IBOutlet UIView *view_Alignmentalign;
	IBOutlet UIButton *btnQRCode;
	IBOutlet UIButton *btnimage_PicLib;
	
	UIImage *image_Card;
	UIImage *image_photoLib;
	IBOutlet UIImageView *imgView_card;
	
	IBOutlet UISlider *sliderTransperancy;
	IBOutlet UIView *viewImgCard;
	
	int btnIndex;

	IBOutlet UIImageView *imgBgFromPhotoAlbum;
	
	IBOutlet UIImageView *imgAlignmentView;
	
	NSString *strFlag;
	NSString *str_TM_SelectedItem;
	
	int alignFlag;
	
	IBOutlet UIButton *btnLeft;
	IBOutlet UIButton *btnRight;
	IBOutlet UIButton *btnTop;
	IBOutlet UIButton *btnBottom;
	
	IBOutlet UIButton *btnblackpatch;
	IBOutlet UIButton *btnwhitepatch;

	
	
	IBOutlet UIImageView *imgBG_Lowersec;
	
	
	//variables for save in library
	NSString *EventTitleLib;
	NSString *StDateLib;
	NSString *EnDateLib;
	NSString *NotesLib;
	NSString *streetAdressLib;
	NSString *cityLib;
	NSString *StateLib;
	NSString *ZipLib;
	NSString *countryLib;
	NSString *phoneNoLib; 
	
	KrenMarketingAppDelegate *appDel;
}
-(IBAction)btnAlignmentPressed:(id)sender;
-(IBAction)btnColorPressed:(id)sender;
-(IBAction)btnbackPressed:(id)sender;
-(IBAction)btnCreatePressed:(id)sender;

-(IBAction)btnBackgroundPressed:(id)sender;

-(IBAction)btnTopPressed:(id)sender;
-(IBAction)btnBottomPressed:(id)sender;
-(IBAction)btnLeftPressed:(id)sender;
-(IBAction)btnRightPressed:(id)sender;

-(IBAction)btnBlackColorPressed:(id)sender;
-(IBAction)btnWhiteColorPressed:(id)sender;

-(IBAction)sliderValueChanged:(id)sender;
-(IBAction)btnAddPressed:(id)sender;


-(IBAction)btnChangeBackgroundPressed:(id)sender;
-(IBAction)btnphotoalbumPressed:(id)sender;
@property (nonatomic,retain)NSString *phoneNo;
@property (nonatomic,retain)NSString *EventTitle;
@property (nonatomic,retain)NSString *StDate;
@property (nonatomic,retain)NSString *EnDate;
@property (nonatomic,retain)NSString *Notes;
@property (nonatomic,retain)NSString *streetAdress;
@property (nonatomic,retain)NSString *city;
@property (nonatomic,retain)NSString *State;
@property (nonatomic,retain)NSString *Zip;
@property (nonatomic,retain)NSString *country;
@property (nonatomic,retain)UIImage *image_Card;
@property (nonatomic,retain)NSString *strFlag;
@property (nonatomic,readwrite)int btnIndex;
@property (nonatomic,readwrite)UIImage *image_photoLib;

@end
