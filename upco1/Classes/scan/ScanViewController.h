//
//  ScanViewController.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 01/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderView.h"
#import "ZBarReaderViewController.h"
#import "ScannedResultViewController.h"

@interface ScanViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZBarReaderDelegate,ZBarReaderViewDelegate>
{
	ZBarReaderViewController *reader;
	IBOutlet UIButton *btnPhotoAlbum;
	IBOutlet UIButton *btnCamera;
	
	IBOutlet ZBarReaderView *readerView;
    UIBarButtonItem *manualBtn;
	CGFloat zoom;
	UIView *overlay;
	NSArray *masks;
	UIImagePickerController *popReader;
	
	ScannedResultViewController *scannedResultViewController;
	
	UIImage *img_QR_Iphone;
	ZBarSymbolSet *GsymData;
	KrenMarketingAppDelegate *appDel;
	int ctr;
	IBOutlet UIActivityIndicatorView *spinner;
}

-(IBAction)PhotoLibrary_Clicked;
-(IBAction)getPhotoAlbum:(id)sender;
-(IBAction)getPhoto:(id)sender;

@end
