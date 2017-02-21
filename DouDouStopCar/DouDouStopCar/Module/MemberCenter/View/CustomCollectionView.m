//
//  CustomCollectionView.m
//  xxxxx
//
//  Created by on 16/11/3.
//  Copyright © 2016年 Tony. All rights reserved.
//
#define KItemHeight 40
#import "CustomCollectionView.h"

@interface CustomCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView *_headerView;
    NSArray *_proviceArr;
    UICollectionView *_collectionView;
    UIButton *_deleteBtn;
}
@end
@implementation CustomCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        _headerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_headerView];
        
//        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
//        [sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        sureBtn.frame = CGRectMake(frame.size.width - 50, 0, 40, 30);
//        [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
//        [_headerView addSubview:sureBtn];
        
        
        UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _headerView.frame.origin.y + _headerView.frame.size.height, frame.size.width, 0) collectionViewLayout:flowOut];
        collectionView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0  blue:223/255.0  alpha:1.0];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:collectionView];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView = collectionView;

        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setImage:[UIImage imageNamed:@"keyboard_delete"] forState:UIControlStateNormal];
        [self addSubview:_deleteBtn];
        
        
    }
    return self;
}
- (void)changeDataSourceWithIndex:(NSInteger)index{
    NSArray *arr = @[@"京",
                    @"沪",
                    @"津",
                    @"渝",
                    @"黑",
                    @"吉",
                    @"辽",
                    @"蒙",
                    @"冀",
                    @"新",
                    @"甘",
                    @"青",
                    @"陕",
                    @"宁",
                    @"豫",
                    @"鲁",
                    @"晋",
                    @"皖",
                    @"鄂",
                    @"湘",
                    @"苏",
                    @"川",
                    @"贵", //贵州省
                    @"黔", //贵州省
                    @"滇",
                    @"桂",
                    @"藏",
                    @"浙",
                    @"赣",
                    @"粤",
                    @"闽",
                    @"台",
                    @"琼",
                    @"港"];
    NSArray *numAndLetterArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",
                        @"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",
                        @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"Z",@"X",
                        @"C",@"V",@"B",@"N",@"M",@"L"];
    NSArray *letterArr = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",
                         @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"Z",@"X",
                         @"C",@"V",@"B",@"N",@"M",@"L"];
    NSArray *totalArr = @[arr,letterArr,numAndLetterArr];
    if (index > 2) {
        index = 2;
    }
    _proviceArr = totalArr[index];
    CGFloat height = 0;
    switch (index) {
        case 0:
            height = (KItemHeight + 3) * 4;
            break;
            case 1:
            height = (KItemHeight + 3) * 3;
            break;
            case 2:
            height = (KItemHeight + 3) * 4;
            break;
        default:
            break;
    }
    _collectionView.height = height;
    self.height = _headerView.height + _collectionView.height;
    _deleteBtn.frame = CGRectMake(mScreenWidth - 60, self.height - KItemHeight, 60, KItemHeight);

    [_collectionView reloadData];
}
- (void)delete{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *la = [cell.contentView viewWithTag:100];
    [la removeFromSuperview];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell.frame.size.width - 10, KItemHeight - 10)];
    label.tag = 100;
    label.text = _proviceArr[indexPath.row];
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = 0.5;
    label.backgroundColor = [UIColor whiteColor];
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label.textAlignment = NSTextAlignmentCenter;
    cell.layer.cornerRadius = 2;
    cell.layer.masksToBounds = YES;
    [cell.contentView addSubview:label];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectBlock) {
        self.selectBlock(_proviceArr[indexPath.row]);
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _proviceArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((mScreenWidth - 30)/10, KItemHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
- (void)sureClick{
    if (self.sureBlock) {
        self.sureBlock();
    }
}
@end
