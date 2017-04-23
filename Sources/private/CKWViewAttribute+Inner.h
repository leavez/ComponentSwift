//
//  CKWViewAttribute+Inner.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import "CKWViewAttributes.h"
#import "CKWGestureAttribute.h"
#import "CKWSize.h"
#import <ComponentKit/ComponentKit.h>
#import "macro.h"

EXTENSION(CKWViewClass,
          - (CKComponentViewClass)convert;
          )
EXTENSION(CKWViewAttribute,
          - (CKComponentViewAttribute)convert;
          )
EXTENSION(CKWGestureAttribute,
          - (CKComponentViewAttributeValue)convert;
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


