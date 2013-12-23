//
//  Menulet.m
//  TimeColor
//
//  Created by George Wietor on 12/22/13.
//  Copyright (c) 2013 Issue Press. All rights reserved.
//

#import "Menulet.h"
#import "AppDelegate.h"

static void *kActiveChangedKVO = &kActiveChangedKVO;

@implementation Menulet

@synthesize delegate;

- (void)setDelegate:(id<MenuletDelegate>)newDelegate
{
    [(NSObject *)newDelegate addObserver:self forKeyPath:@"active" options:NSKeyValueObservingOptionNew context:kActiveChangedKVO];
    delegate = newDelegate;
}

- (void)updateFace {
      //NSLog(@"show face");
    
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
    
    //NSLog (@"time: %@", _dateString);
    //NSLog (@"color: %@", _color);
    //NSLog (@"color2: %@", _color2);
    //NSLog (@"current_color: %@", current_color);
    
    
    //define gradient
    NSArray *colors = @[_color2, new_color, current_color, current_color, old_color];
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
    // self.statusItem.attributedTitle = _attributedString;
     NSLog (@"_attributedString1: %@", gradientColor);
}

- (void)drawRect:(NSRect)rect {
    rect = CGRectInset(rect, 2, 2);
    
    NSLog (@"_attributedString2: %@", _attributedString);

     //[string drawAtPoint: NSMakePoint(100, 100) withAttributes: _attributedString];
    //[_attributedString drawInRect:rect withAttributes:];

    
    //if ([self.delegate isActive]) {
    //    [[NSColor selectedMenuItemColor] set]; /* blueish */
    //} else {
    //    [[NSColor textColor] set]; /* blackish */
    //}
    //NSRectFill(rect);

}

- (void)mouseDown:(NSEvent *)event {
    //NSLog(@"Mouse down event: %@", event);
    [self.delegate menuletClicked];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kActiveChangedKVO) {
        //NSLog(@"%@", change);
        [self setNeedsDisplay:YES];
    }
}

@end