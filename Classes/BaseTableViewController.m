//
//  BaseTableViewController.m
//  westcable
//
//  Created by Jesse Andersen on 12/3/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SectionHeader.h"
#import "BaseTableCellModel.h"
#import "SectionModel.h"

@interface BaseTableViewController (PrivateMethods)

- (TableModel *)tableModelForView:(UITableView *)view;

@end

@implementation BaseTableViewController

@synthesize returnVC = _returnVC, editable = _editable;
@synthesize tableModel = _tableModel, searchTableModel = _searchTableModel;

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		[_tableModel release], _tableModel = [[TableModel alloc] init];
		[_searchTableModel release], _searchTableModel = [[TableModel alloc] init];
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[_tableModel release], _tableModel = [[TableModel alloc] init];
		[_searchTableModel release], _searchTableModel = [[TableModel alloc] init];
	}
	return self;
}

- (void)dealloc {
	[_tableModel release], _tableModel = nil;
	[_searchTableModel release], _searchTableModel = nil;
	[_returnVC release], _returnVC = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableModel.tableView = self.tableView;
}

#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

- (TableModel *)tableModelForView:(UITableView *)view {
	if (view == self.tableView) {
		return self.tableModel;
	} else {
		return self.searchTableModel;
	}
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self tableModelForView:tableView].sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionNum {
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:sectionNum];
	if (section) {
		return [section.rows count];
	}
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionNum {
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:sectionNum];
	if (section) {
		return section.headerText;
	}
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)sectionNum {
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:sectionNum];
	if (section) {
		return section.footerText;
	}
	return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionNum {	
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:sectionNum];
	if (section) {
		return section.headerView;
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionNum {
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:sectionNum];
	if (section) {
		if (section.headerView) {
			return section.headerView.frame.size.height;
		} else if (section.headerText) {
			if (tableView.style == UITableViewStyleGrouped) {
				return 35;
			} else {
				return 22;
			}
		}
	}
	return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionNum {
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:sectionNum];
	if (section) {
		return section.footerView;
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionNum {
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:sectionNum];
	if (section && section.footerView) {
		return section.footerView.frame.size.height;
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:indexPath.section];
	if (section) {
		if (indexPath.row < [section.rows count]) {
			id row = [section.rows objectAtIndex:indexPath.row];
			if ([row isKindOfClass:[BaseTableCellModel class]]) {
				return [row getCellWithTable:tableView indexPath:indexPath controller:self];
			} 
		}
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:indexPath.section];
	if (section) {
		if (indexPath.row < [section.rows count]) {
			id row = [section.rows objectAtIndex:indexPath.row];
			if ([row isKindOfClass:[BaseTableCellModel class]]) {
				BaseTableCellModel *model = (BaseTableCellModel *)row;
				return [model heightInTable:tableView];
			}
		}
	}
	return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:indexPath.section];
	if (section) {
		if (indexPath.row < [section.rows count]) {
			id row = [section.rows objectAtIndex:indexPath.row];
			if ([row isKindOfClass:[BaseTableCellModel class]]) {
				BaseTableCellModel *model = (BaseTableCellModel *)row;
				if (model.drilldown) {
					model.drilldown(model);
				}
			}
		}
	}
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return self.editable;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		SectionModel *section = [[self tableModelForView:tableView] sectionAtIndex:indexPath.section];
		if (section) {
			if (indexPath.row < [section.rows count]) {
				[section.rows removeObjectAtIndex:indexPath.row];
				[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			}
		}
	}
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.detailTextLabel.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark Displaying

- (void)layoutTable {
	//to be implemented by subclasses
}

#pragma mark -
#pragma mark Searching

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
	self.searchTableModel.tableView = tableView;
}

@end

