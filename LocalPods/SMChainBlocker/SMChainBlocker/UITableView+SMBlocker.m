//
//  UITableView+SMBlocker.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/11.
//

#import "UITableView+SMBlocker.h"
#import "CHGAdapter.h"

@implementation UITableView (SMBlocker)

- (UITableView *(^)(CGFloat))sm_headerHeight {
    return ^(CGFloat h) {
        self.tableViewAdapter.headerHeight = h;
        return self;
    };
}

- (UITableView *(^)(CGFloat))sm_footerHeight {
    return ^(CGFloat h) {
        self.tableViewAdapter.footerHeight = h;
        return self;
    };
}

- (UITableView *(^)(NSString *))sm_keyPathOfSubData {
    return ^(NSString *string) {
        self.tableViewAdapter.keyPathOfSubData = string;
        return self;
    };
}

- (UITableView *(^)(NSArray *))sm_cellDatas {
    return ^(NSArray *datas) {
        self.cellDatas = datas;
        return self;
    };
}

- (UITableView *(^)(NSArray *))sm_headerDatas {
    return ^(NSArray *datas) {
        self.headerDatas = datas;
        return self;
    };
}

- (UITableView *(^)(NSArray *))sm_footerDatas {
    return ^(NSArray *datas) {
        self.footerDatas = datas;
        return self;
    };
}

- (UITableView *(^)(void))sm_reloadData {
    return ^(void){
        [self reloadData];
        return self;
    };
}
@end
