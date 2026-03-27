#include "SettingsItem.hh"

@implementation SettingsItem
- (id)initWithTitle:(NSString *)title enabled:(BOOL)enabled {
   id r = [super init];

   _title = title;
   _enabled = enabled;

   return r;
}
@end