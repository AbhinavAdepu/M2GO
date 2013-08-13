//
//  Global.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Global : NSObject {

}

+(void)setSelector:(SEL)t_sel;
+(SEL)getSelector;
+(void)setHandler:(UIViewController *)handler;
+(UIViewController *)getHandler;
@end
