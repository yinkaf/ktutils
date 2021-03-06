//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: com/kloudtek/util/Base32.java
//
//  Created by yannick on 08/02/14.
//

#include "Base32.h"
#include "BaseNCodec.h"
#include "IOSByteArray.h"
#include "StringUtils.h"
#include "java/lang/IllegalArgumentException.h"
#include "java/lang/IllegalStateException.h"
#include "java/lang/System.h"

@implementation KTUtilBase32

static IOSByteArray * KTUtilBase32_CHUNK_SEPARATOR_;
static IOSByteArray * KTUtilBase32_DECODE_TABLE_;
static IOSByteArray * KTUtilBase32_ENCODE_TABLE_;
static IOSByteArray * KTUtilBase32_HEX_DECODE_TABLE_;
static IOSByteArray * KTUtilBase32_HEX_ENCODE_TABLE_;

+ (IOSByteArray *)CHUNK_SEPARATOR {
  return KTUtilBase32_CHUNK_SEPARATOR_;
}

+ (IOSByteArray *)DECODE_TABLE {
  return KTUtilBase32_DECODE_TABLE_;
}

+ (IOSByteArray *)ENCODE_TABLE {
  return KTUtilBase32_ENCODE_TABLE_;
}

+ (IOSByteArray *)HEX_DECODE_TABLE {
  return KTUtilBase32_HEX_DECODE_TABLE_;
}

+ (IOSByteArray *)HEX_ENCODE_TABLE {
  return KTUtilBase32_HEX_ENCODE_TABLE_;
}

- (id)init {
  return [self initKTUtilBase32WithBoolean:NO];
}

- (id)initKTUtilBase32WithBoolean:(BOOL)useHex {
  return [self initKTUtilBase32WithInt:0 withByteArray:nil withBoolean:useHex];
}

- (id)initWithBoolean:(BOOL)useHex {
  return [self initKTUtilBase32WithBoolean:useHex];
}

- (id)initWithInt:(int)lineLength {
  return [self initKTUtilBase32WithInt:lineLength withByteArray:KTUtilBase32_CHUNK_SEPARATOR_];
}

- (id)initKTUtilBase32WithInt:(int)lineLength
                withByteArray:(IOSByteArray *)lineSeparator {
  return [self initKTUtilBase32WithInt:lineLength withByteArray:lineSeparator withBoolean:NO];
}

- (id)initWithInt:(int)lineLength
    withByteArray:(IOSByteArray *)lineSeparator {
  return [self initKTUtilBase32WithInt:lineLength withByteArray:lineSeparator];
}

- (id)initKTUtilBase32WithInt:(int)lineLength
                withByteArray:(IOSByteArray *)lineSeparator
                  withBoolean:(BOOL)useHex {
  if (self = [super initWithInt:KTUtilBase32_BYTES_PER_UNENCODED_BLOCK withInt:KTUtilBase32_BYTES_PER_ENCODED_BLOCK withInt:lineLength withInt:lineSeparator == nil ? 0 : (int) [lineSeparator count]]) {
    if (useHex) {
      self->encodeTable_ = KTUtilBase32_HEX_ENCODE_TABLE_;
      self->decodeTable_ = KTUtilBase32_HEX_DECODE_TABLE_;
    }
    else {
      self->encodeTable_ = KTUtilBase32_ENCODE_TABLE_;
      self->decodeTable_ = KTUtilBase32_DECODE_TABLE_;
    }
    if (lineLength > 0) {
      if (lineSeparator == nil) {
        @throw [[JavaLangIllegalArgumentException alloc] initWithNSString:[NSString stringWithFormat:@"lineLength %d > 0, but lineSeparator is null", lineLength]];
      }
      if ([self containsAlphabetOrPadWithByteArray:lineSeparator]) {
        NSString *sep = [KTUtilStringUtils fromUTF8WithByteArray:lineSeparator];
        @throw [[JavaLangIllegalArgumentException alloc] initWithNSString:[NSString stringWithFormat:@"lineSeparator must not contain Base32 characters: [%@]", sep]];
      }
      self->encodeSize_ = KTUtilBase32_BYTES_PER_ENCODED_BLOCK + (int) [((IOSByteArray *) nil_chk(lineSeparator)) count];
      self->lineSeparator_ = [IOSByteArray arrayWithLength:(int) [lineSeparator count]];
      [JavaLangSystem arraycopyWithId:lineSeparator withInt:0 withId:self->lineSeparator_ withInt:0 withInt:(int) [lineSeparator count]];
    }
    else {
      self->encodeSize_ = KTUtilBase32_BYTES_PER_ENCODED_BLOCK;
      self->lineSeparator_ = nil;
    }
    self->decodeSize_ = self->encodeSize_ - 1;
  }
  return self;
}

- (id)initWithInt:(int)lineLength
    withByteArray:(IOSByteArray *)lineSeparator
      withBoolean:(BOOL)useHex {
  return [self initKTUtilBase32WithInt:lineLength withByteArray:lineSeparator withBoolean:useHex];
}

- (void)decodeWithByteArray:(IOSByteArray *)inArg
                    withInt:(int)inPos
                    withInt:(int)inAvail
withKTUtilBaseNCodec_Context:(KTUtilBaseNCodec_Context *)context {
  if (((KTUtilBaseNCodec_Context *) nil_chk(context))->eof_) {
    return;
  }
  if (inAvail < 0) {
    context->eof_ = YES;
  }
  for (int i = 0; i < inAvail; i++) {
    char b = IOSByteArray_Get(nil_chk(inArg), inPos++);
    if (b == PAD_) {
      context->eof_ = YES;
      break;
    }
    else {
      IOSByteArray *buffer = [self ensureBufferSizeWithInt:decodeSize_ withKTUtilBaseNCodec_Context:context];
      if (b >= 0 && b < (int) [((IOSByteArray *) nil_chk(self->decodeTable_)) count]) {
        int result = IOSByteArray_Get(self->decodeTable_, b);
        if (result >= 0) {
          context->modulus_ = (context->modulus_ + 1) % KTUtilBase32_BYTES_PER_ENCODED_BLOCK;
          context->lbitWorkArea_ = ((long long) (((uint64_t) context->lbitWorkArea_) << KTUtilBase32_BITS_PER_ENCODED_BYTE)) + result;
          if (context->modulus_ == 0) {
            (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = (char) ((context->lbitWorkArea_ >> 32) & KTUtilBaseNCodec_MASK_8BITS);
            (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_ >> 24) & KTUtilBaseNCodec_MASK_8BITS);
            (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_ >> 16) & KTUtilBaseNCodec_MASK_8BITS);
            (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_ >> 8) & KTUtilBaseNCodec_MASK_8BITS);
            (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) (context->lbitWorkArea_ & KTUtilBaseNCodec_MASK_8BITS);
          }
        }
      }
    }
  }
  if (context->eof_ && context->modulus_ >= 2) {
    IOSByteArray *buffer = [self ensureBufferSizeWithInt:decodeSize_ withKTUtilBaseNCodec_Context:context];
    switch (context->modulus_) {
      case 2:
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = (char) ((context->lbitWorkArea_ >> 2) & KTUtilBaseNCodec_MASK_8BITS);
      break;
      case 3:
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = (char) ((context->lbitWorkArea_ >> 7) & KTUtilBaseNCodec_MASK_8BITS);
      break;
      case 4:
      context->lbitWorkArea_ = context->lbitWorkArea_ >> 4;
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = (char) ((context->lbitWorkArea_ >> 8) & KTUtilBaseNCodec_MASK_8BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_) & KTUtilBaseNCodec_MASK_8BITS);
      break;
      case 5:
      context->lbitWorkArea_ = context->lbitWorkArea_ >> 1;
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = (char) ((context->lbitWorkArea_ >> 16) & KTUtilBaseNCodec_MASK_8BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_ >> 8) & KTUtilBaseNCodec_MASK_8BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_) & KTUtilBaseNCodec_MASK_8BITS);
      break;
      case 6:
      context->lbitWorkArea_ = context->lbitWorkArea_ >> 6;
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = (char) ((context->lbitWorkArea_ >> 16) & KTUtilBaseNCodec_MASK_8BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_ >> 8) & KTUtilBaseNCodec_MASK_8BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_) & KTUtilBaseNCodec_MASK_8BITS);
      break;
      case 7:
      context->lbitWorkArea_ = context->lbitWorkArea_ >> 3;
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = (char) ((context->lbitWorkArea_ >> 24) & KTUtilBaseNCodec_MASK_8BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_ >> 16) & KTUtilBaseNCodec_MASK_8BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_ >> 8) & KTUtilBaseNCodec_MASK_8BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = (char) ((context->lbitWorkArea_) & KTUtilBaseNCodec_MASK_8BITS);
      break;
      default:
      @throw [[JavaLangIllegalStateException alloc] initWithNSString:[NSString stringWithFormat:@"Impossible modulus %d", context->modulus_]];
    }
  }
}

- (void)encodeWithByteArray:(IOSByteArray *)inArg
                    withInt:(int)inPos
                    withInt:(int)inAvail
withKTUtilBaseNCodec_Context:(KTUtilBaseNCodec_Context *)context {
  if (((KTUtilBaseNCodec_Context *) nil_chk(context))->eof_) {
    return;
  }
  if (inAvail < 0) {
    context->eof_ = YES;
    if (0 == context->modulus_ && lineLength_ == 0) {
      return;
    }
    IOSByteArray *buffer = [self ensureBufferSizeWithInt:encodeSize_ withKTUtilBaseNCodec_Context:context];
    int savedPos = context->pos_;
    switch (context->modulus_) {
      case 0:
      break;
      case 1:
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = IOSByteArray_Get(nil_chk(encodeTable_), (int) (context->lbitWorkArea_ >> 3) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) ((long long) (((uint64_t) context->lbitWorkArea_) << 2)) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      break;
      case 2:
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = IOSByteArray_Get(nil_chk(encodeTable_), (int) (context->lbitWorkArea_ >> 11) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 6) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 1) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) ((long long) (((uint64_t) context->lbitWorkArea_) << 4)) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      break;
      case 3:
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = IOSByteArray_Get(nil_chk(encodeTable_), (int) (context->lbitWorkArea_ >> 19) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 14) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 9) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 4) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) ((long long) (((uint64_t) context->lbitWorkArea_) << 1)) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      break;
      case 4:
      (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = IOSByteArray_Get(nil_chk(encodeTable_), (int) (context->lbitWorkArea_ >> 27) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 22) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 17) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 12) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 7) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 2) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) ((long long) (((uint64_t) context->lbitWorkArea_) << 3)) & KTUtilBase32_MASK_5BITS);
      (*IOSByteArray_GetRef(buffer, context->pos_++)) = PAD_;
      break;
      default:
      @throw [[JavaLangIllegalStateException alloc] initWithNSString:[NSString stringWithFormat:@"Impossible modulus %d", context->modulus_]];
    }
    context->currentLinePos_ += context->pos_ - savedPos;
    if (lineLength_ > 0 && context->currentLinePos_ > 0) {
      [JavaLangSystem arraycopyWithId:lineSeparator_ withInt:0 withId:buffer withInt:context->pos_ withInt:(int) [((IOSByteArray *) nil_chk(lineSeparator_)) count]];
      context->pos_ += (int) [lineSeparator_ count];
    }
  }
  else {
    for (int i = 0; i < inAvail; i++) {
      IOSByteArray *buffer = [self ensureBufferSizeWithInt:encodeSize_ withKTUtilBaseNCodec_Context:context];
      context->modulus_ = (context->modulus_ + 1) % KTUtilBase32_BYTES_PER_UNENCODED_BLOCK;
      int b = IOSByteArray_Get(nil_chk(inArg), inPos++);
      if (b < 0) {
        b += 256;
      }
      context->lbitWorkArea_ = ((long long) (((uint64_t) context->lbitWorkArea_) << 8)) + b;
      if (0 == context->modulus_) {
        (*IOSByteArray_GetRef(nil_chk(buffer), context->pos_++)) = IOSByteArray_Get(nil_chk(encodeTable_), (int) (context->lbitWorkArea_ >> 35) & KTUtilBase32_MASK_5BITS);
        (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 30) & KTUtilBase32_MASK_5BITS);
        (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 25) & KTUtilBase32_MASK_5BITS);
        (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 20) & KTUtilBase32_MASK_5BITS);
        (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 15) & KTUtilBase32_MASK_5BITS);
        (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 10) & KTUtilBase32_MASK_5BITS);
        (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) (context->lbitWorkArea_ >> 5) & KTUtilBase32_MASK_5BITS);
        (*IOSByteArray_GetRef(buffer, context->pos_++)) = IOSByteArray_Get(encodeTable_, (int) context->lbitWorkArea_ & KTUtilBase32_MASK_5BITS);
        context->currentLinePos_ += KTUtilBase32_BYTES_PER_ENCODED_BLOCK;
        if (lineLength_ > 0 && lineLength_ <= context->currentLinePos_) {
          [JavaLangSystem arraycopyWithId:lineSeparator_ withInt:0 withId:buffer withInt:context->pos_ withInt:(int) [((IOSByteArray *) nil_chk(lineSeparator_)) count]];
          context->pos_ += (int) [lineSeparator_ count];
          context->currentLinePos_ = 0;
        }
      }
    }
  }
}

- (BOOL)isInAlphabetWithByte:(char)octet {
  return octet >= 0 && octet < (int) [((IOSByteArray *) nil_chk(decodeTable_)) count] && IOSByteArray_Get(decodeTable_, octet) != -1;
}

+ (void)initialize {
  if (self == [KTUtilBase32 class]) {
    KTUtilBase32_CHUNK_SEPARATOR_ = [IOSByteArray arrayWithBytes:(char[]){ 0x000d, 0x000a } count:2];
    KTUtilBase32_DECODE_TABLE_ = [IOSByteArray arrayWithBytes:(char[]){ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 } count:91];
    KTUtilBase32_ENCODE_TABLE_ = [IOSByteArray arrayWithBytes:(char[]){ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '2', '3', '4', '5', '6', '7' } count:32];
    KTUtilBase32_HEX_DECODE_TABLE_ = [IOSByteArray arrayWithBytes:(char[]){ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -1, -1, -1, -1, -1, -1, -1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 } count:88];
    KTUtilBase32_HEX_ENCODE_TABLE_ = [IOSByteArray arrayWithBytes:(char[]){ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V' } count:32];
  }
}

- (void)copyAllFieldsTo:(KTUtilBase32 *)other {
  [super copyAllFieldsTo:other];
  other->decodeSize_ = decodeSize_;
  other->decodeTable_ = decodeTable_;
  other->encodeSize_ = encodeSize_;
  other->encodeTable_ = encodeTable_;
  other->lineSeparator_ = lineSeparator_;
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "decodeWithByteArray:withInt:withInt:withKTUtilBaseNCodec_Context:", NULL, "V", 0x0, NULL },
    { "encodeWithByteArray:withInt:withInt:withKTUtilBaseNCodec_Context:", NULL, "V", 0x0, NULL },
    { "isInAlphabetWithByte:", NULL, "Z", 0x1, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "BITS_PER_ENCODED_BYTE_", NULL, 0x1a, "I" },
    { "BYTES_PER_ENCODED_BLOCK_", NULL, 0x1a, "I" },
    { "BYTES_PER_UNENCODED_BLOCK_", NULL, 0x1a, "I" },
    { "CHUNK_SEPARATOR_", NULL, 0x1a, "LIOSByteArray" },
    { "DECODE_TABLE_", NULL, 0x1a, "LIOSByteArray" },
    { "ENCODE_TABLE_", NULL, 0x1a, "LIOSByteArray" },
    { "HEX_DECODE_TABLE_", NULL, 0x1a, "LIOSByteArray" },
    { "HEX_ENCODE_TABLE_", NULL, 0x1a, "LIOSByteArray" },
    { "MASK_5BITS_", NULL, 0x1a, "I" },
    { "decodeSize_", NULL, 0x12, "I" },
    { "decodeTable_", NULL, 0x12, "LIOSByteArray" },
    { "encodeSize_", NULL, 0x12, "I" },
    { "encodeTable_", NULL, 0x12, "LIOSByteArray" },
    { "lineSeparator_", NULL, 0x12, "LIOSByteArray" },
  };
  static J2ObjcClassInfo _KTUtilBase32 = { "Base32", "com.kloudtek.util", NULL, 0x1, 3, methods, 14, fields, 0, NULL};
  return &_KTUtilBase32;
}

@end
