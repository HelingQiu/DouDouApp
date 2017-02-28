//
//  MessageTableViewCell.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/19.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "JJSAttributedStringBuilder.h"

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

- (IBAction)gotoCharge:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}

- (void)refreshDataWith:(MessageModel *)model
{
    [self.labTopTime setText:model.inOrOutDate];
    [self.labDate setText:model.inOrOutDate];
    [self.labParkingName setText:[NSString stringWithFormat:@"车场名称：%@",model.parkAddress]];
    if (model.inOrOutType == 0) {//进入
        [self.labTitle setText:@"您已进入停车场"];
        [self.labContent setText:[NSString stringWithFormat:@"亲爱的豆豆会员，您的爱车%@已进入停车场，感谢使用豆豆停车！",model.plateNumber]];
        [self.labTime setText:[NSString stringWithFormat:@"驶入时间：%@",model.inOrOutDate]];
    }else{
        [self.labTitle setText:@"您已驶出停车场"];
        [self.labContent setText:[NSString stringWithFormat:@"亲爱的豆豆会员，您的爱车%@已驶出停车场，感谢使用豆豆停车！",model.plateNumber]];
        [self.labTime setText:[NSString stringWithFormat:@"驶出时间：%@",model.inOrOutDate]];
    }
    
    JJSAttributedStringBuilder *numberBuilder = [[JJSAttributedStringBuilder alloc] initWithString:self.labContent.text];
    [numberBuilder includeString:model.plateNumber all:NO].textColor = kHexColor(kColor_Mian);
    [self.labContent setAttributedText:numberBuilder.commit];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
