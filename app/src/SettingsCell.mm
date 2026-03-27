#import "SettingsCell.hh"
#include <AppKit/AppKit.h>
#include <CoreGraphics/CGGeometry.h>

@implementation SettingsCell

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        _titleLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        // _titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(15, 5, 200, 20)];
        _titleLabel.bezeled = NO;
        _titleLabel.drawsBackground = NO;
        _titleLabel.font = [NSFont systemFontOfSize:14];
        _titleLabel.editable = NO;
        _titleLabel.selectable = NO;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        _toggle = [[NSSwitch alloc] initWithFrame:CGRectZero];
        // _toggle = [[NSSwitch alloc] initWithFrame:NSMakeRect(frameRect.size.width - 70, 2, 60, 24)];
        // _toggle.autoresizingMask = NSViewMinXMargin;
        _toggle.translatesAutoresizingMaskIntoConstraints = NO;

        [self addSubview:_titleLabel];
        [self addSubview:_toggle];

        [NSLayoutConstraint activateConstraints:@[
            [_titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [_titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],

            [_toggle.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [_toggle.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
        ]];
    }
    return self;
}

@end