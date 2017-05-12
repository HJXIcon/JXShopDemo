//
//  JXGoodAttributesCell.m
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXGoodAttributesCell.h"
#import "JXTagView.h"
#import "JXTagFrame.h"

@interface JXGoodAttributesCell ()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) JXTagView *tagView;
@end

@implementation JXGoodAttributesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    // 标题
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.titleLabel
     ];
    
    
    // 属性
    self.tagView = [[JXTagView alloc]init];
    
    __weak typeof(self) weakSelf = self;
    [self.tagView setSelectIndexBlock:^(NSInteger index) {
        if (weakSelf.selectIndexBlock) {
            weakSelf.selectIndexBlock(index);
        }
    }];
    
    [self.contentView addSubview:self.tagView];
    
}

- (void)setTagsFrame:(JXTagFrame *)tagsFrame{
    
    _tagsFrame = tagsFrame;

    self.tagView.tagsFrame = tagsFrame;
    
}

- (void)setAttriName:(NSString *)attriName{
    _attriName = attriName;
    
    self.titleLabel.text = attriName;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(8, 0, self.contentView.bounds.size.width - 16, 35);
    
    self.tagView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width, self.bounds.size.height - 35);
}



+ (instancetype )cellOfCellConfigWithTableView:(UITableView *)tableView{
    
    Class cellClass = NSClassFromString(NSStringFromClass(self));
    
    id cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    
    
    if (cell == nil) {
        cell = [[cellClass alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass(self)];
    }
    
    
    return cell;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
