//
//  LibraryCell.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LibraryCell : UITableViewCell 
{
	IBOutlet UILabel *lblCat;
	IBOutlet UILabel *lblDes;
	IBOutlet UIImageView *qrImage;

}

@property (nonatomic,retain) IBOutlet UILabel *lblCat;
@property (nonatomic,retain) IBOutlet UILabel *lblDes;
@property (nonatomic,retain) IBOutlet UIImageView *qrImage;
@end
