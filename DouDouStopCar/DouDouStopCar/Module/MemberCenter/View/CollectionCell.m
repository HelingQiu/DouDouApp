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

- (void)refreshDataWith:(NearbyModel *)model
{
    [self.labName setText:model.name];
    [self.labAddress setText:model.address];
}

- (void)collectionAction:(UITapGestureRecognizer *)sender {
    if (self.block) {
        self.block();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionAction:)];
    [self.collectView addGestureRecognizer:recognizer];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
