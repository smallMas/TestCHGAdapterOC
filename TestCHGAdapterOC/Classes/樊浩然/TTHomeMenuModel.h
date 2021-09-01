//
//  TTHomeMenuModel.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import "TTHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTHomeMenuModel : TTHomeBaseModel
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *bgColor;
@end

NS_ASSUME_NONNULL_END
