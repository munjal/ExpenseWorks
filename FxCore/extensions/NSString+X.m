#import "NSString+X.h"

#import "XCore.h"
#import "RegexKitLite.h"

/*
@interface NSString (X)
@end
*/

@implementation NSString (X)

#define k_encyrption_key @"I love my kitty"

// initializer/class factory methods/constructors/destructor

+ (id) empty {
  return [self string];
}

+ (id) from: (id)value {
	return [self stringWithString:value];
}

+ (id) fromCString: (const char*)string {
  return [[[self alloc] initWithCString:string encoding:NSUTF8StringEncoding] autorelease];
}

+ (id) fromContentsAtPath: (id)path {  
  id error = nil;
  id result = [[[self alloc] initWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&error] autorelease];
  if (error) {
    @throw [NSException with:[XString withFormat:@"An error ocurred while reading the file at %@. Error: %@", path, error, nil]];
  }
  return result;
}

+ (id) fromData: (id)data {
  return [self withBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];  
}

+ (id) fromSelector: (SEL)selector {
  return [[[self alloc] initWithFormat:@"%s", selector, nil] autorelease];
}

+ (id) with: (id)string, ... {
  va_list ap; 
  va_start(ap, string); 
  id str = [self _with:string vaList:ap];
  va_end(ap);
  return str;
}

+ (id) withBytes:(const void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding {
  return [[[self alloc] initWithBytes:bytes length:length encoding:encoding] autorelease];
}

+ (id) withBytesNoCopy:(void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding freeWhenDone:(BOOL)flag {
  return [[[self alloc] initWithBytesNoCopy:bytes length:length encoding:encoding freeWhenDone:flag] autorelease];
}

+ (id) withFormat: (id) format, ... {
  va_list argList; 
  va_start(argList, format);
  id str = [self withFormat:format arguments:argList];
  va_end(argList);  
  return str;
}

+ (id) withFormat: (id) format arguments:(va_list)argList {
  return [[[self alloc] initWithFormat:format arguments:argList] autorelease];
}

// public instance methods

// z: this method is shared by NSMutableString and its descendants; mutable strings should use appendString because it's faster
// the reason NSMutable string doesn't have its own implementation of this method is because when it does, immutable strings inexplicably call that mutable method (and barf) instead of this one; I blame class clusters and NSCFString for being written poorly
- (id) append: (id)str {
  return [XString with:self, str, nil];
}

- (const char*) asCString {
  return [self UTF8String];
}

- (id) asCamelCase {
  if ([self isEmpty]) return @"";
  id withHumps = [self _humpsAtUnderscoresAndHyphens];  
  return [withHumps stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[withHumps substringToIndex:1] lowercaseString]];
}

- (id) asDoubleObject {
  return [NSNumber double:[self doubleValue]];  
}

- (id) asIntObject {
  return [NSNumber int:[self intValue]];
}

- (id) asPascalCase {
  if ([self isEmpty]) return @"";  
  id withHumps = [self _humpsAtUnderscoresAndHyphens];
  return [withHumps stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[withHumps substringToIndex:1] uppercaseString]];
}

- (id) asRubyCase {
  return [[[self withUnderscoresAtHyphens] withUnderscoresAtHumps] downcase];
}

- (SEL) asSelector {
  return NSSelectorFromString(self);
}

- (id) asXmlCase {
  return [[[self asCamelCase] hyphensAtHumps] downcase];
}

- (BOOL) contains: (id)str {
  if ([self rangeOfString:str].location == NSNotFound) {
    return NO;
  }
  return YES;
}

- (int) countOccurrences: (char)character {
  int cursor = 0;
  int count = 0;
  while (cursor < [self length]) {
    if ([self characterAtIndex:cursor] == character) {
      count++;
    }
    cursor++;
  }
  return count;
}

- (id) decodeBase64 {	
  const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  
	if ([self length] == 0) return [NSData data];
	
	static char *decodingTable = NULL;
	if (decodingTable == NULL) {
		decodingTable = malloc(256);
		if (decodingTable == NULL) return nil;
		memset(decodingTable, CHAR_MAX, 256);
		NSUInteger i;
		for (i = 0; i < 64; i++) {
			decodingTable[(short)encodingTable[i]] = i;
		}
	}
	
	const char *characters = [self cStringUsingEncoding:NSASCIIStringEncoding];
	if (characters == NULL) return nil;     //  Not an ASCII string!
	char *bytes = malloc((([self length] + 3) / 4) * 3);
	if (bytes == NULL) return nil;
	NSUInteger length = 0;
	NSUInteger i = 0;
	
	while (YES) {
		char buffer[4];
		short bufferLength;
		for (bufferLength = 0; bufferLength < 4; i++) {
			if (characters[i] == '\0') break;
			if (isspace(characters[i]) || characters[i] == '=') continue;
			buffer[bufferLength] = decodingTable[(short)characters[i]];
			if (buffer[bufferLength++] == CHAR_MAX) {     //  Illegal character!
				free(bytes);
				return nil;
			}
		}
		
		if (bufferLength == 0) break;
		if (bufferLength == 1) {      //  At least two characters are needed to produce one byte!
			free(bytes);
			return nil;
		}
		
		//  Decode the characters in the buffer to bytes.
		bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
		if (bufferLength > 2)
			bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
		if (bufferLength > 3)
			bytes[length++] = (buffer[2] << 6) | buffer[3];
	}
	
	realloc(bytes, length);
	return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (id) decrypt {
  return self;
}

- (id) copyReplacing: (id)toMatch with:(id)replacement {
  return [self stringByReplacingOccurrencesOfString:toMatch withString:replacement];
}

- (id) downcase {
  return [self lowercaseString];
}

- (BOOL) endsWith: (id)string {
  NSRange range = [self rangeOfString:string];
  if (range.location + range.length == [self length]) {
    return YES;      
  }
  return NO;
}

- (id) encrypt {
  return self;
}

- (id) gsub: (id)regex with: (id)replacement {
  return [self _gsub:regex with:replacement modifiers:[XHash empty]];
}

- (id) gsub: (id)regex with: (id)replacement modifiers: (id)firstMatchNumber, ... {
  va_list argList; 
  va_start(argList, firstMatchNumber);
  id modifiers = [XHash with:firstMatchNumber vaList:argList];
  return [self _gsub:regex with:replacement modifiers:modifiers];
}

- (id) hyphensAtHumps {
  return [self gsub:@"([a-z]+)([A-Z]+)" with:@"\\1-\\2"];
}

- (id) inspect {
	return [XString withFormat:@"\"%@\"", self];
}

- (BOOL) isEmpty {
  if ([[self trimmed] length] == 0) return YES;
  return NO;
}

- (BOOL) matches: (id)regex {
  return [self isMatchedByRegex:regex];
}

- (id) pluralize {
  if ([self characterAtIndex: [self length] - 1] != 's') {  
    return [XString withFormat:@"%@s", self];
  }
  return self;
}

- (id) singularize {
  if ([self characterAtIndex: [self length] - 1] == 's') {
    return [self substringToIndex:[self length] - 1];  
  }
  return self;
}

- (id) split: (id)separator {
  return [self componentsSeparatedByString:separator];
}

- (id) splitIntoLinesNoLongerThan: (int)lineLength {
  id result = [XArray empty];
  id words = [self split:@" "]; // z: this returns immutable strings even if called in NSMutableString or one of its descendants
  
  int cursor = 0;
  for (id word in words) {
    if (![result at:cursor]) {
      [result add:[XString from:word]];
    }
    else if (([[result at:cursor] length] + [word length] + 1) > lineLength) {
      cursor++;
      [result add: [XString from:word]];
    }
    else {
      [result replaceObjectAtIndex:cursor withObject:[[result at:cursor] append:[XString withFormat:@" %@", word, nil]]];
    }
  }
  return result;
}

- (id) stringValue {
  return self;
}

- (id) substring: (int)startIndex length: (int)length {
  NSRange range;
  range.location = startIndex;
  range.length = length;  
  if (startIndex > [self length]) {
    return @"";
  }
  else if ((startIndex + length) > [self length]) {
    range.length = [self length] - startIndex;
  }
  return [self substringWithRange:range];
}

- (id) trimmed {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (id) withUnderscoresAtHumps {
  return [self gsub:@"([a-z]+)([A-Z]+)" with:@"\\1_\\2"];
}

- (id) withUnderscoresAtHyphens {
  return [self gsub:@"[-]([a-zA-Z])" with:@"_\\1"];
}

- (id) urlEncoded {
  return [self stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
}

- (id) withoutWhitespace {
  return [self gsub:@"\\s" with:@""];  
}

// protected class methods

+ (id) _with: (id)first vaList:(va_list)ap {
  id str = [XString empty];
  id part;
  if (first) {
    [str append:first];
    while (part = va_arg(ap, id)) {
      [str append:part];
    }
  }
  return [self stringWithString:str];
}

- (id) _gsub: (id)regex with: (id)replacement modifiers: (id)modifiersHash {
  id result = [XString empty];
  int pos = 0;
  while (pos < [self length] && [self isMatchedByRegex:regex inRange:NSMakeRange(pos, [self length] - pos)]) {
    NSRange matchRange = [self rangeOfRegex:regex inRange:NSMakeRange(pos, [self length] - pos)];
    int match_pos = matchRange.location;
    int match_length = matchRange.length;
    if (match_pos > pos) {
      [result append:[self substring:pos length:(match_pos - pos)]];
    }
    id replacementString = replacement;
    for (int i = 1; i <= [NSString captureCountForRegex:regex]; i++) {
      id replace = [XString withFormat:@"\\%d", i, nil];
      id match = [self stringByMatching:regex options:RKLNoOptions inRange:NSMakeRange(pos, [self length] - pos) capture:i error:nil];
      id modifierKey = [XString withFormat:@"%d", i];
      if ([modifiersHash hasKey:modifierKey]) {	
        match = [match performSelector:NSSelectorFromString([modifiersHash get:modifierKey])];
      }       
      replacementString = [replacementString copyReplacing:replace with:match];
    }
    [result append:replacementString];
    pos = match_pos + match_length;
  }
  [result append:[self substringFromIndex:pos]];
  return result;    
}

- (id) _humpsAtUnderscoresAndHyphens {
  id result = [self gsub:@"[_-]([a-z])" with:@"\\1" modifiers:@"1", @"uppercaseString", nil];
  char lastChar = [result characterAtIndex:([result length] - 1)];
  if (lastChar == '-' || lastChar == '_') {
    result = [result substring:0 length:([result length] - 1)];
  }
  return result;
}
@end
