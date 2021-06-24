//
//  TTTestLoadController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/24.
//

#import "TTTestLoadController.h"
#import "TTChildLoad.h"

@interface TTTestLoadController ()

@end

@implementation TTTestLoadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    TTChildLoad.new;
    TTLoad.new;
    NSString *loadResult = @"load方法在程序启动时加载，只要类被添加到runtime中就会调用load方法，在main方法之前，load的加载顺序：先加载父类的load，再加载子类的load，最后加载分类的load，这些load方法只要实现了都会加载";
    NSString *initResult = @"initialize方法是在类或子类收到第一条消息之前被调用，在main方法之后，initialize的加载顺序：先加载分类的initialize，分类中没有实现initialize，会加载类中的initialize，这里分类和类只能加载一个；父类和子类的关系，假如初始化子类，有两个打印，第一个先加载父类分类的initialize，如果没有再加载父类的initialize，第二个先加载子类分类的initialize，如果没有再加载子类的initialize";
    NSLog(@"测试结果如下 :");
    NSLog(@"%@",loadResult);
    NSLog(@"%@",initResult);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
