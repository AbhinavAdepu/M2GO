//
//  DAL.m
//  iKontacts
//
//  Created by sparsh on 03/03/10.
//  Copyright 2010 Tatvasoft. All rights reserved.
//

#import "DAL.h"
#import "KrenMarketingAppDelegate.h"

#import <sqlite3.h>

#define INSERT_LIBRARY "Insert into library(Notes,Subject,Message,Department,job,Suffix,Middle_Name,Phonetic_LastName,Phonetic_FirstName,Prefix,PhoneNo,Image,CreatedDate,Category,Description,starting_Date,Ending_Date,Address,Links,Email,Locations) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

static int intPrimaryKey;
static sqlite3_stmt *insertStmt;
@implementation DAL

+(NSMutableDictionary *) ExecuteDataSet:(NSString *)strQuery
{
	
	NSMutableDictionary *dctResultDataSet = [[[NSMutableDictionary alloc] initWithCapacity:0] autorelease];


	//	BOOL isSucess = FALSE;
	KrenMarketingAppDelegate *appDelegate = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication] delegate];

	const char *sql = [strQuery UTF8String];
	sqlite3_stmt *selectStatement;

	//prepare the select statement
	int returnValue = sqlite3_prepare_v2(appDelegate.database, sql, -1, &selectStatement, NULL);
	if(returnValue == SQLITE_OK)
	{
		sqlite3_bind_text(selectStatement, 1, sql, -1, SQLITE_TRANSIENT);
		//loop all the rows returned by the query.
		
		NSMutableArray *arrColumnsDataSet = [[[NSMutableArray alloc] initWithCapacity:0] autorelease] ;
       
		int i;
		for (i=0; i<sqlite3_column_count(selectStatement); i++)
		{
			const char *st = sqlite3_column_name(selectStatement, i);
			[arrColumnsDataSet addObject:[NSString stringWithCString:st encoding:NSUTF8StringEncoding]];
		}
		int intRow =1;
		while(sqlite3_step(selectStatement) == SQLITE_ROW)
		{
			NSMutableDictionary *dctRowDataSet = [[[NSMutableDictionary alloc] initWithCapacity:0] autorelease];
            				
			for (i=0; i<sqlite3_column_count(selectStatement); i++)
			{
				int intValue = 0;
				double dblValue =0;
				const char *strValue;
				switch (sqlite3_column_type(selectStatement,i))
				{
					case SQLITE_INTEGER:
						intValue  = (int)sqlite3_column_int(selectStatement, i);
						[dctRowDataSet setObject:[NSString stringWithFormat:@"%d",intValue] forKey:[arrColumnsDataSet objectAtIndex:i]];
						
						break;
					case SQLITE_FLOAT:
						dblValue = (double)sqlite3_column_double(selectStatement, i);
						[dctRowDataSet setObject:[NSString stringWithFormat:@"%f",dblValue] forKey:[arrColumnsDataSet objectAtIndex:i]];
						
						break;
					case SQLITE_TEXT:
						strValue = (const char *)sqlite3_column_text(selectStatement, i);
						[dctRowDataSet setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumnsDataSet objectAtIndex:i]];
						
						break;
					case SQLITE_BLOB:
						strValue = (const char *)sqlite3_column_value(selectStatement, i);
						[dctRowDataSet setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumnsDataSet objectAtIndex:i]];
						
						break;
					case SQLITE_NULL:
						[dctRowDataSet setObject:@"" forKey:[arrColumnsDataSet objectAtIndex:i]];
						
						break;
					default:
						strValue = (const char *)sqlite3_column_value(selectStatement, i);
						[dctRowDataSet setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumnsDataSet objectAtIndex:i]];
						
						break;
				}
				
							}
			[dctResultDataSet setObject:dctRowDataSet forKey:[NSString stringWithFormat:@"Table%d",intRow]];
			
			

			intRow ++;

		}
				
						
	}
	
	return dctResultDataSet;
}


+(int)ExecuteScalar:(NSString *)strQuery
{  
	//NSLog(@"%@",strQuery);
	KrenMarketingAppDelegate *appDelegate = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication] delegate];

	int intResult = -1;
	const char *chrQuery = [strQuery UTF8String];
	sqlite3_stmt *sqlStatement;

	int returnValue = sqlite3_prepare_v2(appDelegate.database, chrQuery, -1, &sqlStatement, NULL);
	//NSLog(@"%d",returnValue);
	if(returnValue == SQLITE_OK)
	{
		returnValue = sqlite3_step(sqlStatement);
		if(returnValue == SQLITE_DONE)
		{
			intResult = 0;
		}
	}
	return intResult;
	
}


+(NSMutableArray *) ExecuteArraySet:(NSString *)strQuery
{
	KrenMarketingAppDelegate *appDelegate = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSMutableArray  *arryResult = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
	//	BOOL isSucess = FALSE;

	const char *sql = [strQuery UTF8String];
	sqlite3_stmt *selectStatement;

	//prepare the select statement
	int returnValue = sqlite3_prepare_v2(appDelegate.database, sql, -1, &selectStatement, NULL);
	if(returnValue == SQLITE_OK)
	{
		sqlite3_bind_text(selectStatement, 1, sql, -1, SQLITE_TRANSIENT);
		//loop all the rows returned by the query.
		NSMutableArray *arrColumns = [[NSMutableArray alloc] initWithCapacity:0];
		int i;
		for (i=0; i<sqlite3_column_count(selectStatement); i++)
		{
			const char *st = sqlite3_column_name(selectStatement, i);
			[arrColumns addObject:[NSString stringWithCString:st encoding:NSUTF8StringEncoding]];
		}
		int intRow =1;
		while(sqlite3_step(selectStatement) == SQLITE_ROW)
		{
			NSMutableDictionary *dctRow = [[[NSMutableDictionary alloc] initWithCapacity:0] autorelease];
			for (i=0; i<sqlite3_column_count(selectStatement); i++)
			{
				int intValue = 0;
				double dblValue =0;
				const char *strValue;
				switch (sqlite3_column_type(selectStatement,i))
				{
					case SQLITE_INTEGER:
						intValue  = (int)sqlite3_column_int(selectStatement, i);
						[dctRow setObject:[NSString stringWithFormat:@"%d",intValue] forKey:[arrColumns objectAtIndex:i]];
						break;
					case SQLITE_FLOAT:
						dblValue = (double)sqlite3_column_double(selectStatement, i);
						[dctRow setObject:[NSString stringWithFormat:@"%f",dblValue] forKey:[arrColumns objectAtIndex:i]];
						break;
					case SQLITE_TEXT:
						strValue = (const char *)sqlite3_column_text(selectStatement, i);
						[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]];
						break;
					case SQLITE_BLOB:
						strValue = (const char *)sqlite3_column_value(selectStatement, i);
						[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]];
						break;
					case SQLITE_NULL:
						[dctRow setObject:@"" forKey:[arrColumns objectAtIndex:i]];
						break;
					default:
						strValue = (const char *)sqlite3_column_value(selectStatement, i);
						[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]];
						break;
				}

			}
			[arryResult addObject:dctRow];
			//	[dctResult setObject:dctRow forKey:[NSString stringWithFormat:@"Table%d",intRow]];
			intRow ++;
		}
	}
	return arryResult;
}


+(int)deleteFromTable:(NSString*)strTable WhereField:(NSString*)strField Condition:(NSString*)strCondition
{
	KrenMarketingAppDelegate *appDelegate = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSString *strQuery = [NSString stringWithFormat:@"delete from %@ where %@ %@",strTable,strField,strCondition];

	int intResult = -1;
	const char *chrQuery = [strQuery UTF8String];
	sqlite3_stmt *sqlStatement;

	int returnValue = sqlite3_prepare_v2(appDelegate.database, chrQuery, -1, &sqlStatement, NULL);
	if(returnValue == SQLITE_OK)
	{
		returnValue = sqlite3_step(sqlStatement);
		if(returnValue == SQLITE_DONE)
		{
			intResult = 0;
		}
	}
	return intResult;
}


+ (void) insert_library_CreatedDate:(NSString*)cDate Image:(NSString*)image Category:(NSString	*)cat Description:(NSString	*)des starting_Date:(NSString*)sDate Ending_Date:(NSString*)eDate Address:(NSString*)address Links:(NSString*)links Email:(NSString*)email Locations:(NSString*)location
							Message:(NSString *)message Department:(NSString*)department Job:(NSString *)job Suffix:(NSString *)suffix MiddleName:(NSString *)middlename LastName:(NSString *)lastname FirstName:(NSString *)firstname Prefix:(NSString *)prefix PhoneNo:(NSString *)phoneno Subject:(NSString *)subject 
Notes:(NSString *)notes
{
    NSLog(@"description to save to DB:%@",des);
	KrenMarketingAppDelegate *appDelegate = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	@try
	{
		sqlite3_exec(appDelegate.database,"BEGIN TRANSACTION", 0, 0, 0);
		//if (sqlite3_open([[self getDBPathStatic] UTF8String], &database) == SQLITE_OK) {
		
		insertStmt=nil;
		if(insertStmt == nil) {
			const char *sql = (const char *) INSERT_LIBRARY;
			if(sqlite3_prepare_v2(appDelegate.database, sql, -1, &insertStmt, NULL) != SQLITE_OK)
			{
				NSAssert1(0, @"Error while creating add statement. '%s' ", sqlite3_errmsg(appDelegate.database));
			}
			
		}
		sqlite3_bind_text(insertStmt, 13, [cDate UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 12, [image UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 14, [cat UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 15, [des UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 16, [sDate UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 17, [eDate UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 18, [address UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 19, [links UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 20, [email UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 21, [location UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 3, [message UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 4, [department UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 5, [job UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 6, [suffix UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 7, [middlename UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 8, [lastname UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 9, [firstname UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 10, [prefix UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 11, [phoneno UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 2, [subject UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt, 1, [notes UTF8String], -1, SQLITE_TRANSIENT);
		
		//}
		
		if(SQLITE_DONE != sqlite3_step(insertStmt))
		{
			NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(appDelegate.database));
		}
		else
		{
			intPrimaryKey = sqlite3_last_insert_rowid(appDelegate.database);
		}
		sqlite3_finalize(insertStmt);
		//sqlite3_close(database);
		sqlite3_exec(appDelegate.database, "COMMIT TRANSACTION", 0 ,0 ,0);
		
	}
	@catch (NSException *e) {
		NSLog(@"\n Exception :%@ %@",[e name],[e reason]);
	}
	
	
}


@end
