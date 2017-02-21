//
//  JJSButton.m
//  JJSOA
//
//  Created by Koson on 15-2-12.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "DouDouButton.h"

@implementation DouDouButton

@synthesize imageViewRect,titleLabelRect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setExclusiveTouch:YES];
    }
    return self;
}

#pragma mark -
#pragma mark setting image bounds for button
/**
 *  Image rect
 *
 *  @param contentRect content rect
 *
 *  @return image rect
 *
 *  @since 1.0.0
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    return self.imageViewRect;
    
}

/**
 *  Title rect
 *
 *  @param CGRecttitleRectForContentRect:CGRect content rect
 *
 *  @return title rect
 *
 *  @since 1.0.0
 */
#pragma mark -
#pragma mark setting title label bounds for button
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    return self.titleLabelRect;
    
}

@end
