//
//  TableButtonModel.h
//
//  Created by Jesse Andersen on 12/7/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JARowModel, JASectionModel;

typedef void (^SetupNewCell)(UITableViewCell *, UITableView *, NSIndexPath *, UIViewController *);
typedef void (^SetupCell)(UITableViewCell *, UITableView *, NSIndexPath *, UIViewController *);
typedef void (^Drilldown)(JARowModel *);
typedef void (^CommitEditing)(UITableView *, UITableViewCellEditingStyle, NSIndexPath *);

@interface JARowModel : NSObject {
	UITableViewCellStyle _style;
	NSString *_text, *_detailText;
	SetupNewCell setupNewCellBlock;
	SetupCell setupCellBlock;
	Drilldown drilldown;
	CommitEditing commitEditingBlock;
	NSString *_setupBlockHash;
	JASectionModel *_section;
	BOOL _enabled;
}

@property (nonatomic) BOOL enabled;
@property (nonatomic, assign) JASectionModel *section;
@property (nonatomic, copy) NSString *text, *detailText;
@property (nonatomic) UITableViewCellStyle style;
@property (nonatomic, copy) SetupNewCell setupNewCellBlock;
@property (nonatomic, copy) SetupCell setupCellBlock;
@property (nonatomic, copy) Drilldown drilldown;
@property (nonatomic, copy) CommitEditing commitEditingBlock;

+ (id)model;
+ (id)modelWithStyle:(UITableViewCellStyle)style;
+ (id)modelWithStyle:(UITableViewCellStyle)style text:(NSString *)text detailText:(NSString *)detailText;
+ (id)modelWithStyle:(UITableViewCellStyle)style text:(NSString *)text detailText:(NSString *)detailText setup:(SetupCell)block;
+ (id)modelWithText:(NSString *)text detailText:(NSString *)detailText;

+ (NSString *)identifier;

- (UITableViewCell *)getCellWithTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller;
- (NSString *)identifierInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller;
- (UITableViewCell *)createNewCellInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller ident:(NSString *)ident;
- (void)setupNewCell:(UITableViewCell *)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller;
- (void)setupCell:(UITableViewCell*)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller;
- (CGFloat)heightInTable:(UITableView *)tableView;

#pragma mark Helper Methods

- (void)reloadWithAnimation:(UITableViewRowAnimation)animation;

@end
