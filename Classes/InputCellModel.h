//
//  InputCellModel.h
//  Navi
//
//  Created by Jesse Andersen on 12/12/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableCellModel.h"

typedef void (^TextChanged)(UITextField *);

@interface InputCellModel : BaseTableCellModel {
	
	TextChanged textChangedBlock;
}

@property (nonatomic, copy) TextChanged textChangedBlock;

@end
