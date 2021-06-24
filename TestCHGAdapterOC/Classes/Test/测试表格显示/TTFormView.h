//
//  TTFormView.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTFormView : UIView
@property (assign, nonatomic) CGFloat l_w;
@property (assign, nonatomic) CGFloat t_h;
@property (assign, nonatomic) CGFloat c_w;
@property (strong, nonatomic) NSString *leftCornerValue;
@property (strong, nonatomic) UIColor *menuColor;
- (void)setLeftMenu:(NSArray *)leftMenu topMenu:(NSArray *)topMenu contents:(NSArray *)contents;
@end

NS_ASSUME_NONNULL_END
