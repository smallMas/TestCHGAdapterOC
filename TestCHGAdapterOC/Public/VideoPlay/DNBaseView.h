//
//  DNBaseView.h
//  DnaerApp
//
//  Created by DNAER5 on 2019/2/22.
//  Copyright © 2019 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHGAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNBaseView : CHGBaseView

/**
 创建UI 子类重写
 */
-(void)createUI NS_REQUIRES_SUPER;

/**
 布局view 子类重写
 */
-(void)layoutUI NS_REQUIRES_SUPER;


@end

NS_ASSUME_NONNULL_END
