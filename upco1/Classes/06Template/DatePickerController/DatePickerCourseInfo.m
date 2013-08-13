//
//  DatePickerCourseInfo.m
//  KrenMarketing
//
//  Created by Deval Chauhan on 1/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DatePickerCourseInfo.h"


@implementation DatePickerCourseInfo
@synthesize delegateCourseInfo;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
- (CGSize)contentSizeForViewInPopoverView {
	
    return CGSizeMake(372, 408);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	UIBarButtonItem* done=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneClicked:)];
	self.navigationItem.rightBarButtonItem=done;
	
	UIBarButtonItem* cancel=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked:)];
	self.navigationItem.leftBarButtonItem=cancel;
	
	array_Hour = [[NSMutableArray alloc] init];
	array_Minute = [[NSMutableArray alloc] init];
	for (int i =1; i<13; i++) {
		NSString *str;
	
		  str = [NSString stringWithFormat:@"%i",i];
		
		[array_Hour addObject:str];
	}
	for (int j =0; j<61; j++) {
		NSString *str1;
		if (j>=0&&j<10) {
			str1 = [NSString stringWithFormat:@"0%i",j];
		}
		else {
			str1 = [NSString stringWithFormat:@"%i",j];
		}
		[array_Minute addObject:str1];
	}
	array_AmPm = [[NSMutableArray alloc] init];
	[array_AmPm addObject:@"AM"];
	[array_AmPm addObject:@"PM"];
	NSDate *currentDate = [NSDate date];
	NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
	//[df setDateFormat:@"HH:mm aaa"];
	[df setDateFormat:@"hh:mm a"];
	
	NSString *str = [[df stringFromDate:currentDate] lowercaseString];
	if(![self userSetTwelveHourMode])
	{
		NSString* tmp= [self time24FromDate:currentDate withTimeZone:[NSTimeZone defaultTimeZone]];
		str= [[self time12FromTime24:tmp] lowercaseString];
		
	}
	
	NSArray *ary = [str componentsSeparatedByString:@":"];
	NSString *Hour = [ary objectAtIndex:0];
	//int hour = [Hour intValue];
	int hour = [Hour intValue];

	
	//int hour = [Hour intValue];
	NSString *tempStr = [ary objectAtIndex:1];
	NSArray *ary1 = [tempStr componentsSeparatedByString:@" "]; 
	int minute = [[ary1 objectAtIndex:0] intValue];
 	//NSLog(@"Hour %@ Min %@ And --%@",Hour,[ary1 objectAtIndex:0],[ary1 objectAtIndex:1]);
	
	if (hour>12) {
		hour=hour-12;
	}
	str_Hour = [[NSString stringWithFormat:@"%i:",hour] retain];
	str_Minute = [[ary1 objectAtIndex:0] retain];
	//if([ary1 count] < 0)
	//{
		if([[ary1 objectAtIndex:1] isEqualToString:@"am"])
			str_AmPm=@"AM";
		else if([[ary1 objectAtIndex:1] isEqualToString:@"pm"])
			str_AmPm=@"PM";
	//}
	//else 
//	{
//		if([[ary1 objectAtIndex:0] isEqualToString:@"am"])
//		{
//			str_AmPm=@"AM";
//		}
//		else if([[ary1 objectAtIndex:0] isEqualToString:@"pm"])
//		{
//			str_AmPm=@"PM";
//		}
//	}
	appDel.strHr = hour;
	appDel.strMin = minute;
	appDel.strampm = str_AmPm;
	if ([appDel.strStartTime isEqualToString:@""]) {
		[picker selectRow:hour-1 inComponent:0 animated:NO];
		[picker selectRow:minute inComponent:1 animated:NO];
		
			if ([[ary1 objectAtIndex:1] isEqualToString:@"pm"]) 
			{
				[picker selectRow:1 inComponent:2 animated:NO];
			}
			else 
			{
				[picker selectRow:0 inComponent:2 animated:NO];
			}
		
	}
	else 
	{
		NSLog(@"%@",appDel.strStartTime);
		NSArray *aryS = [appDel.strStartTime componentsSeparatedByString:@":"];
		int hourS = [[aryS objectAtIndex:0] intValue];
		NSString *tempAmpm = [[aryS objectAtIndex:1] retain];
		NSString *strAmpm = [[tempAmpm substringFromIndex:[tempAmpm length]-2] retain];
		int minS = [[[tempAmpm substringWithRange:NSMakeRange(0, 2)] retain] intValue];
		NSLog(@"%i, amam %@",minS,strAmpm);
		[picker selectRow:hourS-1 inComponent:0 animated:NO];
		[picker selectRow:minS inComponent:1 animated:NO];
		if ([[ary1 objectAtIndex:1] isEqualToString:@"PM"]) {
			[picker selectRow:1 inComponent:2 animated:NO];
		}
		else {
			[picker selectRow:0 inComponent:2 animated:NO];
		}
		
	}
	
	[tbl_Datepicker selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:NO scrollPosition:0];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		nvBar.hidden = TRUE;
	}
	else
	{
		nvBar.hidden = FALSE;
		tbl_Datepicker.frame = CGRectMake(0, 45, 372, 193);
		picker.frame = CGRectMake(0, 245, 372, 300);
		
		//UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		btnDone.frame = CGRectMake(10, 7, 50, 30);
//		[btnDone setTitle:@"Done" forState:UIControlStateNormal];
//		[btnDone addTarget:self action:@selector(DoneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//		[self.view addSubview:btnDone];
		
	}

}

-(NSString *)time24FromDate:(NSDate *)date withTimeZone:(NSTimeZone *)timeZone
{
	NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm"];
	[dateFormatter setTimeZone:timeZone];
	NSString* time = [dateFormatter stringFromDate:date];
	[dateFormatter release];
	
	if (time.length > 5) {
		NSRange range;
		range.location = 3;
		range.length = 2;
		int hour = [[time substringToIndex:2] intValue];
		NSString *minute = [time substringWithRange:range];
		range = [time rangeOfString:@"AM"];
		if (range.length==0)
			hour += 12;
		time = [NSString stringWithFormat:@"%02d:%@", hour, minute];
	}
	
	return time;
}

-(NSString *)time12FromTime24:(NSString *)time24String
{
	NSDateFormatter *testFormatter = [[NSDateFormatter alloc] init];
	int hour = [[time24String substringToIndex:2] intValue];
	int minute = [[time24String substringFromIndex:3] intValue];
	
	if(hour==0)
		hour=12;
//	if(hour>12)
//		hour=hour-12;
	
	NSString *result = [NSString stringWithFormat:@"%02d:%02d %@", hour , minute, hour > 12 ? [testFormatter PMSymbol] : [testFormatter AMSymbol]];
	[testFormatter release];
	return result;
}

-(BOOL)userSetTwelveHourMode
{
	NSDateFormatter *testFormatter = [[NSDateFormatter alloc] init];
	[testFormatter setTimeStyle:NSDateFormatterShortStyle];
	NSString *testTime = [testFormatter stringFromDate:[NSDate date]];
	[testFormatter release];
	return [testTime hasSuffix:@"M"] || [testTime hasSuffix:@"m"];
}


-(IBAction)DoneBtnClicked
{
	[self dismissModalViewControllerAnimated:TRUE];
}
-(void) doneClicked:(id) sender
{
	days=@"";
	if (appDel.mon==TRUE) {
		days = [days stringByAppendingString:@"Mon"];
		if(appDel.tue==TRUE)
		{
			days = [days stringByAppendingString:@",Tue"];
		}
		if(appDel.wed==TRUE)
		{
			days = [days stringByAppendingString:@",Wed"];
		}
		if(appDel.thu==TRUE)
		{
			days = [days stringByAppendingString:@",Thu"];
		}
		if(appDel.fri==TRUE)
		{
			days = [days stringByAppendingString:@",Fri"];
		}
		if(appDel.sat==TRUE)
		{
			days = [days stringByAppendingString:@",Sat"];
		}
		if(appDel.sun==TRUE)
		{
			days = [days stringByAppendingString:@",Sun"];
		}
	}
	else if(appDel.tue==TRUE)
	{
		days = [days stringByAppendingString:@"Tue"];
		if(appDel.wed==TRUE)
		{
			days = [days stringByAppendingString:@",Wed"];
		}
		if(appDel.thu==TRUE)
		{
			days = [days stringByAppendingString:@",Thu"];
		}
		if(appDel.fri==TRUE)
		{
			days = [days stringByAppendingString:@",Fri"];
		}
		if(appDel.sat==TRUE)
		{
			days = [days stringByAppendingString:@",Sat"];
		}
		if(appDel.sun==TRUE)
		{
			days = [days stringByAppendingString:@",Sun"];
		}
	}
	else if(appDel.wed==TRUE)
	{
		days = [days stringByAppendingString:@"Wed"];
		if(appDel.thu==TRUE)
		{
			days = [days stringByAppendingString:@",Thu"];
		}
		if(appDel.fri==TRUE)
		{
			days = [days stringByAppendingString:@",Fri"];
		}
		if(appDel.sat==TRUE)
		{
			days = [days stringByAppendingString:@",Sat"];
		}
		if(appDel.sun==TRUE)
		{
			days = [days stringByAppendingString:@",Sun"];
		}
	}
	else if(appDel.thu==TRUE)
	{
		days = [days stringByAppendingString:@"Thu"];
		if(appDel.fri==TRUE)
		{
			days = [days stringByAppendingString:@",Fri"];
		}
		if(appDel.sat==TRUE)
		{
			days = [days stringByAppendingString:@",Sat"];
		}
		if(appDel.sun==TRUE)
		{
			days = [days stringByAppendingString:@",Sun"];
		}
	}
	else if(appDel.fri==TRUE)
	{
		days = [days stringByAppendingString:@"Fri"];
		if(appDel.sat==TRUE)
		{
			days = [days stringByAppendingString:@",Sat"];
		}
		if(appDel.sun==TRUE)
		{
			days = [days stringByAppendingString:@",Sun"];
		}
	}
	else if(appDel.sat==TRUE)
	{
		days = [days stringByAppendingString:@"Sat"];
		if(appDel.sun==TRUE)
		{
			days = [days stringByAppendingString:@",Sun"];
		}
	}
	else if(appDel.sun==TRUE)
	{
		days = [days stringByAppendingString:@"Sun"];
	}
	if ([lbl_EndTime.text isEqualToString:@""]) {
		appDel.str_date = [NSString stringWithFormat:@"%@  %@",days, lbl_StartTime.text];
	}
	else {
		 appDel.str_date = [NSString stringWithFormat:@"%@  %@-%@",days, lbl_StartTime.text,lbl_EndTime.text];
	}

	//Jayna030212
	if([lbl_EndTime.text length] == 0)
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter End time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	}
	/*else {
		appDel.strStartTime = lbl_StartTime.text;
		appDel.strEndTime = lbl_EndTime.text;
		[delegateCourseInfo dismissdatePopOver];
	}*/
	else {
		NSString *str1 = lbl_StartTime.text;
		NSArray *ary1 = [str1 componentsSeparatedByString:@":"];
		int h1 = [[ary1 objectAtIndex:0] intValue];
		NSString *tm1 = [ary1 objectAtIndex:1];
		NSString *a1 = [tm1  substringFromIndex:[tm1 length]-2];
		NSString *mi1 = [tm1  substringWithRange:NSMakeRange(0,2)];
		int m1 = [mi1 intValue];
		NSLog(@"Start hour : %i minute : %i ampam : %@",h1,m1,a1);

		NSString *str2 = lbl_EndTime.text;
		NSArray *ary2 = [str2 componentsSeparatedByString:@":"];
		int h2 = [[ary2 objectAtIndex:0] intValue];
		NSString *tm2 = [ary2 objectAtIndex:1];
		NSString *a2 = [tm2  substringFromIndex:[tm2 length]-2];
		NSString *mi2 = [tm2  substringWithRange:NSMakeRange(0,2)];
		int m2 = [mi2 intValue];
		NSLog(@"End hour : %i minute : %i ampam : %@",h2,m2,a2);
		
		
		if ([a2 isEqualToString:@"PM"]&&[a1 isEqualToString:@"PM"]||[a2 isEqualToString:@"AM"]&&[a1 isEqualToString:@"AM"]) 
		{
			if(h2 > h1)
			{
				appDel.strStartTime = lbl_StartTime.text;
				appDel.strEndTime = lbl_EndTime.text;
				[delegateCourseInfo dismissdatePopOver];
			}
			else if(h2  == h1)
			{
				if(m2 > m1)
				{
					lbl_EndTime.text = [NSString stringWithFormat:@"%i:%i %@",h2,m2,a2];
					appDel.strStartTime = lbl_StartTime.text;
					appDel.strEndTime = lbl_EndTime.text;
					[delegateCourseInfo dismissdatePopOver];
				}
				else {
					UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"End time should be larger than start time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					[alert show];
					[alert release];
					
				}
				
			}
			else {
				UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"End time should be larger than start time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[alert release];
				
			}
		}
		else if ([a2 isEqualToString:@"PM"]&&[a1 isEqualToString:@"AM"]) 
		{
			appDel.strStartTime = lbl_StartTime.text;
			appDel.strEndTime = lbl_EndTime.text;
			[delegateCourseInfo dismissdatePopOver];
		}
		else {
			UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"End time should be larger than start time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
		}
	}


	

}
-(void) cancelClicked:(id) sender
{
	[delegateCourseInfo dismissdatePopOver];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UILabel *lbl_Start,*lbl_End;
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell=nil;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		if (indexPath.section==0) {
			cell.selectionStyle=UITableViewCellSelectionStyleNone;
			if (indexPath.row==0) {
				cell.textLabel.text = @"Days";
			}
			else {
				btn_Mon    = [UIButton buttonWithType:UIButtonTypeCustom];
				btn_Mon.titleLabel.font = [UIFont boldSystemFontOfSize:15];
				
				
				[btn_Mon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				[btn_Mon setTitle:@"Mon" forState:UIControlStateNormal];
				//[btn_Mon setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
				[btn_Mon setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateSelected];
				[btn_Mon addTarget:self action:@selector(monClicked) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:btn_Mon];
				
				btn_Tue = [UIButton buttonWithType:UIButtonTypeCustom];
				
				[btn_Tue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				[btn_Tue setTitle:@"Tue" forState:UIControlStateNormal];
				//[btn_Tue setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
				[btn_Tue setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateSelected];
				btn_Tue.titleLabel.font = [UIFont boldSystemFontOfSize:15];
				//[btn_Tue setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
				[btn_Tue setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateSelected];
				[btn_Tue addTarget:self action:@selector(tueClicked) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:btn_Tue];
				
				btn_Wed    = [UIButton buttonWithType:UIButtonTypeCustom];
				//	btn_Discount.titleLabel.font              = [UIFont systemFontOfSize:MEDIUM_FONT_SIZE];;
				
				[btn_Wed setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				[btn_Wed setTitle:@"Wed" forState:UIControlStateNormal];
				[btn_Wed addTarget:self action:@selector(wedClicked) forControlEvents:UIControlEventTouchUpInside];
				btn_Wed.titleLabel.font = [UIFont boldSystemFontOfSize:15];
			//	[btn_Wed setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
				[btn_Wed setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateSelected];
				[cell.contentView addSubview:btn_Wed];
				
				btn_Thu    = [UIButton buttonWithType:UIButtonTypeCustom];
				//	btn_Discount.titleLabel.font              = [UIFont systemFontOfSize:MEDIUM_FONT_SIZE];;
				
				[btn_Thu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				[btn_Thu setTitle:@"Thu" forState:UIControlStateNormal];
				btn_Thu.titleLabel.font = [UIFont boldSystemFontOfSize:15];
			//	[btn_Thu setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
				[btn_Thu setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateSelected];
				[btn_Thu addTarget:self action:@selector(thuClicked) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:btn_Thu];
				
				btn_Fri    = [UIButton buttonWithType:UIButtonTypeCustom];
				//	btn_Discount.titleLabel.font              = [UIFont systemFontOfSize:MEDIUM_FONT_SIZE];;
				
				[btn_Fri setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				[btn_Fri setTitle:@"Fri" forState:UIControlStateNormal];
				btn_Fri.titleLabel.font = [UIFont boldSystemFontOfSize:15];
				//[btn_Fri setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
				[btn_Fri setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateSelected];
				[btn_Fri addTarget:self action:@selector(friClicked) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:btn_Fri];
				
				btn_Sat    = [UIButton buttonWithType:UIButtonTypeCustom];
				//	btn_Discount.titleLabel.font              = [UIFont systemFontOfSize:MEDIUM_FONT_SIZE];;
				
				[btn_Sat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				[btn_Sat setTitle:@"Sat" forState:UIControlStateNormal];
				btn_Sat.titleLabel.font = [UIFont boldSystemFontOfSize:15];
				//[btn_Sat setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
				[btn_Sat setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateSelected];
				[btn_Sat addTarget:self action:@selector(satClicked) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:btn_Sat];
				
				btn_Sun    = [UIButton buttonWithType:UIButtonTypeCustom];
				//	btn_Discount.titleLabel.font              = [UIFont systemFontOfSize:MEDIUM_FONT_SIZE];;
				
				[btn_Sun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				[btn_Sun setTitle:@"Sun" forState:UIControlStateNormal];
				btn_Sun.titleLabel.font = [UIFont boldSystemFontOfSize:15];
			//	[btn_Sun setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
				[btn_Sun setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateSelected];
				[btn_Sun addTarget:self action:@selector(sunClicked) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:btn_Sun];
				
				if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
				{
                   // [UIApplication sharedApplication] statusBarOrientation];
                    
                    if(appDel.ori==UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
                    {                    
                        
                        btn_Mon.frame=CGRectMake(5, 3, 35, 30);
                        btn_Tue.frame=CGRectMake(42, 3, 35, 30);
                        btn_Wed.frame=CGRectMake(79, 3, 35, 30);
                        btn_Thu.frame=CGRectMake(116, 3, 35, 30);
                        btn_Fri.frame=CGRectMake(153, 3, 35, 30);
                        btn_Sat.frame=CGRectMake(190, 3, 35, 30);
                        btn_Sun.frame=CGRectMake(227, 3, 35, 30);

                    }
                    else
                    {
                        btn_Mon.frame=CGRectMake(5, 3, 42, 30);
                        btn_Tue.frame=CGRectMake(50, 3, 42, 30);
                        btn_Wed.frame=CGRectMake(95, 3, 42, 30);
                        btn_Thu.frame=CGRectMake(140, 3, 42, 30);
                        btn_Fri.frame=CGRectMake(185, 3, 42, 30);
                        btn_Sat.frame=CGRectMake(230, 3, 42, 30);
                        btn_Sun.frame=CGRectMake(275, 3, 42, 30);
                        
                    }
                    
                    
                 /*   if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
                    {
                        // code for landscape orientation   
                        
                      
                        
                        
                    }
                    else 
                    {
                        // code for Portrait orientation  
                     
                        
                    }*/
                    
                    
                    
                    
               				}
				else {
					btn_Mon.frame=CGRectMake(10, 3, 35, 30);
					btn_Tue.frame=CGRectMake(50, 3, 35, 30);
					btn_Wed.frame=CGRectMake(90, 3, 35, 30);
					btn_Thu.frame=CGRectMake(130, 3, 35, 30);
					btn_Fri.frame=CGRectMake(170, 3, 35, 30);
					btn_Sat.frame=CGRectMake(210, 3, 35, 30);
					btn_Sun.frame=CGRectMake(250, 3, 35, 30);
				}

			}
			
		}
		else {
			if (indexPath.row==0) {
				lbl_Start = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 50, 18)];
				lbl_Start.textColor = [UIColor blackColor];
				lbl_Start.text = @"Starts";
				lbl_Start.font = [UIFont boldSystemFontOfSize:16];
				lbl_Start.backgroundColor = [UIColor clearColor];
				[cell.contentView addSubview:lbl_Start];
				
				lbl_StartTime = [[UILabel alloc]initWithFrame:CGRectMake(100, 8, 100, 18)];
				lbl_StartTime.textColor = [UIColor blackColor];
				if ([appDel.strStartTime isEqualToString:@""]) {
					lbl_StartTime.text = [NSString stringWithFormat:@"%@%@ %@",str_Hour,str_Minute,str_AmPm];
				}
				else {
					lbl_StartTime.text = appDel.strStartTime;
				}
				lbl_StartTime.font = [UIFont fontWithName:@"Helvetica" size:16];
				lbl_StartTime.backgroundColor = [UIColor clearColor];
				[cell.contentView addSubview:lbl_StartTime];
			}
			else {
				lbl_End = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 50, 18)];
				lbl_End.textColor = [UIColor blackColor];
				lbl_End.text = @"Ends";
				lbl_End.font = [UIFont boldSystemFontOfSize:16];
				lbl_End.backgroundColor = [UIColor clearColor];
				[cell.contentView addSubview:lbl_End];
				
				lbl_EndTime = [[UILabel alloc]initWithFrame:CGRectMake(100, 8, 100, 18)];
				lbl_EndTime.textColor = [UIColor blackColor];
				if ([appDel.strEndTime isEqualToString:@""]) {
					lbl_EndTime.text = @"";
				}
				else {
					lbl_EndTime.text = appDel.strEndTime;
				}

				lbl_EndTime.font = [UIFont fontWithName:@"Helvetica" size:16];
				lbl_EndTime.backgroundColor = [UIColor clearColor];
				[cell.contentView addSubview:lbl_EndTime];
				
				if (appDel.mon==TRUE) {
					btn_Mon.selected=TRUE;
				}
				else {
					btn_Mon.selected=FALSE;
				}
				if (appDel.tue==TRUE) {
					btn_Tue.selected=TRUE;
				}
				else {
					btn_Tue.selected=FALSE;
				}
				if (appDel.wed==TRUE) {
					btn_Wed.selected=TRUE;
				}
				else {
					btn_Wed.selected=FALSE;
				}
				if (appDel.thu==TRUE) {
					btn_Thu.selected=TRUE;
				}
				else {
					btn_Thu.selected=FALSE;
				}
				if (appDel.fri==TRUE) {
					btn_Fri.selected=TRUE;
				}
				else {
					btn_Fri.selected=FALSE;
				}
				if (appDel.sat==TRUE) {
					btn_Sat.selected=TRUE;
				}
				else {
					btn_Sat.selected=FALSE;
				}
				if (appDel.sun==TRUE) {
					btn_Sun.selected=TRUE;
				}
				else {
					btn_Sun.selected=FALSE;
				}
			}
			
		}
    }
    
	// Configure the cell.
	
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if (indexPath.section==1) {
		if (indexPath.row==0) {
			flagStartEndTime=FALSE;
		}
		else {
			flagStartEndTime=TRUE;
		}

	}
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (component==0) {
		return 12;
	}
	else if (component==1) {
		return 60;
	}
	else {
		return 2; 
	}

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	switch (component) {
			
		case 0:
			return [array_Hour objectAtIndex:row];
			break;
		case 1:
			return [array_Minute objectAtIndex:row];
			break;
		case 2:
			return [array_AmPm objectAtIndex:row];
			break;

		default:
			break;
			
	}
	
	return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	switch (component) {
		case 0:
			str_Hour = [[NSString stringWithFormat:@"%@:",[array_Hour objectAtIndex:row]] retain];
			break;
		case 1:
			str_Minute = [[NSString stringWithFormat:@"%@",[array_Minute objectAtIndex:row]] retain];
			break;
		default:
			str_AmPm = [[NSString stringWithFormat:@"%@",[array_AmPm objectAtIndex:row]] retain];
			break;
	}
	if (flagStartEndTime==FALSE) 
	{
		appDel.strHr = [str_Hour intValue];
		appDel.strMin = [str_Minute intValue];
		appDel.strampm = str_AmPm;
		lbl_StartTime.text = [NSString stringWithFormat:@"%@%@ %@",str_Hour,str_Minute,str_AmPm];
	}
	else
	{
		if([str_AmPm isEqualToString:@"PM"] && [str_Hour intValue] == 12 && [str_Minute intValue] > 0)
		{
			[picker selectRow:0 inComponent:2 animated:NO];
			str_AmPm=@"AM";
		}
		else if([str_AmPm isEqualToString:@"AM"] && [str_Hour intValue] == 12 && [str_Minute intValue] > 0)
		{
			[picker selectRow:1 inComponent:2 animated:NO];
			str_AmPm=@"PM";
		}
		lbl_EndTime.text = [NSString stringWithFormat:@"%@%@ %@",str_Hour,str_Minute,str_AmPm];
	}
}
-(void)monClicked
{
	if (btn_Mon.selected) {
		[btn_Mon setSelected:FALSE];
		appDel.mon=FALSE;
		
	}
	else {
		[btn_Mon setSelected:TRUE];
		appDel.mon=TRUE;
	}

	
}
-(void)tueClicked
{
	if (btn_Tue.selected) {
		[btn_Tue setSelected:FALSE];
		appDel.tue=FALSE;
	}
	else {
		[btn_Tue setSelected:TRUE];
		appDel.tue=TRUE;
	}
}
-(void)wedClicked
{
	if (btn_Wed.selected) {
		[btn_Wed setSelected:FALSE];
		appDel.wed=FALSE;
	}
	else {
		[btn_Wed setSelected:TRUE];
		appDel.wed=TRUE;
	}
}
-(void)thuClicked
{
	if (btn_Thu.selected) {
		[btn_Thu setSelected:FALSE];
		appDel.thu=FALSE;
	}
	else {
		[btn_Thu setSelected:TRUE];
		appDel.thu=TRUE;
	}
}
-(void)friClicked
{
	if (btn_Fri.selected) {
		[btn_Fri setSelected:FALSE];
		appDel.fri=FALSE;
	}
	else {
		[btn_Fri setSelected:TRUE];
		appDel.fri=TRUE;
	}
}
-(void)satClicked
{
	if (btn_Sat.selected) {
		[btn_Sat setSelected:FALSE];
		appDel.sat=FALSE;
	}
	else {
		[btn_Sat setSelected:TRUE];
		appDel.sat=TRUE;
	}
}
-(void)sunClicked
{
	if (btn_Sun.selected) {
		[btn_Sun setSelected:FALSE];
		appDel.sun=FALSE;
	}
	else {
		[btn_Sun setSelected:TRUE];
		appDel.sun=TRUE;
	}
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
