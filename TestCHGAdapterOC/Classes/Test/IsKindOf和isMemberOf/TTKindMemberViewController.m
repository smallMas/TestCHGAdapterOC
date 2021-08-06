//
//  TTKindMemberViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/2/1.
//

#import "TTKindMemberViewController.h"
#import "TTSark.h"

@interface TTKindMemberViewController ()
@property (weak, nonatomic) UIImageView *img;
@end

@implementation TTKindMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self img];
    /*
     // 类对象 isKindOfClass : 类对象
     + (BOOL)isKindOfClass:(Class)cls {
         for (Class tcls = self->ISA(); tcls; tcls = tcls->superclass) {
             if (tcls == cls) return YES;
         }
         return NO;
     }
     
     // 实例对象 isKindOfClass：类
     - (BOOL)isKindOfClass:(Class)cls {
         for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
             if (tcls == cls) return YES;
         }
         return NO;
     }
     
     isKindOfClass：先判断NSObject与NSObject的元类是否一样，接着判断NSObject与NSObject的元类的父类是否一样，如果一样就返回yes
     
     // 类对象 isMemberOfClass：类对象
     + (BOOL)isMemberOfClass:(Class)cls {
         return self->ISA() == cls;
     }
     // 实例对象 isMemberOfClass: 类对象
     - (BOOL)isMemberOfClass:(Class)cls {
         return [self class] == cls;
     }
     isMemberOfClass：拿自己的isa指针和自己比较，是否相等
     */

    NSObject *object = NSObject.new;
    TTSark *sark = TTSark.new;
    BOOL r1 = [object isKindOfClass:[NSObject class]];
    BOOL r2 = [object isMemberOfClass:[NSObject class]];
    BOOL r3 = [sark isKindOfClass:[NSObject class]];
    BOOL r4 = [sark isMemberOfClass:[NSObject class]];
    BOOL r5 = [sark isKindOfClass:[TTSark class]];
    BOOL r6 = [sark isMemberOfClass:[TTSark class]];
    NSLog(@"r1 : %d  r2 : %d  r3 : %d  r4 : %d  r5 : %d  r6 : %d",r1,r2,r3,r4,r5,r6);
    
    Class sarkCls1 = objc_getClass(object_getClassName(sark)); // 类对象
    Class sarkCls2 = objc_getMetaClass(object_getClassName(sark)); // 元类
    NSLog(@"sarkCls1 >>> %p",sarkCls1);
    NSLog(@"sarkCls2 >>> %p",sarkCls2);
    
    BOOL res1 = [[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [[TTSark class] isKindOfClass:[TTSark class]];
    BOOL res4 = [[TTSark class] isMemberOfClass:[TTSark class]];
    NSLog(@"res1 : %d res2 : %d res3 : %d res4 : %d",res1,res2,res3,res4);
    Class cls = NSClassFromString(@"TTSark");
    NSLog(@"xx : %@  yy : %@",[NSObject class],cls);
    BOOL res5 = [cls isKindOfClass:[NSObject class]];
    NSLog(@"res5 >>> %d",res5);
    BOOL res6 = [[TTSark class] isKindOfClass:[NSObject class]];
    NSLog(@"res6 >>> %d",res6);
    BOOL res7 = [[TTSark class] isMemberOfClass:[NSObject class]];
    NSLog(@"res7 >>> %d",res7);
    
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
    
    Class cls5 = objc_getClass("NSObject");
    Class cls6 = object_getClass(obj);
    Class cls7 = object_getClass(cls6);
    NSLog(@"class5 : %p name : %@",cls5,cls5);
    NSLog(@"class6 : %p name : %@",cls6,cls6);
    NSLog(@"class7 : %p name : %@",cls7,cls7);
}

- (UIImageView *)img {
    if (!_img) {
        UIImageView *obj = UIImageView.new;
        [self.view addSubview:_img = obj];
        CGFloat w = FSJSCREENWIDTH;
        CGFloat h = 305.0/280.0*w;
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeWHV(w, h);
            kMakeCenterXV(0);
            kMakeCenterYV(0);
        }];
        obj.backgroundColor = [UIColor fsj_randomColor];
        obj.image = [UIImage imageNamed:@"元类图"];
    }
    return _img;
}


@end
