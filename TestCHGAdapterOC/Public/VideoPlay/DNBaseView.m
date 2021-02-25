//
//  DNBaseView.m
//  DnaerApp
//
//  Created by DNAER5 on 2019/2/22.
//  Copyright © 2019 燕来秋. All rights reserved.
//

#import "DNBaseView.h"

@implementation DNBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [self layoutUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        [self layoutUI];
    }
    return self;
}


-(void)createUI {
    
}

-(void)layoutUI {
    
}

- (void)cellWillAppear {
    
}

- (void)cellDidDisappear {
    
}

@end
