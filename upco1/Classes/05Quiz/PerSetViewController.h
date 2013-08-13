//
//  PerSetViewController.h
//  DeansQuestionBank
//
//  Created by Alpesh Harsoda on 31/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewFeedBackoverview_Iphone.h"


@interface PerSetViewController : UIViewController {
	
	IBOutlet UIButton *btn1;
	IBOutlet UIButton *btn2;
	IBOutlet UIButton *btn3;
	IBOutlet UIButton *btn4;
	IBOutlet UIButton *btn5;
	
	IBOutlet UILabel *lblQue,*lblOp1,*lblopt2,*lblopt3,*lblopt4,*lblopt5;
	
	NSDictionary *DictQue_perset;
	
	NSDictionary *dictAns;
	int queNo1;
	IBOutlet UIButton *btnSubmit;
	KrenMarketingAppDelegate *appDel;
	
	IBOutlet UIScrollView *paging_scroll;
	IBOutlet UIScrollView *que_scroll;
 	IBOutlet UIPageControl *pageControl;
	UIView *tempvctrl;
	NSMutableArray *pageHistory;
	CGRect rect;
	NSDictionary *Dict_queset;
	int x_pos;
	IBOutlet UIViewController *QueView;
	
	UILabel *lblQuestion;
	UILabel *lblOption1;
	UILabel *lblOption2;
	UILabel *lblOption3;
	UILabel *lblOption4;
	UILabel *lblOption5;
    
    IBOutlet UILabel *lblQNO_iPhone;
	
	
	
}
-(IBAction)BackToLibrary;
-(IBAction)btnoptSelect:(id)sender;
-(IBAction)btnSubmitClicked:(id)sender;
- (id)initWithPageNumber:(int)page questions:(NSString *)Question queNo:(NSString *)QNo options:(NSArray *)optionForQue correct:(NSString *)correct_ans btn:(UIButton *)btnHandIn;
@end
