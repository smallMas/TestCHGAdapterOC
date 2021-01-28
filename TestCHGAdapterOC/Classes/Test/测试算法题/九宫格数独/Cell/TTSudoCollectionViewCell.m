//
//  TTSudoCollectionViewCell.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import "TTSudoCollectionViewCell.h"
#import "TTSudoModel.h"

@implementation TTSudoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel fsj_createFont:[UIFont systemFontOfSize:20] color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath targetView:(UIView *)targetView model:(id)model eventTransmissionBlock:(CHGEventTransmissionBlock)eventTransmissionBlock {
    [super cellForRowAtIndexPath:indexPath targetView:targetView model:model eventTransmissionBlock:eventTransmissionBlock];
    TTSudoModel *tmpModel = model;
    
    [self.titleLabel setText:[tmpModel showString]];
    [self.titleLabel setBackgroundColor:tmpModel.isHaveValue?[UIColor fsj_colorWithHexString:@"#fedcbd"]:[UIColor fsj_colorWithHexString:@"#f47920"]];
}

@end
