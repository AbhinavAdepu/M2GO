//
//  LibraryCell-Landscape.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 30/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryCell-Landscape.h"


@implementation LibraryCell_Landscape

@synthesize lblCategory,lblDescription,qrImage;

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
