//
//  TableTextCellModel.m
//
//  Created by Jesse Andersen on 11/12/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import "JATableTextCellModel.h"


@implementation JATableTextCellModel

@synthesize font = _font;

- (void)dealloc {
	[_font release], _font = nil;
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		_font = [[UIFont fontWithName:@"Helvetica" size:16.0] retain];
	}
	return self;
}

static NSString *CELL_IDENTIFIER = @"TableTextCellModel";
+ (NSString *)identifier {
	return CELL_IDENTIFIER;
}

- (void)setupNewCell:(UITableViewCell *)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {	
	[super setupNewCell:cell inTable:tableView indexPath:indexPath controller:controller];
	cell.textLabel.numberOfLines = 0;
}

- (void)setupCell:(UITableViewCell*)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {
	[super setupCell:cell inTable:tableView indexPath:indexPath controller:controller];
	cell.textLabel.font = self.font;
}

- (CGFloat)heightInTable:(UITableView *)tableView {
	CGSize constraint;
	if (tableView.style == UITableViewStyleGrouped) {
		constraint = CGSizeMake(tableView.frame.size.width - 50, CGFLOAT_MAX);
	} else {
		constraint = CGSizeMake(tableView.frame.size.width, CGFLOAT_MAX);
	}
	CGSize size = [self.text sizeWithFont:self.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	CGFloat height = size.height + 10;
	return height < 44 ? 44 : height;}

@end
