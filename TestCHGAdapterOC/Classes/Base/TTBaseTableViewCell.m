//
//  TTBaseTableViewCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "TTBaseTableViewCell.h"

@implementation TTBaseTableViewCell

- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath targetView:(UIView *)targetView model:(id)model eventTransmissionBlock:(nonnull CHGEventTransmissionBlock)eventTransmissionBlock {
    [super cellForRowAtIndexPath:indexPath targetView:targetView model:model eventTransmissionBlock:eventTransmissionBlock];
    
    [self configModel:model];
}

- (void)configModel:(id)model {
    
}

@end
