//
//  CashOrPrivilCell.m
//  DouDouStopCar
//
//  Created by Rainer on 17/3/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "CashOrPrivilCell.h"

@implementation CashOrPrivilCell

+ (CashOrPrivilCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"CashOrPrivilCell" bundle:nil] forCellReuseIdentifier:@"cashCell"];
    CashOrPrivilCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cashCell"];
    if (!cell) {
        cell = [[CashOrPrivilCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cashCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)refreshDataWith:(CashRecordModel *)model
{
    NSString *paytype = @"";
    if (model.payType == 1) {
        paytype = @"支付宝";
    }else if (model.payType == 2) {
        paytype = @"微信";
    }else{
        paytype = @"银行卡";
    }
    [self.labTitle setText:paytype];
    
    [self.labTime setText:model.startDate];
    [self.labAmount setText:[NSString stringWithFormat:@"%@元",model.cash]];
    
    NSString *status = @"";
    if (model.state == 1) {
        status = @"审核中";
    }else if (model.state == 2) {
        status = @"体现完成";
    }else{
        status = @"未通过审核";
    }
    [self.labStatus setText:status];
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
