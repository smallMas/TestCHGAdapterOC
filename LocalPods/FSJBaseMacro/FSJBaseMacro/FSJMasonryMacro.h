//
//  FSJMasonryMacro.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/4/20.
//


///Masonry
#define kMakeL(v) make.left.equalTo((v))
#define kMakeLV(v) make.left.equalTo(@(v))
#define kMakeT(v) make.top.equalTo((v))
#define kMakeTV(v) make.top.equalTo(@(v))
#define kMakeB(v) make.bottom.equalTo((v))
#define kMakeBV(v) make.bottom.equalTo(@(v))
#define kMakeR(v) make.right.equalTo((v))
#define kMakeRV(v) make.right.equalTo(@(v))

#define kMakeW(v) make.width.equalTo((v))
#define kMakeWV(v) make.width.equalTo(@(v))
#define kMakeH(v) make.height.equalTo((v))
#define kMakeHV(v) make.height.equalTo(@(v))
        
#define kMakeLT(v) make.top.left.equalTo((v))
#define kMakeLTV(v) make.top.left.equalTo(@(v))
#define kMakeTR(v) make.top.right.equalTo((v))
#define kMakeTRV(v) make.top.right.equalTo(@(v))
#define kMakeLR(v) make.left.right.equalTo((v))
#define kMakeLRV(v) make.left.right.equalTo(@(v))
#define kMakeTB(v) make.top.bottom.equalTo((v))
#define kMakeTBV(v) make.top.bottom.equalTo(@(v))
#define kMakeLB(v) make.left.bottom.equalTo((v))
#define kMakeLBV(v) make.left.bottom.equalTo(@(v))
#define kMakeRB(v) make.right.bottom.equalTo((v))
#define kMakeRBV(v) make.right.bottom.equalTo(@(v))
        
#define kMakeLTR(v) make.top.left.right.equalTo((v))
#define kMakeLTRV(v) make.top.left.right.equalTo(@(v))
#define kMakeLTB(v) make.top.left.bottom.equalTo((v))
#define kMakeLTBV(v) make.top.left.bottom.equalTo(@(v))
#define kMakeTRB(v) make.top.right.bottom.equalTo((v))
#define kMakeTRBV(v) make.top.right.bottom.equalTo(@(v))
#define kMakeLBR(v) make.left.bottom.right.equalTo((v))
#define kMakeLBRV(v) make.left.bottom.right.equalTo(@(v))
#define kMakeEdge(v) make.edges.equalTo((v))
#define kMakeEdgeV(v) make.edges.insets((v))
#define kMakeEdge0 make.edges.insets(UIEdgeInsetsZero)

#define kMakeCenter(v) make.center.equalTo((v))
#define kMakeCenterX(v) make.centerX.equalTo((v))
#define kMakeCenterXV(v) make.centerX.equalTo(@(v))
#define kMakeCenterY(v) make.centerY.equalTo((v))
#define kMakeCenterYV(v) make.centerY.equalTo(@(v))

#define kMakeW(v) make.width.equalTo((v))
#define kMakeWV(v) make.width.equalTo(@(v))
#define kMakeH(v) make.height.equalTo((v))
#define kMakeHV(v) make.height.equalTo(@(v))
#define kMakeWH(v1, v2) make.width.equalTo((v1));\
make.height.equalTo((v2))
#define kMakeWHV(v1, v2) make.width.equalTo(@(v1));\
make.height.equalTo(@(v2))


///快捷宏定义
#define kEdge(T,L,B,R) UIEdgeInsetsMake((T), (L), (B), (R))
#define kSize(w,h) CGSizeMake((w), (h))
#define kRect(X,Y,W,H) (CGRect){(X),(Y),(W),(H)}
#define kStringFormat(...) [NSString stringWithFormat:__VA_ARGS__]
