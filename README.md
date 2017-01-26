# Dialog Viewer

## 描述

1. 在 storyboard 中创建 Controller, 用纯代码方式创建自定义 Cell, 必须是 UICollectionViewCell 类的子类
2. 集合视图中, 标题显示人名, 单元显示对话内容

## 知识点

1. UIVCollectionViewController 类可以不声明协议, 即可调用协议方法
2. 执行流: 载入根视图, 从数据源获取分区数和各分区单元数, 辅助类流式布局样式, 从数据源获取内容 cell, 从数据源获取标题 cell

## 参考

《Beginning iPhone Development with Swift: Exploring the iOS SDK》

《精通iOS开发》第7版 第10章 集合视图
