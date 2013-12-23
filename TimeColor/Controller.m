//
//  Controller.m
//  TimeColor
//
//  Created by George Wietor on 12/22/13.
//  Copyright (c) 2013 Issue Press. All rights reserved.
//

#import "Controller.h"
#import "AppDelegate.h"
#import "Menulet.h"
#import "PopUpController.h"

@implementation Controller

@synthesize active;
@synthesize popover;

- (void)_setupPopover
{
    if (!self.popover) {
        self.popover = [[NSPopover alloc] init];
        self.popover.contentViewController = [[PopUpController alloc] init];
        self.popover.contentSize = (CGSize){200, 250};
    }
}

- (void)menuletClicked
{
    //NSLog(@"Menulet clicked");
    self.active = ! self.active;
    if (self.active) {
        [self openPopover];
    } else {
        [self closePopover];
    }
}


- (void)closePopover
{
    //NSLog(@"Close Popover");
    if(self.popoverTransiencyMonitor)
    {
        [NSEvent removeMonitor:self.popoverTransiencyMonitor];
        
        self.popoverTransiencyMonitor = nil;
    }
    
    // (close popover)
    
    [self.popover performClose:self];
    self.active = false;
}

- (void)openPopover
{
    // (open popover
    //NSLog(@"Open Popover");
    AppDelegate *appDelegate = [NSApp delegate];
    
    [self _setupPopover];
    [self.popover showRelativeToRect:[appDelegate.menulet frame]
                              ofView:appDelegate.menulet
                       preferredEdge:NSMinYEdge];
    
    if(self.popoverTransiencyMonitor == nil)
    {
        self.popoverTransiencyMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseUp handler:^(NSEvent* event)
                                         {
                                             [self closePopover];
                                         }];
    }
}



@end
