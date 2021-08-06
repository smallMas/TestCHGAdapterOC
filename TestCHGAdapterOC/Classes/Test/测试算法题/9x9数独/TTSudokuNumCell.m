//
//  TTSudokuNumCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/7/23.
//

#import "TTSudokuNumCell.h"
#import "TTSudokuPropertyModel.h"

@interface TTSudokuNumCell ()
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UIView *topLine, *bottomLine, *rightLine, *leftLine;
@end

@implementation TTSudokuNumCell

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *obj = [UILabel fsj_createFont:[UIFont systemFontOfSize:20] color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_titleLabel = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _titleLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        UIView *obj = [UIView new];
        [self.contentView addSubview:_bottomLine = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeLBRV(0);
            kMakeHV(1);
        }];
        obj.backgroundColor = [UIColor fsj_colorWithHexString:@"#333333"];
    }
    return _bottomLine;
}

- (UIView *)topLine {
    if (!_topLine) {
        UIView *obj = [UIView new];
        [self.contentView addSubview:_topLine = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeLTRV(0);
            kMakeHV(1);
        }];
    }
    return _topLine;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        UIView *obj = [UIView new];
        [self.contentView addSubview:_rightLine = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeTRV(0);
            kMakeBV(0);
            kMakeWV(1);
        }];
    }
    return _rightLine;
}

- (UIView *)leftLine {
    if (!_leftLine) {
        UIView *obj = [UIView new];
        [self.contentView addSubview:_leftLine = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeLTV(0);
            kMakeBV(0);
            kMakeWV(1);
        }];
        obj.backgroundColor = [UIColor fsj_colorWithHexString:@"#979797"];
    }
    return _leftLine;
}

- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath targetView:(UIView *)targetView model:(id)model eventTransmissionBlock:(CHGEventTransmissionBlock)eventTransmissionBlock {
    [super cellForRowAtIndexPath:indexPath targetView:targetView model:model eventTransmissionBlock:eventTransmissionBlock];
    
    TTSudokuPropertyModel *m = model;
    NSNumber *num = m.num;
    if (num.intValue == 0) {
        self.titleLabel.text = @"";
    }else {
        self.titleLabel.text = kStringFormat(@"%@",num);
    }
    if (m.font) {
        self.titleLabel.font = m.font;
    }
    [self.contentView setBackgroundColor:m.bgColor?[UIColor fsj_colorWithHexString:m.bgColor]:[UIColor clearColor]];
    
    if (m.factorial == 9) {
        if (indexPath.section == 0 ||
            indexPath.section == 3 ||
            indexPath.section == 6) {
            self.topLine.backgroundColor = [UIColor fsj_colorWithHexString:@"#333333"];
        }else {
            self.topLine.backgroundColor = [UIColor fsj_colorWithHexString:@"#979797"];
        }
        
        if (indexPath.row == 2 ||
            indexPath.row == 5) {
            self.rightLine.backgroundColor = [UIColor fsj_colorWithHexString:@"#333333"];
        }else {
            self.rightLine.backgroundColor = [UIColor fsj_colorWithHexString:@"#979797"];
        }
        
        if (indexPath.section == 8) {
            self.bottomLine.hidden = NO;
        }else {
            self.bottomLine.hidden = YES;
        }
        
        if (indexPath.row == 0) {
            self.leftLine.hidden = NO;
        }else {
            self.leftLine.hidden = YES;
        }
    }else {
        if (indexPath.section == 0) {
            self.topLine.backgroundColor = [UIColor fsj_colorWithHexString:@"#333333"];
        }else {
            self.topLine.backgroundColor = [UIColor fsj_colorWithHexString:@"#979797"];
        }
        
        if (indexPath.row == m.factorial-1) {
            self.rightLine.backgroundColor = [UIColor fsj_colorWithHexString:@"#333333"];
        }else {
            self.rightLine.backgroundColor = [UIColor fsj_colorWithHexString:@"#979797"];
        }
        
        if (indexPath.section == m.factorial-1) {
            self.bottomLine.hidden = NO;
        }else {
            self.bottomLine.hidden = YES;
        }
        
        if (indexPath.row == 0) {
            self.leftLine.hidden = NO;
        }else {
            self.leftLine.hidden = YES;
        }
    }
}

@end
