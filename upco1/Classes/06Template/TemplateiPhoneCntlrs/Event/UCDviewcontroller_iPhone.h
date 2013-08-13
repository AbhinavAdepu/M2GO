//
//  UCDviewcontroller_iPhone.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 13/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UCDviewcontroller_iPhone : UIViewController {
	
	IBOutlet UIImageView *imgBgFromPhotoAlbum;
	IBOutlet UIView *viewImgCard;
	NSString *strFlag;
	
	IBOutlet UIButton *btnCreate;
}
@property (nonatomic,retain)NSString *strFlag;
-(IBAction)btnphotoalbumPressed:(id)sender;
-(IBAction)btnCreatePressed:(id)sender;
-(IBAction)btnBackPressed:(id)sender;
-(IBAction)btnHomePressed:(id)sender;
@end
