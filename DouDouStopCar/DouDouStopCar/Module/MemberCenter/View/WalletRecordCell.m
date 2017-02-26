//
//  WalletRecordCell.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/26.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "WalletRecordCell.h"

@implementation WalletRecordCell

+ (WalletRecordCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"WalletRecordCell" bundle:nil] forCellReuseIdentifier:@"walletCell"];
    WalletRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"walletCell"];
    if (!cell) {
        cell = [[WalletRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"walletCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)refreshDataWith:(WalletRecordModel *)model
{
    [self.labAmount setText:model.money];
    [self.labTime setText:model.recordDate];
    if (model.consumeType == 0) {
        [self.labTitle setText:@"充值"];
    }else if (model.consumeType == 1) {
        [self.labTitle setText:@"消费"];
    }
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
