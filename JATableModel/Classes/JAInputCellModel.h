//
//  InputCellModel.h
//
//  Created by Jesse Andersen on 12/12/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JARowModel.h"

typedef void (^TextChanged)(UITextField *);

@interface JAInputCellModel : JARowModel {
	
	TextChanged textChangedBlock;
}

@property (nonatomic, copy) TextChanged textChangedBlock;

@end
