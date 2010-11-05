//
//  ExampleViewController.m
//  iOSTableModel
//
//  Created by Jesse Andersen on 10/19/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import "ExampleViewController.h"


@implementation ExampleViewController

@synthesize data = _data;

- (void)dealloc {
	[_data release], _data = nil;
	[super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[_data release], _data = [NSMutableArray arrayWithObjects:@"First", @"Second", @"Third", @"Fourth", @"Fifth",
							  @"Sixth", @"Seventh", @"Eight", nil ];
	[self layoutTable];
}

- (void)layoutTable {
	SectionModel *section = [self.tableModel createSection];
	section.headerText = @"Header Text";
	section.footerText = @"Footer Text";
	
	BaseTableCellModel *row = nil;
		
	SetupCell setup = ^(UITableViewCell * cell, UITableView * view, NSIndexPath * indexPath, UIViewController * controller) {
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	};
	for (NSString *item in self.data) {
		row = [section createRowWithStyle:UITableViewCellStyleValue1];
		row.setupCellBlock = setup;
		row.text = item;
		row.detailText = @"blah";
		
		row.drilldown = ^(BaseTableCellModel * model) {
		};
	}
}

@end
