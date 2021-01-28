//
//  TTGongModel.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import "TTGongModel.h"
CGFloat Cal(NSInteger a, NSInteger b, NSInteger c, TTGongShiBlock block) {
    if (block) {
        return block(a,b,c);
    }
    return 0;
}

@implementation TTGongModel

+ (instancetype)createN:(TTGongShiBlock)nBlock aB:(TTGongShiBlock)aBlock bB:(TTGongShiBlock)bBlock cB:(TTGongShiBlock)cBlock title:(NSString *)title {
    TTGongModel *model = [[self class] new];
    model.normalBlock = nBlock;
    model.reverseBlockA = aBlock;
    model.reverseBlockB = bBlock;
    model.reverseBlockC = cBlock;
    model.title = title;
    return model;
}

+ (instancetype)createN:(TTGongShiBlock)nBlock title:(NSString *)title {
    return [self createN:nBlock aB:nil bB:nil cB:nil title:title];
}

@end
