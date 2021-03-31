//
//  TTMacro.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import <objc/message.h>

#define TT_RunEngine(info, handle)\
Class cls = (id)objc_getClass("TTRunEngine"); \
NSAssert(cls != nil, @"无法找到类TTRunEngine"); \
((void(*)(id,SEL,id,id))objc_msgSend)(cls,NSSelectorFromString(@"handleCommand:handle:"),(info),(handle));
