//
//  Controller.h
//  TimeColor
//
//  Created by George Wietor on 12/22/13.
//  Copyright (c) 2013 Issue Press. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuletDelegate <NSObject>

- (BOOL)isActive;
- (void)menuletClicked;

@end

@interface Controller : NSObject <MenuletDelegate>

@property (nonatomic, assign, getter = isActive) BOOL active;
@property (nonatomic, strong) NSPopover *popover;
@property (nonatomic, strong) id popoverTransiencyMonitor;

@end
