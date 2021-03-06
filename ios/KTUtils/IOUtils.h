//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: com/kloudtek/util/io/IOUtils.java
//
//  Created by yannick on 08/02/14.
//

#ifndef _KTUtilIOUtils_H_
#define _KTUtilIOUtils_H_

@class IOSByteArray;
@class JavaIoFile;
@class JavaIoInputStream;
@class JavaIoOutputStream;
@class JavaIoReader;
@class JavaIoWriter;

#import "JreEmulation.h"

#define KTUtilIOUtils_DEF_BUFF_SIZE 10240
#define KTUtilIOUtils_DEF_CHAR_BUFF_SIZE 200

@interface KTUtilIOUtils : NSObject {
}

+ (IOSByteArray *)toByteArrayWithJavaIoInputStream:(JavaIoInputStream *)inputStream;
+ (long long int)copy__WithJavaIoInputStream:(JavaIoInputStream *)inputStream
                      withJavaIoOutputStream:(JavaIoOutputStream *)outputStream OBJC_METHOD_FAMILY_NONE;
+ (long long int)copy__WithJavaIoInputStream:(JavaIoInputStream *)inputStream
                      withJavaIoOutputStream:(JavaIoOutputStream *)outputStream
                                     withInt:(int)bufSize OBJC_METHOD_FAMILY_NONE;
+ (long long int)copy__WithJavaIoReader:(JavaIoReader *)reader
                       withJavaIoWriter:(JavaIoWriter *)writer OBJC_METHOD_FAMILY_NONE;
+ (long long int)copy__WithJavaIoReader:(JavaIoReader *)reader
                       withJavaIoWriter:(JavaIoWriter *)writer
                                withInt:(int)bufSize OBJC_METHOD_FAMILY_NONE;
+ (long long int)byteArrayToLongWithByteArray:(IOSByteArray *)data;
+ (IOSByteArray *)longToByteArrayWithLong:(long long int)value;
+ (NSString *)toStringWithJavaIoFile:(JavaIoFile *)file;
- (id)init;
@end

typedef KTUtilIOUtils ComKloudtekUtilIoIOUtils;

#endif // _KTUtilIOUtils_H_
