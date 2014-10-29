//
//  TBRSketchLangFix.m
//  SketchLangFix
//
//  Created by Andrey on 18/10/14.
//  Copyright (c) 2014 Turbobabr. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TBRSketchLangFix.h"
#import <objc/runtime.h>

@implementation TBRSketchLangFix

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [TBRSketchLangFix swizzleMethod:@selector(keyDown:) withMethod:@selector(keyDown:) sClass:[self class] pClass:NSClassFromString(@"MSContentDrawView") originalMethodPrefix:@"originalMSContentDrawView_"];
        
        // Special case for Zoom Tool since it wants keyUp too.
        
        [TBRSketchLangFix swizzleMethod:@selector(keyUp:) withMethod:@selector(keyUp:) sClass:[self class] pClass:NSClassFromString(@"MSContentDrawView") originalMethodPrefix:@"originalMSContentDrawView_"];
       
    });
}

+(BOOL)swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ sClass:(Class)sClass pClass:(Class)pClass originalMethodPrefix:(NSString*)prefix {
    
    SEL originalSelector = origSel_;
    SEL swizzledSelector = altSel_;
    
    Method originalMethod = class_getInstanceMethod(pClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(sClass, swizzledSelector);
    
    class_addMethod(sClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    NSString* methodName=[prefix stringByAppendingString:NSStringFromSelector(origSel_)];
    if([[methodName componentsSeparatedByString:@":"] count]<3) {
        methodName=[methodName stringByReplacingOccurrencesOfString:@":" withString:@""];
    }
    
    class_addMethod(pClass,
                    NSSelectorFromString(methodName),
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    return true;
}

- (void)keyDown:(NSEvent*)event; {
    
    NSDictionary* mutableKeycodesD=
    @{
      @"11" : @"b", // B - Toggle border
      @"3"  : @"f", // F - Toggle fill
      @"9"  : @"v", // V - Vector tool
      @"35" : @"p", // P - Pencil tool
      @"17" : @"t", // T - Text tool
      @"0"  : @"a", // A - Artoboard tool
      @"1"  : @"s", // S - Slice tool
      @"37" : @"l", // L - Line tool
      @"15" : @"r", // R - Rectangle tool
      @"31" : @"o", // O - Oval tool
      @"32" : @"u", // U - Rounded Rect tool
      @"6"  : @"z"  // Z - Zoom tool
      };
    
    NSString* preferredCharacter=[mutableKeycodesD valueForKey:[[NSNumber numberWithUnsignedShort:event.keyCode] stringValue]];
    if(preferredCharacter!=nil && !event.isARepeat && event.characters.length==1 && /*[NSEvent modifierFlags]==0 &&*/ ![preferredCharacter isEqualToString:[event.characters lowercaseString]]) {
        event=[NSEvent keyEventWithType:event.type location:event.locationInWindow modifierFlags:event.modifierFlags timestamp:event.timestamp windowNumber:event.windowNumber context:event.context characters:preferredCharacter charactersIgnoringModifiers:preferredCharacter isARepeat:event.isARepeat keyCode:event.keyCode];
    }
    
    SEL sel=NSSelectorFromString(@"originalMSContentDrawView_keyDown");
    if([self respondsToSelector:sel]) {
        [self performSelector:sel withObject:event];
    }
};

- (void)keyUp:(NSEvent*)event; {
    
    printf("Key up event!");
    
    NSDictionary* mutableKeycodesD=
    @{
      @"6"  : @"z"  // Z - Zoom tool
      };
    
    NSString* preferredCharacter=[mutableKeycodesD valueForKey:[[NSNumber numberWithUnsignedShort:event.keyCode] stringValue]];
    if(preferredCharacter!=nil && !event.isARepeat && event.characters.length==1 && /*[NSEvent modifierFlags]==0 &&*/ ![preferredCharacter isEqualToString:[event.characters lowercaseString]]) {
        event=[NSEvent keyEventWithType:event.type location:event.locationInWindow modifierFlags:event.modifierFlags timestamp:event.timestamp windowNumber:event.windowNumber context:event.context characters:preferredCharacter charactersIgnoringModifiers:preferredCharacter isARepeat:event.isARepeat keyCode:event.keyCode];
    }
    
    SEL sel=NSSelectorFromString(@"originalMSContentDrawView_keyUp");
    if([self respondsToSelector:sel]) {
        [self performSelector:sel withObject:event];
    }
};


@end
