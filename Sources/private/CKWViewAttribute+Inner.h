//
//  CKWViewAttribute+Inner.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <ComponentKit/ComponentKit.h>
#import "macro.h"
#import "CKWViewAttributes.h"
#import "CKWGestureAttribute.h"
#import "CKWSize.h"
#import "CKWTextAttributes.h"


EXTENSION(CKWViewClass,
          - (CKComponentViewClass)convert;
          )
EXTENSION(CKWViewAttribute,
          - (CKComponentViewAttribute)convert;
          )
EXTENSION(CKWViewAttributeValueType,
          - (CKComponentViewAttributeValue)convert;
          )

EXTENSION(CKWAccessibilityTextAttribute,
          - (CKComponentAccessibilityTextAttribute)convert;
          )
EXTENSION(CKWAccessibilityContext,
          - (CKComponentAccessibilityContext)convert;
          )
EXTENSION(CKWViewConfiguration,
          - (CKComponentViewConfiguration)convert;
          )


EXTENSION(CKWDimension,
          - (CKRelativeDimension)convert;
          )
EXTENSION(CKWSize,
          - (CKComponentSize)convert;
          )

EXTENSION(CKWTextAttributes ,
          - (CKTextKitAttributes)convert;
          )


CKViewComponentAttributeValueMap convertViewAttributesMap(CKWViewAttributeMap *map);



