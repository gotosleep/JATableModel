//
//  BaseTableCell.m
//
//  Created by Jesse Andersen on 1/13/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import "BaseTableCell.h"
#import "UIView+NumjinAdditions.h"

@implementation BaseTableCell

@synthesize progress = _progress;

- (void)dealloc {
	[_progress release];
	_progress = nil;
    [super dealloc];
}

- (void)willDisplayModel:(BaseTableCellModel *)model {
	self.detailTextLabel.backgroundColor = [UIColor clearColor];
	self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)startProgress {
	[_progress release];
	_progress = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	self.progress.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
	[self.contentView addSubview:self.progress];
	[self.contentView bringSubviewToFront:self.progress];
	[self.progress centerInView:self.contentView];
	[self.progress startAnimating];
}

- (void)endProgress {
	[self.progress removeFromSuperview];
	[_progress release];
	_progress = nil;
}

@end
