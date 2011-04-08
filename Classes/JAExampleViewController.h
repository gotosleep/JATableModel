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
