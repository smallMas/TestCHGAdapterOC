//
//  TTSudoModel.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTSudoModel : NSObject <CHGCollectionViewCellModelProtocol>

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, assign) BOOL isHaveValue;
@property (nonatomic, strong) NSNumber *result;

+ (instancetype)createV:(NSInteger)value;
+ (instancetype)createNoV;

- (NSString *)showString;
- (void)setNumValue:(NSNumber *)value;

@end

NS_ASSUME_NONNULL_END
