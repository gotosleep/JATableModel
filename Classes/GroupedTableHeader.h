//
//  GroupedTableHeader.h
//
//  Created by Jesse Andersen on 4/8/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupedTableHeader : UIView {
	UILabel *_title;
	UIButton *_button;
}

@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UIButton *button;

@end
