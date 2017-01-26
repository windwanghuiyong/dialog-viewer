//
//  ContentCell.h
//  DialogViewer
//
//  Created by wanghuiyong on 25/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UICollectionViewCell

@property (strong, nonatomic) UILabel	*label;		// 单元标签(初始化本类时配置)

@property (copy, nonatomic) NSString		*text;		// 单元内容(在控制器中配置)
@property (assign, nonatomic) CGFloat	maxWidth;	// 单元最大宽度(在控制器中配置)

+ (CGSize)sizeForContentString:(NSString *)string forMaxWidth:(CGFloat)maxWidth;

@end
