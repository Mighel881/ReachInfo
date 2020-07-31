#import "Tweak.h"
#import "widgets.h"

%group reachinfo
%hook SBReachabilityBackgroundView

// https://github.com/KritantaDev/ReachIt/blob/3825b0cd021d464e7ac9fd31f245a6c11909ea3f/Tweak/Tweak.xm#L15
- (void)_setupChevron {
    if (kChevron) {

    } else {
        %orig;
    }
}

%end

%hook SBReachabilityWindow


- (void)layoutSubviews {
    // layoutSubviews. i know. not a good method to hook. but its was also my only option, trust me its not that bad (in this case, since it wont get called as much) & i've done a lot of things to better the performance.

    %orig;
    [RIView removeFromSuperview]; // as @Muirey03 said
    RIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    CGFloat height = [[%c(SBReachabilityManager) sharedInstance] effectiveReachabilityYOffset];
    RIView.frame = CGRectMake(self.frame.origin.x, -height + H, self.frame.size.width, height);
    [self addSubview:RIView];
    [self bringSubviewToFront:RIView];

#pragma mark - Bash-Like
    if ([kTemplate isEqual:@"bash"]) {
        [bashLike show];
    }

#pragma mark - Clock
    if ([kTemplate isEqual:@"clock"]) {
        [Clock show];
    }
#pragma mark - The Two Astronauts
    if ([kTemplate isEqual:@"astronauts"]) {
        [Astro show];
    }
}
- (void) viewDidDisappear:(BOOL)animated {
    if ([kTemplate isEqual:@"clock"]) {
        %orig;
        [clockView stop];
    } else {
        %orig;
    }
}

%end
%end
#pragma mark - ctor
static void prefsChanged() {
    HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.1di4r.reachinfoprefs"];

    kEnabled = [([prefs objectForKey:@"kEnabled"] ? : @(YES)) boolValue];
    kTemplate = [([prefs objectForKey:@"Template"] ? : @"bash") stringValue];
    kChevron = [([prefs objectForKey:@"kChevron"] ? : @(YES)) boolValue];
    H = [([prefs objectForKey:@"kHeight"] ? : @(0)) intValue];

}
%ctor {
    prefsChanged();
    if (kEnabled) {
        [UIDevice currentDevice].batteryMonitoringEnabled = YES;
        %init(reachinfo);
    }
}