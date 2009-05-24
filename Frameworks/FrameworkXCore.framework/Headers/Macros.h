#define boolObject(value)\
  [NSNumber numberWithBool:value]

#define doubleObject(value)\
  [NSNumber numberWithDouble:value]

#define doubleValue(value)\
  [value doubleValue]

#define falseObject\
  [NSNumber falseObj]

#define floatObject(value)\
  [NSNumber numberWithFloat:value]
  
#define intObject(value)\
  [NSNumber numberWithInteger:value]
  
#define intValue(value)\
  [value integerValue]

#define isNilOrNull(obj) \
 (obj == nil || [obj isEqual:nullObject])

#define isNotNilNorNull(obj) \
 (obj && ![obj isEqual:[NSNull null]])

#define nullObject \
  [NSNull null]

#define trueObject\
  [NSNumber trueObj]

#define True \
  [NSNumber trueObj]

#define False \
  [NSNumber falseObj]

// todo: z: needs work; only works for parameterless methods  
#define ALIAS(new, old) \
	- (id) new	 {			\
	  return [self old];			\
	}
