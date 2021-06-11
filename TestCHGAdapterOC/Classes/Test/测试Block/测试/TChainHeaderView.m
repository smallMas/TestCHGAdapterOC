//
//  TChainHeaderView.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/9.
//

#import "TChainHeaderView.h"
#import "TTChainModel.h"

@interface TChainHeaderView ()

@property (weak, nonatomic) UILabel *titleLab;

@end

@implementation TChainHeaderView

- (UILabel *)titleLab {
    if (!_titleLab) {
        UILabel *obj = UILabel.new;
        obj.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLab = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeLV(15);
            kMakeCenterYV(0);
        }];
    }
    return _titleLab;
}

- (void)headerFooterViewWillAppearWithType:(CHGAdapterViewType)type {
    [super headerFooterViewWillAppearWithType:type];
    TTChainModel *model = self.model;
    self.titleLab.text = model.name;
}

@end
