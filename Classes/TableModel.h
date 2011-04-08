//
//  TableModel.h
//
//  Created by Jesse Andersen on 6/17/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SectionModel;

@interface TableModel : NSObject {
	NSMutableDictionary *_sections;
	int _sectionCount;
	UITableView *_tableView;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, readonly) int sectionCount;

- (SectionModel *)sectionAtIndex:(NSUInteger)index;
- (SectionModel *)createSection;
- (SectionModel *)createSectionAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (void)reloadSection:(SectionModel *)section withAnimation:(UITableViewRowAnimation)animation;
- (void)reloadSectionAtIndex:(NSUInteger)index withAnimation:(UITableViewRowAnimation)animation;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)removeSectionAtIndex:(NSUInteger)index andUpdateViewWithAnimation:(UITableViewRowAnimation)animation;
- (int)removeAllSections;
- (int)removeAllSectionsAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation;

@end