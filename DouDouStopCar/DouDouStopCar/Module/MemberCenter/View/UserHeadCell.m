//
//  UserHeadCell.m
//  CancerExpertsStudio_Paitent
//
//  Created by 寒冰 梁 on 16/9/2.
//  Copyright © 2016年 KMHealthCloud Co.ltd. All rights reserved.
//

#import "UserHeadCell.h"

@implementation UserHeadCell

+ (UserHeadCell *)cellWithTableView:(UITableView *)tableView
{
    UserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserHeadCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserHeadCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end