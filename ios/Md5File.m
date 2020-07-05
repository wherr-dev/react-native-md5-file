#import "Md5File.h"
#import <AWFileHash/AWFileHash.h>

@implementation Md5File

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(hashFileMD5:(NSString *)path type:(NSString *)type callback:(RCTResponseSenderBlock)callback)
{
    callback(@[[NSNull null], [self output:[AWFileHash md5HashOfFileAtPath:path] as:type]]);
}

RCT_EXPORT_METHOD(hashFileSHA1:(NSString *)path type:(NSString *)type callback:(RCTResponseSenderBlock)callback)
{
    callback(@[[NSNull null], [self output:[AWFileHash sha1HashOfFileAtPath:path] as:type]]);
}

RCT_EXPORT_METHOD(hashFileSHA512:(NSString *)path type:(NSString *)type callback:(RCTResponseSenderBlock)callback)
{
    callback(@[[NSNull null], [self output:[AWFileHash sha512HashOfFileAtPath:path] as:type]]);
}

RCT_EXPORT_METHOD(hashFileCRC32:(NSString *)path type:(NSString *)type callback:(RCTResponseSenderBlock)callback)
{
    callback(@[[NSNull null], [self output:[AWFileHash crc32HashOfFileAtPath:path] as:type]]);
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_queue_create("com.facebook.React.AsyncLocalStorageQueue", DISPATCH_QUEUE_SERIAL);
}

- (NSString*)hexToBase64:(NSString *)string
{
    string = [string lowercaseString];
    NSMutableData* data = [NSMutableData new];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i = 0;
    int length = string.length;
    while (i < length-1) {
        char c = [string characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            continue;
        byte_chars[0] = c;
        byte_chars[1] = [string characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return [data base64EncodedStringWithOptions:0];
}

- (NSString*)output:(NSString *)hash as:(NSString *) type
{
    if ([type isEqualToString:@"base64"]) {
        return [self hexToBase64:hash];
    }
    return hash;
}

@end
