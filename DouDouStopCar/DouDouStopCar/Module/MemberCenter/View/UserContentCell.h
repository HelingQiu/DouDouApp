//
//  UserContentCell.h
//  CancerExpertsStudio_Paitent
//
//  Created by 寒冰 梁 on 16/9/2.
//  Copyright © 2016年 KMHealthCloud Co.ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UITextField *contentField;

+ (UserContentCell *)cellWithTableView:(UITableView *)tableView;

@end
