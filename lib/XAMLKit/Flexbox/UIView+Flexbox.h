//
//  UIView+Flexbox.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSLayout.h"

@interface UIView (Flexbox)

/**
 The property that decides if we should include this view when calculating layout. Defaults to YES.
 */
@property (nonatomic, readwrite, assign) BOOL css_includeInLayout;

/**
 The property that decides during layout/sizing whether or not css_* properties should be applied. Defaults to NO.
 */
@property (nonatomic, readwrite, assign) BOOL css_usesFlexbox;

@property (nonatomic, assign) CSSDirection css_direction;
@property (nonatomic, assign) CSSFlexDirection css_flexDirection;
@property (nonatomic, assign) CSSJustify css_justifyContent;
@property (nonatomic, assign) CSSAlign css_alignContent;
@property (nonatomic, assign) CSSAlign css_alignItems;
@property (nonatomic, assign) CSSAlign css_alignSelf;
@property (nonatomic, assign) CSSPositionType css_positionType;
@property (nonatomic, assign) CSSWrap css_flexWrap;

@property (nonatomic, assign) CGFloat css_flexGrow;
@property (nonatomic, assign) CGFloat css_flexShrink;
@property (nonatomic, assign) CGFloat css_flexBasis;

@property (nonatomic, assign) CGFloat css_positionAll;
@property (nonatomic, assign) CGFloat css_positionLeft;
@property (nonatomic, assign) CGFloat css_positionTop;
@property (nonatomic, assign) CGFloat css_positionRight;
@property (nonatomic, assign) CGFloat css_positionBottom;
@property (nonatomic, assign) CGFloat css_positionStart;
@property (nonatomic, assign) CGFloat css_positionEnd;
@property (nonatomic, assign) CGFloat css_positionHorizontal;
@property (nonatomic, assign) CGFloat css_positionVertical;

@property (nonatomic, assign) CGFloat css_marginAll;
@property (nonatomic, assign) CGFloat css_marginLeft;
@property (nonatomic, assign) CGFloat css_marginTop;
@property (nonatomic, assign) CGFloat css_marginRight;
@property (nonatomic, assign) CGFloat css_marginBottom;
@property (nonatomic, assign) CGFloat css_marginStart;
@property (nonatomic, assign) CGFloat css_marginEnd;
@property (nonatomic, assign) CGFloat css_marginHorizontal;
@property (nonatomic, assign) CGFloat css_marginVertical;

@property (nonatomic, assign) CGFloat css_paddingAll;
@property (nonatomic, assign) CGFloat css_paddingLeft;
@property (nonatomic, assign) CGFloat css_paddingTop;
@property (nonatomic, assign) CGFloat css_paddingRight;
@property (nonatomic, assign) CGFloat css_paddingBottom;
@property (nonatomic, assign) CGFloat css_paddingStart;
@property (nonatomic, assign) CGFloat css_paddingEnd;
@property (nonatomic, assign) CGFloat css_paddingHorizontal;
@property (nonatomic, assign) CGFloat css_paddingVertical;

@property (nonatomic, assign) CGFloat css_width;
@property (nonatomic, assign) CGFloat css_height;
@property (nonatomic, assign) CGFloat css_minWidth;
@property (nonatomic, assign) CGFloat css_minHeight;
@property (nonatomic, assign) CGFloat css_maxWidth;
@property (nonatomic, assign) CGFloat css_maxHeight;

// Yoga specific properties, not compatible with flexbox specification
@property (nonatomic, assign) CGFloat css_aspectRatio;

/**
 Get the resolved direction of this node. This won't be CSSDirectionInherit
 */
- (CSSDirection)css_resolvedDirection;

/**
 Perform a layout calculation and update the frames of the views in the hierarchy with th results
 */
- (void)css_applyLayout;

/**
 Returns the size of the view if no constraints were given. This could equivalent to calling [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
 */
- (CGSize)css_intrinsicSize;

/**
 Returns the number of children that are using Flexbox.
 */
- (NSUInteger)css_numberOfChildren;

@end

