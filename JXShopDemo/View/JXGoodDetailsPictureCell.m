//
//  JXGoodDetailsPictureCell.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXGoodDetailsPictureCell.h"


@interface JXGoodDetailsPictureCell ()
@property(nonatomic, strong) UIImageView *pictureImageView;
@end
@implementation JXGoodDetailsPictureCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI{
 
    self.pictureImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.pictureImageView];
}


- (void)setPictureName:(NSString *)pictureName{
    _pictureName = pictureName;
    self.pictureImageView.image = [UIImage imageNamed:pictureName];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.pictureImageView.frame = self.bounds;
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
