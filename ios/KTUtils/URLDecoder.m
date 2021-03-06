//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: URLDecoder.java
//
//  Created by yannick on 08/02/14.
//

#include "IOSByteArray.h"
#include "IOSClass.h"
#include "java/io/UnsupportedEncodingException.h"
#include "java/lang/Deprecated.h"
#include "java/lang/IllegalArgumentException.h"
#include "java/lang/Integer.h"
#include "java/lang/NumberFormatException.h"
#include "java/lang/StringBuffer.h"
#include "URLDecoder.h"

@implementation JavaNetURLDecoder

static NSString * JavaNetURLDecoder_dfltEncName_ = nil;

+ (NSString *)dfltEncName {
  return JavaNetURLDecoder_dfltEncName_;
}

+ (void)setDfltEncName:(NSString *)dfltEncName {
  JavaNetURLDecoder_dfltEncName_ = dfltEncName;
}

+ (NSString *)decodeWithNSString:(NSString *)s {
  NSString *str = nil;
  @try {
    str = [JavaNetURLDecoder decodeWithNSString:s withNSString:JavaNetURLDecoder_dfltEncName_];
  }
  @catch (JavaIoUnsupportedEncodingException *e) {
  }
  return str;
}

+ (NSString *)decodeWithNSString:(NSString *)s
                    withNSString:(NSString *)enc {
  BOOL needToChange = NO;
  int numChars = [((NSString *) nil_chk(s)) length];
  JavaLangStringBuffer *sb = [[JavaLangStringBuffer alloc] initWithInt:numChars > 500 ? numChars / 2 : numChars];
  int i = 0;
  if ([((NSString *) nil_chk(enc)) length] == 0) {
    @throw [[JavaIoUnsupportedEncodingException alloc] initWithNSString:@"URLDecoder: empty string enc parameter"];
  }
  unichar c;
  IOSByteArray *bytes = nil;
  while (i < numChars) {
    c = [s charAtWithInt:i];
    switch (c) {
      case '+':
      (void) [sb appendWithChar:' '];
      i++;
      needToChange = YES;
      break;
      case '%':
      @try {
        if (bytes == nil) bytes = [IOSByteArray arrayWithLength:(numChars - i) / 3];
        int pos = 0;
        while (((i + 2) < numChars) && (c == '%')) {
          (*IOSByteArray_GetRef(nil_chk(bytes), pos++)) = (char) [JavaLangInteger parseIntWithNSString:[s substring:i + 1 endIndex:i + 3] withInt:16];
          i += 3;
          if (i < numChars) c = [s charAtWithInt:i];
        }
        if ((i < numChars) && (c == '%')) @throw [[JavaLangIllegalArgumentException alloc] initWithNSString:@"URLDecoder: Incomplete trailing escape (%) pattern"];
        (void) [sb appendWithNSString:[NSString stringWithBytes:bytes offset:0 length:pos charsetName:enc]];
      }
      @catch (JavaLangNumberFormatException *e) {
        @throw [[JavaLangIllegalArgumentException alloc] initWithNSString:[NSString stringWithFormat:@"URLDecoder: Illegal hex characters in escape (%%) pattern - %@", [((JavaLangNumberFormatException *) nil_chk(e)) getMessage]]];
      }
      needToChange = YES;
      break;
      default:
      (void) [sb appendWithChar:c];
      i++;
      break;
    }
  }
  return (needToChange ? [sb description] : s);
}

- (id)init {
  return [super init];
}

+ (IOSObjectArray *)__annotations_decodeWithNSString_ {
  return [IOSObjectArray arrayWithObjects:(id[]) { [[JavaLangDeprecated alloc] init] } count:1 type:[IOSClass classWithProtocol:@protocol(JavaLangAnnotationAnnotation)]];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "decodeWithNSString:", NULL, "LNSString", 0x9, NULL },
    { "decodeWithNSString:withNSString:", NULL, "LNSString", 0x9, "JavaIoUnsupportedEncodingException" },
  };
  static J2ObjcFieldInfo fields[] = {
    { "dfltEncName_", NULL, 0x8, "LNSString" },
  };
  static J2ObjcClassInfo _JavaNetURLDecoder = { "URLDecoder", "java.net", NULL, 0x1, 2, methods, 1, fields, 0, NULL};
  return &_JavaNetURLDecoder;
}

@end
