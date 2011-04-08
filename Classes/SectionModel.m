//
//  SectionModel.m
//
//  Created by Jesse Andersen on 2/4/10.
//  Copyright 2010 Numjin. All rights reserved.
//
#import "SectionModel.h"
#import "BaseTableCellModel.h"
#import "TableModel.h"

@implementation SectionModel

@synthesize rows = _rows, headerView = _headerView, footerView = _footerView, headerText = _headerText, footerText = _footerText;

@synthesize sectionNum = _sectionNum;
@synthesize tableModel = _tableModel;

- (id)initWithTableModel:(TableModel *)tableModel {
	if (self = [super init]) {
		_tableModel = tableModel;
		self.rows = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
	}
	return self;
}

- (void)dealloc {
	_tableModel = nil;
	self.headerText = nil;
	self.footerText = nil;
	self.rows = nil;
	self.headerView = nil;
	self.footerView = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Row Methods

- (BaseTableCellModel *)createRow {
	return [self createRowWithStyle:UITableViewCellStyleDefault];
}

- (BaseTableCellModel *)createRowWithStyle:(UITableViewCellStyle)style {
	BaseTableCellModel *row = [[BaseTableCellModel alloc] init];
	row.section = self;
	row.style = style;
	[self.rows addObject:row];
	return [row autorelease];
}

- (BaseTableCellModel *)createRowAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation {
	BaseTableCellModel *row = [self createRow];
	NSArray *path = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:([self.rows count]-1) inSection:self.sectionNum]];
	[self.tableModel.tableView insertRowsAtIndexPaths:path withRowAnimation:animation];
	return row;
}

- (BaseTableCellModel *)addRow:(BaseTableCellModel *)row {
	row.section = self;
	[self.rows addObject:row];
	return row;
}

- (BaseTableCellModel *)addRow:(BaseTableCellModel *)row andUpdateViewWithAnimation:(UITableViewRowAnimation)animation {
	[self addRow:row];
	NSArray *path = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:([self.rows count]-1) inSection:self.sectionNum]];
	[self.tableModel.tableView insertRowsAtIndexPaths:path withRowAnimation:animation];
	return row;
}

- (void)reloadWithAnimation:(UITableViewRowAnimation)animation {
	[self.tableModel reloadSection:self withAnimation:animation];
}

- (void)reloadRowAtIndex:(int)index withAnimation:(UITableViewRowAnimation)animation {
	NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:_sectionNum];
	NSArray *paths = [NSArray arrayWithObject:path];
	[self.tableModel.tableView reloadRowsAtIndexPaths:paths withRowAnimation:animation];
}

- (void)reloadRow:(BaseTableCellModel *)row withAnimation:(UITableViewRowAnimation)animation {
	int index = [self.rows indexOfObject:row];
	if (index != NSNotFound) {
		[self reloadRowAtIndex:index withAnimation:animation];
	}
}

- (void)removeRowAtIndex:(NSUInteger)index {
	if (index < [self.rows count]) {
		[self.rows removeObjectAtIndex:index];
	}
}

- (void)removeRowAtIndex:(NSUInteger)index andUpdateViewWithAnimation:(UITableViewRowAnimation)animation {
	if (index < [self.rows count]) {
		NSArray *path = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:_sectionNum]];
		[self removeRowAtIndex:index];
		[self.tableModel.tableView deleteRowsAtIndexPaths:path withRowAnimation:animation];
	}
}

- (void)removeAllRows {
	[self.rows removeAllObjects];
}

- (void)removeAllRowsAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation {
	NSMutableArray *paths = [NSMutableArray arrayWithCapacity:[self.rows count]];
	for (int i = 0; i < [self.rows count]; ++i) {
		[paths addObject:[NSIndexPath indexPathForRow:i inSection:_sectionNum]];
	}
	[self removeAllRows];
	[self.tableModel.tableView deleteRowsAtIndexPaths:paths withRowAnimation:animation];
}

@end