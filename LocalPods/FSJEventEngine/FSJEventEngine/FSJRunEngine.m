//
//  FSJRunEngine.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "FSJRunEngine.h"

@implementation FSJRunEngine

+ (void)handleCommand:(NSDictionary *)command {
    [self handleCommand:command handle:nil];
}

+ (void)handleCommand:(NSDictionary *)action handle:(id)handle {
    NSLog(@"%s %@",__FUNCTION__,action);
}

@end
