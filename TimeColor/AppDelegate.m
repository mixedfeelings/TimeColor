//
//  AppDelegate.m
//  TimeColor
//
//  Created by George Wietor on 12/19/13.
//  Copyright (c) 2013 Issue Press. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>
#import <ServiceManagement/ServiceManagement.h>

static void DrawGradientPattern(void * info, CGContextRef context)
{
    NSGraphicsContext *currentContext = [NSGraphicsContext currentContext];
    CGRect clipRect = CGContextGetClipBoundingBox(context);
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithGraphicsPort:context flipped:NO]];
    NSGradient *gradient = (__bridge NSGradient *)info;
    [gradient drawInRect:NSRectFromCGRect(clipRect) angle:60.0];
    [NSGraphicsContext setCurrentContext:currentContext];
}

@implementation NSColor (Gradient)

+ (NSColor *)my_gradientColorWithGradient:(NSGradient *)gradient
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreatePattern(NULL);
    CGPatternCallbacks callbacks;
    callbacks.drawPattern = &DrawGradientPattern;
    callbacks.releaseInfo = NULL;
    CGPatternRef pattern = CGPatternCreate((__bridge void *)(gradient), CGRectMake(0, 0, CGFLOAT_MAX, CGFLOAT_MAX), CGAffineTransformIdentity, CGFLOAT_MAX, CGFLOAT_MAX, kCGPatternTilingConstantSpacing, true, &callbacks);
    const CGFloat components[4] = {1.0, 1.0, 1.0, 1.0};
    CGColorRef cgColor = CGColorCreateWithPattern(colorSpace, pattern, components);
    CGColorSpaceRelease(colorSpace);
    NSColor *color = [NSColor colorWithCGColor:cgColor];
    objc_setAssociatedObject(color, "gradient", gradient, OBJC_ASSOCIATION_RETAIN);
    return color;
}
@end



@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	_statusItem.highlightMode = YES;
	_statusItem.menu = [[NSMenu alloc] init];
	_dateMenuItem = [[NSMenuItem alloc] init];
	_dateMenuItem.enabled = YES;
    _settingsMenuItem = [[NSMenuItem alloc] init];
    _settingsMenuItem.enabled = YES;
    _settingsMenuItem.title = @"Settings";
    _settingsMenuItem.action = @selector(terminateApp);
    _quitMenuItem = [[NSMenuItem alloc] init];
    _quitMenuItem.enabled = YES;
    _quitMenuItem.title = @"Quit";
    _quitMenuItem.action = @selector(terminateApp);
    
	[_statusItem.menu addItem:_dateMenuItem];
    [_statusItem.menu addItem:_settingsMenuItem];
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
    
    _shadowDic=[[NSShadow alloc] init];
    [_shadowDic setShadowBlurRadius:2.0];
    [_shadowDic setShadowColor:[NSColor whiteColor]];
    [_shadowDic setShadowOffset:CGSizeMake(0, 0)];

    _yellow = [NSColor colorWithCalibratedRed:1 green:.92 blue:.13 alpha:1.0f];
    _orange = [NSColor colorWithCalibratedRed:1 green:.49 blue:.09 alpha:1.0f];
    //_pink = [NSColor colorWithCalibratedRed:1 green:.76 blue:.76 alpha:1.0f];
    _pink = [NSColor colorWithCalibratedRed:1 green:.64 blue:.64 alpha:1.0f];
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
         
         
         
         //NSLog (@"number: %@", myNumber);
         //NSLog (@"progress: %@", progresso);
         //NSLog (@"progressy: %f", progress);
         
         
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
         
         //define colors
         NSColor * current_color = [_color blendedColorWithFraction:progress ofColor:_color2];
         NSColor * new_color = [current_color blendedColorWithFraction:progress ofColor:_color2];
         NSColor * old_color = [_color blendedColorWithFraction:progress ofColor:current_color];
         
         //define gradient
         NSArray *colors = @[_color2, new_color, current_color, current_color, old_color, _color];
         NSGradient *gradient = [[NSGradient alloc] initWithColors:colors];
         NSColor *gradientColor = [NSColor my_gradientColorWithGradient:gradient];
         [gradientColor set];
         
         //set face attributes
         [_attributedString replaceCharactersInRange:NSMakeRange(0, _attributedString.string.length) withString:_face];
         [_attributedString setAttributes:@{
                                            NSFontAttributeName: _font,
                                            NSForegroundColorAttributeName: gradientColor,
                                            NSShadowAttributeName: _shadowDic,
                                            } range:NSMakeRange(0, _attributedString.string.length)];
         
         //display face
         _statusItem.attributedTitle = _attributedString;
         
         //NSLog (@"time: %@", _dateString);
     }
     
@synthesize launchAtLoginButton;
-(IBAction)toggleLaunchAtLogin:(id)sender
{
    NSInteger clickedSegment = [sender selectedSegment];
    if (clickedSegment == 0) { // ON
        // Turn on launch at login
        if (!SMLoginItemSetEnabled ((__bridge CFStringRef)@"com.issuepress.TimeColorHelper", YES)) {
            NSAlert *alert = [NSAlert alertWithMessageText:@"An error ocurred"
                                             defaultButton:@"OK"
                                           alternateButton:nil
                                               otherButton:nil
                                 informativeTextWithFormat:@"Couldn't add Helper App to launch at login item list."];
            [alert runModal];
        }
    }
    if (clickedSegment == 1) { // OFF
        // Turn off launch at login
        if (!SMLoginItemSetEnabled ((__bridge CFStringRef)@"com.issuepress.TimeColorHelper", NO)) {
            NSAlert *alert = [NSAlert alertWithMessageText:@"An error ocurred"
                                             defaultButton:@"OK"
                                           alternateButton:nil
                                               otherButton:nil
                                 informativeTextWithFormat:@"Couldn't remove Helper App from launch at login item list."];
            [alert runModal];
        }
    }
}

- (void)terminateApp {
    exit(0);
}

@end

