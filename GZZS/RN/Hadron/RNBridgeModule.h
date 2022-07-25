
#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
#import <React/RCTLog.h>
#import <React/RCTBridgeModule.h>

@interface RNBridgeModule : NSObject<RCTBridgeModule>
@property (nonatomic,strong) NSDictionary *userDic;
@end
