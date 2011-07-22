//
//  ExampleViewController.m
//  iOSTableModel
//
//  Created by Jesse Andersen on 10/19/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import "JAExampleViewController.h"

@implementation JAExampleViewController

@synthesize data = _data;

- (void)dealloc {
    [_data release], _data = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_data release], _data = [[NSMutableArray arrayWithObjects:@"First", @"Second", @"Third", @"Fourth", @"Fifth",
            @"Sixth", @"Seventh", @"Eighth", nil] retain];
    [self display];
}

- (void)display {
    JASectionModel *section = [self.tableModel createSection];
    section.headerText = @"Header Text";
    section.footerText = @"Footer Text";

    JARowModel *row = nil;

    SetupCell setup = ^(UITableViewCell *cell, UITableView *view, NSIndexPath *indexPath, UIViewController *controller) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    };
    for (NSString *item in self.data) {
        row = [section createRowWithStyle:UITableViewCellStyleValue1];
        row.setupCellBlock = setup;
        row.text = item;
        row.detailText = @"blah";
        row.drilldown = ^(JARowModel *model) {
            NSString *msg = [NSString stringWithFormat:@"You clicked: %@!", item];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This is easy." message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alert show];
            [alert release];
            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
        };
    }
}

@end
