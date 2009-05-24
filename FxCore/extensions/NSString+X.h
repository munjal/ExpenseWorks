// ****************************************
// Generated from .m file
// ****************************************


@interface NSString (X)
+ (id) empty;
+ (id) from: (id)value;
+ (id) fromCString: (const char*)string;
+ (id) fromContentsAtPath: (id)path;
+ (id) fromData: (id)data;
+ (id) fromSelector: (SEL)selector;
+ (id) with: (id)string, ...;
+ (id) withBytes:(const void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding;
+ (id) withBytesNoCopy:(void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding freeWhenDone:(BOOL)flag;
+ (id) withFormat: (id) format, ...;
+ (id) withFormat: (id) format arguments:(va_list)argList;
- (id) append: (id)str;
- (const char*) asCString;
- (id) asCamelCase;
- (id) asDoubleObject;
- (id) asIntObject;
- (id) asPascalCase;
- (id) asRubyCase;
- (SEL) asSelector;
- (id) asXmlCase;
- (BOOL) contains: (id)str;
- (int) countOccurrences: (char)character;
- (id) decodeBase64;
- (id) decrypt;
- (id) copyReplacing: (id)toMatch with:(id)replacement;
- (id) downcase;
- (BOOL) endsWith: (id)string;
- (id) encrypt;
- (id) gsub: (id)regex with: (id)replacement;
- (id) gsub: (id)regex with: (id)replacement modifiers: (id)firstMatchNumber, ...;
- (id) hyphensAtHumps;
- (id) inspect;
- (BOOL) isEmpty;
- (BOOL) matches: (id)regex;
- (id) pluralize;
- (id) singularize;
- (id) split: (id)separator;
- (id) splitIntoLinesNoLongerThan: (int)lineLength;
- (id) stringValue;
- (id) substring: (int)startIndex length: (int)length;
- (id) trimmed;
- (id) withUnderscoresAtHumps;
- (id) withUnderscoresAtHyphens;
- (id) urlEncoded;
- (id) withoutWhitespace;
+ (id) _with: (id)first vaList:(va_list)ap;
- (id) _gsub: (id)regex with: (id)replacement modifiers: (id)modifiersHash;
- (id) _humpsAtUnderscoresAndHyphens;
@end
