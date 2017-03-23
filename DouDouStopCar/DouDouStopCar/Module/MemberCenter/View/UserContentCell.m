//
//  UserContentCell.m
//  CancerExpertsStudio_Paitent
//
//  Created by 寒冰 梁 on 16/9/2.
//  Copyright © 2016年 KMHealthCloud Co.ltd. All rights reserved.
//

#import "UserContentCell.h"

@implementation UserContentCell

+ (UserContentCell *)cellWithTableView:(UITableView *)tableView
{
    UserContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserContentCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserContentCell" owner:self options:nil] lastObject];
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
