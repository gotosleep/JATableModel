//
//  BaseTableViewController.h
//
//  Created by Jesse Andersen on 12/3/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASectionModel.h"
#import "JARowModel.h"
#import "JATableModel.h"
#import "JAInputCellModel.h"
#import "JAInputTableViewCell.h"

@class JASectionModel;

@interface JATableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
	BOOL _editable;
	JATableModel *_tableModel;
	JATableModel *_searchTableModel;
    UITableView *_tableView;
    UITableViewStyle _style;
    BOOL _clearsSelectionOnViewWillAppear;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) JATableModel *tableModel;
@property (nonatomic, retain) JATableModel *searchTableModel;
@property (nonatomic) BOOL editable;
@property (nonatomic, readonly) UITableViewStyle style;
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

- (id)initWithStyle:(UITableViewStyle)style;

- (JATableModel *)tableModelForView:(UITableView *)view;

#pragma mark -
#pragma mark Searching

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView;

@end
