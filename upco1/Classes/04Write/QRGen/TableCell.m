//
//  TableCell.m
//  FontView
//
//  Created by Amitesh Kumar on 12/5/11.
//  Copyright 2011 Silver Touch Technologies Ltd. All rights reserved.
//

#import "TableCell.h"


@implementation TableCell

@synthesize cellLabel, cellBtn1, cellBtn2, cellBtn3, cellBtn4, cellBtn5;
@synthesize titleImgView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
