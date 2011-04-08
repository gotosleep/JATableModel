//
//  SectionModel.h
//
//  Created by Jesse Andersen on 2/4/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JATableCellModel, JATableModel;

@interface JASectionModel : NSObject {
	NSMutableArray *_rows;
	UIView *_headerView;
	UIView *_footerView;
	NSString *_headerText;
	NSString *_footerText;
	int _sectionNum;
	JATableModel *_tableModel;
}

@property (nonatomic, readonly, assign) JATableModel *tableModel;
@property (nonatomic) int sectionNum;
@property (nonatomic, retain) NSMutableArray *rows;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) NSString *headerText;
@property (nonatomic, retain) NSString *footerText;

- (JATableCellModel *)createRow;
- (JATableCellModel *)createRowAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (JATableCellModel *)createRowWithStyle:(UITableViewCellStyle)style;
- (JATableCellModel *)addRow:(JATableCellModel *)row;
- (JATableCellModel *)addRow:(JATableCellModel *)row andUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (void)reloadWithAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowAtIndex:(int)index withAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRow:(JATableCellModel *)row withAnimation:(UITableViewRowAnimation)animation;
- (void)removeRowAtIndex:(NSUInteger)index;
- (void)removeRowAtIndex:(NSUInteger)index andUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (void)removeAllRows;
- (void)removeAllRowsAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation;

- (id)initWithTableModel:(JATableModel *)tableModel;

@end