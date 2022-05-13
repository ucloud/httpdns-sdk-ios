//
//  ViewController.m
//  UHttpDnsSDKDemo
//
//  Created by jdq on 2021/11/9.
//

#import "ViewController.h"
#import <UHttpDnsSDK/UHttpDnsSDK.h>
#import "UUntil.h"

@interface ViewController ()
/// domainTextfield
@property (weak, nonatomic) IBOutlet UITextField *domainTextfield;
/// resultTextView
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
/// log string
@property (nonatomic, strong) NSMutableString *logString;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setup];
}

#pragma mark - Setup

- (void)setup {
	self.logString = [[NSMutableString alloc] init];
}

#pragma mark - Action

- (IBAction)ipv4ResolveAction:(id)sender {
	[self.domainTextfield resignFirstResponder];
	NSString *inputValue = [self currenInputValue];
	if (![self verifyDomain:inputValue]) {
		return;
	}
	[[UHttpDnsManager shared] getIPV4ByDomain:inputValue returnBlock:^(NSError * _Nullable error, NSArray * _Nullable ipsArray) {
        if (error) {
            /// errorCode 为UDNSErrorCodeDegradeHost时，表示当前host为降级host
            [self printLog:[NSString stringWithFormat:@"%@ error: %@", inputValue, error]];
            return;
		 }
        [self printLog:[NSString stringWithFormat:@"%@ result: %@", inputValue, ipsArray]];
	 }];
}

- (IBAction)ipv6ResolveAction:(id)sender {
	[self.domainTextfield resignFirstResponder];
	NSString *inputValue = [self currenInputValue];
	if (![self verifyDomain:inputValue]) {
		return;
	}
	[[UHttpDnsManager shared] getIPV6ByDomain:inputValue returnBlcok:^(NSError * _Nullable error, NSArray * _Nullable ipsArray) {
        if (error) {
            /// errorCode 为UDNSErrorCodeDegradeHost时，表示当前host为降级host
            [self printLog:[NSString stringWithFormat:@"%@ error: %@", inputValue, error]];
            return;
		 }
        [self printLog:[NSString stringWithFormat:@"%@ result: %@", inputValue, ipsArray]];
	 }];
}

#pragma mark - Other

- (BOOL)verifyDomain:(NSString *)domain {
	if (domain.length == 0) { return NO; }
	if (![UUntil isDomain:domain]) {
		[self printLog:[NSString stringWithFormat:@"%@-域名格式不正确", domain]];
		return NO;
	}
	return YES;
}

- (NSString *)currenInputValue {
	NSString *inputValue = [self.domainTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if (inputValue.length > 0) {
		return inputValue;
	}
	return nil;
}

- (void)printLog:(NSString *)log {
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.logString appendFormat:@"%@\n\n", log];
		self.resultTextView.text = self.logString;

		CGFloat contentSizeHeight = self.resultTextView.contentSize.height;
		CGFloat scrollViewHeight = self.resultTextView.bounds.size.height;
		CGFloat scrollViewBottom = self.resultTextView.contentInset.bottom;

		if (contentSizeHeight < scrollViewHeight) { return; }

		CGFloat offset = contentSizeHeight - scrollViewHeight + scrollViewBottom;
		[self.resultTextView setContentOffset:CGPointMake(0, offset) animated:YES];
	});
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self.view endEditing:YES];
}

@end
