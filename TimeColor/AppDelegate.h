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

@end

@interface NSColor (Gradient)

+ (NSColor *)my_gradientColorWithGradient:(NSGradient *)gradient;

@end