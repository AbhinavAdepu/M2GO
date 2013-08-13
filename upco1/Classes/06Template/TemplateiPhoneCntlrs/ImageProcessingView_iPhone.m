//
//  ImageProcessingView_iPhone.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 05/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageProcessingView_iPhone.h"
#import "PreviewShareView_iPhone.h"
#import "ColorSelection_iPhone.h"
#import "DAL.h"

@implementation ImageProcessingView_iPhone
@synthesize EventTitle,StDate,EnDate,Notes,streetAdress,city,State,Zip,country,image_Card,btnIndex,phoneNo,strFlag,image_photoLib;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	

	alignFlag = 1;
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	if(btnIndex == 7)
	{
		btnBackground.hidden = NO;
		
	}
	else {
		imgAlignmentView.image = [UIImage imageNamed:@"alignselwobg.png"];
	}

	str_TM_SelectedItem = [[NSString alloc]init];
	scrl_imageProcessing.contentSize = CGSizeMake(320, 700);
	UIImage *stetchLeftTrack = [[UIImage imageNamed:@"slidermin.png"]
								stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
	[sliderTransperancy setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
	

	
	
	if(appDel.indexForTemplate == 0)
	{
		//if(EventTitle)
		/*if (stringRange.length > [myString length])
		 ? ? // throw exception, ignore error, or set shortString to myString
		 else 
		 ? ? shortString = [myString substringWithRange:stringRange];*/
	
        
		NSMutableString *fullStr = [[NSMutableString alloc]initWithFormat:@"%@",appDel.aEventTitle];
        
       
        
        
		if([fullStr isEqualToString:@"(null)\n\n"])
			[fullStr setString:@""];
        
      //  fullStr = [fullStr stringByAppendingString:@"\n"];
        [fullStr appendString:@"\n"];
        
		str_TM_SelectedItem = @"Event";
		
		if([appDel.aStDate length] > 0)
		{
			            [fullStr appendFormat:@"%@%@",appDel.aStDate,@"\n"];
		}
		if([appDel.aEnDate length] > 0)
			            [fullStr appendString:appDel.aEnDate];
		
          NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:fullStr];
		
		if([appDel.aEventTitle length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:appDel.aEventTitle]];
        if([appDel.aStDate length] > 0)
            	[attrStr1 setTextBold:YES range:[fullStr rangeOfString:@"Starts Date:"]];
        if([appDel.aEnDate length] > 0)
               [attrStr1 setTextBold:YES range:[fullStr rangeOfString:@"Ends Date:"]];
        
        [view_Alignmentalign bringSubviewToFront:lblEventTitle];
        
        /*
        if([appDel.aStDate length] > 0)
        {
        
        NSString *boldFontName = [[UIFont boldSystemFontOfSize:8] fontName];
      
        NSRange boldedRange = [fullStr rangeOfString:@"Starts Date:"];
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:fullStr
                                                 ];
        
        [attrString beginEditing];
        [attrString addAttribute:kCTFontAttributeName 
                           value:boldFontName
                           range:boldedRange];
        
        [attrString endEditing];
            [attrStr1 appendAttributedString:attrString];
        }
        
	//	        
        if([appDel.aEnDate length] > 0)
        {
            NSString *boldFontName = [[UIFont boldSystemFontOfSize:8] fontName];
            
            NSRange boldedRange = [fullStr rangeOfString:@"Ends Date:"];
            
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:fullStr
                                                     ];
            
            [attrString beginEditing];
            [attrString addAttribute:kCTFontAttributeName 
                               value:boldFontName
                               range:boldedRange];
            
            [attrString endEditing];
            [attrStr1 appendAttributedString:attrString];
            
        }
        
        
        
        
		//if([appDel.aEnDate length] > 0)
			//
        [attrStr1 setTextBold:YES range:[fullStr rangeOfString:@"Ends Date:"]];
		*/
        
		
		
		
		CGSize boundingSize = CGSizeMake(lblEventTitle.frame.size.width, CGFLOAT_MAX);
		CGSize requiredSize = [fullStr sizeWithFont:[UIFont fontWithName:@"Helvetica" size:2]
								  constrainedToSize:boundingSize
									  lineBreakMode:UILineBreakModeWordWrap];
		CGFloat requiredHeight = requiredSize.height;
		
		if(requiredHeight > 45)
			requiredHeight = 45;
			
		lblEventTitle.frame = CGRectMake(lblEventTitle.frame.origin.x, lblEventTitle.frame.origin.y, lblEventTitle.frame.size.width, 45);
        [attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:8]];

        lblEventTitle.attributedText = attrStr1;
		
		NSMutableString *fullStrAddress = [[NSMutableString alloc]initWithString:@""];
		if([appDel.astreetAdress length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.astreetAdress,@"\n"];
		if([appDel.acity length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.acity,@", "];
		if([appDel.aState length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.aState,@" "];
		if([appDel.aZip length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.aZip,@"\n"];
	
        if([appDel.acountry length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.acountry,@""];
		
		NSMutableAttributedString* attrStraddress = [NSMutableAttributedString attributedStringWithString:fullStrAddress];
		
		[attrStraddress setFont:[UIFont fontWithName:@"Helvetica" size:8]];
		lblstreetAdress.linkColor=[UIColor blackColor];
		lblstreetAdress.attributedText = attrStraddress;
		lblstreetAdress.frame = CGRectMake(lblstreetAdress.frame.origin.x, lblstreetAdress.frame.origin.y, lblstreetAdress.frame.size.width, 50);
		
		lblNotes.hidden = NO;
		
		lblNotes.text = appDel.aNotes;
		
		
		CGSize maximumLabelSize1 = CGSizeMake(275,20);
		CGSize expectedLabelSize1 = [lblNotes.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:8] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		CGRect newframe = lblNotes.frame;
		newframe.size.height = expectedLabelSize1.height;
		newframe.origin.y = lblEventTitle.frame.origin.y + lblEventTitle.frame.size.height;
		if(newframe.origin.y < 55)
			newframe.origin.y = 55;
		lblNotes.frame = newframe;
		
		//[fullStr release];
		//[fullStrAddress release];
	}
	else if(appDel.indexForTemplate == 1)
	{
		str_TM_SelectedItem = @"BusinessCard";
		NSMutableString *fullStr = [[NSMutableString alloc]initWithFormat:@"%@%@",appDel.aEventTitle,@"\n\n"];
		if([appDel.aStDate length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:appDel.aStDate];
			fullStr = [fullStr stringByAppendingString:@"\n"];
		}
		if([appDel.aEnDate length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:appDel.aEnDate];
			fullStr = [fullStr stringByAppendingString:@"\n"];
		}
		if([appDel.aNotes length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:appDel.aNotes];
			fullStr = [fullStr stringByAppendingString:@"\n"];
		}if([appDel.aphoneNo length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:appDel.aphoneNo];
			fullStr = [fullStr stringByAppendingString:@"\n"];
		}
		
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:fullStr];
		
		[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:8]];
		[attrStr1 setTextColor:[UIColor blackColor]];
        
		
		if([appDel.aEventTitle length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:appDel.aEventTitle]];
		if([appDel.aStDate length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:appDel.aStDate]];
		
		[attrStr1 setTextColor:[UIColor blackColor]];
		
		lblEventTitle.attributedText = attrStr1;
		
		lblEventTitle.frame = CGRectMake(lblEventTitle.frame.origin.x, lblEventTitle.frame.origin.y, lblEventTitle.frame.size.width, 81);
		
		lblNotes.hidden = YES;
		
		NSMutableString *fullStrAddress = [[NSMutableString alloc]initWithString:@""];
		if([appDel.astreetAdress length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.astreetAdress,@"\n"];
		if([appDel.acity length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.acity,@", "];
		if([appDel.aState length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.aState,@" "];
		if([appDel.aZip length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.aZip,@"\n"];
		if([appDel.acountry length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",appDel.acountry,@""];
		
		NSMutableAttributedString* attrStraddress = [NSMutableAttributedString attributedStringWithString:fullStrAddress];
		[attrStraddress setFont:[UIFont fontWithName:@"Helvetica" size:8]];
		
		lblstreetAdress.attributedText = attrStraddress;
        
        lblstreetAdress.linkColor=[UIColor blackColor];
    
		lblstreetAdress.frame = CGRectMake(lblstreetAdress.frame.origin.x, lblstreetAdress.frame.origin.y, lblstreetAdress.frame.size.width, 85);
		
		//[fullStr release];
		//[fullStrAddress release];
		
	}	
	else if(appDel.indexForTemplate == 2)
	{
		str_TM_SelectedItem = @"Invitation";
		NSMutableString *fullStr = [[NSMutableString alloc]initWithFormat:@"%@%@",EventTitle,@"\n\n"];
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:fullStr];
		[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:8]];
		[attrStr1 setTextColor:[UIColor blackColor]];
		if([EventTitle length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:EventTitle]];
		
		lblEventTitle.attributedText = attrStr1;
		lblEventTitle.frame = CGRectMake(lblEventTitle.frame.origin.x, lblEventTitle.frame.origin.y, lblEventTitle.frame.size.width, 25);
		
		lblNotes.hidden = YES;
		
		NSMutableString *fullStrAddress = [[NSMutableString alloc]initWithString:@""];
		if([streetAdress length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",streetAdress,@"\n"];
		if([city length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",city,@", "];
		if([State length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",State,@" "];
		if([Zip length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",Zip,@"\n"];
		if([country length] > 0)
			fullStrAddress = [fullStrAddress stringByAppendingFormat:@"%@%@",country,@""];
		
		NSMutableAttributedString* attrStraddress = [NSMutableAttributedString attributedStringWithString:fullStrAddress];
		[attrStraddress setFont:[UIFont fontWithName:@"Helvetica" size:8]];
		lblstreetAdress.linkColor=[UIColor blackColor];
		lblstreetAdress.attributedText = attrStraddress;
		lblstreetAdress.frame = CGRectMake(lblEventTitle.frame.origin.x, 20, lblstreetAdress.frame.size.width, 60);
		
		
		
	}
	else if(appDel.indexForTemplate == 3)
	{
		str_TM_SelectedItem = @"IDBadge";
		NSMutableString *fullStr = [[NSMutableString alloc]initWithFormat:@"%@%@",EventTitle,@"\n\n"];
		if([StDate length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:StDate];
			fullStr = [fullStr stringByAppendingString:@"\n\n"];
		}
		if([EnDate length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:EnDate];
			fullStr = [fullStr stringByAppendingString:@"\n\n"];
		}
		if([Notes length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:Notes];
			fullStr = [fullStr stringByAppendingString:@"\n\n"];
		}if([phoneNo length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:phoneNo];
			fullStr = [fullStr stringByAppendingString:@"\n"];
		}
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:fullStr];
		[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:8]];
		[attrStr1 setTextColor:[UIColor blackColor]];
		if([EventTitle length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:EventTitle]];
		if([StDate length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:StDate]];
		
		lblEventTitle.attributedText = attrStr1;
		
		lblEventTitle.frame = CGRectMake(lblEventTitle.frame.origin.x, lblEventTitle.frame.origin.y, 275, 81);
		
		lblNotes.hidden = YES;
		
		
		
		
		
		
	}
	else if(appDel.indexForTemplate == 4)
	{
		
		
		str_TM_SelectedItem = @"CourseInfo";
		NSMutableString *fullStr = [[NSMutableString alloc]initWithFormat:@"%@%@",appDel.aEventTitle,@"\n\n"];
		if([appDel.aStDate length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:appDel.aStDate];
			fullStr = [fullStr stringByAppendingString:@"\n\n"];
		}
		if([appDel.aEnDate length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:appDel.aEnDate];
			fullStr = [fullStr stringByAppendingString:@"\n\n"];
		}
		if([appDel.aNotes length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:appDel.aNotes];
			fullStr = [fullStr stringByAppendingString:@"\n\n"];
		}if([appDel.aphoneNo length] > 0)
		{
			fullStr = [fullStr stringByAppendingString:appDel.aphoneNo];
			fullStr = [fullStr stringByAppendingString:@"\n\n"];
		}
		
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:fullStr];
		[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:8]];
		[attrStr1 setTextColor:[UIColor blackColor]];
		
		if([appDel.aEventTitle length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:@"Course Name:"]];
		if([appDel.aStDate length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:@"Course Code:"]];
		if([appDel.aNotes length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:@"Day and Time:"]];
		if([appDel.aEnDate length] > 0)
			[attrStr1 setTextBold:YES range:[fullStr rangeOfString:@"Professor:"]];
		
		lblEventTitle.attributedText = attrStr1;
        lblEventTitle.textColor=[UIColor blackColor];
        lblEventTitle.linkColor=[UIColor blackColor];
		
		lblEventTitle.frame = CGRectMake(lblEventTitle.frame.origin.x, lblEventTitle.frame.origin.y, 275, 81);
		
		lblNotes.hidden = YES;
		
	}
	
	
	imgView_card.image = image_Card;
	
	if(image_photoLib && appDel.QRImageFromLib)
	{
		btnQRCode.frame = CGRectMake(90,8,50,45);
		btnimage_PicLib.frame = CGRectMake(145,8,50,45);
		btnimage_PicLib.hidden = NO;
		
	}
	else if(image_photoLib)
	{
		btnimage_PicLib.frame = CGRectMake(145,8,50,45);
		btnimage_PicLib.hidden = NO;
	}
	else {
		btnimage_PicLib.hidden = YES;
	}

	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(bg_ChangeTempColor) 
												 name:@"bg_ChangeTempColor"
											   object:nil];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	[btnQRCode setBackgroundImage:appDel.QRImageFromLib forState:UIControlStateNormal];
	[btnimage_PicLib setBackgroundImage:image_photoLib forState:UIControlStateNormal];
	

	
	
	///// For Add Gestures /////////
	UILongPressGestureRecognizer *longpressGestureEvent = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    longpressGestureEvent.minimumPressDuration = 1;
    [longpressGestureEvent setDelegate:self];
	[btnQRCode addGestureRecognizer:longpressGestureEvent];
	[longpressGestureEvent release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction)btnAlignmentPressed:(id)sender
{
	if(btnIndex == 7)
	{
		imgAlignmentView.image = [UIImage imageNamed:@"alignment_temp_iPhone.png"];
		
	}
	else {
		imgAlignmentView.image = [UIImage imageNamed:@"alignselwobg.png"];
	}
	
	
	view_Alignment.hidden = NO;
	view_background.hidden = YES;
	view_color.hidden = YES;
}
-(IBAction)btnColorPressed:(id)sender
{
	if(btnIndex == 7)
	{
		imgAlignmentView.image = [UIImage imageNamed:@"Colorselc_temp_iPhone.png"];
		
	}
	else {
		imgAlignmentView.image = [UIImage imageNamed:@"colselwoBG.png"];
	}
	
	
	view_Alignment.hidden = YES;
	view_background.hidden = YES;
	view_color.hidden = NO;
}
-(IBAction)btnbackPressed:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)btnCreatePressed:(id)sender
{
	NSLog(@"btnCreatePressed=======");
	
	[self saveToLibSection:[self captureScreenInRect:imgView_card.frame]];
	
	PreviewShareView_iPhone *previewShareView_iPhone = [[PreviewShareView_iPhone alloc]initWithNibName:@"PreviewShareView_iPhone" bundle:nil];
	previewShareView_iPhone.imageBCard = [self captureScreenInRect:imgView_card.frame];
	previewShareView_iPhone.phoneNumber = phoneNo;
	previewShareView_iPhone.align = alignFlag;
	[self.navigationController pushViewController:previewShareView_iPhone animated:YES];
	[previewShareView_iPhone release];
	
	
}


#pragma mark Save in Library Section

-(NSString *)TimeandDate{
	
	//Date
	NSDate* date = [NSDate date];
	NSDateFormatter *Date1=[[[NSDateFormatter alloc] init] autorelease];
	[Date1 setDateFormat:@"E MM/dd/yy"];
	//[Date1 setDateFormat:@"MMMM dd, yyyy"];
	NSString *Date12=[Date1 stringFromDate:date];    
	NSLog(@"Date: %@", Date12);
	//Time
	NSDateFormatter *Time1=[[[NSDateFormatter alloc] init] autorelease];
	[Time1 setDateFormat:@"h:mm aaa"];
	NSString *Time12=[Time1 stringFromDate:date];    
	NSLog(@"Date: %@",Time12);
	NSString *createdDate = [NSString stringWithFormat:@"Created on %@",Date12];
	//Time12 = [Time12 stringByReplacingOccurrencesOfString:@"PM" withString:@"P.M."];
	//Time12 = [Time12 stringByReplacingOccurrencesOfString:@"AM" withString:@"A.M."];
	//[TimeLabel setText:Time12];
	return createdDate;
}

-(void)saveToLibSection:(UIImage *)img
{
	NSString *createdDate = [self TimeandDate];
	
	NSString *sql = [NSString stringWithFormat:@"select *from library"];
	NSMutableArray *array=[DAL ExecuteArraySet:sql];
	
	UIImage *newImage = img;
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM-dd-yyyy-HH-mm-ss"];
	
	NSString * date = [dateFormatter stringFromDate:[NSDate date]];
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent: 
					  [NSString stringWithFormat:@"qr%@.png",date]];
	NSData* data = UIImagePNGRepresentation(newImage);
	[data writeToFile:path atomically:YES];
	if ([strFlag isEqualToString:@"UCD"])
	{
		[DAL insert_library_CreatedDate:createdDate 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:@"Event"
							Description:@""
						  starting_Date:@""
							Ending_Date:@""
								Address:@""
								  Links:@"NODATA" 
								  Email:@"NODATA" 
							  Locations:@"NODATA" 
								Message:@"NODATA" 
							 Department:@"NODATA" 
									Job:@"NODATA" 
								 Suffix:@"NODATA" 
							 MiddleName:@"NODATA" 
							   LastName:@"NODATA" 
							  FirstName:@"NODATA" 
								 Prefix:@"NODATA" 
								PhoneNo:@"NODATA" 
								Subject:@"NODATA" 
								  Notes:[NSString stringWithFormat:@"%@",Notes]];
	}
	else {
		
		if ([str_TM_SelectedItem isEqualToString:@"Event"]) {
			
			StDateLib = [appDel.aStDate stringByReplacingOccurrencesOfString:@"Starts Date:" withString:@""];
			EnDateLib = [appDel.aEnDate stringByReplacingOccurrencesOfString:@"Ends Date:" withString:@""];
			
			NSString *str1 = @"";
			if([appDel.astreetAdress length] > 0)
				str1 = [str1 stringByAppendingFormat:@"%@",appDel.astreetAdress];
			if([appDel.acity length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",appDel.acity];
			if([appDel.aState length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",appDel.aState];
			if([appDel.aZip length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",appDel.aZip];
			if([appDel.acountry length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",appDel.acountry];
	
			
			
			//NSString *address = [NSString stringWithFormat:@"%@",lbl_Address.text];
			[DAL insert_library_CreatedDate:createdDate 
									  Image:[NSString stringWithFormat:@"qr%@.png",date] 
								   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
								Description:[NSString stringWithFormat:@"%@",appDel.aEventTitle]
							  starting_Date:[NSString stringWithFormat:@"%@",StDateLib]
								Ending_Date:[NSString stringWithFormat:@"%@",EnDateLib]
									Address:str1
									  Links:@"NODATA" 
									  Email:@"NODATA" 
								  Locations:@"NODATA" 
									Message:@"NODATA" 
								 Department:@"NODATA" 
										Job:@"NODATA" 
									 Suffix:@"NODATA" 
								 MiddleName:@"NODATA" 
								   LastName:@"NODATA" 
								  FirstName:@"NODATA" 
									 Prefix:@"NODATA" 
									PhoneNo:@"NODATA" 
									Subject:@"NODATA" 
									  Notes:[NSString stringWithFormat:@"%@",appDel.aNotes]];
			
		}
		if ([str_TM_SelectedItem isEqualToString:@"BusinessCard"])
		{
			
			phoneNoLib = [appDel.aphoneNo stringByReplacingOccurrencesOfString:@"Phone Number: " withString:@""];
			NotesLib = [appDel.aNotes stringByReplacingOccurrencesOfString:@"Email: " withString:@""];
			
	
			NSString *str1 = @"";
			if([appDel.astreetAdress length] > 0)
				str1 = [str1 stringByAppendingFormat:@"%@",appDel.astreetAdress];
			if([appDel.acity length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",appDel.acity];
			if([appDel.aState length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",appDel.aState];
			if([appDel.aZip length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",appDel.aZip];
			if([appDel.acountry length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",appDel.acountry];
			
			[DAL insert_library_CreatedDate:createdDate 
									  Image:[NSString stringWithFormat:@"qr%@.png",date] 
								   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
								Description:[NSString stringWithFormat:@"%@",appDel.aEventTitle]
							  starting_Date:@"NODATA"
								Ending_Date:@"NODATA"
									Address:str1
									  Links:@"NODATA" 
									  Email:[NSString stringWithFormat:@"%@",NotesLib]
								  Locations:@"NODATA"
									Message:@"NODATA" 
								 Department:@"NODATA" 
										Job:[NSString stringWithFormat:@"%@",appDel.aEnDate]
									 Suffix:@"NODATA" 
								 MiddleName:@"NODATA" 
								   LastName:@"NODATA" 
								  FirstName:[NSString stringWithFormat:@"%@",appDel.aStDate]
									 Prefix:@"NODATA" 
									PhoneNo:[NSString stringWithFormat:@"%@",phoneNoLib]
									Subject:@"NODATA" 
									  Notes:@"NODATA" ];
		}
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"] ) {
			
			NSString *str1 = @"";
			if([streetAdress length] > 0)
				str1 = [str1 stringByAppendingFormat:@"%@",streetAdress];
			if([city length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",city];
			if([State length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",State];
			if([Zip length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",Zip];
			if([country length] > 0)
				str1 = [str1 stringByAppendingFormat:@", %@",country];

			
			[DAL insert_library_CreatedDate:createdDate 
									  Image:[NSString stringWithFormat:@"qr%@.png",date] 
								   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
								Description:[NSString stringWithFormat:@"%@",EventTitle]
							  starting_Date:@"NODATA"
								Ending_Date:@"NODATA"
									Address:str1
									  Links:@"NODATA" 
									  Email:@"NODATA" 
								  Locations:@"NODATA" 
									Message:@"NODATA" 
								 Department:@"NODATA" 
										Job:@"NODATA" 
									 Suffix:@"NODATA" 
								 MiddleName:@"NODATA" 
								   LastName:@"NODATA" 
								  FirstName:@"NODATA" 
									 Prefix:@"NODATA" 
									PhoneNo:@"NODATA" 
									Subject:@"NODATA" 
									  Notes:@"NODATA"];
		}
		if ([str_TM_SelectedItem isEqualToString:@"IDBadge"])
		{
			[DAL insert_library_CreatedDate:createdDate 
									  Image:[NSString stringWithFormat:@"qr%@.png",date] 
								   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
								Description:[NSString stringWithFormat:@"%@",EventTitle]
							  starting_Date:@"NODATA" 
								Ending_Date:@"NODATA" 
									Address:@"NODATA" 
									  Links:@"NODATA" 
									  Email:@"NODATA" 
								  Locations:@"NODATA"
									Message:@"NODATA" 
								 Department:@"NODATA" 
										Job:[NSString stringWithFormat:@"%@",EnDate]
									 Suffix:@"NODATA" 
								 MiddleName:@"NODATA" 
								   LastName:@"NODATA" 
								  FirstName:[NSString stringWithFormat:@"%@",StDate]
									 Prefix:@"NODATA" 
									PhoneNo:@"NODATA" 
									Subject:@"NODATA" 
									  Notes:@"NODATA" ];
		}
		if ([str_TM_SelectedItem isEqualToString:@"CourseInfo"] ) {
			
			if([appDel.aEventTitle length] > 0)
				EventTitleLib = [appDel.aEventTitle stringByReplacingOccurrencesOfString:@"Course Name: " withString:@""];
			if([appDel.aNotes length] > 0)
				NotesLib = [appDel.aNotes stringByReplacingOccurrencesOfString:@"Day and Time: " withString:@""];
			if([appDel.aEnDate length] > 0)
				EnDateLib = [appDel.aEnDate stringByReplacingOccurrencesOfString:@"Professor: " withString:@""];
			if([appDel.aStDate length] > 0)
				StDateLib= [appDel.aStDate stringByReplacingOccurrencesOfString:@"Course Code: " withString:@""];
			
			
			[DAL insert_library_CreatedDate:createdDate 
									  Image:[NSString stringWithFormat:@"qr%@.png",date] 
								   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
								Description:[NSString stringWithFormat:@"%@",EventTitleLib]
							  starting_Date:@"NODATA" 
								Ending_Date:@"NODATA" 
									Address:@"NODATA" 
									  Links:[NSString stringWithFormat:@"%@",NotesLib]
									  Email:@"NODATA" 
								  Locations:@"NODATA"
									Message:[NSString stringWithFormat:@"%@",EnDateLib]
								 Department:[NSString stringWithFormat:@"%@",StDateLib]
										Job:@"NODATA" 
									 Suffix:@"NODATA" 
								 MiddleName:@"NODATA" 
								   LastName:@"NODATA" 
								  FirstName:@"NODATA" 
									 Prefix:@"NODATA" 
									PhoneNo:@"NODATA" 
									Subject:@"NODATA" 
									  Notes:@"NODATA" ];
		}
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
	//[DAL insert_library_CreatedDate:createdDate Image:[NSString stringWithFormat:@"qr%d.png",[array count]+1]  Category:@"NODATA" Description:@"NODATA" starting_Date:@"NODATA" Ending_Date:@"NODATA" Address:@"NODATA" Links:@"NODATA" Email:@"NODATA" Locations:@"NODATA"];
}

- (UIImage *)captureScreenInRect:(CGRect)captureFrame {
    CALayer *layer;
    layer = viewImgCard.layer;
	
    UIGraphicsBeginImageContext(viewImgCard.frame.size); 
    CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	
	/*CGImageRef imageRef = CGImageCreateWithImageInRect([screenImage CGImage], CGRectMake(15,15,290,152));
	
	UIImage *image = [UIImage imageWithCGImage:imageRef]; 
	CGImageRelease(image);*/
	
    return screenImage;
	
	
}
-(IBAction)btnAddPressed:(id)sender
{
	//appDel.im
	appDel.QRImageFromLib = nil;
	[self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:3] animated:YES];
}

#pragma mark background

-(IBAction)btnBackgroundPressed:(id)sender
{
	imgAlignmentView.image = [UIImage imageNamed:@"Background_iPhone.png"];
	view_Alignment.hidden = YES;
	view_color.hidden = YES;
	view_background.hidden = NO;
}

-(IBAction)btnChangeBackgroundPressed:(id)sender
{
	
	ColorSelection_iPhone *colorSelection_iPhone = [[ColorSelection_iPhone alloc]initWithNibName:@"ColorSelection_iPhone" bundle:nil];
	[self presentModalViewController:colorSelection_iPhone animated:YES];
}

-(IBAction)btnphotoalbumPressed:(id)sender
{
	UIImagePickerController *controller = [[UIImagePickerController alloc] init];
	[controller setDelegate:self];
	[self presentModalViewController:controller animated:TRUE];
}

-(void)bg_ChangeTempColor
{
 	if([appDel.bgTempColor isEqual:[UIColor clearColor]])
	{}
	else
	
		//ivMainImage.image = [self changeColor:ivMainImage.image _Uicolor:appDel.bgTempColor];
		[self ChangeViewColor:appDel.bgTempColor];
	////ivMainImage.image = [self changeColor:ivMainImage.image _Uicolor:[UIColor blackColor]];
	
}
#pragma mark Change imageColor
-(void)ChangeViewColor:(UIColor*)colorMy
{
	imgView_card.hidden = YES;
	viewImgCard.backgroundColor = colorMy;
}
#pragma mark imagePickerController

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];	
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	imgBgFromPhotoAlbum.image = image;
	[self dismissModalViewControllerAnimated:YES];
}
#pragma mark Alignment


-(IBAction)btnTopPressed:(id)sender
{
	alignFlag = 0;
	view_Alignmentalign.frame = CGRectMake(2,2,287,76);
	imgBG_Lowersec.frame = CGRectMake(2,2,287,76);
	
	btnQRCode.frame = CGRectMake(120,102,50,45);
	btnimage_PicLib.frame = CGRectMake(120,102,50,45);
	
	
	[btnTop setBackgroundImage:[UIImage imageNamed:@"top-copy.png"] forState:UIControlStateNormal];
	[btnRight setBackgroundImage:[UIImage imageNamed:@"right_iPhone.png"] forState:UIControlStateNormal];
	[btnLeft setBackgroundImage:[UIImage imageNamed:@"left_iPhone.png"] forState:UIControlStateNormal];
	[btnBottom setBackgroundImage:[UIImage imageNamed:@"bottom_iPhone.png"] forState:UIControlStateNormal];
	
	if(image_photoLib && appDel.QRImageFromLib)
	{
		
		btnQRCode.frame = CGRectMake(90,102,50,45);
		btnimage_PicLib.frame = CGRectMake(145,102,50,45);
		
	}
	
	
	
	//Cell.LblName.text=str1;
	
	
	//lblEventTitle.frame = CGRectMake(0,4,140,60);
	//lblNotes.frame = CGRectMake(0,65,140,31);
	
	
	//lblstreetAdress.frame = CGRectMake(150,3,130,17);
	if(appDel.indexForTemplate == 0)
	{
		lblEventTitle.frame = CGRectMake(5,5,140,lblEventTitle.frame.size.height);
		lblstreetAdress.frame = CGRectMake(150,5,130,50);
		
	}
	else if(appDel.indexForTemplate == 1)
	{
		
		lblEventTitle.frame = CGRectMake(5,5,140,lblEventTitle.frame.size.height);
		lblstreetAdress.frame = CGRectMake(150,5,130,50);
		
	}
	else if(appDel.indexForTemplate == 2)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 140, 25);
		
		lblstreetAdress.frame = CGRectMake(5, 20, 130, 60);
		
	}
	else if(appDel.indexForTemplate == 3)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 275, 81);
	}
	else if(appDel.indexForTemplate == 4)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 275, 81);
	}
	
	lblNotes.numberOfLines = 2;
	
	CGSize maximumLabelSize1 = CGSizeMake(275,20);
	CGSize expectedLabelSize1 = [lblNotes.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:8] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	CGRect newframe = lblNotes.frame;
	newframe.size.width = 275; 
	newframe.size.height = expectedLabelSize1.height;
	//newframe.origin.y = lblEventTitle.frame.origin.y + lblEventTitle.frame.size.height;
	newframe.origin.y = 55;
	if(newframe.origin.y < 55)
		newframe.origin.y = 55;
	lblNotes.frame = newframe;
	/*lblcity.frame = CGRectMake(150,22,130,17);
	 lblState.frame = CGRectMake(150,40,130,17);
	 lblZip.frame = CGRectMake(150,58,130,17);
	 lblcountry.frame = CGRectMake(150,76,130,17);*/
}
-(IBAction)btnBottomPressed:(id)sender
{
	alignFlag = 1;
	
	[btnTop setBackgroundImage:[UIImage imageNamed:@"top_iPhone.png"] forState:UIControlStateNormal];
	[btnRight setBackgroundImage:[UIImage imageNamed:@"right_iPhone.png"] forState:UIControlStateNormal];
	[btnLeft setBackgroundImage:[UIImage imageNamed:@"left_iPhone.png"] forState:UIControlStateNormal];
	[btnBottom setBackgroundImage:[UIImage imageNamed:@"bottom-copy.png"] forState:UIControlStateNormal];
	
	
	btnQRCode.frame = CGRectMake(120,8,50,45);
	btnimage_PicLib.frame = CGRectMake(120,8,50,45);
	
	view_Alignmentalign.frame = CGRectMake(2,73,285,76);
	imgBG_Lowersec.frame = CGRectMake(2,73,285,76);
	//lblEventTitle.frame = CGRectMake(0,4,140,60);
	
	
	//lblNotes.frame = CGRectMake(0,62,140,31);
	
	
	//lblstreetAdress.frame = CGRectMake(150,3,130,17);
	
	if(image_photoLib && appDel.QRImageFromLib)
	{
		
		btnQRCode.frame = CGRectMake(90,8,50,45);
		btnimage_PicLib.frame = CGRectMake(145,8,50,45);
		
	}
	
	if(appDel.indexForTemplate == 0)
	{
		lblEventTitle.frame = CGRectMake(5,5,140,lblEventTitle.frame.size.height);
		lblstreetAdress.frame = CGRectMake(150,5,130,50);
	}
	else if(appDel.indexForTemplate == 1)
	{
		lblEventTitle.frame = CGRectMake(5,4,140,81);
		lblstreetAdress.frame = CGRectMake(150,3,130,85);
	}
	else if(appDel.indexForTemplate == 2)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 140, 25);
		
		lblstreetAdress.frame = CGRectMake(5,20, 130, 60);
		
	}
	else if(appDel.indexForTemplate == 3)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 275, 81);
	}
	else if(appDel.indexForTemplate == 4)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 275, 81);
	}
	
	lblNotes.numberOfLines = 2;
	
	
	CGSize maximumLabelSize1 = CGSizeMake(275,20);
	CGSize expectedLabelSize1 = [lblNotes.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:8] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	CGRect newframe = lblNotes.frame;
	newframe.size.width = 275;
	newframe.size.height = expectedLabelSize1.height;
	//newframe.origin.y = lblEventTitle.frame.origin.y + lblEventTitle.frame.size.height;
	newframe.origin.y = 55;
	if(newframe.origin.y < 55)
		newframe.origin.y = 55;
	lblNotes.frame = newframe;
	/*lblcity.frame = CGRectMake(150,22,130,17);
	 lblState.frame = CGRectMake(150,40,130,17);
	 lblZip.frame = CGRectMake(150,58,130,17);
	 lblcountry.frame = CGRectMake(150,76,130,17);*/
	
}
-(IBAction)btnLeftPressed:(id)sender
{
	[btnTop setBackgroundImage:[UIImage imageNamed:@"top_iPhone.png"] forState:UIControlStateNormal];
	[btnRight setBackgroundImage:[UIImage imageNamed:@"right_iPhone.png"] forState:UIControlStateNormal];
	[btnLeft setBackgroundImage:[UIImage imageNamed:@"left-copy.png"] forState:UIControlStateNormal];
	[btnBottom setBackgroundImage:[UIImage imageNamed:@"bottom_iPhone.png"] forState:UIControlStateNormal];
	
	
	alignFlag = 2;
	view_Alignmentalign.frame = CGRectMake(2,2,150,148);
	imgBG_Lowersec.frame = CGRectMake(2,2,150,148);
	btnQRCode.frame = CGRectMake(210,53,50,45);
	btnimage_PicLib.frame = CGRectMake(210,53,50,45);
	
	//lblEventTitle.frame = CGRectMake(0,0,150,60);
	
	

	//lblNotes.frame = CGRectMake(0,45,150,31);
	//lblstreetAdress.frame = CGRectMake(0,68,150,17);
	
	if(image_photoLib && appDel.QRImageFromLib)
	{

		btnQRCode.frame = CGRectMake(195,25,50,45);
		btnimage_PicLib.frame = CGRectMake(195,75,50,45);
		
	}
	
	if(appDel.indexForTemplate == 0)
	{
		lblEventTitle.frame = CGRectMake(5,4,140,60);
		lblstreetAdress.frame = CGRectMake(5,90,140,60);
	}
	else if(appDel.indexForTemplate == 1)
	{
		lblEventTitle.frame = CGRectMake(5,4,140,60);
		lblstreetAdress.frame = CGRectMake(5,68,140,60);
	}
	else if(appDel.indexForTemplate == 2)
	{
		lblEventTitle.frame = CGRectMake(5,4, 140, 25);
		
		lblstreetAdress.frame = CGRectMake(5,30,140, 60);
		
	}
	else if(appDel.indexForTemplate == 3)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 140, 81);
	}
	else if(appDel.indexForTemplate == 4)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 140, 81);
	}
	
	CGSize maximumLabelSize1 = CGSizeMake(140,40);
	lblNotes.numberOfLines = 3;
	CGSize expectedLabelSize1 = [lblNotes.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	CGRect newframe = lblNotes.frame;
	newframe.origin.x = 5;
	newframe.size.width = 140;
	newframe.size.height = expectedLabelSize1.height;
	newframe.origin.y = lblEventTitle.frame.origin.y + lblEventTitle.frame.size.height-15;
	lblNotes.frame = newframe;
	
	/*lblcity.frame = CGRectMake(0,85,150,17);
	lblState.frame = CGRectMake(0,102,150,17);
	lblZip.frame = CGRectMake(0,119,150,17);
	lblcountry.frame = CGRectMake(0,136,150,17);*/
	
	

}
-(IBAction)btnRightPressed:(id)sender
{
	
	[btnTop setBackgroundImage:[UIImage imageNamed:@"top_iPhone.png"] forState:UIControlStateNormal];
	[btnRight setBackgroundImage:[UIImage imageNamed:@"right-copy.png"] forState:UIControlStateNormal];
	[btnLeft setBackgroundImage:[UIImage imageNamed:@"left_iPhone.png"] forState:UIControlStateNormal];
	[btnBottom setBackgroundImage:[UIImage imageNamed:@"bottom_iPhone.png"] forState:UIControlStateNormal];

	
	alignFlag = 3;
	view_Alignmentalign.frame = CGRectMake(138,2,150,148);
	imgBG_Lowersec.frame = CGRectMake(138,2,150,148);
	btnQRCode.frame = CGRectMake(25,53,50,45);
	btnimage_PicLib.frame = CGRectMake(25,53,50,45);
	
	//lblEventTitle.frame = CGRectMake(0,0,150,60);
	
	
	//lblNotes.frame = CGRectMake(0,45,150,31);
	//lblstreetAdress.frame = CGRectMake(0,68,150,17);
	if(image_photoLib && appDel.QRImageFromLib)
	{

		btnQRCode.frame = CGRectMake(45,25,50,45);
		btnimage_PicLib.frame = CGRectMake(45,75,50,45);
		
	}
	
	if(appDel.indexForTemplate == 0)
	{
		lblEventTitle.frame = CGRectMake(5,4,140,60);
		lblstreetAdress.frame = CGRectMake(5,90,140,60);
	}
	else if(appDel.indexForTemplate == 1)
	{
		lblEventTitle.frame = CGRectMake(5,4,140,60);
		lblstreetAdress.frame = CGRectMake(5,68,140,60);
	}
	else if(appDel.indexForTemplate == 2)
	{
		lblEventTitle.frame = CGRectMake(5,4, 140, 25);
		
		lblstreetAdress.frame = CGRectMake(5,30,140, 60);	
	}
	else if(appDel.indexForTemplate == 3)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 140, 81);
	}
	else if(appDel.indexForTemplate == 4)
	{
		lblEventTitle.frame = CGRectMake(5, 4, 140, 81);
	}
	
	CGSize maximumLabelSize1 = CGSizeMake(140,40);
	lblNotes.numberOfLines = 3;
	CGSize expectedLabelSize1 = [lblNotes.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	CGRect newframe = lblNotes.frame;
	newframe.origin.x = 5;
	newframe.size.width = 140;
	newframe.size.height = expectedLabelSize1.height;
	newframe.origin.y = lblEventTitle.frame.origin.y + lblEventTitle.frame.size.height-15;
	lblNotes.frame = newframe;
	/*lblcity.frame = CGRectMake(0,85,150,17);
	lblState.frame = CGRectMake(0,102,150,17);
	lblZip.frame = CGRectMake(0,119,150,17);
	lblcountry.frame = CGRectMake(0,136,150,17);*/

}
#pragma mark ColorText

-(IBAction)btnBlackColorPressed:(id)sender
{
	
	[btnblackpatch setBackgroundImage:[UIImage imageNamed:@"ColorSelecnblack_iPhone.png"] forState:UIControlStateNormal];
	[btnwhitepatch setBackgroundImage:[UIImage imageNamed:@"btnwhitebgpatchsel.png"] forState:UIControlStateNormal];
	
	
	imgBG_Lowersec.backgroundColor = [UIColor whiteColor];
	lblEventTitle.textColor = [UIColor blackColor];
	 
	 lblNotes.textColor = [UIColor blackColor];
	 lblstreetAdress.textColor = [UIColor blackColor];
	lblstreetAdress.linkColor = [UIColor blackColor];
	 lblcity.textColor = [UIColor blackColor];
	 lblState.textColor = [UIColor blackColor];
	 lblZip.textColor = [UIColor blackColor];
	 lblcountry.textColor = [UIColor blackColor];
}

-(IBAction)btnWhiteColorPressed:(id)sender
{
	[btnblackpatch setBackgroundImage:[UIImage imageNamed:@"Colorselectionblackoutline_iPhone.png"] forState:UIControlStateNormal];
	[btnwhitepatch setBackgroundImage:[UIImage imageNamed:@"ColorselectionWhiteoutline_iPhone.png"] forState:UIControlStateNormal];

	
	
	imgBG_Lowersec.backgroundColor = [UIColor blackColor];
	lblEventTitle.textColor = [UIColor whiteColor];
	 
	 lblNotes.textColor = [UIColor whiteColor];
	 lblstreetAdress.textColor = [UIColor whiteColor];
	lblstreetAdress.linkColor = [UIColor whiteColor];
	 lblcity.textColor = [UIColor whiteColor];
	 lblState.textColor = [UIColor whiteColor];
	 lblZip.textColor = [UIColor whiteColor];
	 lblcountry.textColor = [UIColor whiteColor];
	
}

-(IBAction)sliderValueChanged:(id)sender
{
	imgBG_Lowersec.alpha=[sliderTransperancy value];
}

#pragma mark longPressHandler
- (void)longPressHandler:(UILongPressGestureRecognizer *)gestureRecognizer {
	
	if(UIGestureRecognizerStateBegan == gestureRecognizer.state) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure, you want to delete QR Code?" delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
		alert.tag = 1000;
		[alert show];
		[alert release];
    }
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==1) 
	{
		[btnQRCode setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
		appDel.QRImageFromLib = nil;
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
