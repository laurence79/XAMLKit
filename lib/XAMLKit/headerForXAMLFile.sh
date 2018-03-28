#!/bin/sh

#  headerForXAMLFile.sh
#  LHLayoutPoc
#
#  Created by Laurence Hartgill on 17/12/2017.
#  Copyright © 2017 RIVR Systems Ltd. All rights reserved.

INPUT_FILE_BASE=$1

SUPER_CLASS=`sed -n 's|.*<\([a-zA-Z0-9_]*\).*|\1|p' $INPUT_FILE_PATH | head -1`

if [ -z "$SUPER_CLASS" ]
then
SUPER_CLASS='NSObject'
fi

cat << EOF
//
//  Created by headerForXAMLFile.sh
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface $INPUT_FILE_BASE : $SUPER_CLASS

@end

EOF

