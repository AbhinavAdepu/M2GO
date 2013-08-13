//
//  StartEndDayController.m
//  test
//
//  Created by Paras Gandhi on 12/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StartEndDayController.h"


@implementation StartEndDayController
@synthesize startDate,endDate;
@synthesize delegate,selectedDate,isFrom;
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

-(IBAction)btnBackPressed:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
	//[delegate completeDateselection:nil :nil :nil];
	[delegate completeDateselection:sdate :edate :allday];
	//[delegate calledendclick];
}
- (CGSize)contentSizeForViewInPopoverView {
    return CGSizeMake(320, 360);
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		navHeaderBar.hidden = YES;
	}
	else {
		tblView.frame =  CGRectMake(0, 50, tblView.frame.size.width, tblView.frame.size.height);
		picker.frame =  CGRectMake(0, 220, picker.frame.size.width, picker.frame.size.height);
	}

	
    [super viewDidLoad];
	flagDoneClick=FALSE;
	sdate=@"";
	edate=@"";
	allday=@"";
	UIBarButtonItem* done=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneClicked:)];
	self.navigationItem.rightBarButtonItem=done;
	
	UIBarButtonItem* cancel=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked:)];
	self.navigationItem.leftBarButtonItem=cancel;
	
}
-(void) viewWillAppear:(BOOL)animated
{
	sdate=@"";
	edate=@"";
	allday=@"";
	picker.date=[NSDate date];

	if([selectedDate isEqualToString:@"start"])
	{
		selected=1;
		[tblView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
	}
	else if([selectedDate isEqualToString:@"end"])
	{
		selected=2;
		[tblView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
		
	}

}

-(void) doneClicked:(id) sender
{
	//if (flagDoneClick==TRUE && ![edate isEqualToString:@""]) {
//		[delegate event3respond];
//		[delegate dismissdatePopOver];
//	}
//	else {
	if ([isFrom isEqualToString:@"TM"]) {
		
	}
	else {
		if([allday isEqualToString:@"All Day"])
		{
			[delegate event3respond];
			//[delegate dismissdatePopOver];
		}
		else
		{
		if([selectedDate isEqualToString:@"start"])
		{
			[delegate calledendclick];
		}
		else{
		[delegate event3respond];
		//[delegate dismissdatePopOver];
		}
		}
		
	}
	//}
	
	//NSLog(@"sdate===>%@",sdate);
	//NSLog(@"edate===>%@",edate);
	//NSLog(@"selectedt===>%d",selected);
	
	NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
	if([allday isEqualToString:@"All Day"])
	{
		[df setDateFormat:@"E MM/dd/yy"];	
		if (selected==1) {
			edate=sdate;
		}else if (selected==2) {
			
		}
	}
	if([allday isEqualToString:@"All Day"])
		[df setDateFormat:@"E MM/dd/yy"];	
	else 
		[df setDateFormat:@"E MM/dd/yy h:mm aaa"];
	
	if([selectedDate isEqualToString:@"start"])
	{
		if([sdate length]>0){}
		else if([allday isEqualToString:@"All Day"]){
			sdate=[df stringFromDate:[NSDate date]];
			edate=sdate;
		}
		else 
			sdate=[df stringFromDate:[NSDate date]];
	}
	else if([selectedDate isEqualToString:@"end"])
	{		
		if([edate length]>0){
			 if([allday isEqualToString:@"All Day"]){				
				sdate=edate;
			}
			
		}
		else {
			
			edate=[df stringFromDate:[NSDate date]];
			if([allday isEqualToString:@"All Day"]){				
				sdate=edate;
			}
		}
	}
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		
	}
	else {
		[self dismissModalViewControllerAnimated:YES];
	}

	[delegate completeDateselection:sdate :edate :allday];
	
	
}
-(void) cancelClicked:(id) sender
{
	[delegate dismissdatePopOver];
}

-(IBAction) dateChangeAction:(id) sender
{
	NSIndexPath *indexPath = [tblView indexPathForSelectedRow];
	UITableViewCell *cell = [tblView cellForRowAtIndexPath:indexPath];
	NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
	if([allday isEqualToString:@"All Day"])
		[df setDateFormat:@"E MM/dd/yy"];	
	else 
		[df setDateFormat:@"E MM/dd/yy h:mm aaa"];
	
	cell.detailTextLabel.text = [df stringFromDate: [picker date]];
	
	
	if([allday isEqualToString:@"All Day"])
	{
		[df setDateFormat:@"E MM/dd/yy"];
		edate=[[df stringFromDate:[picker date]] copy];
	}

	cell = [tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
	cell.detailTextLabel.text = [df stringFromDate:[picker date]];
	
	
	
	
	
		
	if([allday isEqualToString:@"All Day"])
		[df setDateFormat:@"E MM/dd/yy"];	
	else 
		[df setDateFormat:@"E MM/dd/yy h:mm aaa"];
	if(selected==1)
		sdate=[[df stringFromDate:[picker date]] copy];
	else if(selected==2)
		edate=[[df stringFromDate:[picker date]] copy];
	
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"TableCell";
	UITableViewCell *cell;
	if(indexPath.row<2)
	{
		cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) 
		{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				
			UIView* v=[[UIView alloc] init];
			//UIImageView *image=[UIImage imageNamed:@"_0006_Pink-Patch.png"];
			//v.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"_0006_Pink-Patch.png"]];
			v.backgroundColor=[UIColor blueColor];
			cell.selectedBackgroundView=v;
			}
		}
		cell.detailTextLabel.adjustsFontSizeToFitWidth=YES;
		if(indexPath.row==0)
		{
			cell.textLabel.text=@"Starts";
			NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
			if([allday isEqualToString:@"All Day"])
				[df setDateFormat:@"E MM/dd/yy"];	
			else 
				[df setDateFormat:@"E MM/dd/yy h:mm aaa"];
			cell.detailTextLabel.text=[df stringFromDate:[NSDate date]];
		}
		else if(indexPath.row==1)
		{
			cell.textLabel.text=@"Ends";
			NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
			if([allday isEqualToString:@"All Day"])
				[df setDateFormat:@"E MM/dd/yy"];	
			else
				[df setDateFormat:@"E MM/dd/yy h:mm aaa"];
			cell.detailTextLabel.text=[df stringFromDate:[NSDate date]];
		}
	}
	else if(indexPath.row==2)
	{
		cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) 
		{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			
			UISwitch* sw=[[UISwitch alloc] init];
			[sw addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventValueChanged];
			cell.accessoryView=sw;
			cell.selectionStyle=UITableViewCellEditingStyleNone;
			
		}
		cell.textLabel.text=@"All-Day";
	}
		
	if(indexPath.row==0)
	{
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
	else if(indexPath.row==1)
	{
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
	else {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}

	return cell;
}

-(void) onSwitchClick:(id) sender
{
	UISwitch* s=(UISwitch*) sender;
	if(s.on)
	{
		allday=@"All Day";
		picker.datePickerMode = UIDatePickerModeDate;
		
	}
	else 
	{
		allday=@"";
		picker.datePickerMode = UIDatePickerModeDateAndTime;
	}
	picker.date=[NSDate date];
	[tblView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	selected=indexPath.row+1;
	if(selected==2)
	{
		flagDoneClick=TRUE;
		NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
		if([allday isEqualToString:@"All Day"])
			[df setDateFormat:@"E MM/dd/yy"];	
		else 
			[df setDateFormat:@"E MM/dd/yy h:mm aaa"];
		
		picker.minimumDate = [df dateFromString:sdate];
		
	}
	if(selected==1)
		picker.minimumDate= nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
