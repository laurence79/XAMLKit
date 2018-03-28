//
//  UIView+Flexbox.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "UIView+Flexbox.h"

#import <objc/runtime.h>

@interface CSSNodeBridge : NSObject
@property (nonatomic, assign, readonly) CSSNodeRef cnode;
@end

@implementation CSSNodeBridge

+ (void)initialize
{
    CSSLayoutSetExperimentalFeatureEnabled(CSSExperimentalFeatureWebFlexBasis, true);
}

- (instancetype)init
{
    if ([super init]) {
        _cnode = CSSNodeNew();
    }
    
    return self;
}

- (void)dealloc
{
    CSSNodeFree(_cnode);
}
@end

@implementation UIView (Flexbox)

- (BOOL)css_usesFlexbox
{
    NSNumber *usesFlexbox = objc_getAssociatedObject(self, @selector(css_usesFlexbox));
    return [usesFlexbox boolValue];
}

- (void)setCss_usesFlexbox:(BOOL)enabled
{
    objc_setAssociatedObject(
                             self,
                             @selector(css_usesFlexbox),
                             @(enabled),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)css_includeInLayout
{
    NSNumber *includeInLayout = objc_getAssociatedObject(self, @selector(css_includeInLayout));
    return (includeInLayout != nil) ? [includeInLayout boolValue] : YES;
}

- (void)setCss_includeInLayout:(BOOL)includeInLayout
{
    objc_setAssociatedObject(
                             self,
                             @selector(css_includeInLayout),
                             @(includeInLayout),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#define ACCESSOR(PROPLOWER, PROPINITIAL, TYPE) \
- (TYPE)css_##PROPLOWER { \
return CSSNodeStyleGet##PROPINITIAL([self cssNode]); \
} \
- (void)setCss_##PROPLOWER:(TYPE)PROPLOWER \
{ \
CSSNodeStyleSet##PROPINITIAL([self cssNode], PROPLOWER); \
} \

ACCESSOR(direction, Direction, CSSDirection)
ACCESSOR(flexDirection, FlexDirection, CSSFlexDirection)
ACCESSOR(justifyContent, JustifyContent, CSSJustify)
ACCESSOR(alignContent, AlignContent, CSSAlign)
ACCESSOR(alignItems, AlignItems, CSSAlign)
ACCESSOR(alignSelf, AlignSelf, CSSAlign)
ACCESSOR(positionType, PositionType, CSSPositionType)
ACCESSOR(flexWrap, FlexWrap, CSSWrap)
ACCESSOR(flexGrow, FlexGrow, CGFloat)
ACCESSOR(flexShrink, FlexShrink, CGFloat)
ACCESSOR(flexBasis, FlexBasis, CGFloat)


#define EDGE_ACCESSOR(PROPLOWER, PROPINITIAL, EDGE) \
- (CGFloat)css_##PROPLOWER##EDGE { \
return CSSNodeStyleGet##PROPINITIAL([self cssNode], CSSEdge##EDGE); \
} \
- (void)setCss_##PROPLOWER##EDGE:(CGFloat)PROPLOWER \
{ \
CSSNodeStyleSet##PROPINITIAL([self cssNode], CSSEdge##EDGE, PROPLOWER); \
} \

EDGE_ACCESSOR(position, Position, All)
EDGE_ACCESSOR(position, Position, Left)
EDGE_ACCESSOR(position, Position, Top)
EDGE_ACCESSOR(position, Position, Right)
EDGE_ACCESSOR(position, Position, Bottom)
EDGE_ACCESSOR(position, Position, Start)
EDGE_ACCESSOR(position, Position, End)
EDGE_ACCESSOR(position, Position, Horizontal)
EDGE_ACCESSOR(position, Position, Vertical)

EDGE_ACCESSOR(margin, Margin, All)
EDGE_ACCESSOR(margin, Margin, Left)
EDGE_ACCESSOR(margin, Margin, Top)
EDGE_ACCESSOR(margin, Margin, Right)
EDGE_ACCESSOR(margin, Margin, Bottom)
EDGE_ACCESSOR(margin, Margin, Start)
EDGE_ACCESSOR(margin, Margin, End)
EDGE_ACCESSOR(margin, Margin, Horizontal)
EDGE_ACCESSOR(margin, Margin, Vertical)

EDGE_ACCESSOR(padding, Padding, All)
EDGE_ACCESSOR(padding, Padding, Left)
EDGE_ACCESSOR(padding, Padding, Top)
EDGE_ACCESSOR(padding, Padding, Right)
EDGE_ACCESSOR(padding, Padding, Bottom)
EDGE_ACCESSOR(padding, Padding, Start)
EDGE_ACCESSOR(padding, Padding, End)
EDGE_ACCESSOR(padding, Padding, Horizontal)
EDGE_ACCESSOR(padding, Padding, Vertical)


ACCESSOR(width, Width, CGFloat)
ACCESSOR(height, Height, CGFloat)
ACCESSOR(minWidth, MinWidth, CGFloat)
ACCESSOR(minHeight, MinHeight, CGFloat)
ACCESSOR(maxWidth, MaxWidth, CGFloat)
ACCESSOR(maxHeight, MaxHeight, CGFloat)
ACCESSOR(aspectRatio, AspectRatio, CGFloat)


- (NSUInteger)css_numberOfChildren
{
    return CSSNodeChildCount([self cssNode]);
}

#pragma mark - Layout and Sizing

- (CSSDirection)css_resolvedDirection
{
    return CSSNodeLayoutGetDirection([self cssNode]);
}

- (void)css_applyLayout
{
    [self calculateLayoutWithSize:self.bounds.size];
    CSSApplyLayoutToViewHierarchy(self);
}

- (CGSize)css_intrinsicSize
{
    const CGSize constrainedSize = {
        .width = CSSUndefined,
        .height = CSSUndefined,
    };
    return [self calculateLayoutWithSize:constrainedSize];
}

#pragma mark - Private

- (CSSNodeRef)cssNode
{
    CSSNodeBridge *node = objc_getAssociatedObject(self, @selector(cssNode));
    if (!node) {
        node = [CSSNodeBridge new];
        CSSNodeSetContext(node.cnode, (__bridge void *) self);
        objc_setAssociatedObject(self, @selector(cssNode), node, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return node.cnode;
}

- (CGSize)calculateLayoutWithSize:(CGSize)size
{
    NSAssert([NSThread isMainThread], @"CSS Layout calculation must be done on main.");
    NSAssert([self css_usesFlexbox], @"CSS Layout is not enabled for this view.");
    
    CSSAttachNodesFromViewHierachy(self);
    
    const CSSNodeRef node = [self cssNode];
    CSSNodeCalculateLayout(
                           node,
                           size.width,
                           size.height,
                           CSSNodeStyleGetDirection(node));
    
    return (CGSize) {
        .width = CSSNodeLayoutGetWidth(node),
        .height = CSSNodeLayoutGetHeight(node),
    };
}

static CSSSize CSSMeasureView(
                              CSSNodeRef node,
                              float width,
                              CSSMeasureMode widthMode,
                              float height,
                              CSSMeasureMode heightMode)
{
    const CGFloat constrainedWidth = (widthMode == CSSMeasureModeUndefined) ? CGFLOAT_MAX : width;
    const CGFloat constrainedHeight = (heightMode == CSSMeasureModeUndefined) ? CGFLOAT_MAX: height;
    
    UIView *view = (__bridge UIView*) CSSNodeGetContext(node);
    const CGSize sizeThatFits = [view sizeThatFits:(CGSize) {
        .width = constrainedWidth,
        .height = constrainedHeight,
    }];
    
    return (CSSSize) {
        .width = CSSSanitizeMeasurement(constrainedWidth, sizeThatFits.width, widthMode),
        .height = CSSSanitizeMeasurement(constrainedHeight, sizeThatFits.height, heightMode),
    };
}

static CGFloat CSSSanitizeMeasurement(
                                      CGFloat constrainedSize,
                                      CGFloat measuredSize,
                                      CSSMeasureMode measureMode)
{
    CGFloat result;
    if (measureMode == CSSMeasureModeExactly) {
        result = constrainedSize;
    } else if (measureMode == CSSMeasureModeAtMost) {
        result = MIN(constrainedSize, measuredSize);
    } else {
        result = measuredSize;
    }
    
    return result;
}

static void CSSAttachNodesFromViewHierachy(UIView *view) {
    CSSNodeRef node = [view cssNode];
    
    // Only leaf nodes should have a measure function
    if (![view css_usesFlexbox] || view.subviews.count == 0) {
        CSSNodeSetMeasureFunc(node, CSSMeasureView);
        CSSRemoveAllChildren(node);
    } else {
        CSSNodeSetMeasureFunc(node, NULL);
        
        // Create a list of all the subviews that we are going to use for layout.
        NSMutableArray<UIView *> *subviewsToInclude = [[NSMutableArray alloc] initWithCapacity:view.subviews.count];
        for (UIView *subview in view.subviews) {
            if ([subview css_includeInLayout]) {
                [subviewsToInclude addObject:subview];
            }
        }
        
        BOOL shouldReconstructChildList = NO;
        if (CSSNodeChildCount(node) != subviewsToInclude.count) {
            shouldReconstructChildList = YES;
        } else {
            for (int i = 0; i < subviewsToInclude.count; i++) {
                if (CSSNodeGetChild(node, i) != [subviewsToInclude[i] cssNode]) {
                    shouldReconstructChildList = YES;
                    break;
                }
            }
        }
        
        if (shouldReconstructChildList) {
            CSSRemoveAllChildren(node);
            
            for (int i = 0 ; i < subviewsToInclude.count; i++) {
                UIView *const subview = subviewsToInclude[i];
                CSSNodeInsertChild(node, [subview cssNode], i);
                CSSAttachNodesFromViewHierachy(subview);
            }
        }
    }
}

static void CSSRemoveAllChildren(const CSSNodeRef node)
{
    if (node == NULL) {
        return;
    }
    
    while (CSSNodeChildCount(node) > 0) {
        CSSNodeRemoveChild(node, CSSNodeGetChild(node, CSSNodeChildCount(node) - 1));
    }
}

static CGFloat CSSRoundPixelValue(CGFloat value)
{
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(){
        scale = [UIScreen mainScreen].scale;
    });
    
    return round(value * scale) / scale;
}

static void CSSApplyLayoutToViewHierarchy(UIView *view) {
    NSCAssert([NSThread isMainThread], @"Framesetting should only be done on the main thread.");
    if (![view css_includeInLayout]) {
        return;
    }
    
    CSSNodeRef node = [view cssNode];
    const CGPoint topLeft = {
        CSSNodeLayoutGetLeft(node),
        CSSNodeLayoutGetTop(node),
    };
    
    const CGPoint bottomRight = {
        topLeft.x + CSSNodeLayoutGetWidth(node),
        topLeft.y + CSSNodeLayoutGetHeight(node),
    };
    
    view.frame = (CGRect) {
        .origin = {
            .x = CSSRoundPixelValue(topLeft.x),
            .y = CSSRoundPixelValue(topLeft.y),
        },
        .size = {
            .width = CSSRoundPixelValue(bottomRight.x) - CSSRoundPixelValue(topLeft.x),
            .height = CSSRoundPixelValue(bottomRight.y) - CSSRoundPixelValue(topLeft.y),
        },
    };
    
    const BOOL isLeaf = ![view css_usesFlexbox] || view.subviews.count == 0;
    if (!isLeaf) {
        for (NSUInteger i = 0; i < view.subviews.count; i++) {
            CSSApplyLayoutToViewHierarchy(view.subviews[i]);
        }
    }
}

@end

