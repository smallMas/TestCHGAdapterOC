//
//  TTTestStackViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/23.
//  测试撑开view，KLEmptyTipView

#import "TTTestStackViewController.h"
#import "TTMenuModel.h"
#import "AFNetworking.h"

@interface TTTestStackViewController ()
@property (weak, nonatomic) UIStackView *stackView;
@end

@implementation TTTestStackViewController {
    TTMenuModel *menuModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    menuModel = [TTMenuModel new];
    NSLog(@"self->menuModel >>> %@",self->menuModel);

    
    UIStackView *s1 = [self cStack];
    [s1 addArrangedSubview:[self cLabelText:@"1_1"]];
    [s1 addArrangedSubview:[self cLabelText:@"1_2"]];
    [s1 addArrangedSubview:[self cLabelText:@"1_3"]];
    
    
    UIStackView *s2 = [self cStack];
    [s2 addArrangedSubview:[self cLabelText:@"2_1"]];
    [s2 addArrangedSubview:[self cLabelText:@"2_2"]];
    [s2 addArrangedSubview:[self cLabelText:@"2_3"]];
    
    
    UIStackView *s3 = [self cStack];
    [s3 addArrangedSubview:[self cLabelText:@"3_1"]];
    [s3 addArrangedSubview:[self cLabelText:@"3_2"]];
    [s3 addArrangedSubview:[self cLabelText:@"3_3"]];
    
    
    [self.stackView addArrangedSubview:s1];
    [self.stackView addArrangedSubview:s2];
    [self.stackView addArrangedSubview:s3];
}

- (UILabel *)cLabelText:(NSString *)text {
    UILabel *obj = UILabel.new;
    obj.text = text;
    return obj;
}

- (UIStackView *)cStack {
    UIStackView *obj = [[UIStackView alloc] init];
    obj.axis = UILayoutConstraintAxisHorizontal;
    obj.spacing = 100;
    obj.alignment = UIStackViewAlignmentTop;
    obj.distribution = UIStackViewDistributionFillProportionally;
    return obj;
}

- (UIStackView *)stackView{
    if (!_stackView) {
        UIStackView *obj = [[UIStackView alloc] init];
        obj.axis = UILayoutConstraintAxisVertical;//UILayoutConstraintAxisHorizontal;
        obj.spacing = 100;
        obj.alignment = UIStackViewAlignmentTop;
        obj.distribution = UIStackViewDistributionFillProportionally;
        [self.view addSubview:_stackView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
        }];
    }
    return _stackView;
}

- (void)request {
    NSString *url = @"";
    NSDictionary *params = nil;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
//    NSURLSessionDataTask *reqTask = [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
////        [self parsingUrl:url responseObject:responseObject error:nil block:block task:task];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////        DN_STRONG_SELF
////        [self parsingUrl:url responseObject:nil error:error block:block task:task];
//    }];
}
@end
