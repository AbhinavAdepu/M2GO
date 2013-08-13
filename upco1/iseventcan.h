//
//  iseventcan.h
//  KrenMarketing
//
//  Created by Ravi Sethia on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iseventcan : NSObject
{

    BOOL flageven;
    
}
-(BOOL)eventsupported;
-(BOOL)caneventadded:(NSString *) str;
-(void)addeventtoevents:(NSString *)evntname:(NSString *)strtdate:(NSString *)enddate:(NSString *)notes;

@end
