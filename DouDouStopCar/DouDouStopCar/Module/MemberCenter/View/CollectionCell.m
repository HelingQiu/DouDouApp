//
//  CollectionCell.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

+ (CollectionCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellReuseIdentifier:@"collectionCell"];
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionCell"];
    if (!cell) {
        cell = [[CollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collectionCell"];
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
