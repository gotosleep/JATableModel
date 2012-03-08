//
//  TableButtonModel.m
//
//  Created by Jesse Andersen on 12/7/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import "JARowModel.h"
#import "JATableViewCell.h"
#import "JASectionModel.h"

@implementation JARowModel

@synthesize style = _style;
@synthesize setupNewCellBlock, drilldown;
@synthesize text = _text, detailText = _detailText;
@synthesize commitEditingBlock;
@synthesize section = _section;
@synthesize enabled = _enabled;

+ (id)model {
	return [[[self alloc] init] autorelease];
}

+ (id)modelWithStyle:(UITableViewCellStyle)style {
	JARowModel *model = [[self alloc] init];
	model.style = style;
	return [model autorelease];
}

+ (id)modelWithText:(NSString *)text detailText:(NSString *)detailText {
	JARowModel *model = [[self alloc] init];
	model.text = text;
	model.detailText = detailText;
	return [model autorelease];
}

+ (id)modelWithStyle:(UITableViewCellStyle)style text:(NSString *)text detailText:(NSString *)detailText {
	JARowModel *model = [[self alloc] init];
	model.style = style;
	model.text = text;
	model.detailText = detailText;
	return [model autorelease];
}

+ (id)modelWithStyle:(UITableViewCellStyle)style text:(NSString *)text detailText:(NSString *)detailText setup:(SetupCell)block {
	JARowModel *model = [[self alloc] init];
	model.style = style;
	model.text = text;
	model.detailText = detailText;
	model.setupCellBlock = block;
	return [model autorelease];
}

- (void)dealloc {
	_section = nil;
	[_setupBlockHash release], _setupBlockHash = nil;
	[commitEditingBlock release], commitEditingBlock = nil;
	[_text release], _text = nil;
	[_detailText release], _detailText = nil;
	[setupCellBlock release], setupCellBlock = nil;
	[setupNewCellBlock release], setupNewCellBlock = nil;
	[drilldown release], drilldown = nil;
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		_enabled = YES;
	}
	return self;
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
	if ([cell isKindOfClass:[JATableViewCell class]]) {
		JATableViewCell *btc = (JATableViewCell *)cell;
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
+ (NSString *)identifier {
	return CELL_IDENTIFIER;
}

- (NSString *)identifierInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {
	NSMutableString *ident = [NSMutableString stringWithFormat:@"%@-%d", [[self class] identifier], self.style];
	if (_setupBlockHash) {
		[ident appendFormat:@"-%@", _setupBlockHash];
	}
//	NSLog(@"Cell identifier: %@", ident);
	return ident;
}

- (UITableViewCell *)createNewCellInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller ident:(NSString *)ident {
	return [[[JATableViewCell alloc] initWithStyle:self.style reuseIdentifier:ident] autorelease];
}

- (void)setupNewCell:(UITableViewCell *)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {
}

- (void)setupCell:(UITableViewCell*)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {
	cell.textLabel.text = self.text;
	cell.detailTextLabel.text = self.detailText;
	if (self.drilldown) {
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	} else {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
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

#pragma mark Helper Methods

- (void)reloadWithAnimation:(UITableViewRowAnimation)animation {
	[self.section reloadRow:self withAnimation:animation];
}

@end
