//
//  InputTableCell.h
//
//  Created by Jesse Andersen on 12/12/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableCell.h"

@interface InputTableCell : BaseTableCell {
	UITableViewCell *_cell;
	UILabel *_label;
	UITextField *_textField;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *cell;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UITextField *textField;

@end
