//
//  TTAnimationModel.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/22.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TTAnimationType) {
    TTAnimationTypePosition,
    TTAnimationTypeTransformTotationZ,
    TTAnimationTypeTransformTotationY,
    TTAnimationTypeTransformTotationX,
    TTAnimationTypeTransformScale,
    TTAnimationTypeOpacity,
    TTAnimationTypeBackgroundColor,
    TTAnimationTypeTransformRotation
};

NS_ASSUME_NONNULL_BEGIN

@interface TTAnimationModel : NSObject
@property (nonatomic, assign) TTAnimationType type;

+ (instancetype)createT:(TTAnimationType)type;

@end

NS_ASSUME_NONNULL_END
