//
//  TTTestCopyViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/29.
//

/*
    1、非容器不可变对象的copy为浅拷贝，mutableCopy为深拷贝
    浅拷贝获得的对象地址和原对象地址一致， 返回的对象为不可变对象
    深拷贝返回新的内存地址，返回对象为可变对象，mutableCopy拷贝出来的对象变成了可变对象
 
    2、非容器可变对象的copy为深拷贝，mutableCopy为深拷贝，copy出来的对象已经变成了不可变对象了，而mutableCopy出来的对象还是可变的
 
    3、容器不可变对象的copy为浅拷贝，mutableCopy为深拷贝，容器内的对象仍然是浅拷贝，深拷贝是可变的
 
    4、容器可变对象的copy为深拷贝，mutableCopy为深拷贝，容器内的对象仍然是浅拷贝
 
 总结：
    copy：对于可变对象为深拷贝，对于不可变对象为浅拷贝，都是不可变的
    mutableCopy：始终都是深拷贝，深拷贝出来的对象是可变的
 */

#import "TTTestCopyViewController.h"

@interface TTTestCopyViewController ()

@end

@implementation TTTestCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 拷贝分为深拷贝 浅拷贝
    // 拷贝对象 分为非容器不可变对象 、非容器可变对象、容器不可变对象、容器可变对象
    
    [self testNoContainerNoChanged];
    [self testNoContainerChanged];
    [self testContainerNoChanged];
    [self testContainerChanged];
}

// 测试非容器不可变对象
- (void)testNoContainerNoChanged {
    NSLog(@"========测试非容器不可变对象");
    NSString *str1 = @"abc";
    NSString *str2 = [str1 copy];
    NSMutableString *str3 = [str1 mutableCopy];
    
    NSLog(@"str1_p : %p class : %@",str1, [str1 class]);
    NSLog(@"str2_p : %p class : %@",str2, [str2 class]);
    NSLog(@"str3_p : %p class : %@",str3, [str3 class]);
    
    [str3 appendString:@"3"];
    NSLog(@"str3 >> %@",str3);
}

// 测试非容器可变对象
- (void)testNoContainerChanged {
    NSLog(@"========测试非容器可变对象");
    NSMutableString *mstr1 = [NSMutableString stringWithFormat:@"非容器可变对象"];
    NSMutableString *mstr2 = [mstr1 copy];
    NSMutableString *mstr3 = [mstr1 mutableCopy];
    
    NSLog(@"mstr1_p : %p class : %@",mstr1, [mstr1 class]);
    NSLog(@"mstr2_p : %p class : %@",mstr2, [mstr2 class]);
    NSLog(@"mstr3_p : %p class : %@",mstr3, [mstr3 class]);
    
//    [mstr1 appendString:@"1"];
//    [mstr2 appendString:@"2"];
//    [mstr3 appendString:@"3"];
//    NSLog(@"mstr1 >> %@",mstr1);
//    NSLog(@"mstr2 >> %@",mstr2);
//    NSLog(@"mstr3 >> %@",mstr3);
}

// 测试容器不可变对象
- (void)testContainerNoChanged {
    NSLog(@"========测试容器不可变对象");
    NSMutableString *mstr1 = [NSMutableString stringWithFormat:@"非容器可变对象"];
    
    NSArray *arr1 = [NSArray arrayWithObjects:mstr1,@"非容器不可变对象",nil];
    NSArray *arr2 = [arr1 copy];
    NSMutableArray *arr3 = [arr1 mutableCopy];
    
    NSLog(@"arr1_p : %p class : %@",arr1, [arr1 class]);
    NSLog(@"arr2_p : %p class : %@",arr2, [arr2 class]);
    NSLog(@"arr3_p : %p class : %@",arr3, [arr3 class]);
    
    NSLog(@"-----------原对象内的对象");
    NSLog(@"object_p : %p class : %@",arr1[0], [arr1[0] class]);
    NSLog(@"object_p : %p class : %@",arr1[1], [arr1[1] class]);
    
    NSLog(@"-----------copy后对象内的对象");
    NSLog(@"object_p : %p class : %@",arr2[0], [arr2[0] class]);
    NSLog(@"object_p : %p class : %@",arr2[1], [arr2[1] class]);
    
    NSLog(@"-----------mutableCopy后对象内的对象");
    NSLog(@"object_p : %p class : %@",arr3[0], [arr3[0] class]);
    NSLog(@"object_p : %p class : %@",arr3[1], [arr3[1] class]);
    
    [arr3 addObject:@"3"];
    NSLog(@"arr3 >>> %@",arr3);
}

// 测试容器可变对象
- (void)testContainerChanged {
    NSLog(@"========测试容器可变对象");
    NSMutableString *mstr1 = [NSMutableString stringWithFormat:@"非容器可变对象"];
    
    NSMutableArray *marr1 = [NSMutableArray arrayWithObjects:mstr1,@"非容器不可变对象",nil];
    NSMutableArray *marr2 = [marr1 copy];
    NSMutableArray *marr3 = [marr1 mutableCopy];
    
    NSLog(@"marr1_p : %p class : %@",marr1, [marr1 class]);
    NSLog(@"marr2_p : %p class : %@",marr2, [marr2 class]);
    NSLog(@"marr3_p : %p class : %@",marr3, [marr3 class]);
    
    NSLog(@"-----------原对象内的对象");
    NSLog(@"object_p : %p class : %@",marr1[0], [marr1[0] class]);
    NSLog(@"object_p : %p class : %@",marr1[1], [marr1[1] class]);
    
    NSLog(@"-----------copy后对象内的对象");
    NSLog(@"object_p : %p class : %@",marr2[0], [marr2[0] class]);
    NSLog(@"object_p : %p class : %@",marr2[1], [marr2[1] class]);
    
    NSLog(@"-----------mutableCopy后对象内的对象");
    NSLog(@"object_p : %p class : %@",marr3[0], [marr3[0] class]);
    NSLog(@"object_p : %p class : %@",marr3[1], [marr3[1] class]);
    
//    [marr2 addObject:@"2"];
//    NSLog(@"marr2 : %@",marr2);
}


@end
