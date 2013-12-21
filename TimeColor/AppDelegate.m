//
//  AppDelegate.m
//  TimeColor
//
//  Created by George Wietor on 12/19/13.
//  Copyright (c) 2013 Issue Press. All rights reserved.
//

#import "AppDelegate.h"

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
    NSShadow *shadowDic;

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
    
	_font = [NSFont menuBarFontOfSize:35];
    _face = @"\u25CF";
    
    shadowDic=[[NSShadow alloc] init];
    [shadowDic setShadowBlurRadius:3.0];
    [shadowDic setShadowColor:[NSColor whiteColor]];
    [shadowDic setShadowOffset:CGSizeMake(0, 0)];

    _yellow = [NSColor colorWithCalibratedRed:1 green:.92 blue:.13 alpha:1.0f];
    _orange = [NSColor colorWithCalibratedRed:1 green:.49 blue:.09 alpha:1.0f];
    _pink = [NSColor colorWithCalibratedRed:.99 green:.76 blue:.76 alpha:1.0f];
    _red = [NSColor colorWithCalibratedRed:.84 green:.13 blue:.18 alpha:1.0f];
    _lilac = [NSColor colorWithCalibratedRed:1 green:.41 blue:.81 alpha:1.0f];
    _violet = [NSColor colorWithCalibratedRed:.72 green:.09 blue:.64 alpha:1.0f];
    _blue = [NSColor colorWithCalibratedRed:.25 green:.25 blue:.72 alpha:1.0f];
    _green = [NSColor colorWithCalibratedRed:.17 green:.49 blue:.17 alpha:1.0f];
    _turquoise = [NSColor colorWithCalibratedRed:.02 green:.76 blue:.76 alpha:1.0f];
    _brown = [NSColor colorWithCalibratedRed:.60 green:.29 blue:.21 alpha:1.0f];
    _ochre = [NSColor colorWithCalibratedRed:.88 green:.83 blue:.72 alpha:1.0f];
    _beige = [NSColor colorWithCalibratedRed:.80 green:.60 blue:.41 alpha:1.0f];
	
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
    [f setMaximumFractionDigits:1];
    NSNumber * myNumber = [f numberFromString:_minuteString];
    NSNumber *progresso = [NSNumber numberWithFloat:([myNumber floatValue]/60)];

    
    float progress = [progresso floatValue];

    
    
    NSLog (@"number: %@", myNumber);
    NSLog (@"progress: %@", progresso);
    NSLog (@"progressy: %f", progress);

    
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
    

    NSColor * current_color = [_color blendedColorWithFraction:progress ofColor:_color2];
    
    //NSLog (@"color: %@", _color);
    //NSLog (@"color2: %@", _color2);
    //NSLog (@"color3: %@", current_color);
    
    
    
    //set face attributes
    [_attributedString replaceCharactersInRange:NSMakeRange(0, _attributedString.string.length) withString:_face];
	[_attributedString setAttributes:@{
                                       NSFontAttributeName: _font,
                                       NSForegroundColorAttributeName: current_color,
                                       NSShadowAttributeName: shadowDic,
                                       } range:NSMakeRange(0, _attributedString.string.length)];
	
    //display face
	_statusItem.attributedTitle = _attributedString;
    
    //NSLog (@"time: %@", _dateString);
}



- (void)terminateApp {
    exit(0);
}

@end

