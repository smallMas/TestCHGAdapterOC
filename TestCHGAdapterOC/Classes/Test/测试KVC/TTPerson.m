//
//  TTPerson.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/29.
//

#import "TTPerson.h"

@implementation TTPerson
//@synthesize name = _name;

+ (BOOL)accessInstanceVariablesDirectly {
    NSLog(@"%s",__func__);
    return [super accessInstanceVariablesDirectly];
//    return NO;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    NSLog(@"%s",__func__);
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%s",__func__);
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"%s",__func__);
    return [super valueForUndefinedKey:key];
}

//- (void)setName:(NSString *)name {
//    NSLog(@"%s",__func__);
//    _name = name;
//}

//- (void)_setName:(NSString *)a {
//    NSLog(@"%s",__func__);
//    name = a;
//}

//- (void)setIsName:(NSString *)a {
//    isName = a;
//}
//
//- (void)_setIsName:(NSString *)a {
//    NSLog(@"%s",__func__);
//    _isName = a;
//}

//- (void)setIsIsName:(NSString *)a {
//    NSLog(@"%s",__func__);
//    name = a;
//}

//- (void)set_isName:(NSString *)a {
//    NSLog(@"%s",__func__);
//    name = a;
//}


#pragma mark - 获取
//- (NSString *)getName {
//    NSLog(@"%s",__func__);
//    return _name;
//}

//- (NSString *)name {
//    NSLog(@"%s",__func__);
//    return _name;
//}

//- (NSString *)isName {
//    NSLog(@"%s",__func__);
//    return _name;
//}

- (void)test {
    if (self.block) {
        self.block();
    }
}
@end
