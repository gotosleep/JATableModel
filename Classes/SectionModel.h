//
//  SectionModel.h
//
//  Created by Jesse Andersen on 2/4/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseTableCellModel, TableModel;

@interface SectionModel : NSObject {
	NSMutableArray *_rows;
	UIView *_headerView;
	UIView *_footerView;
	NSString *_headerText;
	NSString *_footerText;
	int _sectionNum;
	TableModel *_tableModel;
}

@property (nonatomic, readonly, assign) TableModel *tableModel;
@property (nonatomic) int sectionNum;
@property (nonatomic, retain) NSMutableArray *rows;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) NSString *headerText;
@property (nonatomic, retain) NSString *footerText;

- (BaseTableCellModel *)createRow;
- (BaseTableCellModel *)createRowAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (BaseTableCellModel *)createRowWithStyle:(UITableViewCellStyle)style;
- (BaseTableCellModel *)addRow:(BaseTableCellModel *)row;
- (BaseTableCellModel *)addRow:(BaseTableCellModel *)row andUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (void)reloadWithAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowAtIndex:(int)index withAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRow:(BaseTableCellModel *)row withAnimation:(UITableViewRowAnimation)animation;
- (void)removeRowAtIndex:(NSUInteger)index;
- (void)removeRowAtIndex:(NSUInteger)index andUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (void)removeAllRows;
- (void)removeAllRowsAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation;

- (id)initWithTableModel:(TableModel *)tableModel;

@end