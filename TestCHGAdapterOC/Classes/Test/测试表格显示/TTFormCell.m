//
//  TTFormCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/21.
//

#import "TTFormCell.h"
#import "TTFormModel.h"

@interface TTFormCell ()
@property (weak, nonatomic) UILabel *titleLab;
@end

@implementation TTFormCell

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
    TTFormModel *model = self.model;
    self.titleLab.text = model.title;
    self.contentView.backgroundColor = model.bgColor;
    self.titleLab.textAlignment = model.textAlignment;
}

@end
