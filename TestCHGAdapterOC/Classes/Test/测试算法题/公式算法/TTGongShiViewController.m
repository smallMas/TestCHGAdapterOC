//
//  TTGongShiViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//
/*
 题目 : 用A表示1第一列，B表示2第二列，。。。，Z表示26，AA表示27，AB表示28。。。以此类推。请写出一个函数，输入用字母表示的列号编码，输出它是第几列。
 提示 : 26进制转10进制。
*/

#import "TTGongShiViewController.h"
#import "TTCalculateUtility.h"

@interface TTGongShiViewController ()
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, strong) UIButton *calculateBtn;
@property (nonatomic, strong) UILabel *resultLabel;
@end

@implementation TTGongShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    [self layoutUI];
}

- (void)setupView {
    [self.questionLabel setText:[self.exeModel questionString]];
    
    [self.view addSubview:self.questionLabel];
    [self.view addSubview:self.inputField];
    [self.view addSubview:self.calculateBtn];
    [self.view addSubview:self.resultLabel];
}

- (void)layoutUI {
    [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view).inset(20);
    }];
    
    [self.calculateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.questionLabel.mas_bottom).inset(20);
        make.right.mas_equalTo(self.view).inset(20);
    }];
    
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.questionLabel);
        make.right.mas_equalTo(self.calculateBtn.mas_left).inset(10);
        make.centerY.mas_equalTo(self.calculateBtn);
    }];
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.questionLabel);
        make.top.mas_equalTo(self.inputField.mas_bottom).inset(20);
    }];
}

#pragma mark - 懒加载
- (UILabel *)questionLabel {
    if (!_questionLabel) {
        _questionLabel = [UILabel fsj_createFont:[UIFont systemFontOfSize:17] color:[UIColor blackColor]];
        _questionLabel.numberOfLines = 0;
    }
    return _questionLabel;
}

- (UITextField *)inputField {
    if (!_inputField) {
        _inputField = [[UITextField alloc] init];
        _inputField.placeholder = @"请输入条件";
    }
    return _inputField;
}

- (UIButton *)calculateBtn {
    if (!_calculateBtn) {
        _calculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_calculateBtn setTitle:@"计算" forState:UIControlStateNormal];
        [_calculateBtn addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
        [_calculateBtn setBackgroundColor:[UIColor greenColor]];
    }
    return _calculateBtn;
}

- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [UILabel fsj_createFont:[UIFont systemFontOfSize:17] color:[UIColor blackColor]];
        _resultLabel.numberOfLines = 0;
    }
    return _resultLabel;
}

#pragma mark - 点击事件
- (void)tapClick:(id)sender {
    NSString *string = self.inputField.text;
    NSString *result = [TTCalculateUtility calculateColumnWithLetter:string];
    self.exeModel.result = result;
    
    [self.resultLabel setText:[self.exeModel resultString]];
}

@end
