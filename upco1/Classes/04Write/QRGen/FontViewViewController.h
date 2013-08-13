//
//  FontViewViewController.h
//  FontView
//
//  Created by Amitesh Kumar on 12/5/11.
//  Copyright 2011 Silver Touch Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableCell.h"

@protocol dateSelectedDelegate <NSObject>
@property(nonatomic) BOOL isBold;
@property(nonatomic) BOOL isItalic;
@property(nonatomic) BOOL isUnderline;

@optional
-(void) styleselected:(int) index;
-(void) alignmentselected:(int) index;
-(void) fontandsizeselected:(NSString*) fontname:(int) size :(int) style :(int) alignment:(int) color:(int) fontIndex:(int) lastFontsize;
-(void) fontcolorselected:(NSString*) color;

@end

@interface FontViewViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate>{

	IBOutlet UITableView *mainTableView;
	
	IBOutlet TableCell *cell;
	
	IBOutlet UIButton *mainBtn;
	
	IBOutlet UIPickerView *pickerView;
	
	IBOutlet UIButton *colorBtn1;
	IBOutlet UIButton *colorBtn2;
	IBOutlet UIButton *colorBtn3;
	IBOutlet UIButton *colorBtn4;
	IBOutlet UIButton *colorBtn5;
	IBOutlet UIButton *colorBtn6;
	IBOutlet UIButton *colorBtn7;
	IBOutlet UIButton *colorBtn8;
	
	UIImageView *selimage;
	UIFont *fontType;
	float fontSize;
	id<dateSelectedDelegate> delegate;
	int styleIndex;
	int alignIndex;
	int colorIndex;
	
	int lastFontIndex;
	int lastfontSize;
	NSArray *familyNames;
	
	BOOL Bold;
	BOOL Underline;
	BOOL Italic;
	
	IBOutlet UINavigationBar *nvBar;
	
}
@property(nonatomic) BOOL Bold;
@property(nonatomic) BOOL Underline;
@property(nonatomic) BOOL Italic;

@property(nonatomic) int lastfontSize;
@property(nonatomic, readwrite) 	int lastFontIndex;
@property(nonatomic,readwrite)int styleIndex;
@property(nonatomic,readwrite)int alignIndex;
@property(nonatomic,readwrite)int colorIndex;
@property(nonatomic, retain)id<dateSelectedDelegate> delegate;

@property (nonatomic, retain) UITableView *mainTableView;
@property (nonatomic, retain) UIButton *mainBtn;

@property (nonatomic, retain) UIPickerView *pickerView;


@property (nonatomic, retain) UIButton *colorBtn1;
@property (nonatomic, retain) UIButton *colorBtn2;
@property (nonatomic, retain) UIButton *colorBtn3;
@property (nonatomic, retain) UIButton *colorBtn4;
@property (nonatomic, retain) UIButton *colorBtn5;
@property (nonatomic, retain) UIButton *colorBtn6;
@property (nonatomic, retain) UIButton *colorBtn7;
@property (nonatomic, retain) UIButton *colorBtn8;

@property (nonatomic, retain) UIFont *fontType;


-(IBAction) colorBtnClick : (id)sender;

-(IBAction) cellBtnClick: (id)sender;

-(IBAction) mainBtnClick: (id)sender;

-(IBAction)btnDoneClicked:(id)sender;
-(IBAction)btnCancelClick:(id)sender;
@end

