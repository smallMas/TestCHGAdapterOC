//
//  TTMenuCollectionViewCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/12.
//

#import "TTMenuCollectionViewCell.h"
#import "TTMenuModel.h"

@interface TTMenuCollectionViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TTMenuCollectionViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *obj = [UILabel new];
        [self.contentView addSubview:_titleLabel = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView).inset(20);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLabel;
}

- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath targetView:(UIView *)targetView model:(id)model eventTransmissionBlock:(CHGEventTransmissionBlock)eventTransmissionBlock {
    [super cellForRowAtIndexPath:indexPath targetView:targetView model:model eventTransmissionBlock:eventTransmissionBlock];
    TTMenuModel *tmpModel = model;
    self.titleLabel.text = tmpModel.title;
}

@end
