//
//  generalcalculations.h
//  KrenMarketing
//
//  Created by Ravi Sethia on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface generalcalculations : NSObject
{
    BOOL flagevent;
}


- (NSString *) dividestring:(NSString *)text:(NSString *)category;

-(BOOL) canbeadded:(NSString *)text:(NSString *)category:(int)focus;
@end
