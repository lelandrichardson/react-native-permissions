//
//  ReactNativePermissions.m
//  ReactNativePermissions
//
//  Created by Yonah Forst on 18/02/16.
//  Copyright © 2016 Yonah Forst. All rights reserved.
//

@import Contacts;

#import "ReactNativePermissions.h"

#import <React/RCTBridge.h>
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>

#import "RNPPhoto.h"

@interface ReactNativePermissions()
@end

@implementation ReactNativePermissions


RCT_EXPORT_MODULE();
@synthesize bridge = _bridge;

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init]) {
    }

    return self;
}

/**
 * run on the main queue.
 */
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}


RCT_REMAP_METHOD(canOpenSettings, canOpenSettings:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    resolve(@(UIApplicationOpenSettingsURLString != nil));
}

RCT_EXPORT_METHOD(openSettings)
{
    if (@(UIApplicationOpenSettingsURLString != nil)) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

RCT_REMAP_METHOD(getPermissionStatus, getPermissionStatus:(RNPType)type resolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *status;

    switch (type) {
        case RNPTypePhoto:
            status = [RNPPhoto getStatus];
            break;
        default:
            break;
    }

    resolve(status);
}
@end
