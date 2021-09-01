//
//  TTTetrisViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/31.
//  https://github.com/suidongyang/TETRIS

#import "TTTetrisViewController.h"
#import "SquareGroup.h"
#import "BasicSquare.h"
#import <FSJAudioPlayer/FSJAudioPlayer.h>

#define COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kRowCount 20
#define kColumnCount 11

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

@interface TTTetrisViewController () {
    CGPoint _startPoint;        // 新组合origin
    BOOL _disableButtonActions; // 按钮禁用1
    BOOL _disablePauseButton;   // 刷新动画期间使暂停按钮无效
    CGFloat _edgeRotateOffset;  // 旋转溢出补偿
    int _levelUpCounter;        // 计满20行升级
    BOOL _hadBegan;             // 程序是否运行过
}
@property (strong, nonatomic) FSJAudioPlayer *player;

@property (strong, nonatomic) UIView *squareRoomView;
@property (strong, nonatomic) UIView *roomBgView;
@property (strong, nonatomic) SquareGroup *group;
@property (weak, nonatomic) UIView *tipBoardView;

@property (weak, nonatomic) UIButton *pauseButton;
@property (weak, nonatomic) UIButton *soundButton;
@property (weak, nonatomic) UILabel *levelLabel;
@property (weak, nonatomic) UILabel *scoreLabel;
@property (weak, nonatomic) UILabel *lineCountLabel;

@property (weak, nonatomic) UIView *opView;
@property (weak, nonatomic) UIButton *leftBtn;
@property (weak, nonatomic) UIButton *rightBtn;
@property (weak, nonatomic) UIButton *topBtn;
@property (weak, nonatomic) UIButton *bottomBtn;

@property (weak, nonatomic) UIButton *startBtn;

@property (assign, nonatomic) int score;                    // 当前得分
@property (assign, nonatomic) int clearedLines;             // 消除行数
@property (assign, nonatomic) int speedLevel; // 速度级别
@property (assign, nonatomic) BOOL isSettingMode;           // 1-设置 0-移动
@property (assign, nonatomic) int startupLines;             // 起始行数

@property (strong, nonatomic) NSTimer *dropDownTimer;       // 下落计时 1
@property (strong, nonatomic) NSTimer *keepMoveTimer;       // 按住按钮持续移动 0
@property (strong, nonatomic) NSTimer *refreshTimer;        // 刷新动画计时 0
@end

@implementation TTTetrisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"俄罗斯方块";
    [self initBGM];
    [self setupUI];
    [self initConfigs];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self playBGM];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self pauseBGM];
}

- (void)initBGM {
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"tetris_bgm" ofType:@"mp3"];
    [self.player setUrlString:filepath];
}

- (void)playBGM {
    [[FSJAudioPlayerManager shareInstance] play:self.player];
}

- (void)pauseBGM {
    [[FSJAudioPlayerManager shareInstance] pause];
}

- (void)initConfigs {
    _startPoint = CGPointMake(kSquareWH * 4, 0);
    self.speedLevel = 1;
//    self.score = 0;
    self.isSettingMode = YES;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.roomBgView];
    [self.squareRoomView addSubview:self.group];
    [self.tipBoardView addSubview:self.group.tipBoard];
    CGSize size = self.group.tipBoard.frame.size;
    [self.group.tipBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        kMakeWHV(size.width, size.height);
        kMakeCenterXV(0);
        kMakeCenterYV(0);
    }];
    
    [self opView];
    [self pauseButton];

    self.tipBoardView.layer.borderWidth = 5.0;
    self.tipBoardView.layer.borderColor = self.roomBgView.backgroundColor.CGColor;
    self.tipBoardView.backgroundColor = COLOR(222, 238, 254);
}


#pragma mark - setters

- (void)setIsSettingMode:(BOOL)isSettingMode {
    _isSettingMode = isSettingMode;
    if (isSettingMode) {
        self.lineCountLabel.text = kStringFormat(@"行数:%@",@(self.startupLines).stringValue);
    }else {
        self.scoreLabel.text = kStringFormat(@"分数:%@",@(self.score).stringValue);
        self.lineCountLabel.text = kStringFormat(@"行数:%@",@(self.startupLines).stringValue);
    }
}

- (void)setScore:(int)score {
    _score = score;
    self.scoreLabel.text = kStringFormat(@"分数:%@",@(self.score).stringValue);
}

- (void)setClearedLines:(int)clearedLines {
    _clearedLines = clearedLines;
    self.lineCountLabel.text = kStringFormat(@"行数:%@",@(clearedLines).stringValue);
}

- (void)setStartupLines:(int)startupLines {
    _startupLines = startupLines;
    self.lineCountLabel.text = kStringFormat(@"行数:%@",@(self.startupLines).stringValue);
}

- (void)setSpeedLevel:(int)speedLevel {
    _speedLevel = speedLevel;
    self.levelLabel.text = kStringFormat(@"等级:%@",@(self.speedLevel).stringValue);
}

#pragma mark - lazy loads
- (FSJAudioPlayer *)player {
    if (!_player) {
        FSJAudioPlayer *obj = [FSJAudioPlayer new];
        _player = obj;
        obj.progressBlock = ^(Float64 current, Float64 duration, CGFloat progress) {
            NSLog(@"播放进度 : %f current : %f duration : %f",progress,current,duration);
        };
        FSJ_WEAK_SELF
        obj.playEndBlock = ^{
            FSJ_STRONG_SELF
            [self playBGM];
        };
    }
    return _player;
}

- (UIView *)squareRoomView {
    if (!_squareRoomView) {
        _squareRoomView = [[UIView alloc] init];
        _squareRoomView.frame = CGRectMake(5, 5, kSquareWH * kColumnCount, kSquareWH * kRowCount);
        _squareRoomView.backgroundColor = [UIColor colorWithRed:191.0 green:207.0 blue:233.0 alpha:1];
        _squareRoomView.userInteractionEnabled = NO;
        
        for (int i = 0; i < kColumnCount * kRowCount; i++) {
            BasicSquare *square = [[BasicSquare alloc] initWithFrame:CGRectMake(i % kColumnCount * kSquareWH, i / kColumnCount * kSquareWH, kSquareWH, kSquareWH)];
            square.selected = NO;
            [_squareRoomView addSubview:square];
        }
    }
    return _squareRoomView;
}

- (UIView *)roomBgView {
    if (!_roomBgView) {
        _roomBgView = [[UIView alloc] init];
        [_roomBgView addSubview:self.squareRoomView];
        _roomBgView.frame = CGRectMake(20, 40, _squareRoomView.fsj_width + 10, _squareRoomView.fsj_height + 10);
        _roomBgView.backgroundColor = COLOR(120, 137, 169);
        _roomBgView.clipsToBounds = YES;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _roomBgView.fsj_width, 5)];
        line.backgroundColor = _roomBgView.backgroundColor;
        [_roomBgView addSubview:line];
    }
    return _roomBgView;
}

- (SquareGroup *)group {
    if (!_group) {
        _group = [[SquareGroup alloc] init];
    }
    return _group;
}

- (UIView *)tipBoardView {
    if (!_tipBoardView) {
        UIView *obj = UIView.new;
        [self.view addSubview:_tipBoardView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeL(self.roomBgView.mas_right).offset(5);
            kMakeRV(-20);
            kMakeT(self.roomBgView);
            kMakeHV(76);
        }];
    }
    return _tipBoardView;
}

- (UIView *)opView {
    if (!_opView) {
        UIView *obj = [UIView new];
        [self.view addSubview:_opView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeWHV(180, 180);
            kMakeLV(20);
            kMakeBV(-(FSJAppSafeBottomH+20));
        }];
        
        [self topBtn];
        [self bottomBtn];
        [self leftBtn];
        [self rightBtn];
        
        [self startBtn];
    }
    return _opView;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.opView addSubview:_leftBtn = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeLV(0);
            kMakeWHV(75, 75);
            kMakeCenterYV(0);
        }];
        obj.tag = 11;
        [obj setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [obj addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
        [obj addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(setupKeepMoveTimer:)]];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.opView addSubview:_rightBtn = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeRV(0);
            kMakeWHV(75, 75);
            kMakeCenterYV(0);
        }];
        obj.tag = 33;
        [obj setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        
        [obj addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
        [obj addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(setupKeepMoveTimer:)]];
    }
    return _rightBtn;
}

- (UIButton *)topBtn {
    if (!_topBtn) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.opView addSubview:_topBtn = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeTV(0);
            kMakeWHV(75, 75);
            kMakeCenterXV(0);
        }];
        [obj setBackgroundImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        
        [obj addTarget:self action:@selector(thunderDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topBtn;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.opView addSubview:_bottomBtn = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeBV(0);
            kMakeWHV(75, 75);
            kMakeCenterXV(0);
        }];
        obj.tag = 22;
        [obj setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        
        [obj addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
        [obj addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(setupKeepMoveTimer:)]];
    }
    return _bottomBtn;
}

- (UIButton *)pauseButton {
    if (!_pauseButton) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_pauseButton = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeL(self.roomBgView.mas_right).offset(5);
            kMakeB(self.roomBgView.mas_bottom);
        }];
        [obj setTitle:@"PAUSE" forState:UIControlStateNormal];
        [obj setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [obj addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pauseButton;
}

- (UIButton *)startBtn {
    if (!_startBtn) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_startBtn = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeRV(-20);
            kMakeWHV(92, 92);
            kMakeCenterY(self.opView);
        }];
        [obj setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        
        [obj addTarget:self action:@selector(rotate:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

- (UILabel *)levelLabel {
    if (!_levelLabel) {
        UILabel *obj = [UILabel new];
        [self.view addSubview:_levelLabel = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeL(self.tipBoardView);
            kMakeR(self.tipBoardView);
            kMakeT(self.tipBoardView.mas_bottom).offset(5);
        }];
        obj.font = [UIFont systemFontOfSize:15];
        obj.textColor = [UIColor blackColor];
    }
    return _levelLabel;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        UILabel *obj = [UILabel new];
        [self.view addSubview:_scoreLabel = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeL(self.tipBoardView);
            kMakeR(self.tipBoardView);
            kMakeT(self.levelLabel.mas_bottom).offset(5);
        }];
        obj.font = [UIFont systemFontOfSize:15];
        obj.textColor = [UIColor blackColor];
    }
    return _scoreLabel;
}

- (UILabel *)lineCountLabel {
    if (!_lineCountLabel) {
        UILabel *obj = [UILabel new];
        [self.view addSubview:_lineCountLabel = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeL(self.tipBoardView);
            kMakeR(self.tipBoardView);
            kMakeT(self.scoreLabel.mas_bottom).offset(5);
        }];
        obj.font = [UIFont systemFontOfSize:15];
        obj.textColor = [UIColor blackColor];
    }
    return _lineCountLabel;
}

#pragma mark - 游戏中

/// 将落下的方块固定
- (void)convertGroupSquareToBlack {
    
    // 取消下落计时
    [self destroyTimer:self.dropDownTimer];
    
    // 固定已下落的组合
    for (int i = 0; i < self.group.subviews.count; i++) {
        BasicSquare *square = self.group.subviews[i];
        
        if (square.selected) {
            // 将square的坐标转换到背景中
            CGRect rect2 = [self.squareRoomView convertRect:square.frame fromView:self.group];
            
            if (rect2.origin.y >= 0) {
                
                int X = rect2.origin.x / kSquareWH;
                int Y = rect2.origin.y / kSquareWH;
                
                int indexOfBehindSquare = Y * kColumnCount + X;
                
                BasicSquare *behindSquare = self.squareRoomView.subviews[indexOfBehindSquare];
                
                behindSquare.color = self.group.color;
                behindSquare.selected = YES;
            }
            
        }
    }
}

/// 消行 改进：行数为0时返回、group延时回到起点
- (void)clearFullLines {
    
    NSArray *linesShouldClear = [self LineArrayWaitForClear];
    
    // 消行动画
    for (int i = 0; i < linesShouldClear.count; i++) {
        for (NSNumber *index in linesShouldClear[i]) {
            BasicSquare *square = self.squareRoomView.subviews[[index intValue]];
            
            [self dispatchAfter:0.05 operation:^{
                square.selected = NO;
            [self dispatchAfter:0.1 operation:^{
                square.selected = YES;
            [self dispatchAfter:0.1 operation:^{
                square.selected = NO;
            [self dispatchAfter:0.1 operation:^{
                square.selected = YES;
            [self dispatchAfter:0.1 operation:^{
                square.selected = NO;
            }]; }]; }]; }]; }];
            
        }
    }
    
    // 消行
    CGFloat duration = SIMULATOR ? 0.8 : 0.55;
    [self dispatchAfter:duration operation:^{
        for (int i = 0; i < linesShouldClear.count; i++) {
            
            NSArray *squareLine = linesShouldClear[i];
            int lastSquareIndex = [squareLine.lastObject intValue];
            
            for (int j = lastSquareIndex; j > 0; j--) {
                
                BasicSquare *lastLineSquare = self.squareRoomView.subviews[j];
                
                if (j >= kColumnCount) {
                    BasicSquare *aboveSquare = self.squareRoomView.subviews[j - kColumnCount];
                    lastLineSquare.selected = aboveSquare.selected;
                    
                }else {
                    lastLineSquare.selected = NO;
                }
            }
        }
    }];
    
    // 消行计分、提高速度级别
    [self calcScoreAndSpeedLevel:(int)linesShouldClear.count];
    // 消除动画完成后，判断游戏结束，group回到起始位置
    if (![self isOver]) {
        [self.group backToStartPoint:_startPoint];
        [self setupDropDownTimer];
        
    }else {
        [self gameOverOperaton];
    }
}

/// 找出需要消除的行
- (NSArray *)LineArrayWaitForClear {
    
    // 找出刚落下的组合对应的都是第几行
    NSMutableArray *lineMaybeFull_Arr = [NSMutableArray arrayWithCapacity:4];
    
    for (int i = 0; i < self.group.subviews.count; i++) {
        BasicSquare *square = self.group.subviews[i];
        
        if (square.selected) {
            
            CGRect rect2 = [self.squareRoomView convertRect:square.frame fromView:self.group];
            
            int Y = rect2.origin.y / kSquareWH;
            // 增加 Y>=0 的判断，防止当新组合没有完全进入视野时变黑时引发数组越界
            if (Y >=0 && ![lineMaybeFull_Arr containsObject:@(Y)]) {
                [lineMaybeFull_Arr addObject:@(Y)];
            }
            
        }
    }
    
    // 拿到这些行里面所有按钮的索引
    NSMutableArray *indexArrays = [NSMutableArray arrayWithCapacity:4];
    
    for (int i = 0; i < lineMaybeFull_Arr.count; i++) {
        
        int Y = [lineMaybeFull_Arr[i] intValue];
        
        NSMutableArray *indexArrayForALine = [NSMutableArray arrayWithCapacity:kColumnCount];
        for (int j = 0; j < kColumnCount; j++) {
            int index = Y * kColumnCount + j;
            [indexArrayForALine addObject:@(index)];
        }
        [indexArrays addObject:indexArrayForALine];
        
    }
    
    // 判断其中某一行是否不满
    NSMutableArray *notFullLines = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < indexArrays.count; i++) {
        NSArray *indexArr = indexArrays[i];
        int notFullFlag = 0;
        for (int j = 0; j < indexArr.count; j++) {
            int squareIndex = [indexArr[j] intValue];
            BasicSquare *square = self.squareRoomView.subviews[squareIndex];
            if (!square.selected) {
                notFullFlag = 1;
            }
        }
        if (notFullFlag) {
            [notFullLines addObject:indexArr];
        }
    }
    
    // 只保留满行的数组
    [indexArrays removeObjectsInArray:notFullLines];
    
    return indexArrays;
}

/// 根据消除的行数计分、提高速度级别 bug
- (void)calcScoreAndSpeedLevel:(int)clearedCount {
    
    self.clearedLines += clearedCount;
    _levelUpCounter += clearedCount;
    
    if (clearedCount) {
        self.score += clearedCount == 1 ? 100 : (clearedCount == 2 ? 300 : (clearedCount == 3 ? 600 : 1000));
    }
    
    if (self.speedLevel < 6 && _levelUpCounter >= 20) {
        self.speedLevel += 1;
        _levelUpCounter -= 20;
    }
    
}

/// 游戏结束后的操作
- (void)gameOverOperaton {
    NSLog(@"---- Game Over ----");
    
    self.group.hidden = YES;

    // 清空当前得分行数
    self.clearedLines = 0;
    self.score = 0;
    // 销毁计时器
    [self destroyTimer:self.dropDownTimer];
    // 刷新动画 1.6s
    [self commitRefreshAnimation];
    // 动画执行一半
    CGFloat duration = SIMULATOR ? 1.2 : 0.8;
    [self dispatchAfter:duration operation:^{
        self.isSettingMode = YES;
    }];
    
}

/// 刷新动画
- (void)commitRefreshAnimation {
    
    // 禁止按钮操作
    _disableButtonActions = YES;
    _disablePauseButton = YES;
    // 暂停时取消暂停
    self.pauseButton.selected = NO;
    
    __weak typeof(self) weakSelf = self;
    __block int startIndex = kColumnCount * kRowCount - 1;
    
    // 变白
    __block void(^refreshWhite)() = ^{
        
        int i = startIndex;
        
        if (i > kColumnCount * kRowCount - 1) {
            [weakSelf destroyTimer:weakSelf.refreshTimer];
            // 改进：代码执行完了，但是屏幕刷新延迟了，所以这个操作需要延时 ?
            CGFloat duration = SIMULATOR ? 0.5 : 0.2;
            [weakSelf dispatchAfter:duration operation:^{
                _disableButtonActions = NO; ///
                _disablePauseButton = NO;
            }];
            return;
        }
        for (; i < startIndex + kColumnCount; i++) {
            BasicSquare *square = weakSelf.squareRoomView.subviews[i];
            square.selected = NO;
        }
        startIndex = i;
        
    };
    
    // 变黑
    __block void(^refresh)() = ^{
        
        int i = startIndex;
        
        if (i < 0) {
            startIndex = 0;
            refresh = refreshWhite;
        }else {
            for (; i > startIndex - kColumnCount; i--) {
                BasicSquare *square = weakSelf.squareRoomView.subviews[i];
                square.color = self.squareRoomView.backgroundColor;
                square.selected = YES;
            }
            startIndex = i;
        }
        
    };
    
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 repeats:YES block:^(NSTimer * _Nonnull timer) {
        refresh();
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.refreshTimer forMode:NSRunLoopCommonModes];
    
}

#pragma mark - 定时器

- (void)destroyTimer:(NSTimer *)timer {
    [timer invalidate];
    timer = nil;
}

/// 下落计时
- (void)setupDropDownTimer {
    CGFloat duartion = 1.0 * pow(0.75, (self.speedLevel - 1));
    self.dropDownTimer = [NSTimer scheduledTimerWithTimeInterval:duartion target:self selector:@selector(down:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.dropDownTimer forMode:NSRunLoopCommonModes];
}

#pragma mark - 判断

/// 是否处于非游戏状态：暂停 刷新
- (BOOL)isPauseState {
    // 暂停时取消暂停
    if (self.pauseButton.selected) {
        _disableButtonActions = NO;
        [self setupDropDownTimer];
        self.pauseButton.selected = NO;
        return YES;
        // 刷新动画时按钮无效
    }else if (_disableButtonActions) {
        return YES;
    }else {
        return NO;
    }
}

/// 是否结束游戏
- (BOOL)isOver {
    for (int i = 0; i < kColumnCount; i++) {
        BasicSquare *square = self.squareRoomView.subviews[i];
        if (square.selected) {
            return YES;
        }
    }
    return NO;
}

/// 是否可以旋转
- (BOOL)canRotate:(NSArray *)nextGroup {
    
    for (int i = 0; i < nextGroup.count; i++) {
        BasicSquare *square = self.group.subviews[[nextGroup[i] intValue]];
        CGRect squareRect = [self.squareRoomView convertRect:square.frame fromView:self.group];
        
        int X = squareRect.origin.x / kSquareWH;
        int Y = squareRect.origin.y / kSquareWH;
        
        if (X < 0) {
            _edgeRotateOffset = -X * kSquareWH;
        }else if (X >= kColumnCount) {
            _edgeRotateOffset = (kColumnCount - X - 1) * kSquareWH;
        }
        
        // XY判断
        if (Y >= kRowCount) {
            return NO;
        }
        
        // 重合判断
        if (Y >= 0) {
            int indexOfBehindSquare = Y * kColumnCount + X;
            BasicSquare *behindSquare = self.squareRoomView.subviews[indexOfBehindSquare];
            if (behindSquare.selected) {
                return NO;
            }
        }
    }
    
    return YES;
}

/// 是否可以下移
- (BOOL)canMoveDown {
    
    for (int i = 0; i < self.group.subviews.count; i++) {
        BasicSquare *square = self.group.subviews[i];
        if (square.selected) {
            
            // 将square的坐标转换到背景中
            CGRect rect2 = [self.squareRoomView convertRect:square.frame fromView:self.group];
            
            // 只考虑显示在room范围内的，防止崩溃
            if (rect2.origin.y >= 0) {
                int X = rect2.origin.x / kSquareWH;
                int Y = rect2.origin.y / kSquareWH;
                
                if (Y == kRowCount - 1) return NO;
                
                int indexOfBelowSquare = (Y + 1) * kColumnCount + X;
                
                BasicSquare *belowSquare = self.squareRoomView.subviews[indexOfBelowSquare];
                
                if (belowSquare.isSelected) {
                    return NO;
                }
            }
        }
    }
    
    return YES;
}

/// 是否可以左移
- (BOOL)canMoveLeft {
    
    for (int i = 0; i < self.group.subviews.count; i++) {
        BasicSquare *square = self.group.subviews[i];
        if (square.selected) {
            // 将square的坐标转换到背景中
            CGRect rect2 = [self.squareRoomView convertRect:square.frame fromView:self.group];
            int X = rect2.origin.x / kSquareWH;
            int Y = rect2.origin.y / kSquareWH;
            
            if (X == 0) return NO;
            
            if (Y >= 0) {
                int indexOfLeftSquare = Y * kColumnCount + X - 1;
                
                BasicSquare *leftSquare = self.squareRoomView.subviews[indexOfLeftSquare];
                
                if (leftSquare.isSelected) {
                    return NO;
                }
                
            }
            
        }
    }
    
    return YES;
}

/// 是否可以右移
- (BOOL)canMoveRight {
    
    for (int i = 0; i < self.group.subviews.count; i++) {
        BasicSquare *square = self.group.subviews[i];
        if (square.selected) {
            // 将square的坐标转换到背景中
            CGRect rect2 = [self.squareRoomView convertRect:square.frame fromView:self.group];
            
            int X = rect2.origin.x / kSquareWH;
            int Y = rect2.origin.y / kSquareWH;
            
            if (X == kColumnCount - 1) return NO;
            
            if (Y >= 0) {
                int indexOfRightSquare = Y * kColumnCount + X + 1;
                
                BasicSquare *rightSquare = self.squareRoomView.subviews[indexOfRightSquare];
                
                if (rightSquare.isSelected) {
                    return NO;
                }
                
            }
            
            
        }
    }
    
    return YES;
}

#pragma mark - EVENT
- (void)left:(UIButton *)sender {
    if ([self isPauseState]) return;
    
    // 设置模式调整速度级别
    if (self.isSettingMode) {
        self.speedLevel = self.speedLevel < 2 ? 6 : self.speedLevel - 1;
        return;
    }
    // 向左移动
    if ([self canMoveLeft]) {
        self.group.fsj_left -= kSquareWH;
    }
    
}

- (void)right:(id)sender {
    if ([self isPauseState]) return;
    
    if (self.isSettingMode) {
        self.speedLevel = self.speedLevel > 5 ? 1 : self.speedLevel + 1;
        return;
    }
    
    if ([self canMoveRight]) {
        self.group.fsj_left += kSquareWH;
    }
    
}

- (void)down:(id)sender {
    if ([self isPauseState]) return;
    
    if (self.isSettingMode) {
        self.startupLines = self.startupLines < 1 ? 10 : self.startupLines - 1;
        return;
    }
    
    if ([self canMoveDown]) {
        self.group.fsj_top += kSquareWH;
        
        if (sender != nil) {
            [self destroyTimer:self.dropDownTimer];
            [self setupDropDownTimer];
        }
        
    }else {
        [self convertGroupSquareToBlack];
        // 下落得分
//        self.score += 18;
        // 消行
        [self clearFullLines];
    }
    
}

- (void)thunderDown:(UIButton *)sender {
    if ([self isPauseState]) return;
    
    if (self.isSettingMode) {
        self.startupLines = (self.startupLines + 1) % 11;
        return;
    }
    
    while ([self canMoveDown]) {
        [self down:nil];
    }
    [self down:nil];
    
    // 窗口动画
    [UIView animateWithDuration:0.06 animations:^{
        self.roomBgView.fsj_top += 6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.05 animations:^{
            self.roomBgView.fsj_top -= 6;
        }];
    }];
}

- (void)rotate:(id)sender {
    if ([self isPauseState]) return;
    
    if (self.isSettingMode) {
        [self startPlay];
        return;
    }
    
    // 如果旋转后重合则不允许旋转
    [self.group rotate:^BOOL(NSArray *nextGroup) {
        return [self canRotate:nextGroup];
    }];
    
    // 如果旋转后超出范围，旋转并调整origin
    if (_edgeRotateOffset != 0) {
        self.group.fsj_left += _edgeRotateOffset;
        _edgeRotateOffset = 0;
    }
}

/// 按住按钮持续移动的计时
- (void)setupKeepMoveTimer:(UILongPressGestureRecognizer *)longGes {
    if (self.isSettingMode) return;
    
    SEL controlAction = NULL;
    CGFloat duration = 0;
    
    switch (longGes.view.tag) {
        case 11: // left
            controlAction = @selector(left:);
            duration = 0.1;
            break;
        case 22: // down
            controlAction = @selector(down:);
            duration = 0.03;
            break;
        case 33: // right
            controlAction = @selector(right:);
            duration = 0.1;
            break;
    }
    
    if (self.keepMoveTimer == nil) {
        self.keepMoveTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:controlAction userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.keepMoveTimer forMode:NSRunLoopCommonModes];
    }
    
    if (longGes.state == UIGestureRecognizerStateEnded || longGes.state == UIGestureRecognizerStateFailed || longGes.state == UIGestureRecognizerStateCancelled) {
        
        [self.keepMoveTimer invalidate];
        self.keepMoveTimer = nil;
        
    }
}

#pragma mark - 设置
/// 音效
- (void)configVoice:(UIButton *)sender {
    if (_disableButtonActions) return;
    sender.selected = !sender.selected;
}

/// 暂停
- (void)pause:(UIButton *)sender {
    if (_disablePauseButton) return;
    
    if (self.isSettingMode) {
        [self startPlay];
        return;
    }
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _disableButtonActions = YES;
        [self destroyTimer:self.dropDownTimer];
    }else {
        _disableButtonActions = NO;
        [self setupDropDownTimer];
    }
}

/// 点击其他按钮开始游戏
- (void)startPlay {
    if (!_hadBegan) {
        _hadBegan = YES;
    }
    self.isSettingMode = NO;
    self.group.hidden = NO;
    [self.group backToStartPoint:_startPoint];
    [self setupDropDownTimer];
    [self configRandomLines];
}

/// 设置起始行
- (void)configRandomLines {
    if (self.startupLines == 0) return;
    for (int i = kColumnCount * kRowCount - 1; i > kColumnCount * (kRowCount - self.startupLines); i--) {
        BasicSquare *square = self.squareRoomView.subviews[i];
        square.selected = arc4random_uniform(2);
    }
}

#pragma mark - Assistant
- (void)dispatchAfter:(CGFloat)time operation:(void(^)())operation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), operation);
}

@end
