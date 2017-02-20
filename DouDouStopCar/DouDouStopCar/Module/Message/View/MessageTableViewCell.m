//
//  MessageTableViewCell.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/19.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

+ (MessageTableViewCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"memberCell"];
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell"];
    if (!cell) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"memberCell"];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
