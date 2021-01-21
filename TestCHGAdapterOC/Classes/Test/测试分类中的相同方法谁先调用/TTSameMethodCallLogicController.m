//
//  TTSameMethodCallLogicController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/21.
//
/*
 总结:
     在Compile Sources中 谁在最后后面，就以谁为准
 */

#import "TTSameMethodCallLogicController.h"
#import "TTSameModel+SameA.h"
#import "TTSameModel+SameB.h"

@interface TTSameMethodCallLogicController ()

@end

@implementation TTSameMethodCallLogicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TTSameModel *model = [TTSameModel new];
    [model testMethod];
}


@end
