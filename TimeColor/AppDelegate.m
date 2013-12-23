//
//  AppDelegate.m
//  TimeColor
//
//  Created by George Wietor on 12/19/13.
//  Copyright (c) 2013 Issue Press. All rights reserved.
//

#import "AppDelegate.h"
#import "Menulet.h"
#import "Controller.h"
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

    @synthesize window = _window;
    @synthesize menulet;
    @synthesize statusItem;
    @synthesize controller;


- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    CGFloat thickness = [[NSStatusBar systemStatusBar] thickness];
	//_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:thickness];
	statusItem.highlightMode = YES;
	statusItem.menu = [[NSMenu alloc] init];
	//_dateMenuItem = [[NSMenuItem alloc] init];
	//_dateMenuItem.enabled = YES;
    //_quitMenuItem = [[NSMenuItem alloc] init];
    //_quitMenuItem.enabled = YES;
    //_quitMenuItem.title = @"Quit";
    //_quitMenuItem.action = @selector(terminateApp);
    self.menulet = [[Menulet alloc] initWithFrame:(NSRect){.size={thickness, thickness}}]; /* square item */
    self.controller = [[Controller alloc] init];
    self.menulet.delegate = self.controller;
    
	//[_statusItem.menu addItem:_dateMenuItem];
    //[_statusItem.menu addItem:_quitMenuItem];
	
	_attributedString = [[NSMutableAttributedString alloc] init];
	
	_timeFormatter = [[NSDateFormatter alloc] init];
    _timeFormatter.dateFormat = @"hh";
    _minuteFormatter = [[NSDateFormatter alloc] init];
	_minuteFormatter.dateFormat = @"mm";
	_dateFormatter = [[NSDateFormatter alloc] init];
	_dateFormatter.dateFormat = @"hh:mm a";
    
	_font = [NSFont menuBarFontOfSize:34];
    _face = @"\u25CF";
    	
    //set secondary clock
    [self updateClock];
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateClock) userInfo:nil repeats:YES];
    
    [self.statusItem setView:self.menulet];

}


     - (void)updateClock {
        // NSLog(@"clock");
         //update secondary clock menu
         NSDate *date = [NSDate date];
         _dateMenuItem.title = [_dateFormatter stringFromDate:date];
         
         //set statusbar face
         [menulet updateFace];
       
         
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

