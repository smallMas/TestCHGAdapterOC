//
//  TTWCDBDataTableCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//

#import "TTWCDBDataTableCell.h"
#import "TTTestRandomData.h"

@implementation TTWCDBDataTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath targetView:(UIView *)targetView model:(id)model eventTransmissionBlock:(nonnull CHGEventTransmissionBlock)eventTransmissionBlock {
    [super cellForRowAtIndexPath:indexPath targetView:targetView model:model eventTransmissionBlock:eventTransmissionBlock];
    TTTestRandomData *tmpModel = model;
    self.textLabel.text = [NSString stringWithFormat:@"%@-%@",tmpModel.name,tmpModel.uuid];
}


@end
