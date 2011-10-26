//
//  InputTableCell.m
//
//  Created by Jesse Andersen on 12/12/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import "JAInputTableViewCell.h"

@implementation JAInputTableViewCell

@synthesize label = _label, textField = _textField, cell = _cell;

- (id)init {
	if (self = [super init]) {
		[[NSBundle mainBundle] loadNibNamed:@"InputTableCell" owner:self options:nil];
		if (self.cell && [self.cell isKindOfClass:[JAInputTableViewCell class]]) {
			JAInputTableViewCell *input = (JAInputTableViewCell *)self.cell;
			input.label = self.label;
			input.textField = self.textField;
		}
	}
	return self;
}

- (void)dealloc {
	self.label = nil;
	self.textField = nil;
	self.cell = nil;
	[super dealloc];
}

@end
