//
//  TTLocalLibTableViewCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "TTLocalLibTableViewCell.h"
#import "TTLocalLibModel.h"

@implementation TTLocalLibTableViewCell

- (void)configModel:(TTLocalLibModel *)model {
    [super configModel:model];
    self.textLabel.text = model.title;
}

@end
