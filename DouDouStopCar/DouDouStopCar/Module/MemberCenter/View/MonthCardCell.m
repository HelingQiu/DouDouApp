//
//  MonthCardCell.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MonthCardCell.h"

@implementation MonthCardCell

+ (MonthCardCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"MonthCardCell" bundle:nil] forCellReuseIdentifier:@"monthcardCell"];
    MonthCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthcardCell"];
    if (!cell) {
        cell = [[MonthCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"monthcardCell"];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
