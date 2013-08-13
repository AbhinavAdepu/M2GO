//
//  AboutViewController.m
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import "AboutViewController.h"
#import "LibraryCell-Landscape.h"
#import "AboutDetailViewController.h"

#define kCellHeight 100.0


@implementation AboutViewController

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
- (void) viewWillAppear:(BOOL)animated
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		
	}
	else 
	{
		//[tblAbout reloadData];
	}
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	firstTime = TRUE;
	oncePort = FALSE;
	
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(didRotate:) 
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
	
	Scroll1.hidden=NO;
	Scroll2.hidden=YES;
	Scroll3.hidden=YES;
	Scroll4.hidden=YES;
	
	counter=1;
	}
	else 
	{
		NSLog(@"AboutUs-Iphone");
		selectedRow = 500;
		arrayAboutTexts = [[NSMutableArray alloc] initWithObjects:@"Message from the Authors",@"About the Authors",@"About Connect",@"Buy the Book",nil];
		
		array_NormalImages = [[NSMutableArray alloc] initWithObjects:@"MessageFrom_AboutNormal_iphone.png",@"AboutTheAuthors_AboutNormal_iphone.png",@"AboutConnect_AboutNormal_iphone.png",@"BuyTheBooks_AboutNormal_iphone.png",nil];
		array_SelectedImages = [[NSMutableArray alloc] initWithObjects:@"MessageFrom_AboutSelected_iphone.png",@"AboutTheAuthors_AboutSelected_iphone.png",@"AboutConnect_AboutSelected_iphone.png",@"BuyTheBooks_AboutSelected_iphone.png",nil];
		
	}

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	return [arrayAboutTexts count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 89;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
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
	img.frame = CGRectMake(0, 0, 320, 89);
	[cell.contentView addSubview:img];
	[img release];
	
	UIImageView *img1 = [[UIImageView alloc]init];
	img1.image = [UIImage imageNamed:[array_NormalImages objectAtIndex:indexPath.row]];
	img1.frame = CGRectMake(10, 15, 56, 56);
	[cell.contentView addSubview:img1];
	[img1 release];
	
	
	UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 150, 50)];
	lbl1.text = [arrayAboutTexts objectAtIndex:indexPath.row];
	lbl1.numberOfLines = 0;
	lbl1.lineBreakMode = UILineBreakModeWordWrap;
	[lbl1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
	[cell.contentView addSubview:lbl1];
	[lbl1 release];
	
	UIImageView *img_aero = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow_WriteDark_iphone.png"]];
	img_aero.frame = CGRectMake(300, 37, 6, 11);
	[cell.contentView addSubview:img_aero];
	
	
	img.highlightedImage = [UIImage imageNamed:@"_0001_seperation-lines-set1-20.png"];
	img.image = [UIImage imageNamed:@"_0000_seperation-lines-set1-copy-20.png"];
	lbl1.highlightedTextColor = [UIColor whiteColor];
	img_aero.highlightedImage = [UIImage imageNamed:@"Arrow_WriteNormal_iphone.png"];
	img1.highlightedImage = [UIImage imageNamed:[array_SelectedImages objectAtIndex:indexPath.row]];
	
	/*
	if(selectedRow == indexPath.row)
	{
		img.image = [UIImage imageNamed:@"_0001_seperation-lines-set1-20.png"];
		img1.image =[UIImage imageNamed:[array_SelectedImages objectAtIndex:indexPath.row]];
		lbl1.backgroundColor = [UIColor clearColor];
		lbl1.textColor = [UIColor whiteColor];
		img_aero.image = [UIImage imageNamed:@"Arrow_WriteNormal_iphone.png"];
	}
	*/
	return cell;


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	selectedRow = indexPath.row;
	[tblAbout reloadData];
	
	AboutDetailViewController *obj_About = [[AboutDetailViewController alloc] initWithNibName:@"AboutDetailViewController" bundle:nil index:selectedRow];
	[self.navigationController pushViewController:obj_About animated:TRUE];
	[obj_About release];
	
	//[tableView deselectRowAtIndexPath:indexPath.row animated:TRUE];
}
	
- (void) didRotate:(NSNotification *)notification
{	
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{		
		[self setFrameOrientation_Portrait];
	}
	
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{		
		[self setFrameOrientation_LandScap];
	}
	
	
}

-(void)setFrameOrientation_Portrait
{	
	oncePort = TRUE;
	firstTime = FALSE;
	
	
	lblTop.frame=CGRectMake(230,4,800,30);
	
	Topimage.image=[UIImage imageNamed:@"_0009_top-red-band.png"];
	imageTableBack.frame=CGRectMake(0,0,768,58);
	Topimage.frame=CGRectMake(0,0,768,48);
	BtnBottom1.frame=CGRectMake(33,880, 163, 124);
	BtnBottom2.frame=CGRectMake(197,880, 163, 124);
	BtnBottom3.frame=CGRectMake(361,880, 163, 124);
	BtnBottom4.frame=CGRectMake(525,880,163, 124);
	imageDivder1.frame=CGRectMake(34,875,654,129);
	
	/////////SCROLL FOR TAB 1
	Scroll1.contentSize=CGSizeMake(654, 1670);
	Scroll1.frame=CGRectMake(34,55,800,800);
	Lblfirstscreen1.frame=CGRectMake(0,0,600,50);	
	Lblfirstscreen2.frame=CGRectMake(0,20,600,170);	
	Lblfirstscreen3.frame=CGRectMake(0,170,600,50);	
	Lblfirstscreen4.frame=CGRectMake(0,190,600,250);
	Lblfirstscreen5.frame=CGRectMake(0,430,600,50);	
	Lblfirstscreen6.frame=CGRectMake(0,440,600,350);
	Lblfirstscreen7.frame=CGRectMake(0,790,600,50);	
	Lblfirstscreen8.frame=CGRectMake(0,780,600,600);
	Lblfirstscreen1.hidden=YES;
	Lblfirstscreen2.hidden=YES;
	Lblfirstscreen3.hidden=YES;
	Lblfirstscreen4.hidden=YES;
	Lblfirstscreen5.hidden=YES;
	Lblfirstscreen6.hidden=YES;
	Lblfirstscreen7.hidden=YES;
	Lblfirstscreen8.hidden=YES;
	image1.frame=CGRectMake(0,0,654,1439);
	image1.image=[UIImage imageNamed:@"MessageFromTheAuthors-P.png"];
	
	/////////SCROLL FOR TAB 2
	Scroll2.contentSize=CGSizeMake(654,950);
	Scroll2.frame=CGRectMake(34,55,700,800);
	LblSecondscreen1.frame=CGRectMake(190,18,550,30);	
	LblSecondscreen2.frame=CGRectMake(190,0,400,300);	
	LblSecondscreen3.frame=CGRectMake(0,320,200,28);	
	LblSecondscreen4.frame=CGRectMake(0,300,400,300);
	LblSecondscreen5.frame=CGRectMake(190,594,150,30);	
	LblSecondscreen6.frame=CGRectMake(190,562,400,350);
	LblSecondscreen1.hidden=YES;
	LblSecondscreen2.hidden=YES;
	LblSecondscreen3.hidden=YES;
	LblSecondscreen4.hidden=YES;
	LblSecondscreen5.hidden=YES;
	LblSecondscreen6.hidden=YES;
	image2.frame=CGRectMake(0,0,655,943);	
	image2.image=[UIImage imageNamed:@"App-AboutTheAuthors-P.png"];
	
	
	
	ImageSecondpictureScreen2.frame=CGRectMake(450,314,157,203);
	ImageSecondpictureScreen3.frame=CGRectMake(0,600,157,203);
	ImageSecondpictureScreen1.frame=CGRectMake(0,22,157,203);
	
	ImageSecondpictureScreen2.hidden=YES;
	ImageSecondpictureScreen3.hidden=YES;
	ImageSecondpictureScreen1.hidden=YES;
	
	
	/////////SCROLL FOR TAB 3
	Scroll3.contentSize=CGSizeMake(600, 1050);
	Scroll3.frame=CGRectMake(33,60,700,800);
	LblThirdscreen1.frame=CGRectMake(0,0,250,30);	
	LblThirdscreen2.frame=CGRectMake(0,25,610,100);	
	LblThirdscreen3.frame=CGRectMake(0,170,400,28);	
	LblThirdscreen4.frame=CGRectMake(0,195,610,240);	
	LblThirdscreen1.hidden=YES;
	LblThirdscreen2.hidden=YES;
	LblThirdscreen3.hidden=YES;
	LblThirdscreen4.hidden=YES;
	image3.frame=CGRectMake(0,0,654,790);
	BtnOpenlink.frame=CGRectMake(135,140,280,30);
	image3.image=[UIImage imageNamed:@"_0002_App-AboutConnect-New22-1-1.png"];
	
	
	/////////// FOR TAB4
	Scroll4.frame=CGRectMake(33,60,700,300);
	image4.frame=CGRectMake(0, 0,654 ,248);
	image4.image=[UIImage imageNamed:@"Buy-the-Book-P-1.png"];
	BtnLink.frame=CGRectMake(140,165 ,280 ,30);
	
	
	[BtnBottom1 setImage:[UIImage imageNamed:@"_0012_stage_1-1.png"] forState:UIControlStateNormal];
	[BtnBottom2 setImage:[UIImage imageNamed:@"_0011_stage_1-2.png"] forState:UIControlStateNormal];
	[BtnBottom4 setImage:[UIImage imageNamed:@"_0000_Normal-Landscape-icon.png"] forState:UIControlStateNormal];
	[BtnBottom3 setImage:[UIImage imageNamed:@"_0010_stage_1-3.png"] forState:UIControlStateNormal];
	
	imageDivder1.image=[UIImage imageNamed:@"Portrait_About_Sep.png"];
	
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori  == UIInterfaceOrientationPortraitUpsideDown)
	{
		if(counter == 1){
			lblTop.frame=CGRectMake(208,2,800,30);
			lblTop.text=@"Message from the Authors";
			
			[BtnBottom1 setImage:[UIImage imageNamed:@"_0004_stage_3-1.png"] forState:UIControlStateNormal];			
		}
		else if(counter == 2){
			lblTop.text=@"About the Authors";
			lblTop.frame=CGRectMake(248,4,800,30);
			[BtnBottom2 setImage:[UIImage imageNamed:@"_0003_stage_3-2.png"] forState:UIControlStateNormal];			
		}
		else if(counter == 3){
			lblTop.text=@"About Connect";
			lblTop.frame=CGRectMake(275,4,800,30);
			[BtnBottom3 setImage:[UIImage imageNamed:@"_0002_stage_3-3.png"] forState:UIControlStateNormal];			
		}
		else if(counter == 4){
			lblTop.text=@"Buy the Book";
			lblTop.frame=CGRectMake(283,2,800,30);
			[BtnBottom4 setImage:[UIImage imageNamed:@"_0001_Active-icon.png"] forState:UIControlStateNormal];			
		}
	}else{
		if(counter == 1){
			lblTop.text=@"Message from the Authors";
			[BtnBottom1 setImage:[UIImage imageNamed:@"SEL_1.png"] forState:UIControlStateNormal];			
		}
		else if(counter == 2){
			lblTop.text=@"About the Authors";
			[BtnBottom2 setImage:[UIImage imageNamed:@"AboutAuthor1.png"] forState:UIControlStateNormal];			
		}
		else if(counter == 3){
			lblTop.text=@"About Connect";
			[BtnBottom3 setImage:[UIImage imageNamed:@"Connect_UN.png"] forState:UIControlStateNormal];			
		}
		else if(counter == 4){
			lblTop.text=@"Buy the Book";
			[BtnBottom4 setImage:[UIImage imageNamed:@"SEL_BuyAbook-.png"] forState:UIControlStateNormal];			
		}
		
	}
}
-(void)setFrameOrientation_LandScap
{	
	/*
	if(firstTime == TRUE)
	{
		firstTime = FALSE;
		BtnBottom1.frame=CGRectMake(35,39,110,177);
		BtnBottom2.frame=CGRectMake(35,217,110,176);
		BtnBottom3.frame=CGRectMake(35,394,110,176);	
		BtnBottom4.frame=CGRectMake(35,571,110,177);
		imageDivder1.frame=CGRectMake(35,39,115,709);
		Scroll1.frame=CGRectMake(149,60,910,820);
		Scroll2.frame=CGRectMake(149,60,910,820);
		Scroll3.frame=CGRectMake(149,60,910,820);
		Scroll4.frame=CGRectMake(149,60,910,820);
		lblTop.frame=CGRectMake(308,2,800,30);
	}
	else {
		
		if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
		   appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			BtnBottom1.frame=CGRectMake(35,39,110,177);
			BtnBottom2.frame=CGRectMake(35,217,110,176);
			BtnBottom3.frame=CGRectMake(35,394,110,176);	
			BtnBottom4.frame=CGRectMake(35,571,110,177);
			imageDivder1.frame=CGRectMake(35,39,115,709);
			Scroll1.frame=CGRectMake(149,60,910,820);
			Scroll2.frame=CGRectMake(149,60,910,820);
			Scroll3.frame=CGRectMake(149,60,910,820);
			Scroll4.frame=CGRectMake(172,60,910,820);
			lblTop.frame=CGRectMake(308,2,800,30);
		}
		if(oncePort == TRUE)
		{
			BtnBottom1.frame=CGRectMake(13,39,110,177);
			BtnBottom2.frame=CGRectMake(13,217,110,176);
			BtnBottom3.frame=CGRectMake(13,394,110,176);	
			BtnBottom4.frame=CGRectMake(13,571,110,177);
			imageDivder1.frame=CGRectMake(13,39,115,709);
			Scroll1.frame=CGRectMake(127,60,910,820);
			Scroll2.frame=CGRectMake(127,60,910,820);
			Scroll3.frame=CGRectMake(127,60,910,820);
			Scroll4.frame=CGRectMake(127,60,910,820);
			lblTop.frame=CGRectMake(308,2,800,30);
		}
		else {
			BtnBottom1.frame=CGRectMake(35,39,110,177);
			BtnBottom2.frame=CGRectMake(35,217,110,176);
			BtnBottom3.frame=CGRectMake(35,394,110,176);	
			BtnBottom4.frame=CGRectMake(35,571,110,177);
			imageDivder1.frame=CGRectMake(35,39,115,709);
			Scroll1.frame=CGRectMake(149,60,910,820);
			Scroll2.frame=CGRectMake(149,60,910,820);
			Scroll3.frame=CGRectMake(149,60,910,820);
			Scroll4.frame=CGRectMake(149,60,910,820);
			lblTop.frame=CGRectMake(308,2,800,30);
		}		
	}
	*/
	
	BtnBottom1.frame=CGRectMake(13,39,110,177);
	BtnBottom2.frame=CGRectMake(13,217,110,176);
	BtnBottom3.frame=CGRectMake(13,394,110,176);	
	BtnBottom4.frame=CGRectMake(13,571,110,177);
	imageDivder1.frame=CGRectMake(13,39,115,709);
	Scroll1.frame=CGRectMake(127,60,910,820);
	Scroll2.frame=CGRectMake(127,60,910,820);
	Scroll3.frame=CGRectMake(127,60,910,820);
	Scroll4.frame=CGRectMake(127,60,910,820);

	
	
	/******ortiginal***********/
	
	Topimage.image=[UIImage imageNamed:@"_0006_top-red-band910.png"];
	
	Topimage.frame=CGRectMake(0,0,1004,48);
	/*BtnBottom1.frame=CGRectMake(13,39,110,177);
	 BtnBottom2.frame=CGRectMake(13,217,110,176);
	 BtnBottom3.frame=CGRectMake(13,394,110,176);	
	 BtnBottom4.frame=CGRectMake(13,572,110,176);
	 imageDivder1.frame=CGRectMake(13,39,115,709);*/
	
	imageDivder1.image=[UIImage imageNamed:@"Landscape_sep_About.png"];
	[BtnBottom1 setImage:[UIImage imageNamed:@"UNSEL_MESSAGE.png"] forState:UIControlStateNormal];
	[BtnBottom2 setImage:[UIImage imageNamed:@"UNSEL_AUTHOR.png"] forState:UIControlStateNormal];
	[BtnBottom3 setImage:[UIImage imageNamed:@"Connect_UN.png"] forState:UIControlStateNormal];
	[BtnBottom4 setImage:[UIImage imageNamed:@"_0000_Normal-port.-icon.png"] forState:UIControlStateNormal];
	
	
	/////////SCROLL FOR TAB 1
	Scroll1.contentSize=CGSizeMake(654, 1500);
	//Scroll1.frame=CGRectMake(127,60,910,820);
	Lblfirstscreen1.frame=CGRectMake(0,0,550,50);	
	Lblfirstscreen2.frame=CGRectMake(0,20,720,170);	
	Lblfirstscreen3.frame=CGRectMake(0,170,720,50);	
	Lblfirstscreen4.frame=CGRectMake(0,190,720,250);
	Lblfirstscreen5.frame=CGRectMake(0,430,720,50);	
	Lblfirstscreen6.frame=CGRectMake(0,440,720,350);
	Lblfirstscreen7.frame=CGRectMake(0,790,720,50);	
	Lblfirstscreen8.frame=CGRectMake(0,780,720,600);
	Lblfirstscreen1.hidden=YES;
	Lblfirstscreen2.hidden=YES;
	Lblfirstscreen3.hidden=YES;
	Lblfirstscreen4.hidden=YES;
	Lblfirstscreen5.hidden=YES;
	Lblfirstscreen6.hidden=YES;
	Lblfirstscreen7.hidden=YES;
	Lblfirstscreen8.hidden=YES;
	image1.frame=CGRectMake(0,0,800,1360);
	image1.image=[UIImage imageNamed:@"MessageFromTheAuthors-L.png"];
	
	
	/////////SCROLL FOR TAB 2
	Scroll2.contentSize=CGSizeMake(600, 950);
	//Scroll2.frame=CGRectMake(127,60,910,820);
	LblSecondscreen1.frame=CGRectMake(190,18,550,30);	
	LblSecondscreen2.frame=CGRectMake(190,0,550,300);	
	LblSecondscreen3.frame=CGRectMake(0,320,200,28);	
	LblSecondscreen4.frame=CGRectMake(0,300,400,300);
	LblSecondscreen5.frame=CGRectMake(190,594,150,30);	
	LblSecondscreen6.frame=CGRectMake(190,562,400,350);
	
	ImageSecondpictureScreen2.frame=CGRectMake(450,314,157,203);
	ImageSecondpictureScreen3.frame=CGRectMake(0,600,157,203);
	ImageSecondpictureScreen1.frame=CGRectMake(0,22,157,203);
	LblSecondscreen1.hidden=YES;
	LblSecondscreen2.hidden=YES;
	LblSecondscreen3.hidden=YES;
	LblSecondscreen4.hidden=YES;
	LblSecondscreen5.hidden=YES;
	LblSecondscreen6.hidden=YES;	
	image2.frame=CGRectMake(0,0,799,710);
	image2.image=[UIImage imageNamed:@"App-AboutTheAuthors-L.png"];
	
	
	
	
	/////////SCROLL FOR TAB 3
	
	//Scroll3.frame=CGRectMake(127,60,600,820);
	Scroll3.contentSize=CGSizeMake(600, 1024);
	LblThirdscreen1.frame=CGRectMake(0,0,250,30);	
	LblThirdscreen2.frame=CGRectMake(0,25,610,100);	
	LblThirdscreen3.frame=CGRectMake(0,170,400,28);	
	LblThirdscreen4.frame=CGRectMake(0,195,610,240);
	LblThirdscreen1.hidden=YES;
	LblThirdscreen2.hidden=YES;
	LblThirdscreen3.hidden=YES;
	LblThirdscreen4.hidden=YES;
	image3.frame=CGRectMake(0,0,800,800);
	image3.image=[UIImage imageNamed:@"Land_App-AboutConnect-1-New22-1-1.png"];
	BtnOpenlink.frame=CGRectMake(370,128,280,30);
	
	
	/////////// FOR TAB4
	//Scroll4.frame=CGRectMake(33,60,700,300);
	image4.frame=CGRectMake(0, 0,800 ,208);
	image4.image=[UIImage imageNamed:@"Buy-the-Book-L-1.png"];
	BtnLink.frame=CGRectMake(50,140,260 ,40);
	
	
	if(appDel.ori  == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		if(counter == 1){
			lblTop.frame=CGRectMake(208,2,800,30);
			lblTop.text=@"Message from the Authors";
			[BtnBottom1 setImage:[UIImage imageNamed:@"_0004_stage_3-1.png"] forState:UIControlStateNormal];
		}
		else if(counter == 2){
			lblTop.text=@"About the Authors";
			lblTop.frame=CGRectMake(248,4,800,30);
			[BtnBottom2 setImage:[UIImage imageNamed:@"_0003_stage_3-2.png"] forState:UIControlStateNormal];
			
		}
		else if(counter == 3){
			lblTop.text=@"About Connect";
			lblTop.frame=CGRectMake(275,4,800,30);
			[BtnBottom3 setImage:[UIImage imageNamed:@"_0002_stage_3-3.png"] forState:UIControlStateNormal];
			
		}
		else if(counter == 4){
			lblTop.text=@"Buy the Book";
			lblTop.frame=CGRectMake(283,2,800,30);
			[BtnBottom4 setImage:[UIImage imageNamed:@"_0001_Active-icon.png"] forState:UIControlStateNormal];
			
		}
	}else{
		if(counter == 1){
			lblTop.text=@"Message from the Authors";
			lblTop.frame=CGRectMake(343,2,800,30);
			[BtnBottom1 setImage:[UIImage imageNamed:@"SEL_1.png"] forState:UIControlStateNormal];
			
		}
		else if(counter == 2){
			lblTop.text=@"About the Authors";
			lblTop.frame=CGRectMake(377,2,800,30);
			[BtnBottom2 setImage:[UIImage imageNamed:@"AboutAuthor1.png"] forState:UIControlStateNormal];
			
		}
		else if(counter == 3){
			lblTop.text=@"About Connect";
			lblTop.frame=CGRectMake(404,2,800,30);	
			[BtnBottom3 setImage:[UIImage imageNamed:@"Contact_sel.png"] forState:UIControlStateNormal];
		}
		else if(counter == 4){
			lblTop.text=@"Buy the Book";			
			lblTop.frame=CGRectMake(412,2,800,30);
    		[BtnBottom4 setImage:[UIImage imageNamed:@"_0001_Active-Port--icon.png"] forState:UIControlStateNormal];
    	}
	}
}

-(IBAction)ButtonClick1:(id)sender{
	lblTop.text=@"Message from the Authors";
	
	counter=1;
	Scroll1.hidden=NO;
	Scroll2.hidden=YES;
	Scroll3.hidden=YES;
	Scroll4.hidden=YES;
	
	Lblfirstscreen1.hidden=YES;
	Lblfirstscreen2.hidden=YES;
	Lblfirstscreen3.hidden=YES;
	Lblfirstscreen4.hidden=YES;
	Lblfirstscreen5.hidden=YES;
	Lblfirstscreen6.hidden=YES;
	Lblfirstscreen7.hidden=YES;
	Lblfirstscreen8.hidden=YES;
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		lblTop.frame=CGRectMake(208,2,800,30);		
		image1.frame=CGRectMake(0,0,654,1439);
		image1.image=[UIImage imageNamed:@"MessageFromTheAuthors-P.png"];		
		[BtnBottom1 setImage:[UIImage imageNamed:@"_0004_stage_3-1.png"] forState:UIControlStateNormal];
		[BtnBottom2 setImage:[UIImage imageNamed:@"_0011_stage_1-2.png"] forState:UIControlStateNormal];
		[BtnBottom4 setImage:[UIImage imageNamed:@"_0000_Normal-Landscape-icon.png"] forState:UIControlStateNormal];
		[BtnBottom3 setImage:[UIImage imageNamed:@"_0010_stage_1-3.png"] forState:UIControlStateNormal];
		
	}else{
		lblTop.frame=CGRectMake(343,2,800,30);
		image1.frame=CGRectMake(0,0,800,1360);
		image1.image=[UIImage imageNamed:@"MessageFromTheAuthors-L.png"];
		
		[BtnBottom1 setImage:[UIImage imageNamed:@"SEL_1.png"] forState:UIControlStateNormal];
		[BtnBottom2 setImage:[UIImage imageNamed:@"UNSEL_AUTHOR.png"] forState:UIControlStateNormal];
		[BtnBottom4 setImage:[UIImage imageNamed:@"_0000_Normal-port.-icon.png"] forState:UIControlStateNormal];
		[BtnBottom3 setImage:[UIImage imageNamed:@"Connect_UN.png"] forState:UIControlStateNormal];
		
	}
}
-(IBAction)ButtonClick2:(id)sender{
	Scroll1.hidden=YES;
	Scroll2.hidden=NO;
	Scroll3.hidden=YES;
	Scroll4.hidden=YES;
	
	LblSecondscreen1.hidden=YES;
	LblSecondscreen2.hidden=YES;
	LblSecondscreen3.hidden=YES;
	LblSecondscreen4.hidden=YES;
	LblSecondscreen5.hidden=YES;
	LblSecondscreen6.hidden=YES;		
	
	ImageSecondpictureScreen2.hidden=YES;
	ImageSecondpictureScreen3.hidden=YES;
	ImageSecondpictureScreen1.hidden=YES;
	
	counter=2;
	lblTop.text=@"About the Authors";
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		image2.frame=CGRectMake(0,0,655,943);		
		image2.image=[UIImage imageNamed:@"App-AboutTheAuthors-P.png"];
		lblTop.frame=CGRectMake(248,4,800,30);
		[BtnBottom2 setImage:[UIImage imageNamed:@"_0003_stage_3-2.png"] forState:UIControlStateNormal];
		[BtnBottom4 setImage:[UIImage imageNamed:@"_0000_Normal-Landscape-icon.png"] forState:UIControlStateNormal];
		[BtnBottom3 setImage:[UIImage imageNamed:@"_0010_stage_1-3.png"] forState:UIControlStateNormal];
		[BtnBottom1 setImage:[UIImage imageNamed:@"_0012_stage_1-1.png"] forState:UIControlStateNormal];		
	}else{	
		lblTop.frame=CGRectMake(377,2,800,30);
		image2.frame=CGRectMake(0,0,799,710);
		image2.image=[UIImage imageNamed:@"App-AboutTheAuthors-L.png"];
		
		[BtnBottom1 setImage:[UIImage imageNamed:@"UNSEL_MESSAGE.png"] forState:UIControlStateNormal];
		[BtnBottom2 setImage:[UIImage imageNamed:@"AboutAuthor1.png"] forState:UIControlStateNormal];
		[BtnBottom4 setImage:[UIImage imageNamed:@"_0000_Normal-port.-icon.png"] forState:UIControlStateNormal];
		[BtnBottom3 setImage:[UIImage imageNamed:@"Connect_UN.png"] forState:UIControlStateNormal];
	}
	
	
}
-(IBAction)ButtonClick3:(id)sender{
	counter=3;
    lblTop.text=@"About Connect";
	
	Scroll1.hidden=YES;
	Scroll2.hidden=YES;
	Scroll3.hidden=NO;
	Scroll4.hidden=YES;
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		lblTop.frame=CGRectMake(275,4,800,30);
		
		LblThirdscreen1.hidden=YES;
		LblThirdscreen2.hidden=YES;
		LblThirdscreen3.hidden=YES;
		LblThirdscreen4.hidden=YES;
		image3.frame=CGRectMake(0,0,654,790);	
		image3.image=[UIImage imageNamed:@"_0002_App-AboutConnect-New22-1-1.png"];		
		
		[BtnBottom1 setImage:[UIImage imageNamed:@"_0012_stage_1-1.png"] forState:UIControlStateNormal];
		[BtnBottom2 setImage:[UIImage imageNamed:@"_0011_stage_1-2.png"] forState:UIControlStateNormal];
		[BtnBottom4 setImage:[UIImage imageNamed:@"_0000_Normal-Landscape-icon.png"] forState:UIControlStateNormal];
		[BtnBottom3 setImage:[UIImage imageNamed:@"_0002_stage_3-3.png"] forState:UIControlStateNormal];
		
	}else{
		lblTop.frame=CGRectMake(404,2,800,30);
		image3.frame=CGRectMake(0,0,800,800);
		image3.image=[UIImage imageNamed:@"Land_App-AboutConnect-1-New22-1-1.png"];
		[BtnBottom1 setImage:[UIImage imageNamed:@"UNSEL_MESSAGE.png"] forState:UIControlStateNormal];
		[BtnBottom2 setImage:[UIImage imageNamed:@"UNSEL_AUTHOR.png"] forState:UIControlStateNormal];
		[BtnBottom4 setImage:[UIImage imageNamed:@"_0000_Normal-port.-icon.png"] forState:UIControlStateNormal];
		[BtnBottom3 setImage:[UIImage imageNamed:@"Contact_sel.png"] forState:UIControlStateNormal];
		
	} 	
}
-(IBAction)ButtonClick4:(id)sender{
	counter=4;
    lblTop.text=@"Buy the Book";
	Scroll1.hidden=YES;
	Scroll2.hidden=YES;
	Scroll3.hidden=YES;
	Scroll4.hidden=NO;
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{	
		lblTop.frame=CGRectMake(283,2,800,30);
		image4.image=[UIImage imageNamed:@"Buy-the-Book-P-1.png"];
		image4.frame=CGRectMake(0, 0,654 ,248);
		BtnLink.frame=CGRectMake(140,165 ,280 ,30);	
		[BtnBottom1 setImage:[UIImage imageNamed:@"_0012_stage_1-1.png"] forState:UIControlStateNormal];
		[BtnBottom2 setImage:[UIImage imageNamed:@"_0011_stage_1-2.png"] forState:UIControlStateNormal];
		[BtnBottom4 setImage:[UIImage imageNamed:@"_0001_Active-icon.png"] forState:UIControlStateNormal];
		[BtnBottom3 setImage:[UIImage imageNamed:@"_0010_stage_1-3.png"] forState:UIControlStateNormal];
	}else{
		lblTop.frame=CGRectMake(412,2,800,30);
		image4.image=[UIImage imageNamed:@"Buy-the-Book-L-1.png"];
		image4.frame=CGRectMake(0, 0,800 ,208);
		BtnLink.frame=CGRectMake(50,140,260 ,40);
		[BtnBottom1 setImage:[UIImage imageNamed:@"UNSEL_MESSAGE.png"] forState:UIControlStateNormal];
		[BtnBottom2 setImage:[UIImage imageNamed:@"UNSEL_AUTHOR.png"] forState:UIControlStateNormal];
		[BtnBottom4 setImage:[UIImage imageNamed:@"_0001_Active-Port--icon.png"] forState:UIControlStateNormal];
		[BtnBottom3 setImage:[UIImage imageNamed:@"Connect_UN.png"] forState:UIControlStateNormal];
		
	} 	
}

#pragma mark URL CLICK
-(IBAction)ButtonURLCLICK:(id)sender{
	if (counter==4) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.coursesmart.com"]];

	}
	else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://connect.mcgraw-hill.com"]];

	}
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	ori= interfaceOrientation;
	
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
