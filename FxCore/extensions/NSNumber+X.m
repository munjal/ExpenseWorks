#import "NSNumber+X.h"

#import "XCore.h"

/*
@interface NSNumber (X)
@end
*/

@implementation NSNumber (X)

// public class methods

+ (id) int: (int) value {
  return [NSNumber numberWithInt:value];
}

+ (id) double: (double) value {
  return [NSNumber numberWithDouble:value];
}

+ (id) falseObj {
  return [NSNumber int:0];
}

+ (id) doubleFromString: (id)string {
  return [NSNumber double:[string doubleValue]];  
}

+ (id) intFromString: (id)string {
  return [NSNumber int:[string intValue]];  
}

+ (id) trueObj {
  return [NSNumber int:1];
}

// public instance methods

- (BOOL) asBool {
  return [self isEqual:[NSNumber trueObj]];
}

- (id) asString {
  return [XString from:[self stringValue]];
}

- (id) inspect {
	return self;
}

- (BOOL) isFalse {
  return [self isEqual:[NSNumber falseObj]];
}

- (BOOL) isGreaterThan: (id)other {
  NSComparisonResult comparisonResult = [self compare:other];
  if (comparisonResult == NSOrderedDescending) {
    return YES;
  }
  return NO;
}

- (BOOL) isGreaterThanOrEqualTo: (id)other {
  NSComparisonResult comparisonResult = [self compare:other];
  if (comparisonResult == NSOrderedDescending || comparisonResult == NSOrderedSame) {
    return YES;
  }
  return NO;  
}

- (BOOL) isLessThan: (id)other {
  NSComparisonResult comparisonResult = [self compare:other];
  if (comparisonResult == NSOrderedAscending) {
    return YES;
  }
  return NO;    
}

- (BOOL) isLessThanOrEqualTo: (id)other {
  NSComparisonResult comparisonResult = [self compare:other];
  if (comparisonResult == NSOrderedAscending || comparisonResult == NSOrderedSame) {
    return YES;
  }
  return NO;      
}

- (BOOL) isTrue {
  return [self isEqual:[NSNumber trueObj]];
}

- (id) plusInt: (int)integer {
  return [NSNumber int:[self intValue] + integer];
}

- (id) plus: (id)other {
  return [NSNumber int:[self intValue] + [other intValue]];
}

@end
