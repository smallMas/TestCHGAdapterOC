//
//  TTChainCollectionCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/11.
//

#import "TTChainCollectionCell.h"
#import "TTChainModel.h"

@interface TTChainCollectionCell ()
@property (weak, nonatomic) UILabel *titleLab;
@end

@implementation TTChainCollectionCell

- (UILabel *)titleLab {
    if (!_titleLab) {
        UILabel *obj = UILabel.new;
        obj.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLab = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeEdge0;
        }];
        obj.numberOfLines = 0;
    }
    return _titleLab;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    TTChainModel *model = self.model;
    self.titleLab.text = model.name;
    self.contentView.backgroundColor = model.bgColor;
}

@end
