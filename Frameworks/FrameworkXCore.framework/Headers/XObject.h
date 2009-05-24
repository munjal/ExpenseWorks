// ****************************************
// Generated from .m file
// ****************************************

#import <Foundation/Foundation.h>

@interface XObject : NSObject {
    id _attributes;
    id _delegations;
}
- (id) init;
- (id) initWithCoder: (id)coder;
- (void) dealloc;
+ (id) attrAccessors: (id)firstItem, ...;
+ (id) attrReaders: (id)firstItem, ...;
+ (id) attrWriters: (id)firstItem, ...;
- (void) encodeWithCoder: (id)coder;
- (id) setValue: (id)value forUndefinedKey: (id)key;
+ (id) _attrAccessors: (id)accessors;
+ (id) _attrReaders: (id)readers;
+ (id) _attrWriters: (id)writers;
- (id) _attributes;
- (id) _attributeSetterWithoutSetAndColon: (id)method;
- (id) _delegates;
- (BOOL) _hasDelegations;
- (id) _getHashAttrByCmd;
- (id) _setHashAttrByCmd: (id)value;
- (id) _delegations;
@end
