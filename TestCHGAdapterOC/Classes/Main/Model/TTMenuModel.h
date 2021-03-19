//
//  TTMenuModel.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTMenuModel : NSObject <CHGTableViewCellModelProtocol, CHGCollectionViewCellModelProtocol>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *toClassString;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) id data;
+ (instancetype)createT:(NSString *)title toCS:(NSString * __nullable)toClassString type:(NSInteger)type;
+ (instancetype)createT:(NSString *)title toCS:(NSString * __nullable)toClassString;
+ (instancetype)createT:(NSString *)title type:(NSInteger)type;
+ (instancetype)createT:(NSString *)title type:(NSInteger)type data:(id)data;
@end

NS_ASSUME_NONNULL_END
