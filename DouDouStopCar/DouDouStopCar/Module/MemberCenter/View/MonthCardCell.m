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

- (void)refreshDataWith:(MonthCardModel *)model
{
    [self.labParkingName setText:model.parkingName];
    [self.labPrice setText:[NSString stringWithFormat:@"%@元/月",model.price]];
    [self.labPlatNum setText:model.plateNumber];
    if (model.state == 0) {
        [self.labStatus setText:@"未过期"];
    }else{
        [self.labStatus setText:@"已过期"];
    }
}

- (IBAction)goChargeAction:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
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
