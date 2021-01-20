//
//  TTMenuModel.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTMenuModel : NSObject <CHGTableViewCellModelProtocol>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *toClassString;
@property (nonatomic, assign) NSInteger type;
+ (instancetype)createT:(NSString *)title toCS:(NSString * __nullable)toClassString type:(NSInteger)type;
+ (instancetype)createT:(NSString *)title toCS:(NSString * __nullable)toClassString;
@end

NS_ASSUME_NONNULL_END
