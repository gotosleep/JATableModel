//
//  BaseTableViewController.h
//  westcable
//
//  Created by Jesse Andersen on 12/3/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionModel.h"
#import "BaseTableCellModel.h"
#import "TableModel.h"
#import "InputCellModel.h"
#import "InputTableCell.h"

@class SectionModel;

@interface BaseTableViewController : UITableViewController {
	UIViewController *_returnVC;
	BOOL _editable;
	TableModel *_tableModel;
	TableModel *_searchTableModel;
}

@property (nonatomic, retain) TableModel *tableModel;
@property (nonatomic, retain) TableModel *searchTableModel;
@property (nonatomic, retain) UIViewController *returnVC;
@property (nonatomic) BOOL editable;

#pragma mark -
#pragma mark Displaying

- (void)layoutTable;

@end
