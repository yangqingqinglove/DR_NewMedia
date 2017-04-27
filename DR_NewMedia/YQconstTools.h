#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat onceXXXINT;

//dock的高度
UIKIT_EXTERN const CGFloat YQDockButtonH ;
UIKIT_EXTERN const CGFloat YQDockWidth ;

UIKIT_EXTERN const CGFloat YQswitchViewHeight ;

//通知
//官方的标准
//按钮被点击的通知
UIKIT_EXTERN NSString *const YQButtonDidSelectNotification;

//通过这个key可以去除被选中按钮的索引
UIKIT_EXTERN NSString *const YQSelectButtonIndexKey;

//switchViewButton
UIKIT_EXTERN NSString *const YQswitchViewSelectNotification;

//switchViewkey
UIKIT_EXTERN NSString *const YQswitchViewButtonIndexKey;

//屏幕的旋转的通知的内容
UIKIT_EXTERN NSString *const YQsentScreenTransition;

//屏幕旋转要求的传入的dock的值
UIKIT_EXTERN NSString *const YQswitchScreenTransitionKey;

//case的数据的包的传递的参数
UIKIT_EXTERN NSString *const YQcaseKey;

//case的model的数据包的key
UIKIT_EXTERN NSString *const YQcaseModelKey;

//脑电WaveView的通知包
UIKIT_EXTERN NSString *const YQwaveSetDataNotification;
UIKIT_EXTERN NSString *const YQsendConnectDevice;
UIKIT_EXTERN NSString *const YQcurrentDeviceKey;

////通知子控制的刷新
UIKIT_EXTERN NSString *const YQNotificationToChildVC ;

//全局的通道range
UIKIT_EXTERN NSString *const YQPassagewayCount;
UIKIT_EXTERN NSString *const YQPassagewayHead;

//全局的物理的尺寸和像素的尺寸
UIKIT_EXTERN const double CrossScreen;
UIKIT_EXTERN const double VerticalScreen;
UIKIT_EXTERN const double Speed;
UIKIT_EXTERN const double RealWith;
UIKIT_EXTERN const double OnceMillimeter;
UIKIT_EXTERN const double TimerSpeed;

/**
 *  switchFunction send EEG setting 全局通知的变量属性
 */
UIKIT_EXTERN NSString *const YQSendEEGXSpeed;
UIKIT_EXTERN NSString *const YQSendEEGXSpeedKey;
UIKIT_EXTERN NSString *const YQSendDrawRulerSpeed;
UIKIT_EXTERN NSString *const YQSendDrawRulerSpeedKey;

/**
 *  发送通知到rulerView的字符串
 */
UIKIT_EXTERN NSString *const YQSecondDrawRuler;
UIKIT_EXTERN NSString *const YQSecondDrawRulerKey;
UIKIT_EXTERN NSString *const YQSecondDrawRulerKey2;

/**
 *  Yscale的显示的字符串
 */
UIKIT_EXTERN NSString *const YQYscale;
UIKIT_EXTERN NSString *const YQYscaleKey;



