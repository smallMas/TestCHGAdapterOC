//
//  TTMenuViewController.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTTableViewController.h"
#import "TTMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTMenuViewController : TTTableViewController
@property (nonatomic, strong) NSArray <TTMenuModel *>* dataArray;
@end

NS_ASSUME_NONNULL_END
