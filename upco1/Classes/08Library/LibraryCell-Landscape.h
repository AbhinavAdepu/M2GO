//
//  LibraryCell-Landscape.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 30/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LibraryCell_Landscape : UITableViewCell
{
	IBOutlet UILabel *lblCategory;
	
	IBOutlet UILabel *lblDescription;
	IBOutlet UIImageView *qrImage;

}

@property (nonatomic,retain) IBOutlet UILabel *lblCategory;
@property (nonatomic,retain) IBOutlet UILabel *lblDescription;
@property (nonatomic,retain) IBOutlet UIImageView *qrImage;

@end
