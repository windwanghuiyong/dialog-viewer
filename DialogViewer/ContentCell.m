//
//  ContentCell.m
//  DialogViewer
//
//  Created by wanghuiyong on 25/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

// text 属性设值方法
- (NSString *)text {
    NSLog(@"取值方法没用到");
    return self.label.text;		// 并未给 text 属性本身赋值
}

// text 属性取值方法
- (void)setText:(NSString *)text {
    self.label.text = text;		// text 属性本身没有值, 能取到值吗
    
    CGRect newLabelFrame = self.label.frame;					// 单元标签大小
    CGRect newContentFrame = self.contentView.frame;			// 单元内容视图大小
    
    CGSize textSize = [[self class] sizeForContentString:text forMaxWidth:_maxWidth];	// 依据单元字符串内容大小
    newLabelFrame.size = textSize;
    newContentFrame.size = textSize;
    
    self.label.frame = newLabelFrame;					// 更新单元标签大小
    self.contentView.frame = newContentFrame;			// 更新单元内容视图大小
}

// 重写初始化方法
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 配置标签并添加到单元的内容视图
        self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.label.opaque = NO;
        self.label.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [[self class] defaultFont];
        [self.contentView addSubview:self.label];
    }
    return self;
}

// 计算表单元尺寸, 设置字符串属性
+(CGSize)sizeForContentString:(NSString *)string forMaxWidth:(CGFloat)maxWidth {
    // 字符串大小: 宽度固定, 高度最大可扩展到 1000
    CGSize maxSize = CGSizeMake(maxWidth, 1000);
    // 字符串绘制: 决定绘制哪些属性?
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    // 字符串属性: 字体为取偏好设置, 段落风格为字符折行
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributes = @{NSFontAttributeName: [[self class ] defaultFont], NSParagraphStyleAttributeName: style};
    
    CGRect rect = [string boundingRectWithSize:maxSize options:opts attributes:attributes context:nil ];	// 字符串所占尺寸
    
    return rect.size;
}

// 读取"设置"中的字体
+(UIFont *)defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];	// 正文风格
}

@end
