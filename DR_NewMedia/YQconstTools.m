#import <UIKit/UIKit.h>
CGFloat onceXXXINT = 0;

//dock
const CGFloat YQDockButtonH = 100;
const CGFloat YQDockWidth = 240;

//switchView 的高度
const CGFloat YQswitchViewHeight = 80;

//通知
NSString *const YQButtonDidSelectNotification = @"YQButtonDidSelectNotification";

//通过这个key可以去除被选中按钮的索引
NSString *const YQSelectButtonIndexKey = @"YQSelectButtonIndexKey";

//switchView button的通知内容
NSString *const YQswitchViewSelectNotification = @"YQswitchViewSelectNotification";

//switchView button的点击的所应用的索引
NSString *const YQswitchViewButtonIndexKey = @"YQswitchViewButtonIndexKey";

//屏幕的旋转的通知的内容
NSString *const YQsentScreenTransition = @"YQsentScreenTransition";
//屏幕旋转的switchsuper的宽度
NSString *const  YQswitchScreenTransitionKey= @"YQswitchScreenTransitionKey";

//case 病例的数据的包
NSString *const YQcaseKey = @"YQcaseKey";

//case 病例的模型数据的key
NSString *const YQcaseModelKey = @"YQcaseModelKey";

//脑电WaveView的通知包
NSString *const YQwaveSetDataNotification = @"YQwaveSetDataNotification";
NSString *const YQsendConnectDevice = @"YQsendConnectDevice";
NSString *const YQcurrentDeviceKey = @"YQcurrentDeviceKey";

//通知子控制的刷新
NSString *const YQNotificationToChildVC = @"YQNotificationToChildVC";

//设置全局的一个通道的宏
//定义的kvo的属性的监听的字段
NSString *const YQPassagewayCount = @"passagewayCount";
NSString *const YQPassagewayHead  = @"passagewayHead";


//设置定义的x轴反向上的物理尺寸和像素尺寸的全局的宏
const double CrossScreen = (262.128 / 1366);

const double VerticalScreen = (196.596 / 1024);

const double Speed = 40;

const double RealWith = (Speed / CrossScreen);

const double OnceMillimeter = ( 1 / CrossScreen);
//定时器的刷新的频率
const double TimerSpeed  = 0.04;

/**
 *  switchFunction send EEG setting 全局通知的变量属性
 */
NSString *const YQSendEEGXSpeed = @"YQSendEEGXSpeed";
NSString *const YQSendEEGXSpeedKey = @"YQSendEEGXSpeedKey";
NSString *const YQSendDrawRulerSpeed = @"YQSendDrawRulerSpeed";
NSString *const YQSendDrawRulerSpeedKey = @"YQSendDrawRulerSpeedKey";

/**
 *  发送通知到rulerView的字符串
 */
NSString *const YQSecondDrawRuler = @"YQSecondDrawRuler";
NSString *const YQSecondDrawRulerKey = @"YQSecondDrawRulerKey";
NSString *const YQSecondDrawRulerKey2 = @"YQSecondDrawRulerKey2";

/**
 *  Yscale的显示的字符串
 */
NSString *const YQYscale = @"YQYscale";
NSString *const YQYscaleKey = @"YQYscaleKey";


