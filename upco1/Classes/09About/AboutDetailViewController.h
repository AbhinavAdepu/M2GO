//
//  AboutDetailViewController.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 07/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutDetailViewController : UIViewController
{
	IBOutlet UILabel *lblHeader;
	int selectedindex;
	IBOutlet UIScrollView *scrollImages;
	IBOutlet UIImageView *imgAuthors,*imageViewFullScreen;
	IBOutlet UIButton *btnURLclicked;
	int flag;
	CGFloat lastScale;
	

}
-(IBAction)BackToLibrary;
-(IBAction)btnURLclickedPressed:(id)sender;
@end
