#include "SettingsDropdownCell.hh"
#include <CoreGraphics/CGGeometry.h>

@implementation SettingsDropdownCell

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
      _titleLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
      _titleLabel.bezeled = NO;
      _titleLabel.drawsBackground = NO;
      _titleLabel.font = [NSFont systemFontOfSize:14];
      _titleLabel.editable = NO;
      _titleLabel.selectable = NO;
      _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
      [self addSubview:_titleLabel];

      _popUp = [[NSPopUpButton alloc] initWithFrame:CGRectZero pullsDown:NO];
      _popUp.translatesAutoresizingMaskIntoConstraints = NO;
      [self addSubview:_popUp];

      [NSLayoutConstraint activateConstraints:@[
         [_titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
         [_titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],

         [_popUp.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
         [_popUp.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
      ]];
    }
    return self;
}

@end