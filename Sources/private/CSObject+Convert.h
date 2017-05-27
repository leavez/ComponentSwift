//
//  CSViewAttribute+Inner.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <ComponentKit/ComponentKit.h>
#import "macro.h"
#import "CSViewAttributes.h"
#import "CSGestureAttribute.h"
#import "CSSize.h"
#import "CSTextAttributes.h"
#import "CSStackLayoutComponent.h"
#import "CSScope.h"
#import "CSComponentAnimation.h"

#define EXTENSION(__class__, __content__) \
@interface __class__ () \
__content__ \
@end


EXTENSION(CSViewClass,
          - (CKComponentViewClass)convert;
          )
EXTENSION(CSViewAttribute,
          - (CKComponentViewAttribute)convert;
          )
EXTENSION(CSViewAttributeValue,
          - (CKComponentViewAttributeValue)convert;
          )
EXTENSION(CSViewAttributeMap,
          - (CKViewComponentAttributeValueMap)convert;
          )

EXTENSION(CSAccessibilityTextAttribute,
          - (CKComponentAccessibilityTextAttribute)convert;
          )
EXTENSION(CSAccessibilityContext,
          - (CKComponentAccessibilityContext)convert;
          )
EXTENSION(CSViewConfiguration,
          - (CKComponentViewConfiguration)convert;
          )


EXTENSION(CSDimension,
          - (CKRelativeDimension)convert;
          )
EXTENSION(CSSize,
          - (CKComponentSize)convert;
          )

EXTENSION(CSTextAttributes ,
          - (CKTextKitAttributes)convert;
          )
EXTENSION(CSStackLayoutStyle ,
          - (CKStackLayoutComponentStyle)convert;
          )
EXTENSION(CSStackLayoutChild ,
          - (CKStackLayoutComponentChild)convert;
          )


EXTENSION(CSScope ,
          - (Class)cls;
          - (NSString *)identifier;
          - (id (^)())initialStateCreator;
          )

EXTENSION(CSComponentAnimation ,
          - (CKComponentAnimation)convert;
          )



