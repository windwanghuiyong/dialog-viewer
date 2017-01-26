//
//  ViewController.m
//  DialogViewer
//
//  Created by wanghuiyong on 25/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "ViewController.h"
#import "HeaderCell.h"

@interface ViewController ()

@property (copy, nonatomic) NSArray *sections;	// 保存显示的内容

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数组长度即为分区个数
    self.sections = @[
  		@{ @"header" : @"First Witch",  @"content" : @"Hey, when will the three of us meet up later?" },
  		@{ @"header" : @"Second Witch", @"content" : @"When everything's straightened out." },
  		@{ @"header" : @"Third Witch",  @"content" : @"That'll be just before sunset." },
  		@{ @"header" : @"First Witch",  @"content" : @"Where?" },	
  		@{ @"header" : @"Second Witch", @"content" : @"The dirt patch." },
  		@{ @"header" : @"Third Witch",  @"content" : @"I guess we'll see Mac there." },
    ];
    // 基于标识符注册可复用的单元类
    [self.collectionView registerClass:[ContentCell class] forCellWithReuseIdentifier:@"CONTENT"];

    // 内容插入位置让出状态栏
    UIEdgeInsets contentInsert = self.collectionView.contentInset;
    contentInsert.top = 20;
    [self.collectionView setContentInset:contentInsert];

    // 获取集合视图中的布局对象, 设置内容边缘
    UICollectionViewLayout *layout = self.collectionView.collectionViewLayout;
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)layout;
    flow.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20);

    // 基于标识符注册标题类, 指定辅助视图种类
    [self.collectionView registerClass:[HeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];

    // 标题尺寸, 有尺寸才会显示标题
    flow.headerReferenceSize = CGSizeMake(100, 25);
    
    NSLog(@"根视图载入完成");
}

#pragma mark -
#pragma mark Collection View Data Source Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"共有%lu个分区", (unsigned long)[self.sections count]);
    return [self.sections count];	// 集合视图分区数(可选实现, 默认为1)
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *words = [self wordsInSection:section];
    NSLog(@"%2ld cells in section %ld", [words count], (long)section);
    return [words count];			// 当前分区单元数(必要实现)
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self wordsInSection:indexPath.section];
    
    // 创建 cell,  初始化各属性
    ContentCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CONTENT" forIndexPath:indexPath];
    cell.maxWidth = collectionView.bounds.size.width;
    cell.text = words[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        // 创建标题 cell, 初始化各属性
        HeaderCell *cell = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        cell.maxWidth = collectionView.bounds.size.width;
        cell.text = self.sections[indexPath.section][@"header"];
        return cell;
    }
    return nil;
}

#pragma mark -
#pragma mark Collection View Delegate Flow Layout Methods
// 辅助类, 流式布局, 代码中只需指定单元尺寸即可
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"section %ld at row %ld", indexPath.section, indexPath.row);
    NSArray *words = [self wordsInSection:indexPath.section];
    CGSize size = [ContentCell sizeForContentString:words[indexPath.row] forMaxWidth:collectionView.bounds.size.width];	// 自定义函数
    return size;
}

#pragma mark -

// 将指定分区中的字符串分离为单词
- (NSArray *)wordsInSection: (NSInteger)section {
    NSString *content = self.sections[section][@"content"];
    NSCharacterSet *space = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *words = [content componentsSeparatedByCharactersInSet:space];
    return words;
}

@end
