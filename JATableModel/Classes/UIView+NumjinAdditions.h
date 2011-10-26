//
//  UIView+West.h
//
//  Created by Jesse Andersen on 5/17/10.
//  Copyright 2010 Numjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NumjinAdditions)

#pragma mark Centering & Alignment

- (UIView *)centerInView:(UIView *)parent;
- (UIView *)centerVerticallyInView:(UIView *)parent;
- (UIView *)centerHorizontallyInView:(UIView *)parent;
- (UIView *)alignBottomEdgeWithView:(UIView *)parent;
- (UIView *)alignRightWithView:(UIView *)parent;

#pragma mark Sizing

- (UIView *)autosizeToText:(NSString *)text withFont:(UIFont *)font padding:(CGSize)padding;
- (UIView *)autosizeVerticallyToText:(NSString *)text withFont:(UIFont *)font padding:(CGSize)padding;

@property (nonatomic) CGFloat x, y, width, height;
@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint origin;

@property (nonatomic, readonly) CGFloat horizontalOffset, verticalOffset;

@end
