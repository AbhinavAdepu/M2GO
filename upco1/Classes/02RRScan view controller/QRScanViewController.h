//
//  QRScanViewController.h
//  KrenMarketing
//
//  Created by Silvertouch on 14/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderViewController.h"
#import "ZBarReaderView.h"

@class KrenMarketingViewController;

@interface QRScanViewController : UIViewController {
	BOOL found, paused, continuous;
	ZBarReaderViewController *reader;
	IBOutlet UIButton *btnScan,*btnPhotoAlbum,*btnBack,*btnCamera;
	UIImageView *imagecamera;
	KrenMarketingAppDelegate *appDel;
	CGFloat zoom;
	UIView *overlay;
	 UIBarButtonItem *manualBtn;
	UILabel *typeLabel, *dataLabel;
	UILabel *typeOvl, *dataOvl;
    NSArray *masks;
	 NSInteger dataHeight;
	KrenMarketingViewController *kmkt;


}
-(void)setFrameOrientation_Portrait;
-(void)setFrameOrientation_LandScap;


@end
