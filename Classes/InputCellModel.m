//
//  InputCellModel.m
//
//  Created by Jesse Andersen on 12/12/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import "InputCellModel.h"
#import "InputTableCell.h"

@implementation InputCellModel

@synthesize textChangedBlock;

- (void)dealloc {
	self.textChangedBlock = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark TableCellModelProtocol Methods

- (UITableViewCell *)createNewCellInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller ident:(NSString *)ident {
	InputTableCell *input = [[[InputTableCell alloc] init] autorelease];	
	return input.cell;
}

- (void)setupNewCell:(UITableViewCell *)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {	
	[super setupNewCell:cell inTable:tableView indexPath:indexPath controller:controller];
}


- (void)setupCell:(UITableViewCell*)cell inTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller {
	//[super setupCell:cell inTable:tableView indexPath:indexPath controller:controller];
	if ([cell isKindOfClass:[InputTableCell class]]) {
		InputTableCell *input = (InputTableCell *)cell;
		input.label.text = self.text;
		[input.textField removeTarget:nil action:@selector(inputCellTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
		[input.textField addTarget:self action:@selector(inputCellTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
//		if (self.autopopulateBlock) {
//			self.autopopulateBlock(input.textField);
//		} else {
//			input.textField = nil;
//		}

	}	
}

static NSString *CELL_IDENTIFIER = @"InputCellModel";
- (NSString *)identifier {
	return CELL_IDENTIFIER;
}

#pragma mark -
#pragma mark Text Field Editing

- (void)inputCellTextFieldChanged:(id)sender {
	if (self.textChangedBlock && [sender isKindOfClass:[UITextField class]]) {
		self.textChangedBlock(sender);
	}
}

@end
