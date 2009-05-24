
#import <Foundation/Foundation.h>


#define nullObject \
  [NSNull null]

#define isNilOrNull(obj) \
 (obj == nil || [obj isEqual:nullObject])

#define isNotNilNorNull(obj) \
 (obj && ![obj isEqual:[NSNull null]])


@interface NSNull (X)

@end


