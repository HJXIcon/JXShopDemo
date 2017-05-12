//
//  ViewController.m
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "ViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "JXGoodAttributesView.h"
#import "JXGoodAttrModel.h"
#import "JXTagView.h"
#import "UIScrollView+JXPage.h"
#import "JXGoodDetailsViewController.h"
#import "JXShopCarViewController.h"
#import "JXShopViewModel.h"
#import "GlobalDefine.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static const CGFloat kCycleScrollViewHeight  = 200;

@interface ViewController ()

@property(nonatomic, strong) UIButton *showChoseBtn;

@property(nonatomic,strong) UIViewController *rootViewController;
/*! 遮盖层 */
@property(nonatomic,strong) UIView *maskLayerView;

/*! 弹出View */
@property(nonatomic,strong) JXGoodAttributesView *popView;

/** 商品属性*/
@property (nonatomic, strong) NSArray *goodAttrsArr;

/** 详情控制器*/
@property (nonatomic, strong)JXGoodDetailsViewController *detailsVC;

/*! 视图模型 */
@property(nonatomic, strong) JXShopViewModel *shopViewModel;
@end

@implementation ViewController

#pragma mark - lazy loading

- (JXShopViewModel *)shopViewModel{
    if (_shopViewModel == nil) {
        _shopViewModel = [[JXShopViewModel alloc]init];
    }
    return _shopViewModel;
}

- (JXGoodAttributesView *)popView{
    if (_popView == nil) {
        _popView = [[JXGoodAttributesView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.75)];
        _popView.backgroundColor = [UIColor whiteColor];
        _popView.goodAttrsArr = self.goodAttrsArr;
        __weak typeof(self) weakSelf = self;
        [_popView setCloseBlock:^{
            [weakSelf dismissAction];
        }];
        
    }
    return _popView;
}

- (UIView *)maskLayerView{
    if (_maskLayerView == nil) {
        _maskLayerView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskLayerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        _maskLayerView.alpha = 0;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
        [_maskLayerView addGestureRecognizer:tap];
    }
    return _maskLayerView;
}
- (UIViewController *)rootViewController{
    if (_rootViewController == nil) {
        _rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _rootViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"商品展示";
    [self setupTableHeaderView];
    
    
    self.detailsVC = [[JXGoodDetailsViewController alloc]init];
    
    self.detailsVC.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - 64);
    
    self.tableView.secondScrollView = self.detailsVC.tableView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem
                                              alloc]initWithTitle:@"购物车" style:UIBarButtonItemStylePlain target:self action:@selector(shopCarAction)];
    
    
    /// 模拟网络请求
    kWeakSelf(self);
    [self.shopViewModel requestData:^(NSArray<JXGoodAttrModel *> *datas) {
        weakself.popView.goodAttrsArr = datas;
    }];
    
}

#pragma mark - 私有方法
- (void)setupTableHeaderView{
    
    SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kCycleScrollViewHeight)];
    
    cycleScrollView.localizationImageNamesGroup = @[@"1",@"2",@"3",@"4"];
    
    self.tableView.tableHeaderView = cycleScrollView;
}

#pragma mark - Actions

- (void)shopCarAction{
    
    [self.navigationController pushViewController:[[JXShopCarViewController alloc]init] animated:YES];
}

- (void)showAction{
    
    
    // 1.添加视图
    [self.rootViewController.view addSubview:self.maskLayerView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor blackColor];
    
    // 2.计算位置
    CGRect frame = self.popView.frame;
    frame.origin.y -= frame.size.height;
    
    // 3.第一步动画
    [UIView animateWithDuration:0.25 animations:^{
        
        self.rootViewController.view.layer.transform = [self getFirstTransform];
        
    } completion:^(BOOL finished) {
        // 4.第二步动画
        
        [UIView animateWithDuration:.2 animations:^{
    
            self.rootViewController.view.layer.transform = [self getSecondTransform];
            self.maskLayerView.alpha = 1;
            self.popView.frame = frame;
            
        }];
        
        
    }];
    
    
}

- (void)dismissAction{
    
    CGRect frame = self.popView.frame;
    frame.origin.y += frame.size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.rootViewController.view.layer.transform = [self getFirstTransform];
        self.popView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.rootViewController.view.layer.transform = CATransform3DIdentity;
            self.maskLayerView.alpha = 0;
            
            
        } completion:^(BOOL finished) {
            [self.maskLayerView removeFromSuperview];
            [self.popView removeFromSuperview];
            
            [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
            
        }];
    }];
    
}


#pragma mark - 动画
// 第一次转换
- (CATransform3D)getFirstTransform{
    
    
    /*!
     3D,顾名思义就是可以在z轴上动作
     CATransform3DScale: 函数的叠加，效果的叠加。
     锚点的位置：默认为（0.5，0.5）。在对图像进行变换时，都是按照这个点来进行缩放，偏移等。
     
     */
    
    // CATransform3DIdentity是单位矩阵，该矩阵没有缩放，旋转，歪斜，透视。该矩阵应用到图层上，就是设置默认值
    CATransform3D  transform = CATransform3DIdentity;
    
    transform.m34 = 1.0 / -900.0;
    
    // 1.沿锚点缩小到0.95
    transform = CATransform3DScale(transform, 0.95, 0.95, 1);
    
    // 2.沿锚点旋转15 °
    //获取旋转angle角度后的rotation矩阵
    transform = CATransform3DRotate(transform, (15.0 * M_PI / 180.0), 1, 0, 0);
    
    // 3.往后面移动-100
    transform = CATransform3DTranslate(transform, 0, 0, -100.0);
    return transform;
    
    
    /*! CATransform3D 又是一个结构。他有自己的一个公式，可以进行套用
     
     struct CATransform3D
     
     {
     
     CGFloat    m11（x缩放）,    m12（y切变）,      m13（旋转）,    m14（）;
     
     CGFloat    m21（x切变）,    m22（y缩放）,      m23（）       ,    m24（）;
     
     CGFloat    m31（旋转）  ,    m32（ ）       ,      m33（）       ,    m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
     
     CGFloat    m41（x平移）,    m42（y平移）,    m43（z平移） ,    m44（）;
     
     };
     
     根据这个公式，就一目了然了。
     
     CATransform3D CATransform3DMakeTranslation (CGFloat tx, CGFloat ty, CGFloat tz)
     
     的参数意思就是
     
     tx:：x平移。  ty：y平移。  tz：z平移
     
     
     */
    
    
}

// 第二次转换
- (CATransform3D)getSecondTransform{
    
    
    // 1.创建单位矩阵
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = [self getFirstTransform].m34;
    // 2.沿y移动
    transform = CATransform3DTranslate(transform, 0, self.view.frame.size.height * -0.08, 0);
    // 3.缩放
    transform = CATransform3DScale(transform, 0.8, 0.8, 1.0);
    return transform;
    
}



#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"index -- %ld",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 3) {
        cell.textLabel.text = @"选择  颜色分类  尺码";
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        [self showAction];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
