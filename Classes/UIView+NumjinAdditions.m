//
//  UIView+West.m
//  cvs-iphone
//
//  Created by Jesse Andersen on 5/17/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import "UIView+NumjinAdditions.h"


@implementation UIView (NumjinAdditions)

- (UIView *)centerInView:(UIView *)parent {
	[self centerHorizontallyInView:parent];
	[self centerVerticallyInView:parent];
	return self;
}

- (UIView *)centerVerticallyInView:(UIView *)parent {
	CGFloat y = floor((parent.bounds.size.height - self.bounds.size.height)/2);
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
	return self;
}

- (UIView *)centerHorizontallyInView:(UIView *)parent {
	CGFloat x = floor((parent.bounds.size.width - self.bounds.size.width)/2);
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
	return self;
}

- (UIView *)alignBottomEdgeWithView:(UIView *)parent {
	CGFloat bottomEdge = parent.y + parent.height;
	self.y = bottomEdge - self.height;
	return self;
}

- (UIView *)alignRightWithView:(UIView *)parent {
	self.x = parent.width - self.width;
	return self;
}

- (UIView *)autosizeToText:(NSString *)text withFont:(UIFont *)font padding:(CGSize)padding {
	CGSize size = [text sizeWithFont:font];
	self.height = size.height + (padding.height * 2);
	self.width = size.width + (padding.width * 2);
	return self;
}

- (UIView *)autosizeVerticallyToText:(NSString *)text withFont:(UIFont *)font padding:(CGSize)padding {
	CGSize size = [text sizeWithFont:font];
	self.height = size.height + (padding.height * 2);
	return self;
}

- (void)setX:(CGFloat)x {
	CGRect frame = self.frame;
	if (frame.origin.x != x) {
		frame.origin.x = x;
		self.frame = frame;
	}
}

- (CGFloat)x {
	return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
	CGRect frame = self.frame;
	if (frame.origin.y != y) {
		frame.origin.y = y;
		self.frame = frame;
	}
}

- (CGFloat)y {
	return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	if (frame.size.width != width) {		
		frame.size.width = width;
		self.frame = frame;
	}
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	if (frame.size.height != height) {		
		frame.size.height = height;
		self.frame = frame;
	}
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (CGSize)size {
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	CGRect frame = self.frame;
	if (!CGSizeEqualToSize(size, frame.size)) {
		frame.size = size;
		self.frame = frame;
	}
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	if (!CGPointEqualToPoint(origin, frame.origin)) {
		frame.origin = origin;
		self.frame = frame;
	}
}

- (CGFloat)horizontalOffset {
	return self.x + self.width;
}

- (CGFloat)verticalOffset {
	return self.y + self.height;
}


@end
