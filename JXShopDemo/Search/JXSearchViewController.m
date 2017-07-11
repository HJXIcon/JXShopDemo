//
//  JXSearchViewController.m
//  FishingWorld
//
//  Created by mac on 16/12/21.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import "JXSearchViewController.h"
#import "JXSearchView.h"
#import "JXSearchCollectionView.h"
#import "JXNotSearchProductsView.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JXSearchCollectionHeaderFooterView.h"
#import "JXSearchSortView.h"
#import "JXProductSearchResultCell.h"


// 全局变量 头部视图高度
static CGFloat kHeaderHeignt = 44;
static CGFloat kCollectionFooterHeight = 60;
static NSString *const JXSearchViewControllerHistorySearchArray = @"JXSearchViewControllerHistorySearchArray";
static NSString*const kCollectionCellID = @"CollectionCellID";

static CGFloat const JXMargin = 10;


@interface JXSearchViewController ()<UIScrollViewDelegate,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *cleanHistoryButton;
@property (nonatomic, strong) JXSearchView *hotSearchView;
@property (nonatomic, strong) UITableView *historySearchTableView;
@property (nonatomic, strong) JXSearchCollectionView *searchResultCollectionView;

@property (nonatomic, strong) JXNotSearchProductsView*collectionHeadView;
@property(nonatomic, weak) JXSearchSortView *sortView;

/** 是否搜索到结果*/
@property (nonatomic, assign)BOOL isHasResult;

/** 模型数组*/
@property (nonatomic, strong)NSMutableArray *modelArray;
/** keyWord*/
@property (nonatomic, strong)NSString *keyWord;

@end

@implementation JXSearchViewController

#pragma mark - loze loading
- (NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (UITableView *)historySearchTableView{
    if (_historySearchTableView == nil) {
        _historySearchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
        _historySearchTableView.backgroundColor = kDarkGrayColor;
        _historySearchTableView.delegate = self;
        _historySearchTableView.dataSource = self;
        _historySearchTableView.tableFooterView = [[UIView alloc]init];
        _historySearchTableView.layoutMargins = UIEdgeInsetsZero;
        _historySearchTableView.separatorInset = UIEdgeInsetsZero;
        [_historySearchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _historySearchTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"nav-back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    [self.view addSubview:self.historySearchTableView];
    [self buildSearchBar];
    [self loadHotSearchButtonData];
    [self loadHistorySearchButtonData];
    [self buildsearchResultCollectionView];
    [self buildSortView];
    
}

- (void)leftBarButtonItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 私有方法
- (void)buildSortView{
    
    __weak typeof(self) weakSelf = self;
    JXSearchSortView *sortView = [[JXSearchSortView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    _sortView = sortView;
    sortView.hidden = YES;
    sortView.btnClickCallBack = ^(NSInteger index){
        
        switch (index) {
                case 0: // 综合排序
            {
                [weakSelf loadProductsWithKeyword:self.keyWord isNew:NO isPlay:NO];
            }
                break;
                
                case 1:// 最新发布
            {
                [weakSelf loadProductsWithKeyword:self.keyWord isNew:YES isPlay:NO];
            }
                break;
                
                case 2:// 最多播放
            {
                [weakSelf loadProductsWithKeyword:self.keyWord isNew:NO isPlay:YES];
                
            }
                break;
                
            default:
                break;
        }
        
    };
    
    [self.view addSubview:sortView];
}


-(void)buildsearchResultCollectionView{
    
    CGFloat margin = 3;
    int col = 2;
//    int row = 3;
    CGFloat itemW = (kScreenW - 5 * (col + 1)) / col;
    CGFloat itemH = 170;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.footerReferenceSize = CGSizeMake(kScreenW, kCollectionFooterHeight);
    layout.headerReferenceSize = CGSizeMake(kScreenW, 60);
//    layout.sectionInset = UIEdgeInsetsMake(0, JXMargin, 0, JXMargin);
    
    
    
    self.searchResultCollectionView = [[JXSearchCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64) collectionViewLayout:layout];
    self.searchResultCollectionView.delegate = self;
    self.searchResultCollectionView.dataSource = self;
    self.searchResultCollectionView.backgroundColor = kDarkGrayColor;
    self.searchResultCollectionView.hidden = YES;
    [self.searchResultCollectionView registerClass:[JXProductSearchResultCell class] forCellWithReuseIdentifier:kCollectionCellID];
    [self.searchResultCollectionView registerClass:[JXSearchCollectionHeaderFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.searchResultCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    self.searchResultCollectionView.contentInset = UIEdgeInsetsMake(50, 5, 30, 5);
    [self.view addSubview:self.searchResultCollectionView];
    
    
    
}

- (void)loadHistorySearchButtonData{
    
    
    NSArray *historySearch = [[NSUserDefaults standardUserDefaults] objectForKey:JXSearchViewControllerHistorySearchArray];
    if (historySearch.count > 0) {
        // 显示头部视图
        kHeaderHeignt = 44;
    }else{
        // 隐藏头部视图
        kHeaderHeignt = 0;
    }
    
    if (_historySearchTableView != nil) {
        [_historySearchTableView reloadData];
    }
    
    
    
}


#pragma mark - 加载关键词 

/**
 加载关键词 （默认综合排序）
 warn:最新跟最多播放只能有一个是YES
 
 @param keyWord 关键词
 @param isNew 是否按最新发布
 @param isPlay 是否按最多播放
 */
- (void)loadProductsWithKeyword:(NSString *)keyWord isNew:(BOOL)isNew isPlay:(BOOL)isPlay{
    self.keyWord = keyWord;
    
    if ([keyWord isEqualToString:@" "] || keyWord.length == 0) {
        return;
    }
    
    
}

#pragma mark 加载关键词
- (void)loadProductsWithKeyword:(NSString *)keyWord{
    
    self.keyWord = keyWord;
    
    if ([keyWord isEqualToString:@" "] || keyWord.length == 0) {
        return;
    }

    [SVProgressHUD showWithStatus:@"正在全力加载"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}




- (void)loadHotSearchButtonData{
    
    NSArray *historySearch = [[NSUserDefaults standardUserDefaults]objectForKey:JXSearchViewControllerHistorySearchArray];
    
    if (historySearch == nil) {
        historySearch = [NSArray array];
        [[NSUserDefaults standardUserDefaults] setObject:historySearch forKey:JXSearchViewControllerHistorySearchArray];
    }
    __weak typeof(self) weakSelf = self;
    
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"SearchProduct" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:pathStr];
    
    if (data != nil) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        NSArray *array = [[dict objectForKey:@"data"] objectForKey:@"hotquery"];
        
        if (array.count > 0) {
            
            _hotSearchView = [[JXSearchView alloc]initWithFrame:CGRectMake(10, 20, kScreenW - 20, 100) searchTitleText:@"热门搜索" searchButtonTitleTexts:array searchButtonClickCallback:^(UIButton *button) {
                
                NSString *str = [button titleForState:UIControlStateNormal];
                
                [weakSelf writeHistorySearchToUserDefault:str];
                weakSelf.searchBar.text = [button titleForState:UIControlStateNormal];
                [weakSelf loadProductsWithKeyword:[button titleForState:UIControlStateNormal]];
                [weakSelf loadHistorySearchButtonData];
                
            }];
            
            CGRect tmpFrame = _hotSearchView.frame;
            tmpFrame.size.height = _hotSearchView.searchHeight + JXMargin;
            _hotSearchView.frame = tmpFrame;
            
            self.historySearchTableView.tableHeaderView = _hotSearchView;
            
        }
    }
    
}

// 写入
- (void)writeHistorySearchToUserDefault:(NSString *)str{
    NSArray *historySearch = [[NSUserDefaults standardUserDefaults] objectForKey:JXSearchViewControllerHistorySearchArray];
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:historySearch];
    
    for (NSString *text in historySearch) {
        if ([text isEqualToString: str]) {
            
            [tmpArray removeObject:str];
        }
    }
    
    [tmpArray insertObject:str atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:tmpArray forKey:JXSearchViewControllerHistorySearchArray];
    
    [self loadHistorySearchButtonData];
    
    
}



- (void)buildSearchBar{
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW * 0.8, 30)];
    tmpView.backgroundColor = [UIColor whiteColor];
    tmpView.layer.masksToBounds = YES;
    tmpView.layer.cornerRadius = 6;
    tmpView.layer.borderColor = RGBA(100, 100, 100, 1).CGColor;
    tmpView.layer.borderWidth = 0.2;
    
    UIImage *image = [UIImage createImageFromView:tmpView];
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.frame = CGRectMake(0, 0, kScreenW * 0.9, 30)
    ;
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    [_searchBar setSearchFieldBackgroundImage:image forState:UIControlStateNormal];
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
}

#pragma mark 加载数据
- (void)loadSearchDataWithKeyword:(NSString *)keyword{
    
    
}

#pragma mark - Action
// 清空历史
- (void)emptyHistoryBtnClick{

    [self cleanSearchHistorySearch];
    
    // 隐藏头部视图
    [self loadHistorySearchButtonData];
    
}


- (void)accessoryBtnClick:(UIButton *)button{
    
    NSArray *historySearch = [[NSUserDefaults standardUserDefaults] objectForKey:JXSearchViewControllerHistorySearchArray];
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:historySearch];
    [tmpArray removeObjectAtIndex:button.tag];
    [[NSUserDefaults standardUserDefaults] setObject:tmpArray forKey:JXSearchViewControllerHistorySearchArray];
    
    
    [self loadHistorySearchButtonData];
}

- (void)cleanSearchHistorySearch{
    NSArray *historySearch = [[NSUserDefaults standardUserDefaults] objectForKey:JXSearchViewControllerHistorySearchArray];
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:historySearch];
    [tmpArray removeAllObjects];
    
    [[NSUserDefaults standardUserDefaults] setObject:tmpArray forKey:JXSearchViewControllerHistorySearchArray];
    
    [self loadHistorySearchButtonData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar endEditing:NO];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self writeHistorySearchToUserDefault:searchBar.text];
    [self loadProductsWithKeyword:searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.searchResultCollectionView.hidden = YES;
    _sortView.hidden = YES;
    
    if (searchText.length > 0) {
        
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:JXSearchViewControllerHistorySearchArray];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:JXSearchViewControllerHistorySearchArray];
    
    cell.textLabel.text = array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    cell.imageView.image = [UIImage imageNamed:@"search_history"];
    
    UIButton *accessoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [accessoryBtn setImage:[UIImage imageNamed:@"search_close"] forState:UIControlStateNormal];
    [accessoryBtn sizeToFit];
    accessoryBtn.tag = indexPath.row;
    [accessoryBtn addTarget:self action:@selector(accessoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = accessoryBtn;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:JXSearchViewControllerHistorySearchArray];
    _searchBar.text = array[indexPath.row];
    [self loadProductsWithKeyword:array[indexPath.row]];
    
}


#pragma mark headerFooter
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    header.backgroundColor = [UIColor whiteColor];
    
    // line
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 2, 44 - 20)];
    line.backgroundColor = RGBA(30, 170, 250, 1);
    [header addSubview:line];
    
    // label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame) + 10, 5, 100, 44 - 10)];
    label.text = @"搜索历史";
    [header addSubview:label];
    
    
    // button
    UIButton *emptyHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [emptyHistoryBtn addTarget:self action:@selector(emptyHistoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    emptyHistoryBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [emptyHistoryBtn setTitle:@"清空" forState:UIControlStateNormal];
    [emptyHistoryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [emptyHistoryBtn setImage:[UIImage imageNamed:@"search_empty"] forState:UIControlStateNormal];
    emptyHistoryBtn.frame = CGRectMake(kScreenW - 60 - 10, (44 - 28) * 0.5, 60, 28);
    [header addSubview:emptyHistoryBtn];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, kScreenW, 0.5)];
    bottomLine.backgroundColor = RGBA(220, 220, 220, 1);
    [header addSubview:bottomLine];
    
    return header;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeaderHeignt;
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JXProductSearchResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellID forIndexPath:indexPath];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionFooter) {
        JXSearchCollectionHeaderFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        [footer setLabelText:@"没有更多了" color: RGBA(140, 140, 140, 1)];
        
        return footer;
    }else{
        
        if (_isHasResult) {
         
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            
            [header.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            
            
            
            return header;
            
            
        }else{
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            
            self.collectionHeadView = [[JXNotSearchProductsView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
            self.collectionHeadView.keyword = self.keyWord;
            [header addSubview:self.collectionHeadView];
            
            return header;
        }
    }

}

@end
