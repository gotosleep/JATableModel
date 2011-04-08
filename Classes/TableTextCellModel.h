//
//  TableTextCellModel.h
//
//  Created by Jesse Andersen on 11/12/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableCellModel.h"

@interface TableTextCellModel : BaseTableCellModel {
	UIFont *_font;
}

@property (nonatomic, retain) UIFont *font;

@end
