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
 三个优先级：
 第一个set方法优先级  set<key> > _set<key> > setIs<key>
 第二个get方法优先级  get<key> > <key> > is<key>
 第三个成员命名优先级  _key > _isKey > key > isKey
 
 测试结果：
 方法查找优先级 set<key>:方法 > _set<key>:方法 > setIs<key>方法
 如果上面3个方法都没有的话就会执行accessInstanceVariablesDirectly方法（检测机制,直接方法实例变量），如果这个方法返回NO，则会调用setValue:forUndefinedKey:如果返回YES，则继续寻找相关变量
 优先级(_name > _isName > name > isName)
 
 get<key> > <key> > is<key>
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TTPerson *p = [TTPerson new];
    [p setValue:@"fansj" forKey:@"name"];
    
//    NSLog(@"p __name : %@",p->__name);
//    NSLog(@"p _name : %@",p->_name);
//    NSLog(@"p _isName : %@",p->_isName);
//    NSLog(@"p name : %@",p->name);
//    NSLog(@"p isName : %@",p->isName);
    
//    NSLog(@"value __name : %@",[p valueForKey:@"__name"]);
//    NSLog(@"value _name : %@",[p valueForKey:@"_name"]);
//    NSLog(@"value _isName : %@",[p valueForKey:@"_isName"]);
    NSLog(@"value name : %@",[p valueForKey:@"name"]);
//    NSLog(@"value isName : %@",[p valueForKey:@"isName"]);
    
//    // __block 需要设置为nil才能解决循环引用的问题
//    self.person = p;
//    self.name = @"ac";
//    __block TTTestKVCViewController *wSelf = self;
//    [self.person setBlock:^{
//        NSLog(@"self.person  :%@",wSelf.person);
//        wSelf.name = @"bc";
////        wSelf = nil;
//    }];
//    [self.person test];
//
//    NSLog(@"self.name :: %@",self.name);
    
    
    TTPerson *p1 = TTPerson.new;
    p1.str = @"我";
    p1.id = @"我";
    
    TTPerson *p2 = TTPerson.new;
    p2.str = @"你";
    p2.id = @"我";
    
    TTPerson *p3 = TTPerson.new;
    p3.str = @"他";
    p3.id = @"我";
    NSArray * persions = @[p1,p2,p3];
        
    // 如果valueForKeyPath:这个方法调用者是数组，会抽取这个数组中每一个对象的name属性的值，并且存放在一个新的数组中返回
    NSArray *str2 = [persions valueForKeyPath:@"id"];
    NSLog(@"str2 : %@",str2);
}

@end
