//
//  TTChainTableCell.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/9.
//

#import "TTChainTableCell.h"
#import "TTChainModel.h"

@implementation TTChainTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWillAppear {
    [super cellWillAppear];
    TTChainModel *model = self.model;
    self.textLabel.text = model.name;
}

@end
