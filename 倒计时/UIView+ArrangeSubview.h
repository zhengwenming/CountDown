//
//  UIView+ArrangeSubview.h
//  倒计时
//
//  Created by Maker on 16/7/5.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface UIView (ArrangeSubview)
-(void)arrangeSubviewWithSpacingHorizontally:(NSArray*)views;
- (void)arrangeSubviewWithSpacingVertically:(NSArray*)views;
@end
