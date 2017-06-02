//
//  JXStoreBaseMenuViewController.m
//  JXShopDemo
//
//  Created by mac on 17/6/2.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXStoreBaseMenuViewController.h"
#import "UIView+Extension.h"
#import "JXStoreHomeViewController.h"

static NSString * const ID = @"cell";
static CGFloat const kMaxOffset = 230;

@interface JXStoreBaseMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIButton *selButton;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, weak) UIView *underLineView;
@property (nonatomic, assign) BOOL isInitial;
@property(nonatomic, assign) CGFloat lastCollectionViewOffsetY;

@end

@implementation JXStoreBaseMenuViewController

- (NSMutableArray *)titleButtons
{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}
/*
 the item height must be less than the height of the UICollectionView minus the section insets top and bottom values, minus the content insets top and bottom values.
 表示cell的尺寸 超过 UICollectionView尺寸
 UICollectionView尺寸 减去 顶部和底部额外间距
 */
// 显示在最外面的view,就是导航控制器栈顶控制器
// 导航条内容 是由栈顶控制器的navgaitonItem决定
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 搭建底部view：UICollectionView
    [self setupBottomView];
    
    // 搭建顶部view: UIScollowView
    [self setupTopView];
    
    // iOS7之后，如果是导航控制器下scrollView,顶部都会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    // dispatch_once:整个app运行过程中 只会执行一次
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    if (_isInitial == NO) {
        
        // 设置所有标题
        [self setupAllTitle];
        
        _isInitial = YES;
    }
    //    });
    
 
    
}


// 设置所有标题
- (void)setupAllTitle
{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = kScreenW / count;
    CGFloat btnH = _topView.height;
    CGFloat btnX = 0;
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        btnX = i * btnW;
        titleButton.tag = i;
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
        NSString *title = [self.childViewControllers[i] title];
        [titleButton setTitle:title forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        // 设置标题字体
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        // 监听标题按钮点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        // 默认选中第0个按钮
        if (i == 0) {
            [self titleClick:titleButton];
            // 下划线宽度 = 按钮文字宽度
            // 下划线中心点的x = 按钮中心点x
            // 下划线的高度 = 2
            // 下划线的y = topView的height - 2
            // 添加下划线
            // 按钮的标题的宽度不会马上计算，只能手动计算文字宽度
            UIView *underLineView = [[UIView alloc] init];
            underLineView.backgroundColor = [UIColor redColor];
            // 注意：设置中心点，一点要先设置尺寸
            underLineView.width = [title sizeWithFont:[UIFont systemFontOfSize:15]].width;
            underLineView.centerX = titleButton.centerX;
            
            underLineView.height = 2;
            underLineView.y = _topView.height - underLineView.height;
            [_topView addSubview:underLineView];
            _underLineView = underLineView;
        }
    }
}

#pragma mark - 点击标题就会调用
// UICollectionView不能再滚动完成的时候去添加对应的tableView,cell有循环利用，有可能显示其他子控制器View
// 不能再点击标题的时候，去拿到对应cell，往上面添加tableView（对应子控制器的view）
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    // 重复点击相同标题按钮，就刷新当前tableView
    if (button == _selButton) {
        // 重复点击了按钮
        NSLog(@"重复点击了按钮");
        // 获取对应的子控制器
        UIViewController *vc = self.childViewControllers[i];
        
//        [vc reload];
    }
    
    // 1.选中按钮
    [self selButton:button];
    
    // 2.让collectionView滚动到对应位置,并不是马上滚动
    CGFloat offsetX = i * kScreenW;
//    _collectionView.contentOffset = CGPointMake(offsetX, 0);
    
    [_collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    /*
     问题：点击标题，拿不到cell，返回cell方法根本就没有调用
     分析：返回cell方法为什么没有调用 因为没有滚动
     即使滚动了 也拿不到，contentOffset 延迟 ，并不是马上滚动。
     
     */
}

#pragma mark - 选中按钮
- (void)selButton:(UIButton *)button
{
    _selButton.selected = NO;
    button.selected = YES;
    _selButton = button;
    
    // 移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        
        _underLineView.centerX = button.centerX;
        _underLineView.width = button.titleLabel.width;
    }];
}

// 1.添加底部view 2.添加顶部view 3.让collevtionView展示cell 4.调整cell的尺寸 5.取消了顶部额外滚动区域

// 搭建顶部view: UIScollowView
- (void)setupTopView
{
    UIScrollView *topView = [[UIScrollView alloc] init];
    topView.scrollsToTop = NO;
    _topView = topView;
    topView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    CGFloat topY = self.navigationController.navigationBarHidden? 20 : 64;
    topY = kMaxOffset;
    CGFloat topH = 44;
    CGFloat topW = kScreenW;
    
    topView.frame = CGRectMake(0, topY, topW, topH);
    [self.view addSubview:topView];
}

// 搭建底部view：UICollectionView；占据全屏
- (void)setupBottomView
{
    // 设置布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenW, kScreenH);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    // 指示器，cell间距，分页
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.scrollsToTop = NO;
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor greenColor];
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:collectionView];
    
    // 注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    
   
}

#pragma mark - UICollectionViewDataSource
// 有多少个子控制器就有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

// 只要有新的cell显示的时候才会调用
// 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 注意：一定要记得移除之前添加到cell上子控制器
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    // 3.把对应子控制器的view添加到对应的cell 的 contentView
    // 注意:一定要记得设置子控制器的view尺寸和位置
    JXStoreHomeViewController *vc = self.childViewControllers[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    [cell.contentView addSubview:vc.view];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
// collectionView滚动完成就会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger i = scrollView.contentOffset.x / kScreenW;
    // 选中对应的标题
    [self selButton:self.titleButtons[i]];

    
}




@end
