//
//  AppDelegate.m
//  TimeColor
//
//  Created by George Wietor on 12/19/13.
//  Copyright (c) 2013 Issue Press. All rights reserved.
//
// 12:00 yellow .94 .91 .47
// 1:00 orange .88 .71 .45
// 2:00 pink .84 .73 .70
// 3:00 red .74 .37 .34
// 4:00 lilac .73 .34 .45
// 5:00 violet .37 .16 .28
// 6:00 blue .09 .19 .39
// 7:00 green .17 .36 .24
// 8:00 turquoise .29 .6 .67
// 9:00 brown .59 .45 .33
// 10:00 ochre .81 .78 .69
// 11:00 beige .83 .72 .49

#import "AppDelegate.h"
//#import <QuartzCore/QuartzCore.h>

@interface AppDelegate () {
	NSStatusItem *_statusItem;
	NSMenuItem *_dateMenuItem;
    NSMenuItem *_quitMenuItem;
	NSMenuItem *_timezoneMenuItem;
	NSMutableAttributedString *_attributedString;
	
	NSDateFormatter *_timeFormatter;
	NSDateFormatter *_dateFormatter;
    NSDateFormatter *_minuteFormatter;
	NSDateFormatter *_timezoneFormatter;
	
	NSFont *_font;
	NSColor *_color;
    NSColor *_color2;
    NSColor *_currentColor;
    NSColor *_yellow;
    NSColor *_orange;
    NSColor *_pink;
    NSColor *_red;
    NSColor *_lilac;
    NSColor *_violet;
    NSColor *_blue;
    NSColor *_green;
    NSColor *_turquoise;
    NSColor *_brown;
    NSColor *_ochre;
    NSColor *_beige;
    NSString *_face;
    NSString *_dateString;
    NSString *_minuteString;

}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	_statusItem.highlightMode = YES;
	_statusItem.menu = [[NSMenu alloc] init];
	_dateMenuItem = [[NSMenuItem alloc] init];
	_dateMenuItem.enabled = YES;
    _quitMenuItem = [[NSMenuItem alloc] init];
    _quitMenuItem.enabled = YES;
    _quitMenuItem.title = @"Quit";
    _quitMenuItem.action = @selector(terminateApp);
    
	[_statusItem.menu addItem:_dateMenuItem];
    [_statusItem.menu addItem:_quitMenuItem];
	
	_attributedString = [[NSMutableAttributedString alloc] init];
	
	_timeFormatter = [[NSDateFormatter alloc] init];
    _timeFormatter.dateFormat = @"hh";
    _minuteFormatter = [[NSDateFormatter alloc] init];
	_minuteFormatter.dateFormat = @"mm";
	_dateFormatter = [[NSDateFormatter alloc] init];
	_dateFormatter.dateFormat = @"hh:mm a";
    
	_font = [NSFont menuBarFontOfSize:34];
    _face = @"\u25CF";

    _yellow = [NSColor colorWithCalibratedRed:.94 green:.91 blue:.47 alpha:1.0f];
    _orange = [NSColor colorWithCalibratedRed:.88 green:.71 blue:.45 alpha:1.0f];
    _pink = [NSColor colorWithCalibratedRed:.84 green:.73 blue:.70 alpha:1.0f];
    _red = [NSColor colorWithCalibratedRed:.74 green:.37 blue:.34 alpha:1.0f];
    _lilac = [NSColor colorWithCalibratedRed:.73 green:.34 blue:.45 alpha:1.0f];
    _violet = [NSColor colorWithCalibratedRed:.37 green:.16 blue:.28 alpha:1.0f];
    _blue = [NSColor colorWithCalibratedRed:.09 green:.19 blue:.39 alpha:1.0f];
    _green = [NSColor colorWithCalibratedRed:.17 green:.36 blue:.24 alpha:1.0f];
    _turquoise = [NSColor colorWithCalibratedRed:.29 green:.6 blue:.67 alpha:1.0f];
    _brown = [NSColor colorWithCalibratedRed:.59 green:.45 blue:.33 alpha:1.0f];
    _ochre = [NSColor colorWithCalibratedRed:.81 green:.78 blue:.69 alpha:1.0f];
    _beige = [NSColor colorWithCalibratedRed:.83 green:.72 blue:.49 alpha:1.0f];
	
    //set secondary clock
    [self updateClock];
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateClock) userInfo:nil repeats:YES];
}

- (void)updateClock {

    //update secondary clock menu
    NSDate *date = [NSDate date];
	_dateMenuItem.title = [_dateFormatter stringFromDate:date];
    
    //set statusbar face
    [self updateFace];
    
}

- (void)updateFace {
    _dateString = [_timeFormatter stringFromDate:[NSDate date]];
    _minuteString = [_minuteFormatter stringFromDate:[NSDate date]];
    
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:_minuteString];
    NSNumber *progresso = [NSNumber numberWithFloat:([myNumber floatValue]/60)];
    float progress = [progresso floatValue];
    
    NSLog (@"time: %@", progresso);

    
    //set face color based on hour
    if ([_dateString isEqualToString:(@"01")]) {
        _color = _orange;
        _color2 = _pink;
    } else if ([_dateString isEqualToString:(@"02")]) {
        _color = _pink;
        _color2 = _red;
    } else if ([_dateString isEqualToString:(@"03")]) {
        _color = _red;
        _color2 = _lilac;
    } else if ([_dateString isEqualToString:(@"04")]) {
        _color = _lilac;
        _color2 = _violet;
    } else if ([_dateString isEqualToString:(@"05")]) {
        _color = _violet;
        _color2 = _blue;
    } else if ([_dateString isEqualToString:(@"06")]) {
        _color = _blue;
        _color2 = _green;
    } else if ([_dateString isEqualToString:(@"07")]) {
        _color = _green;
        _color2 = _turquoise;
    } else if ([_dateString isEqualToString:(@"08")]) {
        _color = _turquoise;
        _color2 = _brown;
    } else if ([_dateString isEqualToString:(@"09")]) {
        _color = _brown;
        _color2 = _ochre;
    } else if ([_dateString isEqualToString:(@"10")]) {
        _color = _ochre;
        _color2 = _beige;
    } else if ([_dateString isEqualToString:(@"11")]) {
        _color = _beige;
        _color2 = _yellow;
    } else if ([_dateString isEqualToString:(@"12")]) {
        _color = _yellow;
        _color2 = _orange;
    }
    

    NSColor *current_color = [_color2 blendedColorWithFraction:progress ofColor:_color];

    
    //set face attributes
    [_attributedString replaceCharactersInRange:NSMakeRange(0, _attributedString.string.length) withString:_face];
	[_attributedString setAttributes:@{
                                       NSFontAttributeName: _font,
                                       NSForegroundColorAttributeName: current_color,
                                       } range:NSMakeRange(0, _attributedString.string.length)];
	
    //display face
	_statusItem.attributedTitle = _attributedString;
    
    NSLog (@"time: %@", _dateString);
}



- (void)terminateApp {
    exit(0);
}

@end

