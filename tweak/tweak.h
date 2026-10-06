static NSString *plistPath;

@interface Tile : NSObject
@property (readonly,nonatomic) NSString* label;
@end

@interface DOCKLabelLayer
@property (nonatomic) Tile* source;
- (id)initWithOrientation:(long long)v1 display:(id)v2;
- (void)attach:(id)v1;
- (void)detach;
- (void)scaleFactorChanged;
- (void)updateBackground;
- (void)backgroundChanged;
- (void)materialStyleChanged;
- (void)update;
- (void)_updateLabelImage:(float)v1;
@end

@interface DockBar
-(void)appLaunchedForTile:(id)tile;
@end