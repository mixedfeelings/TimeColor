//
//  AppDelegate.h
//  TimeColor
//
//  Created by George Wietor on 12/19/13.
//  Copyright (c) 2013 Issue Press. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

-(IBAction)toggleLaunchAtLogin:(id)sender;

@property (assign) IBOutlet NSSegmentedControl *launchAtLoginButton;
@property (assign) IBOutlet NSWindow *settingsWindow;

@property(assign, nonatomic, getter=isActive) BOOL active;
@property(assign, nonatomic) BOOL animated;

@property (strong) NSStatusItem * statusItem;
@property (strong) NSMenuItem * dateMenuItem;
@property (strong) NSMenuItem * quitMenuItem;
@property (strong) NSMenuItem * settingsMenuItem;
@property (strong) NSMenuItem * timezoneMenuItem;
@property (strong) NSMutableAttributedString * attributedString;

@property (strong) NSDateFormatter * timeFormatter;
@property (strong) NSDateFormatter * dateFormatter;
@property (strong) NSDateFormatter * minuteFormatter;
@property (strong) NSDateFormatter * timezoneFormatter;

@property (assign) NSFont * font;
@property (strong) NSColor * color;
@property (strong) NSColor * color2;
@property (assign) NSColor * currentColor;
@property (strong) NSColor * yellow;
@property (strong) NSColor * orange;
@property (strong) NSColor * pink;
@property (strong) NSColor * red;
@property (strong) NSColor * lilac;
@property (strong) NSColor * violet;
@property (strong) NSColor * blue;
@property (strong) NSColor * green;
@property (strong) NSColor * turquoise;
@property (strong) NSColor * brown;
@property (strong) NSColor * ochre;
@property (strong) NSColor * beige;
@property (strong) NSString * face;
@property (assign) NSString * dateString;
@property (assign) NSString * minuteString;
@property (strong) NSShadow * shadowDic;
@property (assign) float * progress;

@end

@interface NSColor (Gradient)

+ (NSColor *)my_gradientColorWithGradient:(NSGradient *)gradient;

@end