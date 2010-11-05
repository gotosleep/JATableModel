//
//  SectionHeader.m
//  westcable
//
//  Created by Jesse Andersen on 11/20/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import "SectionHeader.h"

@implementation SectionHeader

@synthesize title = _title;

+ (id)headerWithText:(NSString *)text font:(UIFont *)font {
	return [[[self alloc] initWithText:text font:font padding:CGSizeMake(20.0, 8.0)] autorelease];
}

+ (id)headerWithText:(NSString *)text {
	return [[[self alloc] initWithText:text font:[UIFont fontWithName:@"Helvetica-Bold" size:18.0] padding:CGSizeMake(20.0, 8.0)] autorelease];
}

- (id)initWithText:(NSString *)text font:(UIFont *)font padding:(CGSize)padding {
	CGSize size = [text sizeWithFont:font];
	CGRect frame = CGRectMake(0, 0, size.width + padding.width, size.height + padding.height);
	if (self = [super initWithFrame:frame]) {
		_padding = padding;
		frame = CGRectMake(padding.width/2, padding.height/2, size.width, size.height);
		_title = [[UILabel alloc] initWithFrame:frame];
		_title.font = font;
		_title.backgroundColor = [UIColor clearColor];
		_title.text = text;
		[self addSubview:_title];
	}
    return self;
}

- (CGFloat) height {
	return self.frame.size.height;
}

- (void)dealloc {
	[_title release];
    [super dealloc];
}

@end
