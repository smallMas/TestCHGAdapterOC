//
//  TTSelectNumCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/7/25.
//

#import "TTSelectNumCell.h"
#import "TTSudokuPropertyModel.h"

@interface TTSelectNumCell ()
@property (weak, nonatomic) UILabel *titleLabel;
@end

@implementation TTSelectNumCell

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *obj = [UILabel fsj_createFont:[UIFont boldSystemFontOfSize:24] color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_titleLabel = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        obj.textColor = [UIColor fsj_colorWithHexString:@"#b2d235"];
    }
    return _titleLabel;
}

- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath targetView:(UIView *)targetView model:(id)model eventTransmissionBlock:(CHGEventTransmissionBlock)eventTransmissionBlock {
    [super cellForRowAtIndexPath:indexPath targetView:targetView model:model eventTransmissionBlock:eventTransmissionBlock];
    
    TTSudokuPropertyModel *m = model;
    NSNumber *num = m.num;
    self.titleLabel.text = kStringFormat(@"%@",num);
    if (m.font) {
        self.titleLabel.font = m.font;
    }
}

@end
