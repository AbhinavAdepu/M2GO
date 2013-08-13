#import "OMPageControl.h"

@interface OMPageControl (Private)
- (void) updateDots;
@end


@implementation OMPageControl

@synthesize imageNormal = mImageNormal;
@synthesize imageCurrent = mImageCurrent;

- (void) dealloc
{
	[mImageNormal release], mImageNormal = nil;
	[mImageCurrent release], mImageCurrent = nil;
	
	[super dealloc];
}


/** override to update dots */
- (void) setCurrentPage:(NSInteger)currentPage
{
	[super setCurrentPage:currentPage];
	
	// update dot views
	[self updateDots];
}

/** override to update dots */
- (void) updateCurrentPageDisplay
{
	[super updateCurrentPageDisplay];
	
	// update dot views
	[self updateDots];
}

/** Override setImageNormal */
- (void) setImageNormal:(UIImage*)image
{
	[mImageNormal release];
	mImageNormal = [image retain];
	
	// update dot views
	[self updateDots];
}

/** Override setImageCurrent */
- (void) setImageCurrent:(UIImage*)image
{
	[mImageCurrent release];
	mImageCurrent = [image retain];
	
	// update dot views
	[self updateDots];
}

/** Override to fix when dots are directly clicked */
- (void) endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event 
{
	[super endTrackingWithTouch:touch withEvent:event];
	
	[self updateDots];
}

#pragma mark - (Private)

- (void) updateDots
{
  @try
	{
		if(mImageCurrent || mImageNormal)
		{
			NSArray* dotViews = self.subviews;
			for(int i = 0; i < [dotViews count]; ++i)
			{
				UIImageView* dot = [dotViews objectAtIndex:i];
				dot.image = (i == self.currentPage) ? mImageCurrent : mImageNormal;
			}
		}
		
    }
  @catch (NSException * e) 
	{
		//NSLog(@"NSException==>%@",e);
 
	}
 
}

@end