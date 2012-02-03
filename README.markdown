This project aims to provide an object oriented abstraction for the underlying data in a `UITableView`.

The `UITableView` is broken down into three basic data pieces:
 - the table, represented by `JATableModel`
 - sections in the table, represented by `JASectionModel`
 - and finally rows in a section, represented by `JARowModel`

A custom `UITableViewController` subclass, `JATableViewController`, handles mapping `UITableViewDelegate` & `UITableViewDataSource` methods to the appropriate models. `JATableModel` makes creating tables in iOS quick and easy.

How about an example? (full example is included in the library)

``` objc
//
//  ExampleViewController.h
//  iOSTableModel
//
//  Created by Jesse Andersen on 10/19/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JATableViewController.h"

@interface JAExampleViewController : JATableViewController {
	NSMutableArray *_data;
}

@property (nonatomic, retain) NSMutableArray *data;

@end

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
    
    // Creating a __block variable for self is required to avoid retain cycles
    __block typeof(self) blockSelf = self;

    [_data release], _data = [[NSMutableArray alloc] initWithObjects:@"First", @"Second", @"Third", @"Fourth", @"Fifth",
                              @"Sixth", @"Seventh", @"Eighth", nil];
    
    // Setup the section
    JASectionModel *section = [self.tableModel createSection];
    section.headerText = @"Header Text";
    section.footerText = @"Footer Text";
    
    JARowModel *row = nil;
    
    // This setup block can be reused for each row
    SetupCell setup = ^(UITableViewCell *cell, UITableView *view, NSIndexPath *indexPath, UIViewController *controller) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    };
    
    // Add rows to the section
    for (NSString *item in self.data) {
        row = [section createRowWithStyle:UITableViewCellStyleValue1];
        row.setupCellBlock = setup;
        row.text = item;
        row.detailText = @"detail";
        
        // Pass a block to be invoked when this cell is selected
        row.drilldown = ^(JARowModel *model) {
            NSString *msg = [NSString stringWithFormat:@"You clicked: %@!", item];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This is easy." message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alert show];
            [alert release];
            [blockSelf.tableView deselectRowAtIndexPath:[blockSelf.tableView indexPathForSelectedRow] animated:YES];
        };
    }
}

@end
```