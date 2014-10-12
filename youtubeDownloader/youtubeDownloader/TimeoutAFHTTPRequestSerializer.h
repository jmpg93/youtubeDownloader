#import "AFURLRequestSerialization.h"

@interface TimeoutAFHTTPRequestSerializer : AFHTTPRequestSerializer

@property (nonatomic, assign) NSTimeInterval timeout;

- (id)initWithTimeout:(NSTimeInterval)timeout;

@end