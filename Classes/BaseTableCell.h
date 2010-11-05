//
//  BaseTableCell.h
//  Navi
//
//  Created by Jesse Andersen on 1/13/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTableCellModel;

@interface BaseTableCell : UITableViewCell {
	UIActivityIndicatorView *_progress;
}

@property (nonatomic, readonly, retain) UIActivityIndicatorView *progress;

- (void)willDisplayModel:(BaseTableCellModel *)model;

- (void)startProgress;
- (void)endProgress;

@end
