//
//  TableButtonModel.h
//  westcable
//
//  Created by Jesse Andersen on 12/7/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseTableCellModel;

typedef void (^SetupNewCell)(UITableViewCell *, UITableView *, NSIndexPath *, UIViewController *);
typedef void (^SetupCell)(UITableViewCell *, UITableView *, NSIndexPath *, UIViewController *);
typedef void (^Drilldown)(BaseTableCellModel *);

@interface BaseTableCellModel : NSObject {
	UITableViewCellStyle _style;
	NSString *_text, *_detailText;
	
	SetupNewCell setupNewCellBlock;
	SetupCell setupCellBlock;
	Drilldown drilldown;
	
	NSString *_setupBlockHash;
}

@property (nonatomic, copy) NSString *text, *detailText;
@property (nonatomic) UITableViewCellStyle style;
@property (nonatomic, copy) SetupNewCell setupNewCellBlock;
@property (nonatomic, copy) SetupCell setupCellBlock;
@property (nonatomic, copy) Drilldown drilldown;

+ (id)model;
+ (id)modelWithStyle:(UITableViewCellStyle)style;
+ (id)modelWithStyle:(UITableViewCellStyle)style text:(NSString *)text detailText:(NSString *)detailText;
+ (id)modelWithStyle:(UITableViewCellStyle)style text:(NSString *)text detailText:(NSString *)detailText setup:(SetupCell)block;
+ (id)modelWithText:(NSString *)text detailText:(NSString *)detailText;

- (UITableViewCell *)getCellWithTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller;
- (NSString *)identifierInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller;
- (UITableViewCell *)createNewCellInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller ident:(NSString *)ident;	
- (void)setupNewCell:(UITableViewCell *)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller;
- (void)setupCell:(UITableViewCell*)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller;

- (CGFloat)heightInTable:(UITableView *)tableView;
@end
