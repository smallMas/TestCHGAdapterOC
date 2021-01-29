//
//  TTTestKVCViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/29.
//

#import "TTTestKVCViewController.h"
#import "TTPerson.h"
@interface TTTestKVCViewController ()
@property (nonatomic, strong) TTPerson *person;
@property (nonatomic, strong) NSString *name;
@end

@implementation TTTestKVCViewController

/*
 测试结果：
 方法查找优先级 set<key>:方法 > _set<key>:方法 > setIs<key>方法
 如果上面3个方法都没有的话就会执行accessInstanceVariablesDirectly方法（检测机制,直接方法实例变量），如果这个方法返回NO，则会调用setValue:forUndefinedKey:如果返回YES，则继续寻找相关变量
 优先级(_name > _isName > name > isName)
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TTPerson *p = [TTPerson new];
    [p setValue:@"fansj" forKey:@"name"];
    
    NSLog(@"p __name : %@",p->__name);
    NSLog(@"p _name : %@",p->_name);
    NSLog(@"p _isName : %@",p->_isName);
    NSLog(@"p name : %@",p->name);
    NSLog(@"p isName : %@",p->isName);
    
    // __block 需要设置为nil才能解决循环引用的问题
    self.person = p;
    self.name = @"ac";
    __block TTTestKVCViewController *wSelf = self;
    [self.person setBlock:^{
        NSLog(@"self.person  :%@",wSelf.person);
        wSelf.name = @"bc";
//        wSelf = nil;
    }];
    [self.person test];
    
    NSLog(@"self.name :: %@",self.name);
}

@end
