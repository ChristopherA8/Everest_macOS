#include <AppKit/AppKit.h>

#include "BlurView.hh"

@interface ViewController : NSViewController
@property (retain) BlurView *blurView;
@property (retain) NSTextField *textField;
-(id)init;
-(void)viewDidLoad;
@end