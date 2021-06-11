//
//  UITableView+SMBlocker.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SMBlocker)

- (UITableView *(^)(CGFloat))sm_headerHeight;
- (UITableView *(^)(CGFloat))sm_footerHeight;
- (UITableView *(^)(NSString *))sm_keyPathOfSubData;

- (UITableView *(^)(NSArray *))sm_cellDatas;
- (UITableView *(^)(NSArray *))sm_headerDatas;
- (UITableView *(^)(NSArray *))sm_footerDatas;

- (UITableView *(^)(void))sm_reloadData;

@end

NS_ASSUME_NONNULL_END
