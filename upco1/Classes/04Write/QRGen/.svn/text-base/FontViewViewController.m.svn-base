//
//  FontViewViewController.m
//  FontView
//
//  Created by Amitesh Kumar on 12/5/11.
//  Copyright 2011 Silver Touch Technologies Ltd. All rights reserved.
//

#import "FontViewViewController.h"

@implementation FontViewViewController


@synthesize mainTableView, mainBtn, pickerView;
@synthesize colorBtn1, colorBtn2, colorBtn3, colorBtn4, colorBtn5, colorBtn6, colorBtn7, colorBtn8;
@synthesize fontType;
@synthesize delegate;
@synthesize styleIndex,colorIndex,alignIndex,lastFontIndex,lastfontSize;
@synthesize Bold,Underline,Italic;
- (CGSize)contentSizeForViewInPopoverView {
    return CGSizeMake(320, 440);
}
/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

-(IBAction)btnDoneClicked:(id)sender
{
	
	[self dismissModalViewControllerAnimated:TRUE];
	[delegate fontandsizeselected:[[UIFont familyNames] objectAtIndex:[pickerView selectedRowInComponent:0]]:10+[pickerView selectedRowInComponent:1] :styleIndex :alignIndex :colorIndex :[pickerView selectedRowInComponent:0] :[pickerView selectedRowInComponent:1]];

}
-(IBAction)btnCancelClick:(id)sender
{
	[self dismissModalViewControllerAnimated:TRUE];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	/*NSMutableArray *fontNames = [NSMutableArray array];
	 for (NSString *family in familyNames) {
	 [fontNames addObjectsFromArray:[UIFont fontNamesForFamilyName:family]];
	 }
	 familyNames = [fontNames sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	 */
	
	
	
	self.title=@"Change Font";
	UIBarButtonItem* cancel=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked:)];
	self.navigationItem.leftBarButtonItem=cancel;
	
	UIBarButtonItem* done=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneClicked:)];
	self.navigationItem.rightBarButtonItem=done;
	familyNames=[[NSArray alloc] initWithArray:[UIFont familyNames]];
	NSLog(@"style==>%d",styleIndex);
	NSLog(@"alignIndex==>%d",alignIndex);
	for (int i=0;i<[[UIFont familyNames]count]; i++) {
		//NSLog(@"family font===>%@",[[UIFont familyNames] objectAtIndex:i]);
		if ([[[UIFont familyNames] objectAtIndex:i] isEqualToString:@"Times New Roman"]) {
			[pickerView selectRow:i inComponent:0 animated:NO];
		}
	}
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		nvBar.hidden = TRUE;
	}
	else 
	{
		nvBar.hidden = FALSE;
	}
//	[pickerView selectRow:2 inComponent:0 animated:NO];

}

-(void) cancelClicked:(id) sender
{
	[delegate didmissfontpicker];
}

// DONE CLICKE
-(void) doneClicked:(id) sender
{
	[delegate didmissfontpicker];
	[delegate fontandsizeselected:[[UIFont familyNames] objectAtIndex:[pickerView selectedRowInComponent:0]]:10+[pickerView selectedRowInComponent:1] :styleIndex :alignIndex :colorIndex :[pickerView selectedRowInComponent:0] :[pickerView selectedRowInComponent:1]];
	
}


-(void) viewDidAppear:(BOOL)animated
{	
	
	NSLog(@"===>%d",delegate.isBold);
	NSLog(@"===>%d",delegate.isItalic);
	NSLog(@"===>%d",delegate.isUnderline);
	Bold=delegate.isBold;
	Underline=delegate.isUnderline;
	Italic=delegate.isItalic;
	//Underline =YES;
	//Italic = YES;
	NSLog(@"alignIndex===>%d",alignIndex);
	if(lastFontIndex>0)
	{
		fontType = [UIFont fontWithName:@"Times New Roman" size:lastfontSize];

		[pickerView selectRow:lastFontIndex inComponent:0 animated:YES];		
		[pickerView selectRow:lastfontSize-10 inComponent:1 animated:YES];
		[mainBtn setTitle:[[UIFont familyNames] objectAtIndex:lastFontIndex] forState:UIControlStateNormal];
		[mainBtn.titleLabel setFont:fontType];
		[mainBtn.titleLabel setFont:[fontType fontWithSize:lastfontSize]];
		
	}
	else 
	{
	//	[mainBtn setTitle:[[UIFont familyNames] objectAtIndex:29] forState:UIControlStateNormal];
		fontType = [UIFont fontWithName:@"Times New Roman" size:24.0];
		[mainBtn.titleLabel setFont:[UIFont fontWithName:@"Times New Roman" size:24.0]];
		for (int i=0;i<[[UIFont familyNames]count]; i++) {
			//NSLog(@"family font===>%@",[[UIFont familyNames] objectAtIndex:i]);
			if ([[[UIFont familyNames] objectAtIndex:i] isEqualToString:@"Times New Roman"]) {
				[pickerView selectRow:i inComponent:0 animated:NO];
				[mainBtn setTitle:[[UIFont familyNames] objectAtIndex:i] forState:UIControlStateNormal];
			}
		}
		[pickerView selectRow:14 inComponent:1 animated:NO];
		
	}
	
	[colorBtn1 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn2 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn3 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn4 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn5 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn6 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn7 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn8 setBackgroundImage:nil forState:UIControlStateNormal];
	
	
	
	if (colorIndex==101) {
		[colorBtn1 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];
		
	}else if (colorIndex==102) {
		[colorBtn2 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];
		
	}else if (colorIndex==103) {
		[colorBtn3 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];
		
	}else if (colorIndex==104) {
		[colorBtn4 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];
		
	}else if (colorIndex==105) {
		[colorBtn5 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];
		
	}else if (colorIndex==106) {
		[colorBtn6 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];
		
	}else if (colorIndex==107) {
		[colorBtn7 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];
		
	}else if (colorIndex==108) {
		[colorBtn8 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];
		
	}
	
	
	[mainTableView reloadData];
}



-(void)selectedrow
{
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark tableView delegate and data source;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	//return [appDelegate.allKeys count];	
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// temp working	
  	static NSString *CellIdentifier = @"cellIdentifier";
	
	cell = (TableCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	//NSMutableDictionary *tempdict;	
	if (cell == nil) 
	{
		[[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
	}
    
	
	switch (indexPath.row) {
			
		case 0:
			cell.cellLabel.text = @"Style";
			cell.cellLabel.font = [UIFont boldSystemFontOfSize:14];
			cell.cellLabel.hidden=NO;
			//cell.titleImgView.image=[UIImage imageNamed:@"_0005_Style.png"];	
			/*
			 
			 [cell.cellBtn1 setImage:[UIImage imageNamed:@"_0000_R.png"] forState:UIControlStateNormal];
			 [cell.cellBtn2 setImage:[UIImage imageNamed:@"_0001_B.png"] forState:UIControlStateNormal];
			 [cell.cellBtn3 setImage:[UIImage imageNamed:@"_0002_B.png"] forState:UIControlStateNormal];
			 [cell.cellBtn4 setImage:[UIImage imageNamed:@"_0004_I.png"] forState:UIControlStateNormal];
			 [cell.cellBtn5 setImage:[UIImage imageNamed:@"_0003_U.png"] forState:UIControlStateNormal];
			 */
			
			[cell.cellBtn1 addTarget:self action:@selector(styleClicked:) forControlEvents:UIControlEventTouchUpInside];
			[cell.cellBtn2 addTarget:self action:@selector(styleClicked:) forControlEvents:UIControlEventTouchUpInside];
			[cell.cellBtn3 addTarget:self action:@selector(styleClicked:) forControlEvents:UIControlEventTouchUpInside];
			
			
			[cell.cellBtn1 setImage:[UIImage imageNamed:@"_0001_B.png"] forState:UIControlStateNormal];
			[cell.cellBtn2 setImage:[UIImage imageNamed:@"_0004_I.png"] forState:UIControlStateNormal];
			[cell.cellBtn3 setImage:[UIImage imageNamed:@"_0003_U.png"] forState:UIControlStateNormal];
			
			cell.cellBtn1.tag = 11;
			cell.cellBtn2.tag = 12;
			cell.cellBtn3.tag = 13;
			
			/*	cell.cellBtn4.tag = 14;
			 cell.cellBtn5.tag = 15;		
			 */	
			
			
			if (delegate.isBold) {
				[cell.cellBtn1 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			}
			if (delegate.isItalic) {
				[cell.cellBtn2 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			}
			if (delegate.isUnderline) {
				[cell.cellBtn3 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			}
			 
			 
			/*else if (cell.cellBtn4.tag == styleIndex) {
			 [cell.cellBtn4 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			 }else if (cell.cellBtn5.tag == styleIndex) {
			 [cell.cellBtn5 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			 }*/
			
			
			break;
			
		case 1:			
			cell.cellLabel.text = @"Alignment";
			cell.cellLabel.hidden=YES;
			cell.titleImgView.image=[UIImage imageNamed:@"_0015_Alignment.png"];
			[cell.cellBtn1 setImage:[UIImage imageNamed:@"_0016_Left-Aline.png"] forState:UIControlStateNormal];
			[cell.cellBtn2 setImage:[UIImage imageNamed:@"_0017_Center-Aline.png"] forState:UIControlStateNormal];
			[cell.cellBtn3 setImage:[UIImage imageNamed:@"_0018_Right-Aline.png"] forState:UIControlStateNormal];
			[cell.cellBtn4 setImage:[UIImage imageNamed:@"_0019_Left-Fix-aline.png"] forState:UIControlStateNormal];
			//[cell.cellBtn5 setImage:[UIImage imageNamed:@"Justifyimage.png"] forState:UIControlStateNormal];
			//[cell.cellBtn4 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			
			//			[cell.cellBtn1 setBackgroundImage:nil forState:UIControlStateNormal];
			//			[cell.cellBtn2 setBackgroundImage:nil forState:UIControlStateNormal];
			//			[cell.cellBtn3 setBackgroundImage:nil forState:UIControlStateNormal];
			//			[cell.cellBtn4 setBackgroundImage:nil forState:UIControlStateNormal];
			//			[cell.cellBtn5 setBackgroundImage:nil forState:UIControlStateNormal];
			
			[cell.cellBtn1 addTarget:self action:@selector(AlignmentClicked:) forControlEvents:UIControlEventTouchUpInside];
			[cell.cellBtn2 addTarget:self action:@selector(AlignmentClicked:) forControlEvents:UIControlEventTouchUpInside];
			[cell.cellBtn3 addTarget:self action:@selector(AlignmentClicked:) forControlEvents:UIControlEventTouchUpInside];
			[cell.cellBtn4 addTarget:self action:@selector(AlignmentClicked:) forControlEvents:UIControlEventTouchUpInside];
			//[cell.cellBtn5 addTarget:self action:@selector(AlignmentClicked:) forControlEvents:UIControlEventTouchUpInside];
			
			cell.cellBtn1.tag = 21;
			cell.cellBtn2.tag = 22;
			cell.cellBtn3.tag = 23;
			cell.cellBtn4.tag = 24;
			//cell.cellBtn5.tag = 25;
			
			if (cell.cellBtn1.tag == alignIndex) {
				[cell.cellBtn1 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			}
			else if (cell.cellBtn2.tag == alignIndex) {
				[cell.cellBtn2 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			}else if (cell.cellBtn3.tag == alignIndex) {
				[cell.cellBtn3 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			}else if (cell.cellBtn4.tag == alignIndex) {
				[cell.cellBtn4 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			}/*else if (cell.cellBtn5.tag == alignIndex) {
				[cell.cellBtn5 setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
			}*/
			
			
			
			break;
			
		default:
			break;
	}
	
	cell.selectionStyle=UITableViewCellSelectionStyleNone;
	return cell; 
    
}
-(void) styleClicked:(id) sender
{
	UIButton* b=(UIButton*) sender;
	styleIndex=b.tag;
	TableCell* c=[[b superview] superview];
	[b setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
	if (styleIndex==11) {
		if (Bold) {		
			Bold=NO;
			[c.cellBtn1 setBackgroundImage:nil forState:UIControlStateNormal];
			
		}
		else{Bold=YES;}
		
	}else if(styleIndex==12){
		if (Italic) {
			Italic=NO;
			[c.cellBtn2 setBackgroundImage:nil forState:UIControlStateNormal];
			
		}else{Italic=YES;}
	}else if(styleIndex==13){	
		if (Underline) {
			Underline=NO;
			[c.cellBtn3 setBackgroundImage:nil forState:UIControlStateNormal];
			
		}else{Underline=YES;}
		
		
	}
	
	
	NSLog(@"Bold====>%d",Bold);
	NSLog(@".Italic====>%d",Italic);
	NSLog(@".Underline====>%d",Underline);
	/*[c.cellBtn1 setBackgroundImage:nil forState:UIControlStateNormal];
	 [c.cellBtn2 setBackgroundImage:nil forState:UIControlStateNormal];
	 [c.cellBtn3 setBackgroundImage:nil forState:UIControlStateNormal];
	 [c.cellBtn4 setBackgroundImage:nil forState:UIControlStateNormal];
	 [c.cellBtn5 setBackgroundImage:nil forState:UIControlStateNormal]; 
	 */
	
	
}

-(void)AlignmentClicked:(id) sender
{
	
	UIButton* b=(UIButton*) sender;
	alignIndex=b.tag;
	TableCell* c=[[b superview] superview];
	[c.cellBtn1 setBackgroundImage:nil forState:UIControlStateNormal];
	[c.cellBtn2 setBackgroundImage:nil forState:UIControlStateNormal];
	[c.cellBtn3 setBackgroundImage:nil forState:UIControlStateNormal];
	[c.cellBtn4 setBackgroundImage:nil forState:UIControlStateNormal];
	//[c.cellBtn5 setBackgroundImage:nil forState:UIControlStateNormal]; 
	
	[b setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
	
	
}
#pragma mark pickerView delegate 

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	
	return 2;
	
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
	int nor;
	
	switch (component) {
			
		case 0:
			nor = [UIFont familyNames].count;
			break;
			
		case 1:
			nor = 15;
			break;
			
		default:
			break;
	}
	
	return nor;
	
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component {
	
	switch (component) {
			
		case 0:
			return [[UIFont familyNames] objectAtIndex:row];
			break;
		case 1:
			return [NSString stringWithFormat:@"%d",row +10];
			break;
		default:
			break;
			
	}
	
	return nil;
	
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
	
	int width;
	
	switch (component) {
			
		case 0:
			width = 200;
			break;
			
		case 1:
			width = 120;
			break;
			
		default:
			break;
	}
	
	return width;
	
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	switch (component) {
			
		case 0:	
			
			fontType = [UIFont fontWithName:[[UIFont familyNames] objectAtIndex:row] size:fontSize];
			[mainBtn setTitle:[[UIFont familyNames] objectAtIndex:row] forState:UIControlStateNormal];
			[mainBtn.titleLabel setFont:fontType];
			[mainBtn.titleLabel setFont:[fontType fontWithSize:lastfontSize]];
			
			
			break;
			
		case 1:			
			fontSize = row + 10;
			//[mainBtn setTitle:[[UIFont familyNames] objectAtIndex:row] forState:UIControlStateNormal];
			[mainBtn.titleLabel setFont:[fontType fontWithSize:row + 10]];
			lastfontSize=row+10;
			break;
			
		default:
			break;
			
	}
	
}


-(IBAction) colorBtnClick : (id)sender{
	
	
	
	UIButton *tempBtn = (UIButton*)sender;
	colorIndex=tempBtn.tag;	
	
	[colorBtn1 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn2 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn3 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn4 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn5 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn6 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn7 setBackgroundImage:nil forState:UIControlStateNormal];
	[colorBtn8 setBackgroundImage:nil forState:UIControlStateNormal];
	
	[tempBtn setBackgroundImage:[UIImage imageNamed:@"Selection-image.png"] forState:UIControlStateNormal];   
	
}

-(IBAction) cellBtnClick: (id)sender{
	
	UIButton *tempBtn = (UIButton*)sender;
	//[delegate styleselected:tempBtn.tag];
	
	
}

-(IBAction) mainBtnClick: (id)sender{
	
	
	
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
