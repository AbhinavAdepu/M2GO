//
//  iseventcan.m
//  KrenMarketing
//
//  Created by Ravi Sethia on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "iseventcan.h"

@implementation iseventcan


-(BOOL)eventsupported
{
    flageven=YES;
    
       int seconds_in_year = 60*60*24*365;
    NSDate *dat1=[[NSDate alloc]init];
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSDate *start = [dat1 dateByAddingTimeInterval:-seconds_in_year];
    NSDate *finish = [dat1 dateByAddingTimeInterval:seconds_in_year];
    
    
    // use Dictionary for remove duplicates produced by events covered more one year segment
    NSMutableDictionary *eventsDict = [NSMutableDictionary dictionaryWithCapacity:1024];
    
    NSDate* currentStart = [NSDate dateWithTimeInterval:0 sinceDate:start];
    
    
    
    // enumerate events by one year segment because iOS do not support predicate longer than 4 year !
    while ([currentStart compare:finish] == NSOrderedAscending) {
        
        NSDate* currentFinish = [NSDate dateWithTimeInterval:seconds_in_year sinceDate:currentStart];
        
        if ([currentFinish compare:finish] == NSOrderedDescending) {
            currentFinish = [NSDate dateWithTimeInterval:0 sinceDate:finish];
        }
        NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:currentStart endDate:currentFinish calendars:nil];
        [eventStore enumerateEventsMatchingPredicate:predicate
                                          usingBlock:^(EKEvent *event, BOOL *stop) {
                                              
                                              if (event) {
                                                  
                                                  if(event.eventIdentifier != nil)
                                                  {
                                                      flageven=YES;
                                                      [eventsDict setObject:event forKey:event.eventIdentifier];
                                                  }
                                                  else {
                                                     
                                                      flageven=NO;
                                                       
                                                      
                                                  }
                                              }
                                              
                                          }];       
 /*       currentStart = [NSDate dateWithTimeInterval:(seconds_in_year + 1) sinceDate:currentStart];
        
    }
    
    NSArray *events = [eventsDict allKeys];
    
    
    for(int i=0;i<[events count];i++)
    {
        EKEvent *evn=[eventsDict objectForKey:[events objectAtIndex:i]];
        NSLog(@"title of event:%@",evn.title);*/
    }
    return flageven;  
}

-(BOOL)caneventadded:(NSString *) str
{
    
    __block BOOL canadded=NO;
    int seconds_in_year = 60*60*24*365;
    NSDate *dat1=[[NSDate alloc]init];
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSDate *start = [dat1 dateByAddingTimeInterval:-seconds_in_year];
    NSDate *finish = [dat1 dateByAddingTimeInterval:seconds_in_year];
    
    
    // use Dictionary for remove duplicates produced by events covered more one year segment
    NSMutableDictionary *eventsDict = [NSMutableDictionary dictionaryWithCapacity:1024];
    
    NSDate* currentStart = [NSDate dateWithTimeInterval:0 sinceDate:start];
    
    
    
    // enumerate events by one year segment because iOS do not support predicate longer than 4 year !
    while ([currentStart compare:finish] == NSOrderedAscending) {
        
        NSDate* currentFinish = [NSDate dateWithTimeInterval:seconds_in_year sinceDate:currentStart];
        
        if ([currentFinish compare:finish] == NSOrderedDescending) {
            currentFinish = [NSDate dateWithTimeInterval:0 sinceDate:finish];
        }
        NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:currentStart endDate:currentFinish calendars:nil];
        [eventStore enumerateEventsMatchingPredicate:predicate
                                          usingBlock:^(EKEvent *event, BOOL *stop) {
                                              
                                              if (event) {
                                                  
                                                  if(event.eventIdentifier != nil)
                                                      [eventsDict setObject:event forKey:event.eventIdentifier];
                                                  else {
                                                      NSLog(@"no event dictonary");
                                                  }
                                              }
                                              
                                          }];       
        currentStart = [NSDate dateWithTimeInterval:(seconds_in_year + 1) sinceDate:currentStart];
        
    }
    
    NSArray *events = [eventsDict allKeys];
    
    
    for(int i=0;i<[events count];i++)
    {
        EKEvent *evn=[eventsDict objectForKey:[events objectAtIndex:i]];
       // NSLog(@"title of event:%@",evn.title);
        if([evn.title length]!= 0)
        {
            str=[str stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

            if([evn.title compare:str])
            {
                canadded=YES;
            }
        }
        
    }
    NSLog(@"is events:"); 
    NSLog(canadded ? @"Yes" : @"No");

    return canadded;
}

-(void)addeventtoevents:(NSString *)evntname:(NSString *)strtdate:(NSString *)enddate:(NSString *)notes
{
EKEventStore *eventStore = [[EKEventStore alloc] init];

EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
      evntname=[evntname stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    event.title=evntname;

NSString *stdate=strtdate;

stdate=[stdate substringFromIndex:4];

NSString *endate=enddate;

endate=[endate substringFromIndex:4];

NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
formatter.dateFormat = @"M/d/y h:mm a";

NSDate *date = [formatter dateFromString:stdate];

NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
formatter1.dateFormat = @"M/d/y h:mm a";

NSDate *date1 = [formatter dateFromString:endate];
event.startDate = date;
event.endDate = date1;

//   NSLog(@"final string:%@",tmpst);
// event.notes=notes;




//NSLog(@"start date is %@,end date is %@",startdate,enddate);






//[event setAlarms:[NSArray arrayWithObjects:@"At time of event",nil]];


[event setCalendar:[eventStore defaultCalendarForNewEvents]];
NSError *err;

[eventStore saveEvent:event span:EKSpanThisEvent error:&err]; 
if(!err)
{
    
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:event.title message:@"Event Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertview show];
    [alertview release];
    
}
else {
    NSLog(@"error is %@",err);  
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:event.title message:@"Failed adding event to Calender" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertview show];
    [alertview release];
}



}

@end
