#import "Tweak.h"
#import "ClockView.m"
#include <CoreText/CTFontManager.h>

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
    // talked to some other devs, hooking layoutSubviews here is fine since it wont get called too often.

    %orig;
    RIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    CGFloat height = [[%c(SBReachabilityManager) sharedInstance] effectiveReachabilityYOffset];
    RIView.frame = CGRectMake(self.frame.origin.x, -height + H, self.frame.size.width, height);
    [self addSubview:RIView];
    [self bringSubviewToFront:RIView];

    #pragma mark - Bash-Like
    if ([kTemplate isEqual:@"bash"]) {

        UILabel *cmdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
        cmdLabel.backgroundColor = [UIColor clearColor];
        cmdLabel.textColor = [UIColor whiteColor];
        cmdLabel.font = [UIFont fontWithName:@"Menlo" size:14];
        deviceName = [[UIDevice currentDevice] name];
        cmdLabel.text = [NSString stringWithFormat:@"%@@host:~$ now", deviceName];
        cmdLabel.adjustsFontSizeToFitWidth = true;
        cmdLabel.center = CGPointMake(RIView.center.x + 20, 64);
        cmdLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
        cmdLabel.layer.shadowRadius = 1.0;
        cmdLabel.layer.shadowOpacity = 1.0;
        cmdLabel.layer.shadowOffset = CGSizeMake(0, 0);
        cmdLabel.layer.masksToBounds = false;
        int dF = cmdLabel.font.pointSize;

        NSDate *time = [NSDate date];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm"];
        NSString *timeString = [timeFormatter stringFromDate:time];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = [NSString stringWithFormat:@"[TIME] %@  ", timeString];
        timeLabel.font = [UIFont fontWithName:@"Menlo" size:dF];
        timeLabel.adjustsFontSizeToFitWidth = true;
        timeLabel.center = CGPointMake(RIView.center.x + 20, 84);
        NSMutableAttributedString *clTime = [[NSMutableAttributedString alloc] initWithString:timeLabel.text];
        [clTime addAttribute:NSForegroundColorAttributeName
                       value:[UIColor greenColor]
                       range:NSMakeRange(6, timeLabel.text.length - 6)];

        NSShadow *timeShadow = [[NSShadow alloc] init];
        timeShadow.shadowColor = [UIColor greenColor];
        timeShadow.shadowOffset = CGSizeMake(0, 0);
        timeShadow.shadowBlurRadius = 0.7;
        [clTime addAttribute:NSShadowAttributeName
                       value:timeShadow
                       range:NSMakeRange(6, timeLabel.text.length - 6)];


        timeLabel.attributedText = clTime;
        timeLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
        timeLabel.layer.shadowRadius = 0.5;
        timeLabel.layer.shadowOpacity = 0.6;
        timeLabel.layer.shadowOffset = CGSizeMake(0, 0);
        timeLabel.layer.masksToBounds = false;

        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"E, MMMM d"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.text = [NSString stringWithFormat:@"[DATE] %@", dateString];
        dateLabel.font = [UIFont fontWithName:@"Menlo" size:dF];
        dateLabel.adjustsFontSizeToFitWidth = true;
        dateLabel.center = CGPointMake(RIView.center.x + 20, 104);
        NSMutableAttributedString *clDate = [[NSMutableAttributedString alloc] initWithString:dateLabel.text];
        [clDate addAttribute:NSForegroundColorAttributeName
                       value:[UIColor purpleColor]
                       range:NSMakeRange(6, dateLabel.text.length - 6)];

        NSShadow *dateShadow = [[NSShadow alloc] init];
        dateShadow.shadowColor = [UIColor purpleColor];
        dateShadow.shadowOffset = CGSizeMake(0, 0);
        dateShadow.shadowBlurRadius = 0.7;
        [clDate addAttribute:NSShadowAttributeName
                       value:dateShadow
                       range:NSMakeRange(6, dateLabel.text.length - 6)];

        dateLabel.attributedText = clDate;
        dateLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
        dateLabel.layer.shadowRadius = 0.5;
        dateLabel.layer.shadowOpacity = 0.6;
        dateLabel.layer.shadowOffset = CGSizeMake(0, 0);
        dateLabel.layer.masksToBounds = false;


        int currentBattery = [[UIDevice currentDevice] batteryLevel] *100;
        int hashCount = currentBattery / 10;
        int dotCount = 10 - hashCount;
        NSMutableString *Hashs = [NSMutableString stringWithCapacity:11];
        NSMutableString *Dots = [NSMutableString stringWithCapacity:11];

        for (int a = 0; a < hashCount; a++) {
            [Hashs appendFormat:@"#"];
        }
        for (int b = 0; b < dotCount; b++) {
            [Dots appendFormat:@"."];
        }
        deviceBatteryInHash = [NSString stringWithFormat:@"%@%@", Hashs, Dots];
        UILabel *battLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
        battLabel.backgroundColor = [UIColor clearColor];
        battLabel.text = [NSString stringWithFormat:@"[BATT] [%@] %d%%", deviceBatteryInHash, currentBattery];
        battLabel.textColor = [UIColor whiteColor];
        battLabel.font = [UIFont fontWithName:@"Menlo" size:dF];
        battLabel.adjustsFontSizeToFitWidth = true;
        battLabel.center = CGPointMake(RIView.center.x + 20, 124);
        NSMutableAttributedString *clBatt = [[NSMutableAttributedString alloc] initWithString:battLabel.text];
        [clBatt addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]
                       range:NSMakeRange(6, battLabel.text.length - 6)];

        NSShadow *battShadow = [[NSShadow alloc] init];
        [dateShadow setShadowColor:[UIColor redColor]];
        [dateShadow setShadowOffset:CGSizeMake(0, 0)];
        [dateShadow setShadowBlurRadius:0.7];
        [clBatt addAttribute:NSShadowAttributeName
                       value:battShadow
                       range:NSMakeRange(6, battLabel.text.length - 6)];


        battLabel.attributedText = clBatt;
        battLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
        battLabel.layer.shadowRadius = 0.5;
        battLabel.layer.shadowOpacity = 0.6;
        battLabel.layer.shadowOffset = CGSizeMake(0, 0);
        battLabel.layer.masksToBounds = false;

        UILabel *returnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
        returnLabel.backgroundColor = [UIColor clearColor];
        returnLabel.textColor = [UIColor whiteColor];
        returnLabel.font = [UIFont fontWithName:@"Menlo" size:14];
        deviceName = [[UIDevice currentDevice] name];
        returnLabel.text = [NSString stringWithFormat:@"%@@host:~$", deviceName];
        returnLabel.adjustsFontSizeToFitWidth = true;
        returnLabel.center = CGPointMake(RIView.center.x + 20, 144);
        returnLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
        returnLabel.layer.shadowRadius = 1.0;
        returnLabel.layer.shadowOpacity = 1.0;
        returnLabel.layer.shadowOffset = CGSizeMake(0, 0);
        returnLabel.layer.masksToBounds = false;

        [RIView addSubview:cmdLabel];
        [RIView addSubview:timeLabel];
        [RIView addSubview:dateLabel];
        [RIView addSubview:battLabel];
        [RIView addSubview:returnLabel];
    }

    #pragma mark - Clock
    if ([kTemplate isEqual:@"clock"]) {

        clockView = [[ClockView alloc] initWithFrame:CGRectMake(0, 0, 162, 162)];
        [clockView setClockBackgroundImage:[UIImage imageNamed:clockFacePath].CGImage];
        [clockView setSecHandImage:[UIImage imageNamed:clockSecPath].CGImage];
        [clockView setHourHandImage:[UIImage imageNamed:clockHourPath].CGImage];
        [clockView setMinHandImage:[UIImage imageNamed:clockMinPath].CGImage];

        // [clockView setSecHandContinuos:YES]; // Move the second's hand continously, Off by default
        clockView.center = CGPointMake(RIView.center.x, 110);
        [RIView addSubview:clockView];
        [clockView start];

    }
    #pragma mark - The Two Astronauts
    if ([kTemplate isEqual:@"astronauts"]) {

        if ([[NSFileManager defaultManager] fileExistsAtPath:fontPath]) {
            NSData *fontData = [NSData dataWithContentsOfFile:fontPath];
            NSLog(@"Font path: %@", fontPath);
            CFErrorRef error;
            CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
            CGFontRef font = CGFontCreateWithDataProvider(provider);
            if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
                CFStringRef errorDescription = CFErrorCopyDescription(error);
                NSLog(@"Failed to load font: %@", errorDescription);
                CFRelease(errorDescription);
            }
            fontName = (NSString *)CFBridgingRelease(CGFontCopyPostScriptName(font));

            CFRelease(font);
            CFRelease(provider);
        }

        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm"];
        NSString *timeString = [dateFormatter stringFromDate:date];
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 192, 62)];
        dateLabel.textColor = [UIColor colorWithRed:203.0 / 255.0 green:205.0 / 255.0 blue:212.0 / 255.0 alpha:1];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.text = [NSString stringWithFormat:@"%@?", timeString];
        dateLabel.font = [UIFont fontWithName:fontName size:54];
        // [dateLabel setFont:[UIFont fontWithName:fontPath size:54]];
        // dateLabel.adjustsFontSizeToFitWidth = true;

        NSMutableAttributedString *fzDATE = [[NSMutableAttributedString alloc] initWithString:dateLabel.text];
        [fzDATE setAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:17]
                                 , NSBaselineOffsetAttributeName : @30 } range:NSMakeRange(5, dateLabel.text.length - 5)];

        dateLabel.attributedText = fzDATE;
        dateLabel.center = CGPointMake(RIView.center.x, 115);
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.layer.masksToBounds = false;

        UIImageView *firstAstronaut = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 69, 64)];
        firstAstronaut.image = [UIImage imageNamed:firstAstronautPath];
        firstAstronaut.contentMode = UIViewContentModeScaleAspectFit;
        firstAstronaut.center = CGPointMake(RIView.center.x - 52, 55);
        UIImageView *secondAstronaut = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 83, 64)];
        secondAstronaut.image = [UIImage imageNamed:secondAstronautPath];
        secondAstronaut.contentMode = UIViewContentModeScaleAspectFit;
        secondAstronaut.center = CGPointMake(RIView.center.x + 48, 160);

        UILabel *firstAstroLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 18)];
        firstAstroLabel.backgroundColor = [UIColor clearColor];
        firstAstroLabel.textColor = [UIColor colorWithRed:203.0 / 255.0 green:205.0 / 255.0 blue:212.0 / 255.0 alpha:1];
        firstAstroLabel.font = [UIFont fontWithName:fontName size:14];
        firstAstroLabel.text = @"Wait, it's";
        // firstAstroLabel.adjustsFontSizeToFitWidth = true;
        firstAstroLabel.center = CGPointMake(RIView.center.x + 21, 68);
        firstAstroLabel.layer.masksToBounds = false;

        UILabel *secondAstroLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 18)];
        secondAstroLabel.backgroundColor = [UIColor clearColor];
        secondAstroLabel.textColor = [UIColor colorWithRed:203.0 / 255.0 green:205.0 / 255.0 blue:212.0 / 255.0 alpha:1];
        secondAstroLabel.font = [UIFont fontWithName:fontName size:14];
        secondAstroLabel.text = @"Always has been";
        // secondAstroLabel.adjustsFontSizeToFitWidth = true;
        secondAstroLabel.center = CGPointMake(RIView.center.x - 30, 152);
        secondAstroLabel.layer.masksToBounds = false;


        [RIView addSubview:dateLabel];
        [RIView addSubview:firstAstronaut];
        [RIView addSubview:secondAstronaut];
        [RIView addSubview:firstAstroLabel];
        [RIView addSubview:secondAstroLabel];

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