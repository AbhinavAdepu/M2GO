//
//  QuizViewController.h
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMPageControl.h"

@class PerSetViewController;
@interface QuizViewController : UIViewController <UIScrollViewDelegate>{
	
	
	IBOutlet UIView *viewQuizCh;
	IBOutlet UITableView *tblQuizQue;
	KrenMarketingAppDelegate *appDel;
	IBOutlet UIButton *SubmitBtn;
	IBOutlet OMPageControl* pageControl;
	IBOutlet OMPageControl *pageControl_ForQuiz;
	UIScrollView *scrQuizPage_Result;
	BOOL pageControlIsChangingPage;
	int cx,cx1;
	IBOutlet UIView *quizView;
	NSMutableArray *viewControllers;
    int	kNumberOfPages;
	
	
	IBOutlet UIImageView *topImage;
	IBOutlet UIImageView	*mainImage;
	IBOutlet UILabel *topLable,*topLable1;
	IBOutlet UIImageView *whiteLayer;
	IBOutlet UILabel *labelWhite;
	NSMutableArray *btnChapterArr;
	NSMutableArray *selectedindexes;
	int modVal;
	int selectedRow;
	
	IBOutlet UIImageView *tblBGImage;
	PerSetViewController *perSetViewController;
	
	IBOutlet UIView *feedBackView;
	IBOutlet UILabel *lblunanswered,*lblincorrect,*lblcorrect;
	
	IBOutlet UIImageView *topGrayImageView;
	
	IBOutlet UILabel *lblHeading_result;
	int totNOOfRow;
	
	IBOutlet UIImageView *imgFeedBack;
	IBOutlet UIButton *btnViewfeedback;
	
	IBOutlet UIImageView *topRedImage;
	
	BOOL firstTime;
	BOOL oncePort;
	NSMutableArray *arrPersetQue;
	UIViewController *tempvctrl;
	IBOutlet UIButton *btnBackTOchapters;
	BOOL backbtn;
	//int gPageMy;
	//UIButton *button;
	//UIInterfaceOrientation ori;
	
	UIScrollView *scrlForQuiz;
	int selectPage,selectPage1;
	CGRect rect;
	BOOL fromViewFeedBack;
	
	IBOutlet OMPageControl *iphonPageControl;
	IBOutlet UIScrollView *btnScrollView;
	
	
}
-(IBAction)viewFeedbackPressed:(id)sender;
-(IBAction)btnQuizChapterPressed:(id)sender;
-(IBAction)btnSubmitALLPressed:(id)sender;
- (IBAction)changePage:(id)sender;
- (IBAction)changePage_ForQuiz:(id)sender;
-(IBAction)btnBackPressed:(id)sender;
-(BOOL)queColorChange:(int)rowInt;
-(void)setupPage_FeedBackPage;
-(void)setFrameOrientation_Portrait;
-(void)setFrameOrientation_LandScap;
- (void) didRotate:(NSNotification *)notification;
- (IBAction)setupPage;

@property (nonatomic, retain) OMPageControl* pageControl;

@end
