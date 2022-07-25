
#import "RNBridgeModule.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation RNBridgeModule

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(RNBridgeModule)

//RN → OC  By Promise  OC → RN
RCT_EXPORT_METHOD(RNInvokeOCPromise:(NSDictionary *)dictionary resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    NSLog(@"Received from RN:%@",dictionary);
    NSString *value=[dictionary objectForKey:@"name"];
    if([value isEqualToString:@"kyle"]){
        resolve(@"Success By Promise...");
    }else{
     NSError *error=[NSError errorWithDomain:@"Fail,this name is Illegal ,Promise..." code:100 userInfo:nil];
     reject(@"100",@"Fail,this name is Illegal ,Promise...",error);
   }
}

//RN → OC  By CallBack  OC → RN
RCT_EXPORT_METHOD(RNInvokeOCCallBack:(NSDictionary *)dictionary callback:(RCTResponseSenderBlock)callback){
    NSLog(@"Received from RN:%@",dictionary);
    NSArray *ary = [[NSArray alloc] initWithObjects:@"kyle", nil];
    callback(@[[NSNull null], ary]);
}

// RN open OCView
RCT_EXPORT_METHOD(RNOpenOC:(NSDictionary *)msg){
    NSLog(@"Received from RN:%@",msg);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RNOpenOC" object:msg];
    });
}

// RN open OCView
RCT_EXPORT_METHOD(RNOpen:(NSDictionary *)msg){
    NSLog(@"Received from RN:%@",msg);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RNOpenOC" object:msg];

        if ([msg objectForKey:@"callBack"]) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallRN:) name:[msg objectForKey:@"callBack"] object:nil];
        }
    });
}

// OC → RN
RCT_EXPORT_METHOD(OCcallRN:(NSDictionary *)dictionary){

    NSString *value = [dictionary objectForKey:@"name"];
    if([value isEqualToString:@"kyle"]){
        [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name":[NSString stringWithFormat:@"%@",value],@"errorCode":@"0",@"msg":@"成功"}];
    }else{
        [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name":[NSString stringWithFormat:@"%@",value],@"errorCode":@"0",@"msg":@"输入的name不是kyle"}];
    }
}

// OC → RN
RCT_EXPORT_METHOD(CallRN:(NSNotification *)array){
    if (array.object) {
        [self.bridge.eventDispatcher sendAppEventWithName:array.name body:array.object];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:array.name object:nil];
    }
}

@end
