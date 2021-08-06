//
//  TTMainSectionModel.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "TTHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTMainSectionModel : NSObject <CHGCollectionViewSupplementaryElementModelProtocol>

@property (copy, nonatomic, nullable) __kindof TTHomeBaseModel *(^h_modelBlock)(TTMainSectionModel *sm);
@property (strong, nonatomic, nullable) __kindof TTHomeBaseModel *h_model;

/** footer model data */
@property (strong, nonatomic, nullable) TTHomeBaseModel *f_model;
/** footer model data priority hegher than f_model  */
@property (copy, nonatomic, nullable) TTHomeBaseModel *(^f_modelBlock)(TTMainSectionModel *sm);

/** section间距  */
@property (assign, nonatomic) UIEdgeInsets sectionInsets;
/** section间距优先级高于sectionInsets  */
@property (copy, nonatomic, nullable) UIEdgeInsets (^sectionInsetsBlock)(TTMainSectionModel *sm);

@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat itemSpacing;

@property (strong, nonatomic) NSMutableArray *items;

/** header  */
+ (instancetype)sectionWithHeaderModel:(__kindof TTHomeBaseModel *)model;
/** footer  */
+ (instancetype)sectionWithHeader:(__kindof TTHomeBaseModel *_Nullable)head footer:(__kindof TTHomeBaseModel *_Nullable)footer;

- (void)sectionInsets:(UIEdgeInsets)insets ls:(CGFloat)ls is:(CGFloat)is;

@end

NS_ASSUME_NONNULL_END
