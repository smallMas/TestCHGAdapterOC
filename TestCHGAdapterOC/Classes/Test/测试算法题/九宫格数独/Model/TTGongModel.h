//
//  TTGongModel.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef CGFloat (^ TTGongShiBlock)(NSInteger a, NSInteger b, NSInteger c);
CGFloat Cal(NSInteger a, NSInteger b, NSInteger c, TTGongShiBlock block);

@interface TTGongModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) TTGongShiBlock normalBlock;
@property (nonatomic, copy) TTGongShiBlock reverseBlockA;
@property (nonatomic, copy) TTGongShiBlock reverseBlockB;
@property (nonatomic, copy) TTGongShiBlock reverseBlockC;

+ (instancetype)createN:(TTGongShiBlock)nBlock aB:(TTGongShiBlock __nullable)aBlock bB:(TTGongShiBlock __nullable)bBlock cB:(TTGongShiBlock __nullable)cBlock title:(NSString *)title;
+ (instancetype)createN:(TTGongShiBlock)nBlock title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
