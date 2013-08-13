//
//  DAL.h
//  iKontacts
//
//  Created by sparsh on 03/03/10.
//  Copyright 2010 Tatvasoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CG_HaushaltAppDelegate;

@interface DAL : NSObject
{
	
	//NSMutableDictionary *dctResult;
 
}


+(NSMutableDictionary *)ExecuteDataSet:(NSString *)strQuery;
+(int)ExecuteScalar:(NSString *)strQuery;
+(NSMutableArray *) ExecuteArraySet:(NSString *)strQuery;
+(int)deleteFromTable:(NSString*)strTable WhereField:(NSString*)strField Condition:(NSString*)strCondition;
+ (void) insert_library_CreatedDate:(NSString*)cDate Image:(NSString*)image Category:(NSString	*)cat Description:(NSString	*)des starting_Date:(NSString*)sDate Ending_Date:(NSString*)eDate Address:(NSString*)address Links:(NSString*)links Email:(NSString*)email Locations:(NSString*)location
							Message:(NSString *)message Department:(NSString*)department Job:(NSString *)job Suffix:(NSString *)suffix MiddleName:(NSString *)middlename LastName:(NSString *)lastname FirstName:(NSString *)firstname Prefix:(NSString *)prefix PhoneNo:(NSString *)phoneno Subject:(NSString *)subject Notes:(NSString *)notes;

@end
