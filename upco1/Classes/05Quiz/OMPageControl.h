//
//  OMPageControl.h
//  BootenKoop
//
//  Created by Paras Gandhi on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMPageControl : UIPageControl {
	UIImage* mImageNormal;
	UIImage* mImageCurrent;
}

@property (nonatomic, readwrite, retain) UIImage* imageNormal;
@property (nonatomic, readwrite, retain) UIImage* imageCurrent;



@end
