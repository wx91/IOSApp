//
//  LoginViewController.m
//  RWReactivePlayground
//
//  Created by wangx on 2016/12/1.
//  Copyright © 2016年 wangx. All rights reserved.
//

#import "LoginViewController.h"

#import "RWDummySignInService.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;

@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    self.signInService = [RWDummySignInService new];
    // initially hide the failure message
    self.signInFailureText.hidden = YES;
    RACSignal *validUsernameSignal =
    [self.usernameTextField.rac_textSignal
         map:^id(NSString *text) {
             return @([self isValidUsername:text]);
         }];
    RACSignal *validPasswordSignal =
    [self.passwordTextField.rac_textSignal
     map:^id(NSString *text) {
         return @([self isValidPassword:text]);
     }];
    
    RAC(self.passwordTextField, backgroundColor) =
    [validPasswordSignal
     map:^id(NSNumber *passwordValid) {
         return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
     }];
    
    RAC(self.usernameTextField, backgroundColor) =
    [validUsernameSignal
     map:^id(NSNumber *passwordValid) {
         return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
     }];
    
    
//    RACSignal *signUpActiveSignal =
//    [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
//                      reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid) {
//                          return @([usernameValid boolValue] && [passwordValid boolValue]);
//                      }];
//    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
//        self.signInButton.enabled = [signupActive boolValue];
//    }];
    RAC(self.signInButton,enabled) = [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal] reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid) {
        return @([usernameValid boolValue] && [passwordValid boolValue]);
        }];
    
    //登录
    [[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside]
       doNext:^(id x) {
        self.signInButton.enabled=NO;
        self.signInFailureText.hidden=YES;
    }]flattenMap:^RACStream *(id value) {
        return [self signInSignal];
    }] subscribeNext:^(NSNumber *signedIn) {
        self.signInButton.enabled = YES;
        BOOL success = [signedIn boolValue];
        self.signInFailureText.hidden = success;
        if (success) {
//            [self performSegueWithIdentifier:@"signInSuccess" sender:self];
            NSLog(@"登录成功！");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}

-(RACSignal *)signInSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.signInService signInWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
@end
