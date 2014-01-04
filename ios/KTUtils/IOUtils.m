//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: com/kloudtek/util/io/IOUtils.java
//
//  Created by yannick on 28/12/13.
//

#include "IOSByteArray.h"
#include "IOSClass.h"
#include "IOUtils.h"
#include "java/io/DataInput.h"
#include "java/io/DataOutput.h"
#include "java/io/IOException.h"

@implementation KTUtilsIOUtils

+ (void)writeStringWithJavaIoDataOutput:(id<JavaIoDataOutput>)outArg
                           withNSString:(NSString *)str {
  [((id<JavaIoDataOutput>) nil_chk(outArg)) writeBooleanWithBoolean:str != nil];
  if (str != nil) {
    [outArg writeUTFWithNSString:str];
  }
}

+ (NSString *)readStringWithJavaIoDataInput:(id<JavaIoDataInput>)inArg {
  if ([((id<JavaIoDataInput>) nil_chk(inArg)) readBoolean]) {
    return [inArg readUTF];
  }
  else {
    return nil;
  }
}

+ (void)writeDataWithJavaIoDataOutput:(id<JavaIoDataOutput>)outArg
                        withByteArray:(IOSByteArray *)data {
  int len = data != nil ? (int) [data count] : -1;
  [((id<JavaIoDataOutput>) nil_chk(outArg)) writeIntWithInt:len];
  if (len > -1) {
    [outArg writeWithByteArray:data];
  }
}

+ (IOSByteArray *)readDataWithJavaIoDataInput:(id<JavaIoDataInput>)inArg {
  int len = [((id<JavaIoDataInput>) nil_chk(inArg)) readInt];
  if (len > 0) {
    IOSByteArray *data = [IOSByteArray arrayWithLength:len];
    [inArg readFullyWithByteArray:data];
    return data;
  }
  else if (len == 0) {
    return [IOSByteArray arrayWithLength:0];
  }
  else {
    return nil;
  }
}

- (id)init {
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "writeStringWithJavaIoDataOutput:withNSString:", NULL, "V", 0x9, "JavaIoIOException" },
    { "readStringWithJavaIoDataInput:", NULL, "LNSString", 0x9, "JavaIoIOException" },
    { "writeDataWithJavaIoDataOutput:withByteArray:", NULL, "V", 0x9, "JavaIoIOException" },
    { "readDataWithJavaIoDataInput:", NULL, "LIOSByteArray", 0x9, "JavaIoIOException" },
  };
  static J2ObjcClassInfo _KTUtilsIOUtils = { "IOUtils", "com.kloudtek.util.io", NULL, 0x1, 4, methods, 0, NULL, 0, NULL};
  return &_KTUtilsIOUtils;
}

@end