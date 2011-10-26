//
//  BaseTableCell.h
//
//  Created by Jesse Andersen on 1/13/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JARowModel;

@interface JATableViewCell : UITableViewCell {
	UIActivityIndicatorView *_progress;
}

@property (nonatomic, readonly, retain) UIActivityIndicatorView *progress;

- (void)willDisplayModel:(JARowModel *)model;

- (void)startProgress;
- (void)endProgress;

@end
