//
//  GroupedTableHeader.m
//
//  Created by Jesse Andersen on 4/8/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import "GroupedTableHeader.h"


@implementation GroupedTableHeader

@synthesize title = _title, button = _button;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor clearColor];
		
		CGFloat x, y, width, height;
		
		self.button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		self.button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		width = self.button.frame.size.width;
		height = self.button.frame.size.height;
		y = floor((frame.size.height - height)/2);
		x = frame.size.width - width - 10;
		self.button.frame = CGRectMake(x, y, width, height);
		[self addSubview:self.button];
		
		x = 18;
		width = frame.size.width - x;
		self.title = [[[UILabel alloc] initWithFrame:CGRectMake(x, 0, width, frame.size.height)] autorelease];
		self.title.backgroundColor = [UIColor clearColor];
		self.title.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.title.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
		self.title.shadowColor = [UIColor whiteColor];
		self.title.shadowOffset = CGSizeMake(0, 1);
		[self addSubview:self.title];
	}
	return self;
}

- (void)dealloc {
	self.button = nil;
	self.title = nil;
	[super dealloc];
}

@end
