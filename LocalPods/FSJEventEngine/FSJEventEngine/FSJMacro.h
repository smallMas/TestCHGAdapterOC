//
//  FSJMacro.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#pragma --mark 消息处理 ----
//全局消息处理, 带参，不带参
#define fRunCMD(cmd)          @{@"app_action":(cmd)}
#define fRunCMDINFO(cmd, ...) @{@"app_action":(cmd),@"info":__VA_ARGS__}
//自定义消息处理, 带参，不带参
#define fMsg(cmd) @{@"msg":(cmd)}
#define fMsgPack(cmd, ...) @{@"msg":(cmd),@"info":__VA_ARGS__}
#define fMsgForward(cmd, target) @{@"msg":(cmd),@"target":(target)}
#define fMsgPackForward(cmd,target, ...) @{@"msg":(cmd),@"target":(target),@"info":__VA_ARGS__}
