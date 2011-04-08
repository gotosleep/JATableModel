//
//  BaseTableViewController.h
//
//  Created by Jesse Andersen on 12/3/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASectionModel.h"
#import "JATableCellModel.h"
#import "JATableModel.h"
#import "JAInputCellModel.h"
#import "JAInputTableViewCell.h"

@class JASectionModel;

@interface JATableViewController : UITableViewController {
	UIViewController *_returnVC;
	BOOL _editable;
	JATableModel *_tableModel;
	JATableModel *_searchTableModel;
}

@property (nonatomic, retain) JATableModel *tableModel;
@property (nonatomic, retain) JATableModel *searchTableModel;
@property (nonatomic, retain) UIViewController *returnVC;
@property (nonatomic) BOOL editable;

#pragma mark -
#pragma mark Displaying

- (void)display;

#pragma mark -
#pragma mark Searching

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView;

@end