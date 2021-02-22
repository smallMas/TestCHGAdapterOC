//
//  TTKindMemberViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/2/1.
//

#import "TTKindMemberViewController.h"
#import "TTSark.h"

@interface TTKindMemberViewController ()

@end

@implementation TTKindMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     isKindOfClass：先判断NSObject与NSObject的元类是否一样，接着判断NSObject与NSObject的元类的父类是否一样，如果一样就返回yes
     isMemberOfClass：拿自己的isa指针和自己比较，是否相等
     */
    BOOL res1 = [[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [[TTSark class] isKindOfClass:[TTSark class]];
    BOOL res4 = [[TTSark class] isMemberOfClass:[TTSark class]];
    NSLog(@"res1 : %d res2 : %d res3 : %d res4 : %d",res1,res2,res3,res4);
    
    // res1 ：先判断NSObject与NSObject的元类 是否一样 ，是不一样的，所以再判断NSObject与NSObject的元类的父类判断，NSObject的元类的父类就是NSObject，所以是一样的，返回YES
    // res3 ：先判断TTSark与TTSark的元类是否一样，不一样，再判断TTSark与TTSark的元类的父类是否一样，TTSark的元类父类是NSObject的元类，所以也不一样，所以TTSark与NSObject的元类的父类进行比较，而NSObject的元类的父类是NSObject，所以也不一样，所以返回NO
    
    // res2 ： isa指向NSObject的Meta class，所以和[NSObject class]不相等， 所以返回NO
    // res4 ： isa指向TTSark的Meta class，和TTSark class也不一样 ，所以返回NO
    
    NSObject *obj = [[NSObject alloc] init];
    Class cls1 = [obj class];
    Class cls2 = [NSObject class];
    Class cls3 = objc_getClass(object_getClassName(obj)); // 类对象
    Class cls4 = objc_getMetaClass(object_getClassName(obj)); // 元类
    NSLog(@"class1 : %p name : %@",cls1,cls1);
    NSLog(@"class2 : %p name : %@",cls2,cls2);
    NSLog(@"class3 : %p name : %@",cls3,cls3);
    NSLog(@"class4 : %p name : %@",cls4,cls4);
}


@end
