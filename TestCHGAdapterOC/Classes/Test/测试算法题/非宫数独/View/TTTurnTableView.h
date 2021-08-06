//
//  TTTurnTableView.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TTTurnType) {
    // 普通
    TTTurnTypeNormal,
    TTTurnType1,
    TTTurnType2,
    TTTurnType3,
};

@class TTTurnItemModel;
typedef void (^ TTTurnResultBlock)(TTTurnItemModel *result);

@interface TTTurnItemModel : NSObject

@property (assign, nonatomic) TTTurnType type;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) CGFloat angle; // 角度

@end

@interface TTTurnTableView : UIView
@property (copy, nonatomic) TTTurnResultBlock block;
@end

NS_ASSUME_NONNULL_END
