#import "SettingsHeaderView.hh"
#include <AppKit/AppKit.h>

@implementation SettingsHeaderView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
      _headerImageView = [[NSImageView alloc] init];
      _headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
      _headerImageView.image = [NSImage imageNamed:@"header"];

      [self addSubview:_headerImageView];

      [NSLayoutConstraint activateConstraints:@[
         [_headerImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0],
         [_headerImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0],
         [_headerImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0],
         [_headerImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0],
      ]];
    }
    return self;
}

@end