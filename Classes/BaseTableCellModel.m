//
//  TableButtonModel.m
//
//  Created by Jesse Andersen on 12/7/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import "BaseTableCellModel.h"
#import "BaseTableCell.h"

@implementation BaseTableCellModel

@synthesize style = _style;

//@synthesize setupCellBlock, setupNewCellBlock, drilldown;
@synthesize setupNewCellBlock, drilldown;

@synthesize text = _text, detailText = _detailText;

+ (id)model {
	return [[[self alloc] init] autorelease];
}

+ (id)modelWithStyle:(UITableViewCellStyle)style {
	BaseTableCellModel *model = [[self alloc] init];
	model.style = style;
	return [model autorelease];
}

+ (id)modelWithText:(NSString *)text detailText:(NSString *)detailText {
	BaseTableCellModel *model = [[self alloc] init];
	model.text = text;
	model.detailText = detailText;
	return [model autorelease];
}

+ (id)modelWithStyle:(UITableViewCellStyle)style text:(NSString *)text detailText:(NSString *)detailText {
	BaseTableCellModel *model = [[self alloc] init];
	model.style = style;
	model.text = text;
	model.detailText = detailText;
	return [model autorelease];
}

+ (id)modelWithStyle:(UITableViewCellStyle)style text:(NSString *)text detailText:(NSString *)detailText setup:(SetupCell)block {
	BaseTableCellModel *model = [[self alloc] init];
	model.style = style;
	model.text = text;
	model.detailText = detailText;
	model.setupCellBlock = block;
	return [model autorelease];
}

- (void)dealloc {
	[_setupBlockHash release], _setupBlockHash = nil;
	self.text = nil;
	self.detailText = nil;
	[setupCellBlock release], setupCellBlock = nil;
	self.setupCellBlock = nil;
	self.setupNewCellBlock = nil;
	self.drilldown = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark TableModelProtocol Methods

- (UITableViewCell *)getCellWithTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {
	NSString *ident = [self identifierInTable:tableView indexPath:indexPath controller:controller];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
	if (cell == nil) {
		cell = [self createNewCellInTable:tableView indexPath:indexPath controller:controller ident:ident];
		[self setupNewCell:cell inTable:tableView indexPath:indexPath controller:controller];
		if (self.setupNewCellBlock) {
			self.setupNewCellBlock(cell, tableView, indexPath, controller);
		}
	}
	if ([cell isKindOfClass:[BaseTableCell class]]) {
		BaseTableCell *btc = (BaseTableCell *)cell;
		if (btc.progress) {
			[btc endProgress];
		}
	}
	[self setupCell:cell inTable:tableView indexPath:indexPath controller:controller];
	if (self.setupCellBlock) {
		self.setupCellBlock(cell, tableView, indexPath, controller);
	}
	return cell;
}

#pragma mark -
#pragma mark Cell Creation & Fetching

static NSString *CELL_IDENTIFIER = @"BaseTableCellModel";
- (NSString *)identifierInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {
	NSMutableString *ident = [NSMutableString stringWithFormat:@"%@-%d", CELL_IDENTIFIER, self.style];
	if (_setupBlockHash) {
		[ident appendFormat:@"-%@", _setupBlockHash];
	}
	return ident;
}

- (UITableViewCell *)createNewCellInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller ident:(NSString *)ident {
	return [[[BaseTableCell alloc] initWithStyle:self.style reuseIdentifier:ident] autorelease];	
}

- (void)setupNewCell:(UITableViewCell *)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {	
}

- (void)setupCell:(UITableViewCell*)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {
	cell.textLabel.text = self.text;
	cell.detailTextLabel.text = self.detailText; 
}

- (CGFloat)heightInTable:(UITableView *)tableView {
	return tableView.rowHeight;
}

#pragma mark -
#pragma mark Properties

- (SetupCell)setupCellBlock {
	return setupCellBlock;
}

- (void)setSetupCellBlock:(SetupCell)block {
	[setupCellBlock release];
	setupCellBlock = [block copy];
	/**************************************************************************
	 * Copy the block's hash for use in the table cell's identifier
	 **************************************************************************/
	[_setupBlockHash release];
	if (block) {
		 _setupBlockHash = [[NSString stringWithFormat:@"%qu", [block hash]] retain];
//		NSLog(@"Block Address: %@, %qu", block, [block hash]);
	} else {
		_setupBlockHash = nil;
	}

}

@end
