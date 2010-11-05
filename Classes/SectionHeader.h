//
//  SectionHeader.h
//
//  Created by Jesse Andersen on 11/20/09.
//  Copyright 2009 Numjin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SectionHeader : UIView {
	UILabel *_title;
	CGSize _padding;
}

@property (nonatomic, readonly) UILabel *title;

+ (id)headerWithText:(NSString *)text font:(UIFont *)font;
+ (id)headerWithText:(NSString *)text;

- (id)initWithText:(NSString *)text font:(UIFont *)font padding:(CGSize)padding;
- (CGFloat) height;
@end
