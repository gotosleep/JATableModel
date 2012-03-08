//
//  TableModel.h
//
//  Created by Jesse Andersen on 6/17/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JASectionModel;
@class JARowModel;

@interface JATableModel : NSObject {
	NSMutableDictionary *_sections;
	int _sectionCount;
	UITableView *_tableView;
}

@property (nonatomic, assign) UITableView *tableView;
@property (nonatomic, readonly) int sectionCount;

- (JASectionModel *)sectionAtIndex:(NSUInteger)index;
- (JASectionModel *)createSection;
- (JASectionModel *)createSectionAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (void)reloadSection:(JASectionModel *)section withAnimation:(UITableViewRowAnimation)animation;
- (void)reloadSectionAtIndex:(NSUInteger)index withAnimation:(UITableViewRowAnimation)animation;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)removeSectionAtIndex:(NSUInteger)index andUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (int)removeAllSections;
- (int)removeAllSectionsAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation;

- (JARowModel *)rowAtIndexPath:(NSIndexPath *)indexPath;

@end
