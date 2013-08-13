//
//  LibraryViewController.m
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import "LibraryViewController.h"
#import "SHKItem.h"
#import "SHKActionSheet.h"
#import "DAL.h"
#import "LibraryCell.h"
#import "LibraryCell-Landscape.h"
#import <MessageUI/MFMailComposeViewController.h>



@implementation LibraryViewController
@synthesize flagFromTemp;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	}
	else
	{
		if(flagFromTemp == TRUE)
		{
			UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"QR Code will be pulled from Library" 
														   message:@"If you'd like to create a new code to add to the template, create QRcode in Write section first." 
														  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
		}
	}
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[super viewDidLoad];
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
    flagicloud=NO;

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		
	firstTime = TRUE;
	oncePort = FALSE;
	
	selectedRow = 500;
	
	appDel.fromTwitter = FALSE;

	
	[self loadTable];
	

	selectedindexes = [[NSMutableArray alloc] init];
	
	array_catagory = [[NSMutableArray alloc]init];
	
	
	arrImg = [[NSMutableArray alloc]init];
	
	NSString *strQuery = @"SELECT *FROM library";
	//array_catagory = [DAL ExecuteArraySet:strQuery];
	
	[array_catagory addObjectsFromArray:[[[DAL ExecuteArraySet:strQuery]reverseObjectEnumerator]allObjects]];
	
	
	[array_catagory retain];
	
	
	for(int i=0;i<[array_catagory count];i++)
	{
		
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
		NSLog(@"paths : %@",paths);
		NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
		//NSLog(@"documentsDirectory : %@",documentsDirectory);	
		NSString *newPath = documentsDirectory;
		[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil];
		
		
		if (![[NSFileManager defaultManager] fileExistsAtPath:newPath])
			{
					[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
			}
			
		NSString * strImage = [newPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:i] objectForKey:@"Image"]]];	
		UIImage *image1 = [UIImage imageWithContentsOfFile:strImage];
		[arrImg addObject:image1];
	}
		
        flagcon=NO;
        flagphon=NO;
        flageven=NO;
	//if ([array_catagory count]>0) 
//	{
//		[self tableView:tblView_Lib didSelectRowAtIndexPath:0];
//	}
	
	
	whiteLayer = [[UIImageView alloc]init];
	/*whiteLayer.frame = CGRectMake(0, 38, 654, 44);
    whiteLayer.image = [UIImage imageNamed:@"Select-QR-code---P.png"];
	[self.view addSubview:whiteLayer];
	[TopImage sendSubviewToBack:whiteLayer];
	[whiteLayer release];*/
	
	TopImage = [[UIImageView alloc]init];
	TopImage.frame = CGRectMake(0, 0, 768, 48);
	TopImage.image = [UIImage imageNamed:@"_0009_top-red-band.png"];
	[self.view addSubview:TopImage];
	//TopImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	[TopImage release];
	
	TopLabel = [[UILabel alloc]init];
	TopLabel.frame = CGRectMake(290, 100, 200, 30);
	TopLabel.text = @"Library";
	TopLabel.textColor = [UIColor whiteColor];
	[TopLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
	TopLabel.backgroundColor = [UIColor clearColor];
	//TopLabel.textAlignment = UITextAlignmentCenter;
	TopLabel.hidden = TRUE;
	[self.view addSubview:TopLabel];
	[TopLabel release];
	
	
	whitelayerlabel = [[UILabel alloc]init];
	whitelayerlabel.frame = CGRectMake(290, 100, 200, 30);
	whitelayerlabel.text = @"Select QR code";
	whitelayerlabel.textColor = [UIColor whiteColor];
	//whitelayerlabel.textAlignment = UITextAlignmentCenter;
	[whitelayerlabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
	whitelayerlabel.backgroundColor = [UIColor clearColor];
	whitelayerlabel.hidden = TRUE;
	[self.view addSubview:whitelayerlabel];
	[whitelayerlabel release];
	
	scrollAll = [[UIScrollView alloc]init];
	scrollAll.frame = CGRectMake(54, 520, 600, 400);
	scrollAll.backgroundColor = [UIColor clearColor];
	//scrollAll.contentSize = CGSizeMake(500, 780);
	scrollAll.scrollEnabled = TRUE;
	scrollAll.delegate = self;
        
        //--*
        actbutton=[[UIButton alloc]init];
        lblcalendarnote=[[UITextView alloc]init];
        lblcalendarnote.text=@"*If the device with iOS 5.0 and above is not configured with iCloud, Events will not be added to the calendar.";
        [lblcalendarnote setFont:[UIFont italicSystemFontOfSize:12]];
        lblcalendarnote.userInteractionEnabled=NO;

        
        [scrollAll addSubview:actbutton];
        [scrollAll addSubview:lblcalendarnote];
        [actbutton setEnabled:YES];
        actbutton.titleLabel.text=@"action";
      // [actbutton setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
        [actbutton addTarget:self action:@selector(actbutmethod) forControlEvents:UIControlEventTouchUpInside];
        
        [actbutton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];

        

	qrImageview = [[UIImageView alloc] init];
	//qrImageview.frame = CGRectMake(58, 520, 63 , 65);
	qrImageview.frame = CGRectMake(0, 0, 63, 65);
	qrImageview.contentMode = UIViewContentModeScaleToFill;
	[scrollAll addSubview:qrImageview];
	//[qrImageview release];
	
	
	catDes = [[UILabel alloc]init];
	catDes.frame = CGRectMake(205, 520, 200, 30);
	//catDes.text = @"Library";
	catDes.textColor = [UIColor blackColor];
	[catDes setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
	catDes.backgroundColor = [UIColor clearColor];
	[scrollAll addSubview:catDes];
	[catDes release];
	//catDes.hidden = TRUE;
	
	 
	lblmainDes = [[UILabel alloc]init];
	lblmainDes.frame = CGRectMake(125, 700, 500, 30);
	lblmainDes.numberOfLines = 0;
	//lblmainDes.adjustsFontSizeToFitWidth = NO;
	[lblmainDes setFont:[UIFont fontWithName:@"Helvetica" size:18]];
 	lblmainDes.backgroundColor = [UIColor clearColor];
	[scrollAll addSubview:lblmainDes];
	[lblmainDes release];
	lblmainDes.hidden = TRUE;
	

	
	createdDate = [[UILabel alloc]init];
	createdDate.frame = CGRectMake(207, 560, 200, 60);
	//createdDate.text = @"Created On 28th September 2011";
	createdDate.numberOfLines = 2;
	createdDate.textColor = [UIColor blackColor];
	[createdDate setFont:[UIFont fontWithName:@"Helvetica" size:18]];
	createdDate.backgroundColor = [UIColor clearColor];
	[scrollAll addSubview:createdDate];
	[createdDate release];
	//createdDate.hidden = TRUE;

	
	landSeprate = [[UIImageView alloc]init];
	landSeprate.image = [UIImage imageNamed:@"Copy (3) of _0002_top-gradiation.png"];
	[self.view addSubview:landSeprate];
	[landSeprate release];
	
	portSeprate = [[UIImageView alloc]init];
	portSeprate.frame = CGRectMake(0, 800, 654, 5);
	portSeprate.image = [UIImage imageNamed:@"_0002_Layer-42.png"];
	//[self.view bringSubviewToFront:portSeprate];
	[self.view addSubview:portSeprate];
	[portSeprate release];
	
		
	imgSharing = [[UIImageView alloc]init];
	imgSharing.frame = CGRectMake(34, 500, 654, 56);
	imgSharing.backgroundColor = [UIColor lightGrayColor];
	imgSharing.image = [UIImage imageNamed:@"t-f_P.png"];
	[self.view sendSubviewToBack:imgSharing];
	[self.view addSubview:imgSharing];
	[imgSharing release];
	
	btnFB = [UIButton buttonWithType:UIButtonTypeCustom];
	btnFB.tag = 1;
	[btnFB addTarget:self 
			  action:@selector(buttonFacebooKClicked:)
	forControlEvents:UIControlEventTouchDown];
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btnFB.frame = CGRectMake(140, 950, 50, 50);
	[self.view addSubview:btnFB];
	
	btnTwit = [UIButton buttonWithType:UIButtonTypeCustom];
	btnTwit.tag = 1;
	[btnTwit addTarget:self 
			  action:@selector(buttonTwitterClicked:)
	forControlEvents:UIControlEventTouchDown];
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btnTwit.frame = CGRectMake(270, 950, 50, 50);
	[self.view addSubview:btnTwit];
	
	btnEmail = [UIButton buttonWithType:UIButtonTypeCustom];
	btnEmail.tag = 1;
	[btnEmail addTarget:self 
				action:@selector(emailbtn_click:)
	  forControlEvents:UIControlEventTouchDown];
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btnEmail.frame = CGRectMake(400, 950, 50, 50);
	[self.view addSubview:btnEmail];
	
	btnTrash = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	//btnTrash.tag = 1;
	[btnTrash addTarget:self 
				 action:@selector(btnTrashClick:)
	   forControlEvents:UIControlEventTouchDown];
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btnTrash.frame = CGRectMake(530, 950, 50, 50);
	[self.view addSubview:btnTrash];
	
	

	
	[self.view addSubview:scrollAll];
	//[scrollAll release];

	txtDisplay = [[OHAttributedLabel alloc]init];
	txtDisplay.frame = CGRectMake(6, 130, 500, 200);
	txtDisplay.backgroundColor = [UIColor clearColor];
	[scrollAll addSubview:txtDisplay];
	
	
	if([array_catagory count] == 0)
	{
		
	}
	else 
	{
		[self Newsetselected:0];
	}

    
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"didRotate" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(didRotate:) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification
											   object:nil];
	
	}
	else 
	{
		NSLog(@"iPhone");
		
	//	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadData" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(TableReloadmethod) 
													 name:@"ReloadData"
												   object:nil];
		
		if(flagFromTemp == TRUE)
		{
			lblHeader_iphone.text = @"Use Designed Templates";
			btnTemplateBack.hidden = FALSE;
		}
		else 
		{
			lblHeader_iphone.text = @"Library";
			btnTemplateBack.hidden = TRUE;
		}
		catDes = [[UILabel alloc]init];
		catDes.frame = CGRectMake(205, 520, 200, 30);
		//catDes.text = @"Library";
		catDes.textColor = [UIColor blackColor];
		[catDes setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
		catDes.backgroundColor = [UIColor clearColor];
		
		txtDisplay = [[OHAttributedLabel alloc]init];
		txtDisplay.frame = CGRectMake(6, 130, 500, 200);
		txtDisplay.backgroundColor = [UIColor clearColor];
		
		selectedRow = 500;
		
		array_catagory = [[NSMutableArray alloc]init];
		
		
		arrImg = [[NSMutableArray alloc]init];
		
		NSString *strQuery = @"SELECT *FROM library";
		//array_catagory = [DAL ExecuteArraySet:strQuery];
		
		[array_catagory addObjectsFromArray:[[[DAL ExecuteArraySet:strQuery]reverseObjectEnumerator]allObjects]];
		
		
		[array_catagory retain];
		
		
		for(int i=0;i<[array_catagory count];i++)
		{
			
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
			NSLog(@"paths : %@",paths);
			NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
		//	NSLog(@"documentsDirectory : %@",documentsDirectory);	
			NSString *newPath = documentsDirectory;
			[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil];
			
			
			if (![[NSFileManager defaultManager] fileExistsAtPath:newPath])
			{
				[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
			}
			
			NSString * strImage = [newPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:i] objectForKey:@"Image"]]];	
			UIImage *image1 = [UIImage imageWithContentsOfFile:strImage];
			[arrImg addObject:image1];
			//S[[arrImg reverseObjectEnumerator]allObjects];
		}
		
		
		//[self MainDescription];
		if([array_catagory count] == 0)
		{
			
		}
		else 
		{
			changeColor = 0;
			[self performSelectorInBackground:@selector(MainDescription) withObject:nil];
		}
		
		
	}
}

-(IBAction)BackToTemplate
{
	[self dismissModalViewControllerAnimated:TRUE];
}

-(IBAction)btnScanURL:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:lblmainDes.text ]];
}

-(void)shareToFB
{
	
}

-(void)loadTable
{
	//Size of the table
	CGRect tableFrame = CGRectMake(0,78,654,420);
	// style of table round or square etc
	table = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
	//background color clear otherwise will be grey
	table.backgroundColor = [UIColor clearColor]; 	
	// datasource is the delegate for UITableViewDataSource protocol so we have to assign self to it
	//so we can implement the respective method inside this class thus the OS will know that table methods need to be called to this class
	table.dataSource = self;
	//This is UITableViewDelegate
	table.delegate = self;       
	//scroll down if needed.
	table.scrollEnabled = TRUE;
	//add table to self
	[self.view addSubview:table];
}

-(void)TableReloadmethod
{
	
	[array_catagory removeAllObjects];
	[arrImg removeAllObjects];
	NSString *strQuery = @"SELECT *FROM library";
	//array_catagory = [DAL ExecuteArraySet:strQuery];
	
	[array_catagory addObjectsFromArray:[[[DAL ExecuteArraySet:strQuery]reverseObjectEnumerator]allObjects]];
	
	
	for(int i=0;i<[array_catagory count];i++)
	{
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
		NSLog(@"paths : %@",paths);
		NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
		//NSLog(@"documentsDirectory : %@",documentsDirectory);	
		NSString *newPath = documentsDirectory;
		[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil];
		
		
		if (![[NSFileManager defaultManager] fileExistsAtPath:newPath])
		{
			[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
		}
		
		NSString * strImage = [newPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:i] objectForKey:@"Image"]]];	
		UIImage *image1 = [UIImage imageWithContentsOfFile:strImage];
		[arrImg addObject:image1];
		
		//[[arrImg reverseObjectEnumerator]allObjects];
	}
	
	[tblView_Lib reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		
	}
	else 
	{
		[tblView_Lib reloadData];
	}
	
	//[tblView_Lib reloadData];
	//[tblView_Lib selectRowAtIndexPath:0 animated:YES  scrollPosition:UITableViewScrollPositionTop];[tblView_Lib selectRowAtIndexPath:0 animated:YES  scrollPosition:UITableViewScrollPositionTop];[tblView_Lib selectRowAtIndexPath:0 animated:YES  scrollPosition:UITableViewScrollPositionTop];

}
// Override to allow orientations other than the default portrait orientation.



#pragma mark UITableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	return [array_catagory count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView.tag == 1)
	{
		return 72;
	}
	else 
	{
		if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
		{
			return 83;
		}
		else 
		{
			return 69;
		}
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(tableView.tag == 1)
	{
		//UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
//		
//		if (cell == nil) 
//		{
//			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
//		}
		
		static NSString *CellIdentifier = @"CustomCell";
		LibraryCell_Landscape *cell = (LibraryCell_Landscape *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LibraryCell-Landscape" owner:self options:nil];
			for (id currentObject in topLevelObjects){
				if ([currentObject isKindOfClass:[UITableViewCell class]]){
					cell =  (LibraryCell_Landscape *) currentObject;
					break;
				}
			}
		}
		
		UIImageView *img = [[UIImageView alloc]init];
		img.image = [UIImage imageNamed:@"_0000_seperation-lines-set1-copy-20.png"];
		img.frame = CGRectMake(0, 0, 320, 72);
		[cell.contentView addSubview:img];
		[img release];
		
		UIImageView *imgqr = [[UIImageView alloc]init];
		imgqr.image = [arrImg objectAtIndex:indexPath.row];
		//imgqr.image = image1;
		//imgqr.image = [arrImg objectAtIndex:indexPath.row];
		imgqr.frame = CGRectMake(15, 4, 65, 65);
		[cell.contentView addSubview:imgqr];
		[imgqr release];
		
		UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(90, 9, 200, 18)];
        
		lbl.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Category"];
		[lbl setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
		[cell.contentView addSubview:lbl];
		[lbl release];
		
		UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 28, 200, 30)];
      
        if([[[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Description"] isEqualToString:@"(null)"])
        {
            lbl1.text = @"";
        }
        else 
        {
            lbl1.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Description"];
        }
		[lbl1 setFont:[UIFont fontWithName:@"Arial" size:14]];
		lbl1.numberOfLines = 2;
		[cell.contentView addSubview:lbl1];
		[lbl1 release];
		
		UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(89, 60, 250, 10)];
		lbl2.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"CreatedDate"];
		[lbl2 setFont:[UIFont fontWithName:@"Arial" size:10]];
		lbl2.numberOfLines = 2;
		lbl2.textColor = [UIColor grayColor];
		[cell.contentView addSubview:lbl2];
		[lbl2 release];
		
		UIImageView *img_aero = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow_WriteDark_iphone.png"]];
		img_aero.frame = CGRectMake(300, 32, 6, 11);
		[cell.contentView addSubview:img_aero];
		
		
		img.highlightedImage = [UIImage imageNamed:@"_0001_seperation-lines-set1-20.png"];
		img.image = [UIImage imageNamed:@"_0000_seperation-lines-set1-copy-20.png"];
		lbl1.highlightedTextColor = [UIColor whiteColor];
		lbl.highlightedTextColor = [UIColor whiteColor];
		lbl2.highlightedTextColor = [UIColor lightGrayColor];
		img_aero.highlightedImage = [UIImage imageNamed:@"Arrow_WriteNormal_iphone.png"];
		
		
		/*
		if(selectedRow == indexPath.row)
		{
			img.image = [UIImage imageNamed:@"_0001_seperation-lines-set1-20.png"];
			lbl.backgroundColor = [UIColor clearColor];
			lbl1.backgroundColor = [UIColor clearColor];
			lbl1.textColor = [UIColor whiteColor];
			lbl2.backgroundColor = [UIColor clearColor];
			lbl2.textColor = [UIColor lightGrayColor];
			lbl.textColor = [UIColor whiteColor];
			img_aero.image = [UIImage imageNamed:@"Arrow_WriteNormal_iphone.png"];
		}
		*/
		
		return cell;
		
	}
	else 
	{
	if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
	{
		static NSString *CellIdentifier = @"CustomCell";
		LibraryCell_Landscape *cell = (LibraryCell_Landscape *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LibraryCell-Landscape" owner:self options:nil];
			for (id currentObject in topLevelObjects){
				if ([currentObject isKindOfClass:[UITableViewCell class]]){
					cell =  (LibraryCell_Landscape *) currentObject;
					break;
				}
			}
		}
		
		UIImageView *img = [[UIImageView alloc]init];
		img.image = [UIImage imageNamed:@"_0000_seperation-lines-set1-copy-20.png"];
		img.frame = CGRectMake(0, 0, 360, 83);
		[cell.contentView addSubview:img];
		
		UIImageView *imgqr = [[UIImageView alloc]init];
		imgqr.image = [arrImg objectAtIndex:indexPath.row];
		imgqr.frame = CGRectMake(20, 9, 65, 65);
		[cell.contentView addSubview:imgqr];
		
		UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(100, 9, 200, 18)];
		lbl.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Category"];
		[lbl setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
		[cell.contentView addSubview:lbl];
		
		UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 30, 200, 30)];
		lbl1.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Description"];
		[lbl1 setFont:[UIFont fontWithName:@"Arial" size:14]];
		lbl1.numberOfLines = 2;
		[cell.contentView addSubview:lbl1];
		
		UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(98, 65, 250, 10)];
		//NSString *str = [[[array_catagory objectAtIndex:indexPath.row] objectForKey:@"CreatedDate"] stringByReplacingOccurrencesOfString:@"Created on" withString:@""];
		//lbl2.text =[str stringByReplacingOccurrencesOfString:@"Scanned on" withString:@""];
		
		lbl2.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"CreatedDate"];
		
		[lbl2 setFont:[UIFont fontWithName:@"Arial" size:10]];
		lbl2.numberOfLines = 2;
		lbl2.textColor = [UIColor grayColor];
		[cell.contentView addSubview:lbl2];
		
		if(selectedRow == indexPath.row)
		{
			img.image = [UIImage imageNamed:@"_0001_seperation-lines-set1-20.png"];
			lbl.backgroundColor = [UIColor clearColor];
			lbl1.backgroundColor = [UIColor clearColor];
			lbl1.textColor = [UIColor whiteColor];
			lbl2.backgroundColor = [UIColor clearColor];
			lbl2.textColor = [UIColor lightGrayColor];
			lbl.textColor = [UIColor whiteColor];
		}
		
		
		return cell;
	}
	
	else 
	{
		
		static NSString *CellIdentifier = @"CustomCell";
		LibraryCell *cell = (LibraryCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0001_Layer-41.png"]]; 
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LibraryCell" owner:self options:nil];
			for (id currentObject in topLevelObjects){
				if ([currentObject isKindOfClass:[UITableViewCell class]]){
					cell =  (LibraryCell *) currentObject;
					break;
				}
			}
		}
		
		UIImageView *img = [[UIImageView alloc]init];
		img.image = [UIImage imageNamed:@"_0000_Layer-41-copy-20.png"];
		img.frame = CGRectMake(0, 0, 654, 69);
		[cell.contentView addSubview:img];
		
		UIImageView *imgqr = [[UIImageView alloc]init];
		imgqr.image = [arrImg objectAtIndex:indexPath.row];
		imgqr.frame = CGRectMake(25, 6, 57, 57);
		[cell.contentView addSubview:imgqr];
		
		UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(100, 6, 200, 18)];
		lbl.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Category"];
		[lbl setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
		[cell.contentView addSubview:lbl];
		
		UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 550, 30)];
		lbl1.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Description"];
		[lbl1 setFont:[UIFont fontWithName:@"Arial" size:14]];
		lbl1.backgroundColor = [UIColor clearColor];
		[cell.contentView addSubview:lbl1];
		
		UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(98, 55, 500, 10)];
		//NSString *str = [[[array_catagory objectAtIndex:indexPath.row] objectForKey:@"CreatedDate"] stringByReplacingOccurrencesOfString:@"Created on" withString:@""];
		//lbl2.text =[str stringByReplacingOccurrencesOfString:@"Scanned on" withString:@""];
		
		lbl2.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"CreatedDate"];
		[lbl2 setFont:[UIFont fontWithName:@"Arial" size:10]];
		lbl2.numberOfLines = 2;
		lbl2.textColor = [UIColor grayColor];
		[cell.contentView addSubview:lbl2];
		
		
		if(selectedRow == indexPath.row)
		{
			img.image = [UIImage imageNamed:@"_0001_Layer-41-20.png"];
			lbl.backgroundColor = [UIColor clearColor];
			lbl1.backgroundColor = [UIColor clearColor];
			lbl.textColor = [UIColor whiteColor];
			lbl1.textColor = [UIColor whiteColor];
			lbl2.backgroundColor = [UIColor clearColor];
			lbl2.textColor = [UIColor lightGrayColor];
		}
		
		
		
		return cell;
	}
	}
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	changeColor = indexPath.row;
	selectedRow = indexPath.row;

	if(tableView.tag == 1)
	{
		if(flagFromTemp == TRUE)
		{
			appDel.QRImageFromLib = [arrImg objectAtIndex:changeColor];
			[self dismissModalViewControllerAnimated:YES];
		}
		else
		{
						
			//[tblView_Lib reloadData];
			
			[self MainDescription];
			
			detail_obj = [[LibraryDetailViewController alloc]initWithNibName:@"LibraryDetailViewController" bundle:nil];
			[detail_obj initWithImage:[arrImg objectAtIndex:changeColor] text:[[array_catagory objectAtIndex:changeColor] objectForKey:@"CreatedDate"] topText:[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] string:strattr index:height ImageName:[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"]];
			
			
			[self.navigationController pushViewController:detail_obj animated:TRUE];
			
			//[tableView deselectRowAtIndexPath:indexPath.row animated:TRUE];
			//[detail_obj release];
		}
	}
	else 
	{
		y_pos = 0;
		selectedindex=indexPath;
		[selectedindex retain];
		[self Newsetselected:indexPath];
	}
	//[tableView deselectRowAtIndexPath:indexPath animated:TRUE];

}	

-(void)MainDescription
{
    
	catDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"];
	
	if([catDes.text isEqualToString:@"Event"])
	{
		NSString* str=@"";
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Event:%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"starting_Date"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Start Date & Time: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"starting_Date"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Ending_Date"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"End Date & Time: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Ending_Date"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Address: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Notes"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Notes: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Notes"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Event:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"starting_Date"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Start Date & Time:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Ending_Date"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"End Date & Time:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Address:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Notes"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Notes:"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
	}
	
	else if([catDes.text isEqualToString:@"Map Location"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Location: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Notes: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Location:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Notes:"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
	}
	
	else if([catDes.text isEqualToString:@"Phone"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phone Number:%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Phone Number:"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
	}
	
	else if([catDes.text isEqualToString:@"SMS"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Mobile Number: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Message: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Mobile Number:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Message:"]];
		}
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
	}
	
	else if([catDes.text isEqualToString:@"Contact"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Name:%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
            
            NSLog(@"description Text=========:%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]);
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phone Number: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Prefix"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Prefix: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Prefix"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phonetic First Name: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_LastName"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phonetic Last Name: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_LastName"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Middle_Name"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Middle: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Middle_Name"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Suffix"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Suffix: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Suffix"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Job Title: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Department: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Name:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Phone Number:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Prefix"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Prefix:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Phonetic First Name:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_LastName"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Phonetic Last Name:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Middle_Name"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Middle:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Suffix"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Suffix:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Job Title:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Department:"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
	}
	
	else if([catDes.text isEqualToString:@"URL"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"URL: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"URL:"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
				
	}
	else if([catDes.text isEqualToString:@"Text"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Text: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Text:"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
	}
	else if([catDes.text isEqualToString:@"Email"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"From: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Subject"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Subject: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Subject"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Message: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"From:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Subject"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Subject:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Message:"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
	}
	else if([catDes.text isEqualToString:@"BusinessCard"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Company Name: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Name: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Job Title: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Email"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Email"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Email: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Email"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phone Number: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Address: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Company Name:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] isEqualToString:@"(null)"])
		{
			if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] isEqualToString:@"(null)"])
			{
				[strattr setTextBold:YES range:[str rangeOfString:@"\n\nName:"]];
			}
			else 
			{
				[strattr setTextBold:YES range:[str rangeOfString:@"Name:"]];
			}
			
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Job Title:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Email"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Email"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Email:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Phone Number:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Address:"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
	}
	else if ([catDes.text isEqualToString:@"Invitation"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Title: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Address: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		strattr= [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Title:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0  && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Address:"]];
		}
			
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
	}
	else if ([catDes.text isEqualToString:@"IDBadge"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Company/Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Name: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Job Title: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Company/Event:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Name:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Job Title:"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
	}
	else if ([catDes.text isEqualToString:@"CourseInfo"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Course Name: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Course Code: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] isEqualToString:@"(null)"] )
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Professor: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] isEqualToString:@"(null)"])
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Date and Time: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		strattr = [NSMutableAttributedString attributedStringWithString:str];
		[strattr setTextColor:[UIColor blackColor]];
		[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Course Name:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Course Code:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Professor:"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] length] > 0 && ![[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] isEqualToString:@"(null)"])
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Date and Time:"]];
		}
	
		
		CGSize maximumLabelSize1 = CGSizeMake(280,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
				
	}
	
	
}

-(void)actbutmethod
{
    NSLog(@"into actbutmethos");
    
    if (([catDes.text isEqualToString:@"Contact"] && flagcon)||([catDes.text isEqualToString:@"Phone"] && flagphon))
    
    
    {
        //actbutton.imageView.image=[UIImage imageNamed:@"inactivecontact.png"];
        [actbutton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState: UIControlStateNormal];
        [actbutton setEnabled:NO];
        
        
        NSLog(@"adding contact and phone");
        flagcon=NO;
        flagphon=NO;
        
        ABAddressBookRef addressBook = ABAddressBookCreate();
        ABRecordRef person = ABPersonCreate();
        
        if([catDes.text isEqualToString:@"Contact"])
        ABRecordSetValue(person, kABPersonFirstNameProperty, [[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] , nil);
       
        
        ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABPersonPhoneProperty);
       
        
        if([catDes.text isEqualToString:@"Contact"])
        ABMultiValueAddValueAndLabel(phoneNumberMultiValue, [[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"], kABHomeLabel, nil);
      
       
        
        if([catDes.text isEqualToString:@"Phone"])
            ABMultiValueAddValueAndLabel(phoneNumberMultiValue,[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] , kABHomeLabel, nil);
        
         ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
        
        
        //ABMutableMultiValueRef emailMultiValue = ABMultiValueCreateMutable(kABPersonEmailProperty);
        // ABMultiValueAddValueAndLabel(emailMultiValue, @"whatever@gmail.com", kABWorkLabel, nil);
        // ABRecordSetValue(person, kABPersonEmailProperty, emailMultiValue, nil);
        
        // NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects:@"1234 Whatever Street", @"Hyderabad", @"AP", @"INDIA", @"500008", nil] forKeys: [NSArray arrayWithObjects: (NSString *)kABPersonAddressStreetKey, (NSString *)kABPersonAddressCityKey, (NSString *)kABPersonAddressStateKey, (NSString *)kABPersonAddressCountryKey, (NSString *)kABPersonAddressZIPKey, nil]];
        // ABMultiValueRef addressMultiValue = ABMultiValueCreateMutable(kABDictionaryPropertyType);
        // ABMultiValueAddValueAndLabel(addressMultiValue, (CFDictionaryRef *)dictionary, kABWorkLabel, nil);
        //  ABRecordSetValue(person, kABPersonAddressProperty, addressMultiValue, nil); ABRecordCopyValue(person, kABPersonAddressProperty);
        
        ABAddressBookAddRecord(addressBook, person, nil);
        ABAddressBookSave(addressBook, nil);
        
        CFRelease(person);
        //  CFRelease(addressMultiValue);
        CFRelease(phoneNumberMultiValue);
        // CFRelease(emailMultiValue);
        //  [dictionary release];
        
        
        
        UIAlertView *alertviewcon=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Contact Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertviewcon show];
        [alertviewcon release];

        
    }
    
    
    
    if([catDes.text isEqualToString:@"Event"])
    {
        if(flageven)
        {
            
           // actbutton.imageView.image=[UIImage imageNamed:@"inactivecalender.png"];
            
             [actbutton setImage:[UIImage imageNamed:@"inactivecalender.png"] forState: UIControlStateNormal];
            [actbutton setEnabled:NO];
            
            NSLog(@"events");
            flageven=NO;
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            
            EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
            NSString *evntname=[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
            
            evntname=[evntname stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            
            event.title=evntname;
            
            NSString *stdate=[[array_catagory objectAtIndex:changeColor] objectForKey:@"starting_Date"];
            
            stdate=[stdate substringFromIndex:4];
            
            NSString *endate=[[array_catagory objectAtIndex:changeColor] objectForKey:@"Ending_Date"];
            
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
            // event.notes=tmpst;
        
            if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0)
            {
                event.location= [[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"];        
            }
            
            if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Notes"] length] > 0)
            {
                event.notes=[[array_catagory objectAtIndex:changeColor] objectForKey:@"Notes"];
            }
            
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
            }
            
        }
        else {
          /*  UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert!" 
                                                              message:@"iCloud services are not enabled on this device, so Event can't be added!" 
                                                             delegate:nil 
                                                    cancelButtonTitle:@"OK" 
                                                    otherButtonTitles:nil];
            
            [message show];
            [message release];*/
            [actbutton setImage:[UIImage imageNamed:@"inactivecalender.png"] forState: UIControlStateNormal];
            [actbutton setEnabled:NO];
        }
        
    }
    
    
    
    
    
    

    
    
}



-(void)Newsetselected:(NSIndexPath *)indexpath
{
	
	[self.view addSubview:scrollAll];
	NSLog(@"selected index row:%d",indexpath.row);
	//NSLog(@"selected row qr code:%@",[[array_catagory objectAtIndex:indexpath.row] objectForKey:@"Image"]);
	
	
	changeColor = indexpath.row;
	selectedRow = indexpath.row;
	[selectedindexes addObject:[NSNumber numberWithInt:selectedRow]];
	
	/*
	UITableViewCell *cell = [table cellForRowAtIndexPath:indexpath];
	UIImageView *imgBg = [[UIImageView alloc]init];
	UILabel *lblHeading = [[UILabel alloc]init];
	UILabel *lblHeading1 = [[UILabel alloc]init];
	
	lblHeading.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"];
	lblHeading1.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
	[lblHeading setFont:[UIFont fontWithName:@"Arial-Bold" size:18]];
	lblHeading.textAlignment = UITextAlignmentLeft;
	//lblHeading.textColor = [UIColor whiteColor];
	lblHeading1.backgroundColor = [UIColor clearColor];
	lblHeading.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:imgBg];
	[cell.contentView addSubview:lblHeading];	
	[cell.contentView addSubview:lblHeading1];
	*/
	[table reloadData];
	
	
	
	lblmainDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
	createdDate.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"CreatedDate"];
	qrImageview.image = [arrImg objectAtIndex:changeColor];
	
	catDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"];
	NSLog(@"catDes text:%@",catDes.text);
    
    if([catDes.text isEqualToString:@"Event"])
	{
        lblcalendarnote.hidden=NO;
    }
    else
    {
        lblcalendarnote.hidden=YES;
        
    }
    
    
	if([catDes.text isEqualToString:@"Event"])
	{
		NSString* str=@"";
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Event :%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"starting_Date"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Start Date & Time : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"starting_Date"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Ending_Date"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"End Date & Time : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Ending_Date"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Address : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Notes"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Notes : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Notes"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
        
        if([catDes.text isEqualToString:@"Event"])
        {
        if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0 && [[[array_catagory objectAtIndex:changeColor] objectForKey:@"starting_Date"] length] > 0 && [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Ending_Date"] length] > 0)
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
                                                              [eventsDict setObject:event forKey:event.eventIdentifier];
                                                              flagicloud=YES;
                                                          }
                                                          else {
                                                              NSLog(@"no event dictonary");
                                                              flageven=NO;
                                                              flagicloud=NO;
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
                    NSString* temsavdes=[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
                    temsavdes=[temsavdes stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                    if([[evn.title stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] isEqualToString:temsavdes])
                    {
                        flageven=NO;
                    }
                }
                
            }
            NSLog(@"is events:"); 
            NSLog(flageven ? @"Yes" : @"No");

            
            
            
            if (flageven)
            {
               
                flageven=YES;
               // actbutton.imageView.image=[UIImage imageNamed:@"calenderactive.png"];
                 [actbutton setImage:[UIImage imageNamed:@"calenderactive.png"] forState: UIControlStateNormal];
                [actbutton setEnabled:YES];
                
            }
        else {
            flageven=NO;
           // actbutton.imageView.image=[UIImage imageNamed:@"inactivecalender.png"];
             [actbutton setImage:[UIImage imageNamed:@"inactivecalender.png"] forState: UIControlStateNormal];
            [actbutton setEnabled:NO];
        }
        }
        else {
            flageven=NO;
            [actbutton setImage:[UIImage imageNamed:@"inactivecalender.png"] forState: UIControlStateNormal];
            [actbutton setEnabled:NO];
        }
            
            

            
        }
                
        
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Event :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"starting_Date"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Start Date & Time :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Ending_Date"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"End Date & Time :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Address :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Notes"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Notes :"]];
		}
		[attrStr1 setTextColor:[UIColor blackColor]];
		height;
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		//Event_pos = [attrStr1 length];
		
		txtDisplay.attributedText=attrStr1;
        [txtDisplay setLinkColor:[UIColor blackColor]];
        [txtDisplay setTextColor:[UIColor blackColor]];
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		scrollAll.contentSize = CGSizeMake(0, y_pos+150);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        
        actbutton.hidden=NO;
        actbutton.frame=CGRectMake(10, 142+height, 130, 70);
        lblcalendarnote.frame=CGRectMake(10,210+height+5,450,100);
        [scrollAll bringSubviewToFront:actbutton];
	}
	
	else if([catDes.text isEqualToString:@"Map Location"] || [catDes.text isEqualToString:@"Map Location "])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Location : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Notes : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Location :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Notes :"]];
		}
		
         
		height;
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		//Event_pos = [attrStr1 length];
		
		txtDisplay.attributedText=attrStr1;
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		[txtDisplay setLinkColor:[UIColor blueColor]];
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        
        
        actbutton.hidden=YES;
		
	}
	
	else if([catDes.text isEqualToString:@"Phone"])
	{
        //##
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phone Number : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		//[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
        [attrStr1 setTextColor:[UIColor blueColor] range:[str rangeOfString:[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Phone Number :"]];
            
            
            
            ABAddressBookRef addressBook = ABAddressBookCreate();
            
            
            CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
            CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
            
            int addpho1=1;
            NSString *searchString = nil;
            
            for ( int i = 0; i < nPeople; i++ )
            {
                ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
                ABMultiValueRef phonnumb = (ABMultiValueRef) ABRecordCopyValue(ref,kABPersonPhoneProperty);
                
                
                for (CFIndex i = 0; i < ABMultiValueGetCount(phonnumb); i++) 
                {
                    searchString = (NSString *)ABMultiValueCopyValueAtIndex(phonnumb, i);
                    if([searchString isEqualToString:[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]])
                        addpho1=0;
                    
                }
                
                

            }
            
            if(addpho1)
            {
                flagphon=YES;
               // actbutton.imageView.image=[UIImage imageNamed:@"activecontact.png"];
                [actbutton setImage:[UIImage imageNamed:@"activecontact.png"] forState: UIControlStateNormal];
                [actbutton setEnabled:YES];
            }
            else {
                flagphon=NO;
              //   actbutton.imageView.image=[UIImage imageNamed:@"inactivecontact.png"];
                [actbutton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState: UIControlStateNormal];
                [actbutton setEnabled:NO];
            }
            
            
            
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		//Event_pos = [attrStr1 length];
		
		txtDisplay.attributedText=attrStr1;
    
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		 [txtDisplay setLinkColor:[UIColor blueColor]];
        
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        
        actbutton.hidden=NO;
        actbutton.frame=CGRectMake(10, 142+height, 130, 70);
        [scrollAll bringSubviewToFront:actbutton]; 
           
        
		
	}
	else if([catDes.text isEqualToString:@"SMS"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Mobile Number : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Message : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		//[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Mobile Number :"]];
           [attrStr1 setTextColor:[UIColor blueColor] range:[str rangeOfString:[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Message :"]];
		}
		
	
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		txtDisplay.attributedText=attrStr1;
        [txtDisplay setLinkColor:[UIColor blueColor]];
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);

		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        actbutton.hidden=YES;
		
	}
	
	else if([catDes.text isEqualToString:@"Contact"])
	{
		NSString* str=@"";	
               
        NSLog(@"array category::::::::::::::::::%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]);
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Name : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
           
            
            
            if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0 && [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
            {
                int addcon=1;
                
                //  NSString *newString=[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
                // NSString *newString1=[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"];
                ABAddressBookRef addressBook = ABAddressBookCreate();
                
                
                CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
                CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
                
                
                for ( int i = 0; i < nPeople; i++ )
                {
                    ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
                    NSString *firstName = (NSString *)ABRecordCopyValue(ref, kABPersonFirstNameProperty);
                    NSLog(@"Name %@", firstName);
                    NSLog(@"%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]);
                    if([firstName isEqualToString: [[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]])
                    {
                        addcon=0; 
                        
                    }
                    
                    
                }
                
                if(addcon) 
                {
                    
                    
                 //   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save to Contacts?" message:@"Do you want to add the following contact to Contact book" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                 //   alert.tag=101;
                  //  [alert show];
                  //  [alert release];
                    flagcon=YES;
                   // actbutton.imageView.image=[UIImage imageNamed:@"activecontact.png"];
                    [actbutton setImage:[UIImage imageNamed:@"activecontact.png"] forState: UIControlStateNormal];
                    [actbutton setEnabled:YES];
                    
                    
                }
                else {
                    flagcon=NO;
                    // actbutton.imageView.image=[UIImage imageNamed:@"inactivecontact.png"];
                    [actbutton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState: UIControlStateNormal];
                    [actbutton setEnabled:NO];
                }
                
            }
}
        
        
        
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0)
		{
            
            
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phone Number : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
            
                      
		}
        else {
            flagcon=NO;
            // actbutton.imageView.image=[UIImage imageNamed:@"inactivecontact.png"];
            [actbutton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState: UIControlStateNormal];
            [actbutton setEnabled:NO];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!"
                                                           message:@"Phone Number missing! Contact can't be saved to Phone Book!" 
                                                          delegate:self 
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil];
            alert.tag=151;
            [alert show];
            [alert release];
            
        }
        
                
        
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Prefix"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Prefix : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Prefix"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phonetic First Name : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_LastName"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phonetic Last Name : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_LastName"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Middle_Name"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Middle : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Middle_Name"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Suffix"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Suffix : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Suffix"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Job Title : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Department : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
        NSMutableAttributedString* attrStr1 ;
         NSString *finstrcon=@"";
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0)
		{
            

        
        NSString *condispho;
       
        int leftchar;
        condispho=[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"];
           if ([condispho rangeOfString:@"("].location == NSNotFound) {
                NSLog(@"string does not contain bla");
                
                if([condispho length]>=3)
                {
                    finstrcon=[@"(" stringByAppendingString:finstrcon];
                    
                    for(int i=0;i<3;i++)
                    {
                        finstrcon=[finstrcon stringByAppendingFormat:@"%c",[condispho characterAtIndex:i]];
                    }
                    finstrcon=[finstrcon stringByAppendingString:@") "];
                    leftchar=[condispho length]-3;
                }
                
                if(leftchar<=3)
                {
                    for(int i=3;i<[condispho length];i++)
                        finstrcon=[finstrcon stringByAppendingFormat:@"%c",[condispho characterAtIndex:i]];
                    leftchar=0;
                }
                else {
                    for(int i=3;i<6;i++)
                        finstrcon=[finstrcon stringByAppendingFormat:@"%c",[condispho characterAtIndex:i]];
                    
                    
                    leftchar=leftchar-3;
                }
                if(leftchar>0 && [condispho length]>7)
                {
                    finstrcon=[finstrcon stringByAppendingString:@"-"];
                    for(int i=6;i<[condispho length];i++)
                        finstrcon=[finstrcon stringByAppendingFormat:@"%c",[condispho characterAtIndex:i]];
                }

                
                
                
                
            } else 
            {
                finstrcon=condispho;
            }
            
       
        
        
        
        str=[str stringByReplacingOccurrencesOfString:[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] withString:finstrcon];
        
		 attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		}
        else {
            
           
            
            attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
            [attrStr1 setTextColor:[UIColor blackColor]];
            [attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];

            
        }
        
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Name :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0)
		{
            
            	[attrStr1 setTextBold:YES range:[str rangeOfString:@"Phone Number :"]];
           [attrStr1 setTextColor:[UIColor blueColor] range:[str rangeOfString:finstrcon]];
                
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Prefix"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Prefix :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Phonetic First Name :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_LastName"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Phonetic Last Name :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Middle_Name"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Middle :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Suffix"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Suffix :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Job Title :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Department :"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		txtDisplay.attributedText=attrStr1;
        
        
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		scrollAll.contentSize = CGSizeMake(0, y_pos+70);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        
        
        actbutton.hidden=NO;
        actbutton.frame=CGRectMake(10, 140+height, 130, 70);
        [scrollAll bringSubviewToFront:actbutton];
        
	}
	
	else if([catDes.text isEqualToString:@"URL"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"URL : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"URL :"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		txtDisplay.attributedText=attrStr1;
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        actbutton.hidden=YES;
        [self.view bringSubviewToFront:scrollAll];
		
	}
	else if([catDes.text isEqualToString:@"Text"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Text : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Text :"]];
		}
		
		height;
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		txtDisplay.attributedText=attrStr1;
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        actbutton.hidden=YES;
		
	}
	else if([catDes.text isEqualToString:@"Email"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"From : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Subject"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Subject : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Subject"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			//str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event: %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Message : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"From :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Subject"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Subject :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Message :"]];
		}
		height;
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		txtDisplay.attributedText=attrStr1;
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        actbutton.hidden=YES;
		
	}
	else if([catDes.text isEqualToString:@"BusinessCard"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Company Name : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Name : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Job Title : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Email"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Email : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Email"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Phone : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Address : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		//[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Company Name :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0)
		{
			if ([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
			{
				[attrStr1 setTextBold:YES range:[str rangeOfString:@"\n\nName :"]];
			}
			else 
			{
				[attrStr1 setTextBold:YES range:[str rangeOfString:@"Name :"]];
			}

		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Job Title :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Email"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Email :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Phone :"]];
            [attrStr1 setTextColor:[UIColor blueColor] range:[str rangeOfString:[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"]]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Address :"]];
		}
		
	
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		txtDisplay.attributedText=attrStr1;
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
        [txtDisplay setLinkColor:[UIColor blueColor]];
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        actbutton.hidden=YES;
		
	}
	else if ([catDes.text isEqualToString:@"Invitation"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Title : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Address : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Title :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Address :"]];
		}
		height;
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		txtDisplay.attributedText=attrStr1;
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        actbutton.hidden=YES;
		
	}
	else if ([catDes.text isEqualToString:@"IDBadge"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Company/Event : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Name : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Job Title : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Company/Event :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Name :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Job Title :"]];
		}
		height;
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		txtDisplay.attributedText=attrStr1;
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
        actbutton.hidden=YES;
		
	}
	else if ([catDes.text isEqualToString:@"CourseInfo"])
	{
		NSString* str=@"";	
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Course Name : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Course Code : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Professor : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Date and Time : %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"]]];
			str = [str stringByAppendingFormat:@"\n\n"];
		}
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Course Name :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Course Code :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Professor :"]];
		}
		if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"] length] > 0)
		{
			[attrStr1 setTextBold:YES range:[str rangeOfString:@"Date and Time :"]];
		}
		
		 attrStr1.textColor = [UIColor blackColor];
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
		height = expectedLabelSize1.height;
		
		txtDisplay.attributedText=attrStr1;
		txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
		
		y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		
		actbutton.hidden=YES;
	}
	
		
}


/*
-(void)setselectedFirstRow:(NSIndexPath *)indexpath
{
	[self.view addSubview:scrollAll];
	NSLog(@"selected index row:%d",indexpath.row);
	//NSLog(@"selected row qr code:%@",[[array_catagory objectAtIndex:indexpath.row] objectForKey:@"Image"]);
	
	
	changeColor = indexpath.row;
	selectedRow = indexpath.row;
	[selectedindexes addObject:[NSNumber numberWithInt:selectedRow]];
	
	UITableViewCell *cell = [table cellForRowAtIndexPath:indexpath];
	UIImageView *imgBg = [[UIImageView alloc]init];
	UILabel *lblHeading = [[UILabel alloc]init];
	UILabel *lblHeading1 = [[UILabel alloc]init];
	
	lblmainDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
	catDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"];
	
	if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
	{
		int width;
		if([catDes.text isEqualToString:@"BusinessCard"] || [catDes.text isEqualToString:@"Invitation"] || [catDes.text isEqualToString:@"CourseInfo"] || [catDes.text isEqualToString:@"IDBadge"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			CGSize expectedLabelSize1 = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Locations"] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=20;
		}
		else if([catDes.text isEqualToString:@"Event"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Event Title :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Map Location"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Location :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"SMS"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Mobile Number :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Email"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"From :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Contact"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Name :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Phone"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Phone Number :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else 
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			CGSize expectedLabelSize1 = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
		
			width+=20;
		}
		
		lblEvent.frame = CGRectMake(6, 130, width, 40);
		lblmainDes.frame = CGRectMake(lblEvent.frame.size.width+5, 139, 400, 40);
		
		CGSize maximumLabelSize = CGSizeMake(400,9999);
		
		CGSize expectedLabelSize = [lblmainDes.text sizeWithFont:lblmainDes.font constrainedToSize:maximumLabelSize lineBreakMode:lblmainDes.lineBreakMode];
		
		CGRect newFrame = lblmainDes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lblmainDes.frame = newFrame;
		
		
		
		imgBg.frame = CGRectMake(0,0,360,83);
		imgBg.image = [UIImage imageNamed:@"_0001_seperation-lines-set1-20.png"];
		lblHeading.frame = CGRectMake(100, 3, 200, 30);	
		lblHeading1.frame = CGRectMake(100, 30, 340, 40);
		DepartmentDescription.frame = CGRectMake(125, 535, 400, 30);
		lblSubjectDescription.frame = CGRectMake(95,180,400,30);
		lblBussAddressDes.frame = CGRectMake(100, 385, 400, 30);
		lblMapNotesDescription.frame = CGRectMake(80, 180, 400, 30);
		mainAddress.frame = CGRectMake(6, 284, 350, 30);
	}
	else 
	{
		DepartmentDescription.frame = CGRectMake(125, 530, 400, 30);
		lblSubjectDescription.frame = CGRectMake(95,180,500,30);
		lblBussAddressDes.frame = CGRectMake(100, 385, 400, 30);
		lblMapNotesDescription.frame = CGRectMake(80, 180, 400, 30);
		mainAddress.frame = CGRectMake(6, 284, 350, 30);
		
		//int width = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] length]*10;
//		width+=20;
//		mainDes.frame = CGRectMake(width+60, 650, 500, 40);
//		lblEvent.frame = CGRectMake(6, 130, width+10, 40);
//		lblmainDes.frame = CGRectMake(width+8, 139, 500, 40);
//		 
		
		
		int width;
		if([catDes.text isEqualToString:@"BusinessCard"] || [catDes.text isEqualToString:@"Invitation"] || [catDes.text isEqualToString:@"CourseInfo"] || [catDes.text isEqualToString:@"IDBadge"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			CGSize expectedLabelSize1 = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Locations"] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=20;
		}
		
		else if([catDes.text isEqualToString:@"Event"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Event Title :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Map Location"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Location :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"SMS"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Mobile Number :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Email"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"From :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Contact"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Name :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Phone"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Phone Number :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else 
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			CGSize expectedLabelSize1 = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=20;
		}

		lblEvent.frame = CGRectMake(6, 130, width, 40);
		lblmainDes.frame = CGRectMake(lblEvent.frame.size.width+5, 139, 500, 40);
		
		CGSize maximumLabelSize = CGSizeMake(500,9999);
		CGSize expectedLabelSize = [lblmainDes.text sizeWithFont:lblmainDes.font constrainedToSize:maximumLabelSize lineBreakMode:lblmainDes.lineBreakMode];
		CGRect newFrame = lblmainDes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lblmainDes.frame = newFrame;
		lblmainDes.numberOfLines = 0;
		imgBg.frame = CGRectMake(0,0,654,69);
		imgBg.image = [UIImage imageNamed:@"_0001_Layer-41-20.png"];
		lblHeading.frame = CGRectMake(10, 0, 200, 30);
		lblHeading1.frame = CGRectMake(10, 30, 600, 30);
	}
	
	lblHeading.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"];
	lblHeading1.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
	[lblHeading setFont:[UIFont fontWithName:@"Arial-Bold" size:18]];
	lblHeading.textAlignment = UITextAlignmentLeft;
	//lblHeading.textColor = [UIColor whiteColor];
	lblHeading1.backgroundColor = [UIColor clearColor];
	lblHeading.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:imgBg];
	[cell.contentView addSubview:lblHeading];	
	[cell.contentView addSubview:lblHeading1];
	
	[table reloadData];
	
	
	createdDate.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"CreatedDate"];
	
	mainDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
	//whitelayerlabel.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"];
	
	NSLog(@"mainDes == %@",lblmainDes.text);
	
	
	if([catDes.text isEqualToString:@"Event"])
	{
		
		
		lblmainDes.textColor = [UIColor blackColor];
		
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		
		lblEvent.hidden = FALSE;
		lblstartTime.hidden = FALSE;
		lblEndTime.hidden = FALSE;
		lblAddress.hidden = FALSE;
		lblNotes.hidden = FALSE;
		lblNotesDescription.hidden = FALSE;
		
		startDate.hidden = FALSE;
		endDate.hidden = FALSE;
		mainAddress.hidden = FALSE;
		
		
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		
		lblEvent.text = @"Event Title :";
		
		endDate.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Ending_Date"];
		startDate.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"starting_Date"];
			
		mainAddress.text = [NSString stringWithFormat:@"                  %@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"]];
		
		CGSize maximumLabelSize2 = CGSizeMake(350,9999);
		CGSize expectedLabelSize2 = [mainAddress.text sizeWithFont:mainAddress.font constrainedToSize:maximumLabelSize2 lineBreakMode:mainAddress.lineBreakMode];
		CGRect newFrame2 = mainAddress.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		mainAddress.frame = newFrame2;
		
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		pos = mainAddress.frame.origin.y + mainAddress.frame.size.height + 10;
		lblNotes.frame = CGRectMake(6,pos,70,30);
		lblNotesDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Notes"];
		
		lblNotesDescription.frame = CGRectMake(80,pos,400,30);
		CGSize maximumLabelSize5 = CGSizeMake(400,9999);
		CGSize expectedLabelSize5 = [lblNotesDescription.text sizeWithFont:lblNotesDescription.font constrainedToSize:maximumLabelSize5 lineBreakMode:lblNotesDescription.lineBreakMode];
		CGRect newFrame5 = lblNotesDescription.frame;
		newFrame5.size.height = expectedLabelSize5.height+9;
		lblNotesDescription.frame = newFrame5;
		
		y_pos = lblNotesDescription.frame.origin.y + lblNotesDescription.frame.size.height;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];

	}
	
	else if([catDes.text isEqualToString:@"Map Location"])
	{
		//scrollAll.scrollsToTop =TRUE;
		
		lblmainDes.textColor = [UIColor blueColor];

		
		
		
	//	[scrollAll scrollsToTop];		
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		
		
		lblEvent.hidden = FALSE;
		lblstartTime.hidden = TRUE;
		lblEndTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		lblMapNotes.hidden = FALSE;
		lblMapNotesDescription.hidden = FALSE;
		
		//lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] ];
		lblEvent.text = @"Location :";
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		lblMapNotesDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"];
		
		if([lblMapNotesDescription.text length]>0)
		{
			CGSize maximumLabelSize4 = CGSizeMake(400,9999);
			CGSize expectedLabelSize4 = [lblMapNotesDescription.text sizeWithFont:lblMapNotesDescription.font constrainedToSize:maximumLabelSize4 lineBreakMode:lblMapNotesDescription.lineBreakMode];
			CGRect newFrame4 = lblMapNotesDescription.frame;
			newFrame4.size.height = expectedLabelSize4.height +8;
			lblMapNotesDescription.frame = newFrame4;
		}
		y_pos = lblMapNotesDescription.frame.origin.y + lblMapNotesDescription.frame.size.height;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
	  }
	
	else if([catDes.text isEqualToString:@"Phone"])
	{
		lblmainDes.textColor = [UIColor blackColor];
		
		//	[scrollAll scrollsToTop];		
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		
		lblEvent.hidden = FALSE;
		lblstartTime.hidden = TRUE;
		lblEndTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		
		//lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] ];
		lblEvent.text = @"Phone Number :";
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		y_pos = lblmainDes.frame.origin.y + lblmainDes.frame.size.height;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		
	}
	
	else if([catDes.text isEqualToString:@"SMS"])
	{
		lblmainDes.textColor = [UIColor blackColor];
		
		//	[scrollAll scrollsToTop];		
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		
		lblEvent.hidden = FALSE;
		lblstartTime.hidden = TRUE;
		lblEndTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = FALSE;
		lblSubjectDescription.hidden = FALSE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		
		lblSubject.text = @"Message :";
	//	[lblSubject setFont:[UIFont fontWithName:@"Helvetica" size:18]];
		//lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] ];
		lblEvent.text = @"Mobile Number :";
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		lblSubjectDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"];
		
		CGSize maximumLabelSize4 = CGSizeMake(500,9999);
		CGSize expectedLabelSize4 = [lblSubjectDescription.text sizeWithFont:lblSubjectDescription.font constrainedToSize:maximumLabelSize4 lineBreakMode:lblSubjectDescription.lineBreakMode];
		CGRect newFrame4 = lblSubjectDescription.frame;
		newFrame4.size.height = expectedLabelSize4.height+8;
		lblSubjectDescription.frame = newFrame4;
		
		y_pos = lblSubjectDescription.frame.origin.y + lblSubjectDescription.frame.size.height;
		scrollAll.contentSize = CGSizeMake(0, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		
		
	}
	else if([catDes.text isEqualToString:@"Contact"])
	{
		lblmainDes.textColor = [UIColor blackColor];
		
		lblEvent.hidden = FALSE;
		lblstartTime.hidden = TRUE;
		lblEndTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		
		lblPhoneNo.hidden = FALSE;
		Prefix.hidden = FALSE;
		FirstName.hidden = FALSE;
		LastName.hidden = FALSE;
		MiddleName.hidden = FALSE;
		Suffix.hidden = FALSE;
		job.hidden = FALSE;
		Department.hidden = FALSE;
		
		lblPhoneNoDescription.hidden = FALSE;
		prefixDescription.hidden = FALSE;
		FirstNameDescription.hidden = FALSE;
		LastNameDescription.hidden = FALSE;
		MiddleNameDescription.hidden =FALSE;
		SuffixDescription.hidden = FALSE;
		jobDescription.hidden = FALSE;
		DepartmentDescription.hidden = FALSE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		
		//lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] ];
		lblEvent.text = @"Name :";
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		lblPhoneNoDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"];
		prefixDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Prefix"];
		FirstNameDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"];
		LastNameDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_LastName"];
		MiddleNameDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Middle_Name"];
		SuffixDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Suffix"];
		jobDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"];
		DepartmentDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"];
		
		CGSize maximumLabelSize6 = CGSizeMake(400,9999);
		CGSize expectedLabelSize6 = [DepartmentDescription.text sizeWithFont:DepartmentDescription.font constrainedToSize:maximumLabelSize6 lineBreakMode:DepartmentDescription.lineBreakMode];
		CGRect newFrame6 = DepartmentDescription.frame;
		newFrame6.size.height = expectedLabelSize6.height+8;
		DepartmentDescription.frame = newFrame6;
		
		y_pos = DepartmentDescription.frame.origin.y + DepartmentDescription.frame.size.height + 50;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
	
	}
	else if([catDes.text isEqualToString:@"URL"])
	{
		
		lblmainDes.textColor = [UIColor blueColor];
		
		lblEndTime.hidden = TRUE;
		lblstartTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblEvent.hidden = FALSE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] ];
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		y_pos = lblmainDes.frame.origin.y + lblmainDes.frame.size.height + 50;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
	}
	
	else if([catDes.text isEqualToString:@"Text"])
	{
		lblmainDes.textColor = [UIColor blackColor];
		
		lblEndTime.hidden = TRUE;
		lblstartTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblEvent.hidden = FALSE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] ];
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		y_pos = lblmainDes.frame.origin.y + lblmainDes.frame.size.height + 50;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		
		
	}
	
	else if([catDes.text isEqualToString:@"Email"])
	{
		
		lblmainDes.textColor = [UIColor blackColor];
		
		lblEndTime.hidden = TRUE;
		lblstartTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblEvent.hidden = FALSE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = FALSE;
		lblSubjectDescription.hidden = FALSE;
		
		Message.hidden = FALSE;
		MessageDescription.hidden = FALSE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		lblSubject.text = @"Subject :";
		//lblSubject.backgroundColor=[UIColor yellowColor];
		//lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] ];
		lblEvent.text = @"From :";
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		lblSubjectDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Subject"];
		lblSubjectDescription.frame = CGRectMake(95,180,400,30);
		CGSize maximumLabelSize4 = CGSizeMake(400,9999);
		CGSize expectedLabelSize4 = [lblSubjectDescription.text sizeWithFont:lblSubjectDescription.font constrainedToSize:maximumLabelSize4 lineBreakMode:lblSubjectDescription.lineBreakMode];
		CGRect newFrame4 = lblSubjectDescription.frame;
		newFrame4.size.height = expectedLabelSize4.height + 8;
		lblSubjectDescription.frame = newFrame4;
		//lblSubjectDescription.backgroundColor=[UIColor redColor];
		
		MessageDescription.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"];
		MessageDescription.frame = CGRectMake(100,230,500,30);
		CGSize maximumLabelSize1 = CGSizeMake(500,9999);
		CGSize expectedLabelSize1 = [MessageDescription.text sizeWithFont:MessageDescription.font constrainedToSize:maximumLabelSize1 lineBreakMode:MessageDescription.lineBreakMode];
		CGRect newFrame1 = MessageDescription.frame;
		newFrame1.size.height = expectedLabelSize1.height + 8;
		MessageDescription.frame = newFrame1;
		
		y_pos = MessageDescription.frame.origin.y + MessageDescription.frame.size.height + 50;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		
	}
	
	else if([catDes.text isEqualToString:@"BusinessCard"])
	{
		
		lblmainDes.textColor = [UIColor blackColor];
		
		lblEndTime.hidden = TRUE;
		lblstartTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblEvent.hidden = FALSE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = FALSE;
		lblBussJob.hidden = FALSE;
		lblBussEmail.hidden = FALSE;
		lblBussPhone.hidden = FALSE;
		lblBussAddress.hidden = FALSE;
		lblBussNameDes.hidden = FALSE;
		lblBussJobDes.hidden = FALSE;
		lblBussEmailDes.hidden = FALSE;
		lblBussPhoneDes.hidden = FALSE;
		lblBussAddressDes.hidden = FALSE;
		
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		
		lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Locations"] ];
		//lblEvent.text = @"Company :";
		
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		lblBussNameDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"];
		lblBussJobDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"];
		lblBussEmailDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Email"];
		lblBussPhoneDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"];
		lblBussAddressDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"];
		
		if([lblBussAddressDes.text length]>0)
		{
			CGSize maximumLabelSize2 = CGSizeMake(400,9999);
			CGSize expectedLabelSize2 = [lblBussAddressDes.text sizeWithFont:lblBussAddressDes.font constrainedToSize:maximumLabelSize2 lineBreakMode:lblBussAddressDes.lineBreakMode];
			CGRect newFrame2 = lblBussAddressDes.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lblBussAddressDes.frame = newFrame2;
		}
		
		y_pos = lblBussAddressDes.frame.origin.y + lblBussAddressDes.frame.size.height + 50;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		
	}
	
	else if ([catDes.text isEqualToString:@"Invitation"])
	{
		
		lblmainDes.textColor = [UIColor blackColor];
		
		lblEndTime.hidden = TRUE;
		lblstartTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblEvent.hidden = FALSE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		
		lblInvitAddress.hidden = FALSE;
		lblInvitAddressDes.hidden = FALSE;
		
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Locations"] ];
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		lblInvitAddressDes.text = [NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"]];
		
		y_pos = lblInvitAddressDes.frame.origin.y + lblInvitAddressDes.frame.size.height + 50;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		
	}
	
	else if ([catDes.text isEqualToString:@"IDBadge"])
	{
		lblmainDes.textColor = [UIColor blackColor];
		
		lblEndTime.hidden = TRUE;
		lblstartTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblEvent.hidden = FALSE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = FALSE;
		lblBussJob.hidden = FALSE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = FALSE;
		lblBussJobDes.hidden = FALSE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Locations"] ];
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		lblBussNameDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Phonetic_FirstName"];
		lblBussJobDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Job"];
		
		y_pos = lblBussJobDes.frame.origin.y + lblBussJobDes.frame.size.height + 50;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		
	}
	
	else if ([catDes.text isEqualToString:@"CourseInfo"])
	{
		lblmainDes.textColor = [UIColor blackColor];
		
		lblEndTime.hidden = TRUE;
		lblstartTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblEvent.hidden = FALSE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		
		lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Locations"] ];
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		
		
		lblCourseCode.hidden = FALSE;
		lblCourseCodeDes.hidden = FALSE;
		lblCourseProff.hidden  = FALSE;
		lblCourseProffDes.hidden = FALSE;
		lblCourseTime.hidden = FALSE;
		lblCourseTimeDes.hidden = FALSE;
		
		lblCourseCodeDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Department"];
		lblCourseProffDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Message"];
		lblCourseTimeDes.text = [[array_catagory objectAtIndex:changeColor] objectForKey:@"Links"];
		
		y_pos = lblCourseTimeDes.frame.origin.y + lblCourseTimeDes.frame.size.height + 50;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
	}
	
	
	else  
	{
		
		
		lblmainDes.textColor = [UIColor blackColor];
		
		//	[scrollAll scrollsToTop];		
		lblPhoneNo.hidden = TRUE;
		Prefix.hidden = TRUE;
		FirstName.hidden = TRUE;
		LastName.hidden = TRUE;
		MiddleName.hidden = TRUE;
		Suffix.hidden = TRUE;
		job.hidden = TRUE;
		Department.hidden = TRUE;
		lblMapNotes.hidden = TRUE;
		lblMapNotesDescription.hidden = TRUE;
		
		lblEvent.hidden = FALSE;
		lblstartTime.hidden = TRUE;
		lblEndTime.hidden = TRUE;
		lblAddress.hidden = TRUE;
		lblNotes.hidden = TRUE;
		lblNotesDescription.hidden = TRUE;
		mainAddress.hidden = TRUE;
		startDate.hidden = TRUE;
		endDate.hidden = TRUE;
		
		
		lblPhoneNoDescription.hidden = TRUE;
		prefixDescription.hidden = TRUE;
		FirstNameDescription.hidden = TRUE;
		LastNameDescription.hidden = TRUE;
		MiddleNameDescription.hidden =TRUE;
		SuffixDescription.hidden = TRUE;
		jobDescription.hidden = TRUE;
		DepartmentDescription.hidden = TRUE;
		
		lblSubject.hidden = TRUE;
		lblSubjectDescription.hidden = TRUE;
		
		Message.hidden = TRUE;
		MessageDescription.hidden = TRUE;
		
		lblBussName.hidden = TRUE;
		lblBussJob.hidden = TRUE;
		lblBussEmail.hidden = TRUE;
		lblBussPhone.hidden = TRUE;
		lblBussAddress.hidden = TRUE;
		lblBussNameDes.hidden = TRUE;
		lblBussJobDes.hidden = TRUE;
		lblBussEmailDes.hidden = TRUE;
		lblBussPhoneDes.hidden = TRUE;
		lblBussAddressDes.hidden = TRUE;
		lblInvitAddress.hidden = TRUE;
		lblInvitAddressDes.hidden = TRUE;
		lblCourseCode.hidden = TRUE;
		lblCourseCodeDes.hidden = TRUE;
		lblCourseProff.hidden  = TRUE;
		lblCourseProffDes.hidden = TRUE;
		lblCourseTime.hidden = TRUE;
		lblCourseTimeDes.hidden = TRUE;
		
		
		lblEvent.text = [NSString stringWithFormat:@"%@ : ",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] ];
		qrImageview.image = [arrImg objectAtIndex:changeColor];
		
		y_pos = lblmainDes.frame.origin.y + lblmainDes.frame.size.height + 50;
		scrollAll.contentSize = CGSizeMake(400, y_pos);
		[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		
	}
	
	
		
}
 
 */

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
	
}



#pragma mark set Orientation

-(void)setFrameOrientation_Portrait
{
	txtDisplay.frame = CGRectMake(6, 130, 500, height + 10);
	
	oncePort = TRUE;
	firstTime = FALSE;
	
	table.frame = CGRectMake(34,40,670,420);
	landSeprate.hidden = TRUE;
	imgSharing.frame = CGRectMake(34, 948, 654, 56);
	imgSharing.image = [UIImage imageNamed:@"t-f_P.png"];
	portSeprate.hidden = FALSE;
	portSeprate.frame = CGRectMake(34, 496, 654, 5);
	TopImage.image = [UIImage imageNamed:@"Library---P.png"];
	whiteLayer.frame = CGRectMake(34, 38, 654, 44);
	whiteLayer.image = [UIImage imageNamed:@"Select-QR-code---P.png"];
	whitelayerlabel.frame = CGRectMake(290, 100, 200, 30);
	[whitelayerlabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
	
	TopImage.frame = CGRectMake(34, 0, 654,48);
	whitelayerlabel.frame = CGRectMake(250, 45, 200, 30);
	TopLabel.frame = CGRectMake(290, 5, 200, 30);
	
	qrImageview.frame = CGRectMake(0, 0, 100 , 100);
	
	
	//mainDes.frame = CGRectMake(125, 650, 500, 40);
	
	
	scrollAll.frame = CGRectMake(54, 520, 630, 420);
	
	//createdDate.frame = CGRectMake(180, 560, 250, 60);
	
	createdDate.frame = CGRectMake(126, 40, 250, 60);
	
	//catDes.frame = CGRectMake(180, 520, 200, 30);
	
	catDes.frame = CGRectMake(126, 0, 250, 30);
	
	btnFB.frame = CGRectMake(140, 950, 50, 50);
	btnTwit.frame = CGRectMake(270, 950, 50, 50);
	btnEmail.frame = CGRectMake(400, 950, 50, 50);
	btnTrash.frame = CGRectMake(530, 950, 50, 50);
	
	
	if([array_catagory count] == 0)
	{
		
	}
	else 
	{
	if (changeColor>[array_catagory count]-1)
	{
		NSLog(@"grate than array:");
	}
	else 
	{
		/*
		int width;
		if([catDes.text isEqualToString:@"BusinessCard"] || [catDes.text isEqualToString:@"Invitation"] || [catDes.text isEqualToString:@"CourseInfo"] || [catDes.text isEqualToString:@"IDBadge"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			CGSize expectedLabelSize1 = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Locations"] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=20;
		}
		else if([catDes.text isEqualToString:@"Event"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Event Title :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Map Location"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Location :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"SMS"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Mobile Number :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Email"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"From :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Contact"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Name :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Phone"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Phone Number :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else 
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			CGSize expectedLabelSize1 = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=20;
		}
		
		
		
		lblEvent.frame = CGRectMake(6, 130, width, 40);
		lblmainDes.frame = CGRectMake(lblEvent.frame.size.width+5, 139, 500, 40);
		
		btnUrl.frame = CGRectMake(width+8, 139, 500, 40);
		//lblEvent.frame = CGRectMake(6, 130, width+10, 40);
		int height = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length];
		lblNotes.frame = CGRectMake(6,pos, 70, 30);
		lblNotesDescription.frame = CGRectMake(80, pos,400, 30);
		 */
		}
	}
	
	/*
	
	if([lblmainDes.text length]>0)
	{
	CGSize maximumLabelSize = CGSizeMake(500,9999);
	CGSize expectedLabelSize = [lblmainDes.text sizeWithFont:lblmainDes.font constrainedToSize:maximumLabelSize lineBreakMode:lblmainDes.lineBreakMode];
	CGRect newFrame = lblmainDes.frame;
	newFrame.size.height = expectedLabelSize.height;
	lblmainDes.frame = newFrame;
	}
	
	//new frames start
	lblBussName.frame = CGRectMake(6, 180, 300, 30);
	lblBussJob.frame = CGRectMake(6, 230, 300, 30);
	lblBussEmail.frame = CGRectMake(6, 280, 300, 30);
	lblBussPhone.frame = CGRectMake(6, 330, 300, 30);
	lblBussAddress.frame = CGRectMake(6, 380, 300, 30);
	lblBussNameDes.frame = CGRectMake(75, 180, 500, 30);
	lblBussJobDes.frame = CGRectMake(100, 230, 500, 30);
	lblBussEmailDes.frame = CGRectMake(75, 280, 500, 30);
	lblBussPhoneDes.frame = CGRectMake(80, 330, 500, 30);
	lblBussAddressDes.frame = CGRectMake(100, 385, 400, 30);
	
	if([lblBussAddressDes.text length]>0)
	{
		CGSize maximumLabelSize2 = CGSizeMake(400,9999);
		CGSize expectedLabelSize2 = [lblBussAddressDes.text sizeWithFont:lblBussAddressDes.font constrainedToSize:maximumLabelSize2 lineBreakMode:lblBussAddressDes.lineBreakMode];
		CGRect newFrame2 = lblBussAddressDes.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lblBussAddressDes.frame = newFrame2;
	}
	//Invitation//
	
	lblInvitAddress.frame = CGRectMake(6, 180, 300, 30);
	
	lblInvitAddressDes.frame = CGRectMake(100, 166, 500, 60);
	
	
	//Course Info
	
	lblCourseCode.frame = CGRectMake(6, 180, 300, 30);
	lblCourseCodeDes.frame = CGRectMake(140, 180, 500, 30);
	lblCourseProff.frame = CGRectMake(6, 230, 300, 30);
	lblCourseProffDes.frame = CGRectMake(112, 230, 500, 30);
	lblCourseTime.frame = CGRectMake(6, 280, 300, 30);
	lblCourseTimeDes.frame = CGRectMake(150, 280, 500, 30);
	// new frame end
	
	

		//startDate.frame = CGRectMake(235, 700, 300, 30);
	
	startDate.frame = CGRectMake(181, 180, 300, 30);
	
	//endDate.frame = CGRectMake(225, 750, 300, 30);
	
	endDate.frame = CGRectMake(171, 230, 300, 30);
	
	//mainAddress.frame = CGRectMake(60, 785, 250, 150);
	
	mainAddress.frame = CGRectMake(6, 284, 350, 30);
	
	if([mainAddress.text length]>0)
	{
	CGSize maximumLabelSize2 = CGSizeMake(350,9999);
	CGSize expectedLabelSize2 = [mainAddress.text sizeWithFont:mainAddress.font constrainedToSize:maximumLabelSize2 lineBreakMode:mainAddress.lineBreakMode];
	CGRect newFrame2 = mainAddress.frame;
	newFrame2.size.height = expectedLabelSize2.height;
	mainAddress.frame = newFrame2;
	}
	
	mainUrl.frame = CGRectMake(120, 750, 300, 30);
	lblURL.frame = CGRectMake(60, 750, 300, 30);
	
	
	//lblEvent.frame = CGRectMake(60, 650, 200, 40);
	
	//lblstartTime.frame = CGRectMake(60, 700, 300, 30);
	
	lblstartTime.frame = CGRectMake(6, 180, 300, 30);
	
	lblPhoneNo.frame = CGRectMake(6, 180, 300, 30);
	lblPhoneNoDescription.frame = CGRectMake(155, 180, 500, 30);
	
	lblSubject.frame = CGRectMake(6, 180, 300, 30);
	lblSubjectDescription.frame = CGRectMake(95, 180, 500, 30);
	
	lblMapNotes.frame = CGRectMake(6, 180, 300, 30);
	lblMapNotesDescription.frame = CGRectMake(80, 180, 400, 30);
	
	if([lblMapNotesDescription.text length]>0)
	{
		CGSize maximumLabelSize4 = CGSizeMake(400,9999);
		CGSize expectedLabelSize4 = [lblMapNotesDescription.text sizeWithFont:lblMapNotesDescription.font constrainedToSize:maximumLabelSize4 lineBreakMode:lblMapNotesDescription.lineBreakMode];
		CGRect newFrame4 = lblMapNotesDescription.frame;
		newFrame4.size.height = expectedLabelSize4.height +8;
		lblMapNotesDescription.frame = newFrame4;
	}
	
	if([lblSubjectDescription.text length]>0)
	{
	CGSize maximumLabelSize4 = CGSizeMake(500,9999);
	CGSize expectedLabelSize4 = [lblSubjectDescription.text sizeWithFont:lblSubjectDescription.font constrainedToSize:maximumLabelSize4 lineBreakMode:lblSubjectDescription.lineBreakMode];
	CGRect newFrame4 = lblSubjectDescription.frame;
	newFrame4.size.height = expectedLabelSize4.height +8;
	lblSubjectDescription.frame = newFrame4;
	}
	
	Message.frame = CGRectMake(6, 230, 300, 30);
	MessageDescription.frame = CGRectMake(100, 230, 500, 30);
	if([MessageDescription.text length]>0)
	{
	CGSize maximumLabelSize1 = CGSizeMake(500,9999);
	CGSize expectedLabelSize1 = [MessageDescription.text sizeWithFont:MessageDescription.font constrainedToSize:maximumLabelSize1 lineBreakMode:MessageDescription.lineBreakMode];
	CGRect newFrame1 = MessageDescription.frame;
	newFrame1.size.height = expectedLabelSize1.height+8;
	MessageDescription.frame = newFrame1;
	}
	
	Prefix.frame = CGRectMake(6, 230, 300, 30);
	prefixDescription.frame = CGRectMake(82, 230, 500, 30);
	FirstName.frame = CGRectMake(6, 280, 300, 30);
	FirstNameDescription.frame = CGRectMake(205, 280, 500, 30);
	LastName.frame = CGRectMake(6, 330, 300, 30);
	LastNameDescription.frame = CGRectMake(205, 330, 500, 30);
	MiddleName.frame = CGRectMake(6, 380, 300, 30);
	MiddleNameDescription.frame = CGRectMake(84, 380, 500, 30);
	Suffix.frame = CGRectMake(6, 430, 300, 30);
	SuffixDescription.frame = CGRectMake(80, 430, 500, 30);
	job	.frame = CGRectMake(6, 480, 300, 30);
	jobDescription.frame = CGRectMake(103, 480, 500, 30);
	Department.frame = CGRectMake(6, 530, 300, 30);
	DepartmentDescription.frame = CGRectMake(125, 530, 500, 30);
	if([DepartmentDescription.text length]>0)
	{
	CGSize maximumLabelSize6 = CGSizeMake(500,9999);
	
	CGSize expectedLabelSize6 = [DepartmentDescription.text sizeWithFont:DepartmentDescription.font constrainedToSize:maximumLabelSize6 lineBreakMode:DepartmentDescription.lineBreakMode];
	
	CGRect newFrame6 = DepartmentDescription.frame;
	newFrame6.size.height = expectedLabelSize6.height+8;
	DepartmentDescription.frame = newFrame6;
	}
	
	
	
	if([lblNotesDescription.text length]>0)
	{
	CGSize maximumLabelSize5 = CGSizeMake(400,9999);
	
	CGSize expectedLabelSize5 = [lblNotesDescription.text sizeWithFont:lblNotesDescription.font constrainedToSize:maximumLabelSize5 lineBreakMode:lblNotesDescription.lineBreakMode];
	
	CGRect newFrame5 = lblNotesDescription.frame;
	newFrame5.size.height = expectedLabelSize5.height+9;
	lblNotesDescription.frame = newFrame5;
	}
	
	//lblEndTime.frame = CGRectMake(60, 750, 300, 30);
	
	lblEndTime.frame = CGRectMake(6, 230, 300, 30);
	
	//lblAddress.frame = CGRectMake(60, 800, 300, 30);
	
	lblAddress.frame = CGRectMake(6, 280, 300, 30);
	
		
	//scrollAll.contentSize = CGSizeMake(400, y_pos);
	 
	 */
}
-(void)setFrameOrientation_LandScap
{
	landSeprate.hidden = FALSE;
	portSeprate.hidden = TRUE;
	//landSeprate.frame = CGRectMake(358, 78, 5, 709);
	landSeprate.backgroundColor = [UIColor clearColor];
	landSeprate.image = [UIImage imageNamed:@"Copy (3) of _0002_top-gradiation.png"];
	
	//imgSharing.frame = CGRectMake(360, 692, 570, 56);
	imgSharing.image = [UIImage imageNamed:@"Copy of t-f_L-570.png"];
	
	
	TopImage.image = [UIImage imageNamed:@"Library--L.png"];
	
	
	//whiteLayer.frame = CGRectMake(0, 38, 360, 42);
	whiteLayer.image = [UIImage imageNamed:@"_0000_Select-QR-cofr-.png"];
	
	whitelayerlabel.frame = CGRectMake(110, 45, 200, 30);
	[whitelayerlabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
	
	scrollAll.frame = CGRectMake(400, 78, 515, 590);
	
	qrImageview.frame = CGRectMake(0, 0, 100 , 100);
	
	TopLabel.frame = CGRectMake(390, 2, 250, 30);
	createdDate.frame = CGRectMake(126, 40, 250, 60);
	catDes.frame = CGRectMake(126, 0, 250, 30);
	
	if([array_catagory count] == 0)
	{
	}
	else 
	{
	if (changeColor>[array_catagory count]-1)
	{
		NSLog(@"grate than array landscape:");
	}
	else 
	{
		/*
		int width;
		if([catDes.text isEqualToString:@"BusinessCard"] || [catDes.text isEqualToString:@"Invitation"] || [catDes.text isEqualToString:@"CourseInfo"] || [catDes.text isEqualToString:@"IDBadge"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			CGSize expectedLabelSize1 = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Locations"] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=20;
		}
		else if([catDes.text isEqualToString:@"Event"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Event Title :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Map Location"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Location :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"SMS"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Mobile Number :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Email"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"From :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Contact"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Name :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else if([catDes.text isEqualToString:@"Phone"])
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			NSString *str = @"Phone Number :";
			CGSize expectedLabelSize1 = [[NSString stringWithFormat:@"%@",str] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=10;
		}
		else 
		{
			CGSize maximumLabelSize1 = CGSizeMake(500,9999);
			CGSize expectedLabelSize1 = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Category"] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			width = expectedLabelSize1.width;
			
			width+=20;
		}
		
		
		
		lblEvent.frame = CGRectMake(6, 130, width, 40);
		lblmainDes.frame = CGRectMake(lblEvent.frame.size.width+5, 139, 400, 40);
		 
		btnUrl.frame = CGRectMake(width+8, 139, 500, 40);
		//lblEvent.frame = CGRectMake(6, 130, width+10, 40);
		
		int height = [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Address"] length];
		lblNotes.frame = CGRectMake(6,pos, 70, 30);
		lblNotesDescription.frame = CGRectMake(80,pos,400,30);
		 */
	}
	
	}
	
	
	
	
	//lblmainDes.backgroundColor = [UIColor redColor];
	
	//new frames start
	
	/*
	lblBussName.frame = CGRectMake(6, 180, 300, 30);
	lblBussJob.frame = CGRectMake(6, 230, 300, 30);
	lblBussEmail.frame = CGRectMake(6, 280, 300, 30);
	lblBussPhone.frame = CGRectMake(6, 330, 300, 30);
	lblBussAddress.frame = CGRectMake(6, 380, 300, 30);
	lblBussNameDes.frame = CGRectMake(75, 180, 500, 30);
	lblBussJobDes.frame = CGRectMake(100, 230, 500, 30);
	lblBussEmailDes.frame = CGRectMake(75, 280, 500, 30);
	lblBussPhoneDes.frame = CGRectMake(80, 330, 500, 30);
	lblBussAddressDes.frame = CGRectMake(100, 385, 400, 30);
	
	if([lblBussAddressDes.text length]>0)
	{
		CGSize maximumLabelSize2 = CGSizeMake(400,9999);
		CGSize expectedLabelSize2 = [lblBussAddressDes.text sizeWithFont:lblBussAddressDes.font constrainedToSize:maximumLabelSize2 lineBreakMode:lblBussAddressDes.lineBreakMode];
		CGRect newFrame2 = lblBussAddressDes.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lblBussAddressDes.frame = newFrame2;
	}
	
	//Invitation//
	
	lblInvitAddress.frame = CGRectMake(6, 180, 300, 30);
	
	lblInvitAddressDes.frame = CGRectMake(100, 166, 500, 60);
	
	
	//Course Info
	
	lblCourseCode.frame = CGRectMake(6, 180, 300, 30);
	lblCourseCodeDes.frame = CGRectMake(140, 180, 500, 30);
	lblCourseProff.frame = CGRectMake(6, 230, 300, 30);
	lblCourseProffDes.frame = CGRectMake(112, 230, 500, 30);
	lblCourseTime.frame = CGRectMake(6, 280, 300, 30);
	lblCourseTimeDes.frame = CGRectMake(150, 280, 500, 30);
	// new frame end
	
	
	if([lblmainDes.text length]>0)
	{
	CGSize maximumLabelSize1 = CGSizeMake(400,9999);
	
	CGSize expectedLabelSize1 = [lblmainDes.text sizeWithFont:lblmainDes.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblmainDes.lineBreakMode];
	
	CGRect newFrame1 = lblmainDes.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	lblmainDes.frame = newFrame1;
	}
	
	mainUrl.frame = CGRectMake(460, 250, 300, 30);
	lblURL.frame = CGRectMake(400, 250, 300, 30);
	
	startDate.frame = CGRectMake(181, 180, 400, 30);
	lblstartTime.frame = CGRectMake(6, 180, 300, 30);
	
	endDate.frame = CGRectMake(171, 230, 400, 30);
	lblEndTime.frame = CGRectMake(6, 230, 300, 30);
	
	mainAddress.frame = CGRectMake(6, 284, 350, 30);
	
	if([mainAddress.text length]>0)
	{
	CGSize maximumLabelSize2 = CGSizeMake(350,9999);
	
	CGSize expectedLabelSize2 = [mainAddress.text sizeWithFont:mainAddress.font constrainedToSize:maximumLabelSize2 lineBreakMode:mainAddress.lineBreakMode];
	
	CGRect newFrame2 = mainAddress.frame;
	newFrame2.size.height = expectedLabelSize2.height;
	mainAddress.frame = newFrame2;
	}
	
	lblAddress.frame = CGRectMake(6, 280, 300, 30);
	
	lblSubject.frame = CGRectMake(6, 180, 300, 30);
	lblSubjectDescription.frame = CGRectMake(95, 180, 400, 30);
	
	lblMapNotes.frame = CGRectMake(6, 180, 300, 30);
	lblMapNotesDescription.frame = CGRectMake(80, 180, 400, 30);
	
	if([lblMapNotesDescription.text length]>0)
	{
		CGSize maximumLabelSize4 = CGSizeMake(400,9999);
		CGSize expectedLabelSize4 = [lblMapNotesDescription.text sizeWithFont:lblMapNotesDescription.font constrainedToSize:maximumLabelSize4 lineBreakMode:lblMapNotesDescription.lineBreakMode];
		CGRect newFrame4 = lblMapNotesDescription.frame;
		newFrame4.size.height = expectedLabelSize4.height +8;
		lblMapNotesDescription.frame = newFrame4;
	}
	
	if([lblSubjectDescription.text length]>0)
	{
	CGSize maximumLabelSize4 = CGSizeMake(400,9999);
	CGSize expectedLabelSize4 = [lblSubjectDescription.text sizeWithFont:lblSubjectDescription.font constrainedToSize:maximumLabelSize4 lineBreakMode:lblSubjectDescription.lineBreakMode];
	CGRect newFrame4 = lblSubjectDescription.frame;
	newFrame4.size.height = expectedLabelSize4.height +8;
	lblSubjectDescription.frame = newFrame4;
	}
	
	Message.frame = CGRectMake(6, 230, 300, 30);
	MessageDescription.frame = CGRectMake(100, 230, 400, 30);
	if([MessageDescription.text length]>0)
	{
	CGSize maximumLabelSize = CGSizeMake(400,9999);
	CGSize expectedLabelSize = [MessageDescription.text sizeWithFont:MessageDescription.font constrainedToSize:maximumLabelSize lineBreakMode:MessageDescription.lineBreakMode];
	CGRect newFrame = MessageDescription.frame;
	newFrame.size.height = expectedLabelSize.height + 8;
	MessageDescription.frame = newFrame;
	}
	
	
	if([lblNotesDescription.text length]>0)
	{
	CGSize maximumLabelSize5 = CGSizeMake(400,9999);
	CGSize expectedLabelSize5 = [lblNotesDescription.text sizeWithFont:lblNotesDescription.font constrainedToSize:maximumLabelSize5 lineBreakMode:lblNotesDescription.lineBreakMode];
	CGRect newFrame5 = lblNotesDescription.frame;
	newFrame5.size.height = expectedLabelSize5.height+9;
	lblNotesDescription.frame = newFrame5;
	}
	
	lblPhoneNo.frame = CGRectMake(6, 180, 300, 40);
	Prefix.frame = CGRectMake(6, 230, 300, 40);
	FirstName.frame = CGRectMake(6, 280, 300, 40);
	LastName.frame = CGRectMake(6, 330, 300, 40);
	MiddleName.frame = CGRectMake(6, 380, 300, 40);
	Suffix.frame = CGRectMake(6, 430, 300, 40);
	job	.frame = CGRectMake(6, 480, 300, 40);
	Department.frame = CGRectMake(6, 530, 300, 40);
	
	lblPhoneNoDescription.frame = CGRectMake(155, 185, 400, 30);
	prefixDescription.frame = CGRectMake(82, 235, 400, 30);
	FirstNameDescription.frame = CGRectMake(205, 285, 400, 30);
	LastNameDescription.frame = CGRectMake(205, 335, 400, 30);
	MiddleNameDescription.frame = CGRectMake(84, 385, 400, 30);
	SuffixDescription.frame = CGRectMake(80, 435, 400, 30);
	jobDescription.frame = CGRectMake(103, 485, 400, 30);
	DepartmentDescription.frame = CGRectMake(125, 535, 400, 30);
	
	if([DepartmentDescription.text length]>0)
	{
	CGSize maximumLabelSize6 = CGSizeMake(400,9999);
	
	CGSize expectedLabelSize6 = [DepartmentDescription.text sizeWithFont:DepartmentDescription.font constrainedToSize:maximumLabelSize6 lineBreakMode:DepartmentDescription.lineBreakMode];
	
	CGRect newFrame6 = DepartmentDescription.frame;
	newFrame6.size.height = expectedLabelSize6.height+8;
	DepartmentDescription.frame = newFrame6;
	}
	
	//lblEvent.frame = CGRectMake(400, 200, 200, 40);
	//lblstartTime.frame = CGRectMake(400, 250, 300, 30);
	//lblEndTime.frame = CGRectMake(400, 300, 300, 30);
	//lblAddress.frame = CGRectMake(400, 350, 300, 30);
	
	//btnFB.frame = CGRectMake(425, 695, 50, 50);
	//	btnTwit.frame = CGRectMake(555, 695, 50, 50);
	//	btnEmail.frame = CGRectMake(685, 695, 50, 50);
	//	btnTrash.frame = CGRectMake(815, 695, 50, 50);
	
	 */
	
	table.frame = CGRectMake(0, 40, 360, 680);
	landSeprate.frame = CGRectMake(358, 43, 5, 709);
	
	imgSharing.frame = CGRectMake(359, 692, 570, 56);
	whiteLayer.frame = CGRectMake(0, 38, 360, 42);
	btnFB.frame = CGRectMake(425, 695, 50, 50);
	btnTwit.frame = CGRectMake(555, 695, 50, 50);
	btnEmail.frame = CGRectMake(685, 695, 50, 50);
	btnTrash.frame = CGRectMake(815, 695, 50, 50);
	TopImage.frame = CGRectMake(13, 0, 910, 48);
	/*
	if(firstTime == TRUE)
	{
		firstTime = FALSE;
		table.frame = CGRectMake(20, 78, 360, 680);
		
		landSeprate.frame = CGRectMake(378, 78, 5, 709);
		imgSharing.frame = CGRectMake(379, 692, 570, 56);
		whiteLayer.frame = CGRectMake(20, 38, 360, 42);
		
		btnFB.frame = CGRectMake(445, 695, 50, 50);
		btnTwit.frame = CGRectMake(575, 695, 50, 50);
		btnEmail.frame = CGRectMake(705, 695, 50, 50);
		btnTrash.frame = CGRectMake(835, 695, 50, 50);
		TopImage.frame = CGRectMake(35, 0, 910, 48);
	}
	else {
		
		if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
		   appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			table.frame = CGRectMake(20, 78, 360, 680);
			
			landSeprate.frame = CGRectMake(378, 78, 5, 709);
			imgSharing.frame = CGRectMake(379, 692, 570, 56);
			whiteLayer.frame = CGRectMake(20, 38, 360, 42);
			btnFB.frame = CGRectMake(445, 695, 50, 50);
			btnTwit.frame = CGRectMake(575, 695, 50, 50);
			btnEmail.frame = CGRectMake(705, 695, 50, 50);
			btnTrash.frame = CGRectMake(835, 695, 50, 50);
			TopImage.frame = CGRectMake(35, 0, 910, 48);
			
		}
		if(oncePort == TRUE)
		{
			table.frame = CGRectMake(0, 78, 360, 680);
			landSeprate.frame = CGRectMake(358, 78, 5, 709);
			
			imgSharing.frame = CGRectMake(359, 692, 570, 56);
			whiteLayer.frame = CGRectMake(0, 38, 360, 42);
			btnFB.frame = CGRectMake(425, 695, 50, 50);
			btnTwit.frame = CGRectMake(555, 695, 50, 50);
			btnEmail.frame = CGRectMake(685, 695, 50, 50);
			btnTrash.frame = CGRectMake(815, 695, 50, 50);
			TopImage.frame = CGRectMake(13, 0, 910, 48);
		}
		else {
			table.frame = CGRectMake(20, 78, 360, 680);
			
			landSeprate.frame = CGRectMake(378, 78, 5, 709);
			
			imgSharing.frame = CGRectMake(379, 692, 570, 56);
			whiteLayer.frame = CGRectMake(20, 38, 360, 42);
			btnFB.frame = CGRectMake(445, 695, 50, 50);
			btnTwit.frame = CGRectMake(575, 695, 50, 50);
			btnEmail.frame = CGRectMake(705, 695, 50, 50);
			btnTrash.frame = CGRectMake(835, 695, 50, 50);
			TopImage.frame = CGRectMake(35, 0, 910, 48);
		}
		
	}
	*/
	
	//lblEvent.hidden = TRUE;
	//lblstartTime.hidden = TRUE;
	//lblEndTime.hidden = TRUE;
	//lblAddress.hidden = TRUE;
	//endDate.hidden = TRUE;
	//startDate.hidden = TRUE;
	//mainAddress.hidden = TRUE;
	//catDes.hidden = TRUE;
	
	//scrollAll.contentSize = CGSizeMake(400, y_pos);
}



- (void) didRotate:(NSNotification *)notification
{
	//[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];

	appDel.fromTwitter = FALSE;
	
	[table reloadData];
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
		if(appDel.ori == UIInterfaceOrientationPortrait ||
		   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			
			[self setFrameOrientation_Portrait];
			[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		}
		else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
				appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			
			
			[self setFrameOrientation_LandScap];
			[scrollAll setContentOffset:CGPointMake(0, 0) animated:YES];
		}
		
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	
	if(interfaceOrientation == UIInterfaceOrientationPortrait ||
	   interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		[self setFrameOrientation_Portrait];
		return YES;
	}
	else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation== UIInterfaceOrientationLandscapeRight)
	{
		[self setFrameOrientation_LandScap];
		return YES;
	}
	else {
		
		return NO;
	}
	}
	else 
	{
		return NO;
	}
}



#pragma mark shareKit

/*-(void)btnTrashClick:(id)sender
{
	if(qrImageview.image == nil)
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select any QRCode to delete" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	}
	/*
	else if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"] isEqualToString:@"qr1.png"] || [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"] isEqualToString:@"qr2.png"] || [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"] isEqualToString:@"qr3.png"])
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Can not delete static data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	 */
	/*else 
	{
		[scrollAll removeFromSuperview];
		//NSLog(@"selected row qr code:%@",[[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Image"]);
		//NSString *sql = [NSString stringWithFormat:@"select *from library"];
		//NSMutableArray *array=[DAL ExecuteArraySet:sql];
		NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"]]];
		NSMutableArray *array=[DAL ExecuteArraySet:sql1];
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"]]];	
		[[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
		qrImageview.image = nil;
		catDes.text = nil;
		txtDisplay.text = @"";
		//mainDes.text = nil;
//		startDate.text = nil;
//		endDate.text = nil;
//		mainAddress.text = nil;
		createdDate.text = nil;
		//[lblEvent setHidden:YES];
		//[lblstartTime setHidden:YES];
	//	[lblEndTime setHidden:YES];
		//[lblAddress setHidden:YES];
	//	lblURL.text = nil;
	//	mainUrl.text = nil;
		[arrImg removeObjectAtIndex:changeColor];
		NSString *strQuery = @"SELECT *FROM library";
		//array_catagory = [DAL ExecuteArraySet:strQuery];
		[array_catagory removeAllObjects];
		[array_catagory addObjectsFromArray:[[[DAL ExecuteArraySet:strQuery]reverseObjectEnumerator]allObjects]];
		[array_catagory retain];
	//	NSLog(@"index path:%d",selectedindex.row);
		[table reloadData];
		if ([array_catagory count]==0) {
			
		}
		else 
		{
			
			if([array_catagory count]>changeColor) 
			{
				
				//[self setselectedFirstRow:selectedindex];
				[self Newsetselected:selectedindex];
			}
			else 
			{
				NSLog(@"not do any thing");
			}
		}

		
		
		
	}
	
	

	
	

}*/

-(void)btnTrashClick:(id)sender
{
	if(qrImageview.image == nil)
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select any QRCode to delete" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	}
	/*
     else if([[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"] isEqualToString:@"qr1.png"] || [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"] isEqualToString:@"qr2.png"] || [[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"] isEqualToString:@"qr3.png"])
     {
     UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Can not delete static data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     [alert release];
     
     }
	 */
	else 
	{
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Are you sure you want to delete this?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
		[alert show];
        alert.tag=90;
		[alert release];
        
        /*
         [scrollAll removeFromSuperview];
         //NSLog(@"selected row qr code:%@",[[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Image"]);
         //NSString *sql = [NSString stringWithFormat:@"select *from library"];
         //NSMutableArray *array=[DAL ExecuteArraySet:sql];
         NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"]]];
         NSMutableArray *array=[DAL ExecuteArraySet:sql1];
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectory = [paths objectAtIndex:0];
         NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"]]];	
         [[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
         qrImageview.image = nil;
         catDes.text = nil;
         txtDisplay.text = @"";
         //mainDes.text = nil;
         //		startDate.text = nil;
         //		endDate.text = nil;
         //		mainAddress.text = nil;
         createdDate.text = nil;
         //[lblEvent setHidden:YES];
         //[lblstartTime setHidden:YES];
         //	[lblEndTime setHidden:YES];
         //[lblAddress setHidden:YES];
         //	lblURL.text = nil;
         //	mainUrl.text = nil;
         [arrImg removeObjectAtIndex:changeColor];
         NSString *strQuery = @"SELECT *FROM library";
         //array_catagory = [DAL ExecuteArraySet:strQuery];
         [array_catagory removeAllObjects];
         [array_catagory addObjectsFromArray:[[[DAL ExecuteArraySet:strQuery]reverseObjectEnumerator]allObjects]];
         [array_catagory retain];
         //	NSLog(@"index path:%d",selectedindex.row);
         [table reloadData];
         if ([array_catagory count]==0) {
         
         }
         else 
         {
         
         if([array_catagory count]>changeColor) 
         {
         
         //[self setselectedFirstRow:selectedindex];
         [self Newsetselected:selectedindex];
         }
         else 
         {
         NSLog(@"not do any thing");
         }
         }
         
         */
		
		
	}
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView tag] == 90)
    {
        if(buttonIndex == 0)
        {
            [scrollAll removeFromSuperview];
            //NSLog(@"selected row qr code:%@",[[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Image"]);
            //NSString *sql = [NSString stringWithFormat:@"select *from library"];
            //NSMutableArray *array=[DAL ExecuteArraySet:sql];
            NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"]]];
            NSMutableArray *array=[DAL ExecuteArraySet:sql1];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:changeColor] objectForKey:@"Image"]]];	
            [[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
            qrImageview.image = nil;
            catDes.text = nil;
            txtDisplay.text = @"";
            //mainDes.text = nil;
            //		startDate.text = nil;
            //		endDate.text = nil;
            //		mainAddress.text = nil;
            createdDate.text = nil;
            //[lblEvent setHidden:YES];
            //[lblstartTime setHidden:YES];
            //	[lblEndTime setHidden:YES];
            //[lblAddress setHidden:YES];
            //	lblURL.text = nil;
            //	mainUrl.text = nil;
            [arrImg removeObjectAtIndex:changeColor];
            NSString *strQuery = @"SELECT *FROM library";
            //array_catagory = [DAL ExecuteArraySet:strQuery];
            [array_catagory removeAllObjects];
            [array_catagory addObjectsFromArray:[[[DAL ExecuteArraySet:strQuery]reverseObjectEnumerator]allObjects]];
            [array_catagory retain];
            //	NSLog(@"index path:%d",selectedindex.row);
            [table reloadData];
            if ([array_catagory count]==0) {
                
            }
            else 
            {
                
                if([array_catagory count]>changeColor) 
                {
                    
                    //[self setselectedFirstRow:selectedindex];
                    [self Newsetselected:selectedindex];
                }
                else 
                {
                    NSLog(@"not do any thing");
                }
            }
            
            
            
        }
    }
    
}
-(IBAction)buttonFacebooKClicked:(id)sender
{
	if(qrImageview.image == nil)
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select the QRCode you want to share" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	else 
	{
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	NSString *text=@"hello";
	SHKItem *item = [SHKItem image:qrImageview.image];
	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
	}
}
-(IBAction) buttonTwitterClicked:(id)sender
{
	appDel.fromTwitter = TRUE;
	
	appDel.ori = UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
	
	if(qrImageview.image == nil)
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select the QRCode you want to share" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	else 
	{
	NSString *text=@"hello";
	SHKItem *item = [SHKItem image:qrImageview.image title:nil];
		//SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
		//[actionSheet showFromToolbar:self.navigationController.toolbar];
		
	//SHKItem *item = [SHKItem image:qrImageview.image];
	[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
	}
}

/*

-(IBAction)emailbtn_click:(id)sender
{
	if(qrImageview.image == nil)
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select the QRCode you want to share" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	else 
	{
	int w=qrImageview.image.size.width;
	int h=qrImageview.image.size.height;
	
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
    CGContextRef context = CGBitmapContextCreate(NULL, w, h+155, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
	
	// CGContextDrawImage(context, CGRectMake(0, 155, w, h), image.image.CGImage);
	CGContextDrawImage(context, CGRectMake(0, 155, w, 400), qrImageview.image.CGImage);
    
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);
	
	CGContextSelectFont(context, "Arial", 22, kCGEncodingMacRoman);
	
	CGContextSetTextDrawingMode(context, kCGTextFill);
	CGContextSetRGBFillColor(context, 0, 0, 0, 1);
	
	UIGraphicsPushContext(context);
	
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0.0f, h+155);
    CGContextScaleCTM(context, 1.0f, -1.0f);
	/*
	 [strTemp drawInRect:CGRectMake(5, h+5, w-10, 100) withFont:[UIFont systemFontOfSize:16]];
	 
	 [strTemp1 drawInRect:CGRectMake(w-155, h+100, 150, 35) withFont:[UIFont systemFontOfSize:14]];
	 
    CGContextRestoreGState(context);
	
    UIGraphicsPopContext();
	
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
	
    CGContextRelease(context);
	
    CGColorSpaceRelease(colorSpace);
	
    UIImage *imgText = [UIImage imageWithCGImage:imageMasked];
	UIGraphicsBeginImageContext(CGSizeMake(320, 365));
	[imgText drawInRect:CGRectMake(0, 0, 320, 365)];
	UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
		
	
	UIGraphicsEndImageContext();
		
		if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
		{
		table.frame = CGRectMake(0, 78, 360, 680);
		landSeprate.frame = CGRectMake(358, 78, 5, 709);
		
		imgSharing.frame = CGRectMake(360, 692, 570, 56);
		whiteLayer.frame = CGRectMake(0, 38, 360, 42);
		btnFB.frame = CGRectMake(425, 695, 50, 50);
		btnTwit.frame = CGRectMake(555, 695, 50, 50);
		btnEmail.frame = CGRectMake(685, 695, 50, 50);
		btnTrash.frame = CGRectMake(815, 695, 50, 50);
		}
		else 
		{
			
		}
		
	SHKItem *item = [SHKItem image:qrImageview.image title:@"QR CODE"];
	[NSClassFromString(@"SHKMail") performSelector:@selector(shareItem:) withObject:item];
	
	
	}
	
}	
*/

-(IBAction)emailbtn_click:(id)sender
{
	
	if(qrImageview.image == nil)
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select the QRCode you want to share" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	else 
	{
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
	
		
		//if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
//		{
//			table.frame = CGRectMake(0, 78, 360, 680);
//			landSeprate.frame = CGRectMake(358, 78, 5, 709);
//			
//			imgSharing.frame = CGRectMake(360, 692, 570, 56);
//			whiteLayer.frame = CGRectMake(0, 38, 360, 42);
//			btnFB.frame = CGRectMake(425, 695, 50, 50);
//			btnTwit.frame = CGRectMake(555, 695, 50, 50);
//			btnEmail.frame = CGRectMake(685, 695, 50, 50);
//			btnTrash.frame = CGRectMake(815, 695, 50, 50);
//		}
//		else 
//		{
//			
//		}
		
	
	}
	/*NSString *text=@"hello";
	 
	 SHKItem *item = [SHKItem image:imgScreen title:nil];
	 [NSClassFromString(@"SHKMail") performSelector:@selector(shareItem:) withObject:item];
	 */
	
	
}

-(void)displayComposerSheet
{
	UIImage *imgScreen = [self captureScreenInRect:CGRectMake(0,0 ,700, btnEmail.frame.origin.y)];
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	
	
	/*NSString *tmpBody = @"";
	 tmpBody =[tmpBody stringByAppendingString:@"<br></br>"];
	 tmpBody =[tmpBody stringByAppendingString:@"<br></br>"];
	 //NSString *strURL = [NSString stringWithFormat:@"%@image.ashx?ID=%d&imagesize=W600xH420&imagetype=MainImage",WEB_SERVICE_URL,[idNew intValue]];
	 tmpBody =[tmpBody stringByAppendingFormat:@"<b><img src='%@'></b>",imgScreen];
	 [picker setMessageBody:tmpBody isHTML:YES];*/
	
	NSData *imgData = UIImagePNGRepresentation(imgScreen);
	[picker addAttachmentData:imgData mimeType:@"image/png" fileName:@"Result"];//[tmpBody release];
	
	
	picker.modalPresentationStyle =UIModalPresentationFormSheet;
	picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[appDel.viewController presentModalViewController:picker animated:YES];
	//[self presentModalViewController:picker animated:YES];
    
	//[picker release];
}

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:jayna.gandhi@silvertouch.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	//message.hidden = NO;
	
	[appDel.viewController dismissModalViewControllerAnimated:YES];
}

#pragma mark capture screen
- (UIImage *)captureScreenInRect:(CGRect)captureFrame {
    CALayer *layer;
    layer = qrImageview.layer; //self.view.layer;
    UIGraphicsBeginImageContext( qrImageview.bounds.size);  // self.view.bounds.size); 
    CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}





- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    NSLog(@"unload call");
	[super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
	
}


- (void)dealloc {
    [super dealloc];
	
	NSLog(@"Library dealloc called");
	/*
	[btnEmail release];
	[btnFB release];
	[btnTrash release];
	[btnTwit release];
	[btnUrl release];
	
	[qrImageview release];
	qrImageview = nil;
	
	[landSeprate release];
	landSeprate = nil;
	
	[portSeprate release];
	portSeprate = nil;
	
	[imgSharing release];
	imgSharing = nil;
	
	[lblPhoneNo release];
	[lblPhoneNoDescription release];
	[Prefix release];
	[prefixDescription release];
	[FirstName release];
	[FirstNameDescription release];
	[LastName release];
	[LastNameDescription release];
	[MiddleName release];
	[MiddleNameDescription release];
	[Suffix release];
	[SuffixDescription release];
	[job release];
	[jobDescription release];
	[Department release];
	[DepartmentDescription release];
	[lblSubject release];
	[lblSubjectDescription release];
	[Message release];
	[MessageDescription release];
	[lblNotesDescription release];
	
	[scrollAll release];
	
	[arrImg release];
	
	[TopImage release];
	[whiteLayer release];
	[TopLabel release];
	[whitelayerlabel release];
	[qrImageview release];
	[catDes release];
	[mainDes release];
	[mainDesText release];
	[startDate release];
	[endDate release];
	[mainAddress release];
	[createdDate release];
	[lblEvent release];
	[lblstartTime release];
	[lblEndTime release];
	[lblAddress release];
	[lblURL release];
	[lblNotes release];
	[mainUrl release];
	
	[table release];
	*/
}


@end
