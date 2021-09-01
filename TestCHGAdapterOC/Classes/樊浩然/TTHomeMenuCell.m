//
//  TTHomeMenuCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import "TTHomeMenuCell.h"
#import "TTHomeMenuModel.h"

@interface TTHomeMenuCell ()

@property (weak, nonatomic) UILabel *lab;
@property (weak, nonatomic) UIView *showView;

@end

@implementation TTHomeMenuCell

- (UILabel *)lab {
    if (!_lab) {
        UILabel *obj = [UILabel new];
        [self.contentView addSubview:_lab = obj];
        obj.numberOfLines = 0;
        TTHomeMenuModel *model = self.model;
        CGFloat offset = FSJSCREENWIDTH/5;
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            if (model.index % 2 == 0) {
                kMakeLV(offset);
            }else {
                kMakeRV(-offset);
            }
            kMakeTBV(0);
            kMakeW(self.lab.mas_height).multipliedBy(1);
        }];
        obj.backgroundColor = model.bgColor;
        obj.textAlignment = NSTextAlignmentCenter;
        [obj fsj_setRoundRadius:model.layout.itemSize.height*0.5 borderColor:[UIColor clearColor]];
        
        [self showView];
    }
    return _lab;
}

- (UIView *)showView {
    if (!_showView) {
        UIView *obj = [[UIView alloc] init];
        [self.contentView addSubview:_showView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeEdge(self.lab);
        }];
        TTHomeMenuModel *model = self.model;
        [obj addShadowC:[model.bgColor colorWithAlphaComponent:0.3] offset:kSize(0, 2) opacity:1 radius:7];
        
        [self.contentView sendSubviewToBack:self.showView];
    }
    return _showView;
}

- (void)setModel:(TTHomeMenuModel *)model {
    [super setModel:model];
    self.lab.text = model.title;
}

@end
