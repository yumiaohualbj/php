//
//  ViewController.m
//  测试接口
//
//  Created by mac on 2017/4/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "NWHub.h"
#import "NWNotification.h"
#import "NWPusher.h"
#import "NWPushFeedback.h"
#import "NWSecTools.h"
#import "NWSSLConnection.h"
#import "NWType.h"

#import <PushKit/PushKit.h>
#define NWLogWarn(_format, ...)                  NWLLogWithFilter("warn", NWL_LIB_STR, _format, ##__VA_ARGS__)
static NSString * const deviceToken = @"d8999642a23ef40c127ca0920159a2d19b43e66c9a26bb345bc23f595f7e6985";
@interface ViewController ()<NWHubDelegate>

@end

@implementation ViewController{
    
    NWHub *_hub;
    NSUInteger _index;
    dispatch_queue_t _serial;
    
    NWIdentityRef _identity;
    NWCertificateRef _certificate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载证书，
    [self loadCeitificate];
    //连接
    [self connect];
    [self performSelector:@selector(push) withObject:nil afterDelay:10];
    
}


- (void)loadCeitificate{
    
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"apns-dev-cert.p12" withExtension:nil];
    NSData * pkcs12 = [NSData dataWithContentsOfURL:url];
    NSString * pkcs12Password = @"123456";
    NSError * error = nil;
    NSArray *ids = [NWSecTools identitiesWithPKCS12Data:pkcs12 password:pkcs12Password error:&error];
    if (!ids) {
        NSLog(@"Unable to read p12 file: %@", error.localizedDescription);
        return;
    }
    for (NWIdentityRef identity in ids) {
        NSError *error = nil;
        NWCertificateRef certificate = [NWSecTools certificateWithIdentity:identity error:&error];
        if (!certificate) {
           NSLog(@"Unable to import p12 file: %@", error.localizedDescription);
            return;
        }
        
        _identity = identity;
        _certificate = certificate;
    }

    
 
}

- (void)connect{
    
    NWEnvironment preferredEnvironment = [self preferredEnvironmentForCertificate:_certificate];
    
    [self connectToEnvironment:preferredEnvironment];

}

- (NWEnvironment)preferredEnvironmentForCertificate:(NWCertificateRef)certificate
{
    NWEnvironmentOptions environmentOptions = [NWSecTools environmentOptionsForCertificate:certificate];
    
    return (environmentOptions & NWEnvironmentOptionSandbox) ? NWEnvironmentSandbox : NWEnvironmentProduction;
}

- (void)connectToEnvironment:(NWEnvironment)environment
{

     _serial = dispatch_queue_create("NWAppDelegate", DISPATCH_QUEUE_SERIAL);

    dispatch_async(_serial, ^{
        NSError *error = nil;
        
        NWHub *hub = [NWHub connectWithDelegate:self identity:_identity environment:environment error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (hub) {
                NSString *summary = [NWSecTools summaryWithCertificate:_certificate];
               NSLog(@"Connected to APN: %@ (%@)", summary, descriptionForEnvironent(environment));
                _hub = hub;
                
  
            } else {
                NSLog(@"Unable to connect: %@", error.localizedDescription);
            }
            
            [self enableButtonsForCertificate:_certificate environment:environment];
        });
    });
}


- (void)enableButtonsForCertificate:(NWCertificateRef)certificate environment:(NWEnvironment)environment
{
//    NWEnvironmentOptions environmentOptions = [NWSecTools environmentOptionsForCertificate:certificate];
//    
//    BOOL shouldEnableEnvButton = (environmentOptions == NWEnvironmentOptionAny);
//    BOOL shouldSelectSandboxEnv = (environment == NWEnvironmentSandbox);
//    
//    _pushButton.enabled = YES;
//    _connectButton.enabled = YES;
//    _sanboxSwitch.enabled = shouldEnableEnvButton;
//    _sanboxSwitch.on = shouldSelectSandboxEnv;
}

- (void)notification:(NWNotification *)notification didFailWithError:(NSError *)error{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //NSLog(@"failed notification: %@ %@ %lu %lu %lu", notification.payload, notification.token, notification.identifier, notification.expires, notification.priority);
        NSLog(@"Notification error: %@", error.localizedDescription);
    });
}

- (void)push{
    
   NSString *payload = [NSString stringWithFormat:@"{\"aps\":{\"alert\":\"客户端测试1\",\"badge\":1,\"sound\":\"default\"}}"];
//    NSString *token = deviceToken;
//    
//     NSLog(@"Pushing..");
//    dispatch_async(_serial, ^{
//        NSUInteger failed = [_hub pushPayload:payload token:token];
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
//        dispatch_after(popTime, _serial, ^(void){
//            NSUInteger failed2 = failed + [_hub readFailed];
//            if (!failed2) NSLog(@"Payload has been pushed");
//        });
//    });

//    NSString *payload = payload;
    NSString *token = deviceToken;
    NSDate *expiry = nil;
    NSUInteger priority = 0;
         NSLog(@"Pushing..");
    dispatch_async(_serial, ^{
        NWNotification *notification = [[NWNotification alloc] initWithPayload:payload token:token identifier:0 expiration:expiry priority:priority];
        NSError *error = nil;
        BOOL pushed = [_hub pushNotification:notification autoReconnect:YES error:&error];
        if (pushed) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
            dispatch_after(popTime, _serial, ^(void){
                NSError *error = nil;
                NWNotification *failed = nil;
                BOOL read = [_hub readFailed:&failed autoReconnect:YES error:&error];
                if (read) {
                    if (!failed) NSLog(@"Payload has been pushed");
                } else {
                    NSLog(@"Unable to read failed: %@", error.localizedDescription);
                }
                [_hub trimIdentifiers];
            });
        } else {
           NSLog(@"Unable to push: %@", error.localizedDescription);
        }
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
