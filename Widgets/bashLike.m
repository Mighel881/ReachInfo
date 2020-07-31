//
//  ViewController+Mathn.m
//  ReachInfo
//
//  Created by 1di4r on 7/31/20.
//  Copyright © 2020 1di4r. All rights reserved.
//

#import "bashLike.h"

@implementation bashLike

+(void)show{

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
        NSString *deviceBatteryInHash = [NSString stringWithFormat:@"%@%@", Hashs, Dots];
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

@end
