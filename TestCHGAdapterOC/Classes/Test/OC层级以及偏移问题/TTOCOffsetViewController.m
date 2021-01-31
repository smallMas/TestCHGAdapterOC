//
//  TTOCOffsetViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/1/31.
//

#import "TTOCOffsetViewController.h"
#import "TTPeople.h"

@interface TTOCOffsetViewController ()

@end

@implementation TTOCOffsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // OC层级以及偏移问题
    // 方法调用是查找对象中的方法，而isa指向TTPeople，所以指针kc和person的isa都是指向TTPeople
    // 属性存在当前内存结构体（isa同级）
    // 入栈顺序
    
    Class cls = [TTPeople class];
    void *kc = &cls;
    [(__bridge id)kc saySomething];
    
    
    TTPeople *person = [TTPeople alloc];
    person.name = @"fansj";
    person.age = 19;
    [person saySomething];
    
    // C代码
    void *sp = (void *)&self;
    void *end = (void *)&person;
    long count = (sp-end)/0x8;
    for (long i = 0; i < count; i++) {
        void *address = sp - 0x8 * i;
        if ( i == 1) {
            NSLog(@"%p : %s",address, *(char **)address);
        }else {
            NSLog(@"%p : %@",address, *(void **)address);
        }
    }
}


@end
