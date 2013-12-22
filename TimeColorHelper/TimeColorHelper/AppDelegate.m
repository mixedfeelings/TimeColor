//
//  AppDelegate.m
//  TimeColorHelper
//
//  Created by George Wietor on 12/22/13.
//  Copyright (c) 2013 Issue Press. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Check if main app is already running; if yes, do nothing and terminate helper app
    BOOL alreadyRunning = NO;
    NSArray *running = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in running) {
        if ([[app bundleIdentifier] isEqualToString:@"com.issuepress.TimeColorHelper"]) {
            alreadyRunning = YES;
        }
    }
    
    
    if (!alreadyRunning) {
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSArray *p = [path pathComponents];
        NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:p];
        [pathComponents removeLastObject];
        [pathComponents removeLastObject];
        [pathComponents removeLastObject];
        [pathComponents addObject:@"MacOS"];
        [pathComponents addObject:@"TimeColor"];
        NSString *newPath = [NSString pathWithComponents:pathComponents];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:@"launchAtLogin"], NSWorkspaceLaunchConfigurationArguments, nil];
        [[NSWorkspace sharedWorkspace] launchApplicationAtURL:[NSURL fileURLWithPath:newPath]
                                                      options:NSWorkspaceLaunchWithoutActivation
                                                configuration:dict
                                                        error:nil];
    }
    
    [NSApp terminate:nil];
}

@end
