//
//  TTFormModel.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTFormModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *bgColor;
@property (assign, nonatomic) NSTextAlignment textAlignment;
@property (assign, nonatomic) CGSize size;

@end

NS_ASSUME_NONNULL_END
