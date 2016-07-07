//
//  CountDownCell.h
//  倒计时
//
//  Created by Maker on 16/7/6.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleIV;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@end
