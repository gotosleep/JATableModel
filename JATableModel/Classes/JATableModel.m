//
//  TableModel.m
//
//  Created by Jesse Andersen on 6/17/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import "JATableModel.h"
#import "JASectionModel.h"

@implementation JATableModel

@synthesize sectionCount = _sectionCount;
@synthesize tableView = _tableView;

- (id)init {
	if (self = [super init]) {
		_sections = [[NSMutableDictionary alloc] initWithCapacity:10];
	}
	return self;
}

- (void)dealloc {
	self.tableView = nil;
	[_sections release];
	_sections = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Section Helpers

- (JASectionModel *)sectionAtIndex:(NSUInteger)index {
	if (index < _sectionCount) {
		id section = [_sections objectForKey:[NSNumber numberWithInt:index]];
		if ([section isKindOfClass:[JASectionModel class]]) {
			return section;
		}
	}
	return nil;
}

- (JASectionModel *)createSection {
	int index = _sectionCount++;
	JASectionModel *section = [[JASectionModel alloc] initWithTableModel:self];
	section.sectionNum = index;
	[_sections setObject:section forKey:[NSNumber numberWithInt:index]];
	return [section autorelease];
}

- (JASectionModel *)createSectionAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation {
	int index = _sectionCount;
	JASectionModel *section = [self createSection];
	[self.tableView insertSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:animation];
	return section;
}

- (void)reloadSectionAtIndex:(NSUInteger)index withAnimation:(UITableViewRowAnimation)animation {
	NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:index];
	[self.tableView reloadSections:set withRowAnimation:animation];
	[set release];
}


- (void)reloadSection:(JASectionModel *)section withAnimation:(UITableViewRowAnimation)animation {
	[self reloadSectionAtIndex:section.sectionNum withAnimation:animation];
}

- (void)removeSectionAtIndex:(NSUInteger)index {
	if (index < _sectionCount) {
		[_sections removeObjectForKey:[NSNumber numberWithInt:index]];
		if (index == (_sectionCount - 1)) {
			--_sectionCount;
		}
	}
}

- (void)removeSectionAtIndex:(NSUInteger)index andUpdateViewWithAnimation:(UITableViewRowAnimation)animation {
	if (index < _sectionCount) {
		[self removeSectionAtIndex:index];
		[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:animation];
	}
}


- (int)removeAllSections {
	int removedCount = _sectionCount;
	[_sections removeAllObjects];
	_sectionCount = 0;
	return removedCount;
}

- (int)removeAllSectionsAndUpdateViewWithAnimation:(UITableViewRowAnimation)animation {
	int removedCount = [self removeAllSections];
	if (removedCount > 0) {
		NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
		for (int i = 0; i < removedCount; ++i) {
			[indexes addIndex:i];
		}
		[self.tableView deleteSections:indexes withRowAnimation:animation];
		[indexes release];
	}
	return removedCount;
}

@end