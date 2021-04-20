//
//  TTTestYYTextController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/4/14.
//

#import "TTTestYYTextController.h"
#import <YYText.h>


UIFont *kl_bfont(CGFloat fontSize){
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}

/** 固定匹配暗黑模式颜色值*/
static UIColor *KLColor(NSString *hex){
    return [UIColor fsj_colorWithHexString:hex];
}

@interface TTTestYYTextController ()
@property (strong, nonatomic) NSAttributedString *titleAttributed;
@property (strong, nonatomic) NSAttributedString *completeAttributed;
@property (strong, nonatomic) YYLabel *titleLabel;
@end

@implementation TTTestYYTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.attributedText = self.completeAttributed;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    

}

- (YYLabel *)titleLabel {
    if (!_titleLabel) {
        YYLabel *obj = YYLabel.new;
        [self.view addSubview:_titleLabel = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(kl_Width(305));
            make.height.mas_equalTo(kl_Height(113));
            make.centerX.mas_equalTo(0);
        }];
        obj.numberOfLines = 0;
        obj.textAlignment = NSTextAlignmentCenter;
        obj.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        obj.backgroundColor = [UIColor fsj_randomColor];
    }
    return _titleLabel;
}

- (NSAttributedString *)completeAttributed {
    if (!_completeAttributed) {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 4;
        shadow.shadowColor = [UIColor colorWithRed:255/255.0 green:46/255.0 blue:46/255.0 alpha:0.2];
        shadow.shadowOffset = CGSizeMake(0,2);
        
        CGFloat radio = FSJSCREENWIDTH/375.0;
        UIFont *font1 = kl_bfont(24*radio);
        UIFont *font2 = kl_bfont(15*radio);
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 20;
        
        NSMutableDictionary *dict1 = [NSMutableDictionary new];
        dict1[NSFontAttributeName] = font1;
        dict1[NSForegroundColorAttributeName] = KLColor(@"#FE8E5F");
        dict1[NSShadowAttributeName] = shadow;
//        dict1[NSParagraphStyleAttributeName] = style;
        
        NSMutableDictionary *dict2 = [NSMutableDictionary new];
        dict2[NSFontAttributeName] = font2;
        dict2[NSForegroundColorAttributeName] = KLColor(@"#FE8E5F");
        dict2[NSShadowAttributeName] = shadow;
//        dict2[NSParagraphStyleAttributeName] = style;
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
//        UIImage *image = [UIImage imageNamed:@"拼团_完成"];
//        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
//        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font1 alignment:YYTextVerticalAlignmentCenter];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, kl_Width(15)*2+14)];
        v.backgroundColor = [UIColor clearColor];
        UIImageView *imgView = [[UIImageView alloc] init];
        [v addSubview:imgView];
        [imgView setImage:[UIImage imageNamed:@"拼团_完成"]];
        imgView.frame = CGRectMake(0, kl_Width(15), 14, 14);
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:v contentMode:UIViewContentModeCenter attachmentSize:v.frame.size alignToFont:font1 alignment:YYTextVerticalAlignmentCenter];
        
        [text appendAttributedString:attachText];
        
        NSString *title = @" 拼团成功\n";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:dict1]];
        
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"扫描下方二维码  找班主任报道吧" attributes:dict2]];
        
        _completeAttributed = text;
    }
    return _completeAttributed;
}


- (NSAttributedString *)titleAttributed {
    if (!_titleAttributed) {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 4;
        shadow.shadowColor = [UIColor colorWithRed:255/255.0 green:46/255.0 blue:46/255.0 alpha:0.2];
        shadow.shadowOffset = CGSizeMake(0,2);
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        CGFloat radio = FSJSCREENWIDTH/375.0;
        CGFloat fSize = radio * 24;
        UIFont *font = kl_bfont(fSize);

        NSMutableDictionary *dict = [NSMutableDictionary new];
        dict[NSFontAttributeName] = font;
        dict[NSForegroundColorAttributeName] = KLColor(@"#FE8E5F");
        dict[NSShadowAttributeName] = shadow;

        NSString *title = @"还差";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:dict]];
        
        UILabel *view = [UILabel new];
        view.backgroundColor = KLColor(@"#FE8E5F");
        view.frame = CGRectMake(0, 0, kl_Width(40), kl_Width(40));
        view.layer.cornerRadius = 20;
        view.layer.masksToBounds = YES;
        view.text = @"5";
        view.font = kl_bfont(radio*38);
        view.textColor = KLColor(@"#FFFFFF");
        view.textAlignment = NSTextAlignmentCenter;

        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:view contentMode:UIViewContentModeCenter attachmentSize:view.frame.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"人完成拼团\n赶紧邀请好友拼好课一起学" attributes:dict]];
        
        _titleAttributed = text;
    }
    
    return _titleAttributed;
}

@end
