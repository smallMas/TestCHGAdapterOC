//
//  TTTableViewController.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTTableViewController : TTBaseViewController
/*! tableview */
@property (nonatomic, strong, readonly) UITableView *tableView;
/*! tableview风格 */
@property (nonatomic, assign, readonly) UITableViewStyle style;
@end

NS_ASSUME_NONNULL_END
