#import <HealthKit/HealthKit.h>
#import <Cephei/HBPreferences.h>


@interface SBReachabilityBackgroundViewController : UIViewController
@end

@interface SBReachabilityManager : NSObject
+ (id)sharedInstance;
@property (nonatomic,readonly) BOOL reachabilityModeActive;    //@synthesize reachabilityModeActive=_reachabilityModeActive - In the implementation block
@property (assign,nonatomic) BOOL reachabilityEnabled;
@property (nonatomic,readonly) double effectiveReachabilityYOffset;    //@synthesize effectiveReachabilityYOffset=_effectiveReachabilityYOffset - In the implementation block
@end

@interface SBReachabilityWindow : UIWindow

@end

NSString *fontName;
// @interface UIDevice : NSObject
// @property(nonatomic, readonly, strong) NSString *name;
// @end
UIView *RIView;
int H;
BOOL kEnabled;
NSString *kTemplate;
BOOL kChevron;

NSString *deviceName;
NSString *deviceBatteryInHash = @"";

#define clockFacePath @"/Library/Application Support/ReachInfo.bundle/ClockFace.png"
#define clockSecPath @"/Library/Application Support/ReachInfo.bundle/ClockSec.png"
#define clockMinPath @"/Library/Application Support/ReachInfo.bundle/ClockMin.png"
#define clockHourPath @"/Library/Application Support/ReachInfo.bundle/ClockHour.png"
#define firstAstronautPath @"/Library/Application Support/ReachInfo.bundle/firstAstronaut.png"
#define secondAstronautPath @"/Library/Application Support/ReachInfo.bundle/secondAstronaut.png"
#define fontPath @"/Library/Application Support/ReachInfo.bundle/Roboto.ttf"


