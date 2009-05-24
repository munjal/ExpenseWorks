// ****************************************
// Generated from .m file
// ****************************************


@interface NSMutableDictionary (X)
+ (id) withVargs: (id)firstKey, ...;
+ (id) with: (id)firstKey vaList: (va_list)argList;
- (id) add: (id)key value:(id)value;
- (id) addKey: (id)key withValue:(id)value;
- (id) clone;
- (id) clear;
- (id) delete: (id)key;
- (id) dup;
- (id) empty;
- (BOOL) hasKey: (id)key;
- (id) merge: (id)hash;
- (id) remove: (id)key;
- (id) set: (id)key to:(id)value;
@end
