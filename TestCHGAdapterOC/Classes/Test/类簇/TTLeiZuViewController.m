//
//  TTLeiZuViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/21.
//

#import "TTLeiZuViewController.h"

@interface TTLeiZuViewController (){
@private
   __strong NSString *_name;
}

@end

@implementation TTLeiZuViewController
//@synthesize name = _name;
@dynamic name;

- (NSString *)name {
    if (nil == _name) {
        _name = @"you forgot inputbook name";
    }
    return _name;
}

- (void)setName:(NSString *)name {
    _name = name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSNumber *number1 = [NSNumber numberWithInt:1];
    NSNumber *number2 = [NSNumber numberWithFloat:2.53];
    NSNumber *number3 = [NSNumber numberWithBool:YES];
    NSNumber *number4 = [NSNumber numberWithChar:'a'];
    NSLog(@"number1 : %@ %@",number1,[number1 class]);
    NSLog(@"number2 : %@ %@",number2,[number2 class]);
    NSLog(@"number3 : %@ %@",number3,[number3 class]);
    NSLog(@"number4 : %@ %@",number4,[number4 class]);
    if ([number1 isMemberOfClass:[NSNumber class]]) {
        NSLog(@"=========1");
    }
    if ([number2 isMemberOfClass:[NSNumber class]]) {
        NSLog(@"=========2");
    }
    if ([number3 isMemberOfClass:[NSNumber class]]) {
        NSLog(@"=========3");
    }
    if ([number4 isMemberOfClass:[NSNumber class]]) {
        NSLog(@"=========4");
    }
    
    // ------------------------------------------------
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn3 = [UIButton new];
    NSLog(@"btn1 : %@ %@",btn1,[btn1 class]);
    NSLog(@"btn2 : %@ %@",btn2,[btn1 class]);
    NSLog(@"btn3 : %@ %@",btn3,[btn1 class]);
    if ([btn1 isMemberOfClass:[UIButton class]]) {
        NSLog(@"---------1");
    }
    if ([btn2 isMemberOfClass:[UIButton class]]) {
        NSLog(@"---------2");
    }
    if ([btn1 isMemberOfClass:[UIButton class]]) {
        NSLog(@"---------3");
    }
    
    // ------------------------------------------------
    NSArray *arr1 = [NSArray new];
    NSArray *arr2 = [NSArray arrayWithObject:@"a"];
    NSMutableArray *arr3 = [[NSMutableArray alloc] initWithObjects:@"c", nil];
    NSLog(@"arr1 class : %@",[arr1 class]);
    NSLog(@"arr2 class : %@",[arr2 class]);
    NSLog(@"arr3 class : %@",[arr3 class]);
    
    NSLog(@"name : %@",self.name);
}

@end
