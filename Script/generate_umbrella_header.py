# -*- coding: utf-8 -*-
import os
import re
import sys

def traverse_dir(path, action):
    for root, dirs, files in os.walk(path):
        if "private" not in root:
            for f in files:
                action(f)

def generate_umbrella_header(headers):
    top = '''
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

'''
    bottom = '''

FOUNDATION_EXPORT double CKWrapperVersionNumber;
FOUNDATION_EXPORT const unsigned char CKWrapperVersionString[];
     '''

    content = "\n".join(map(lambda h: '#import "%s"' % h, headers))
    return  top + content + bottom


if __name__ == '__main__':

    scriptPath = os.path.abspath(sys.argv[0])
    targetDir = os.path.dirname(os.path.dirname(scriptPath)) + "/Sources"
    headers = []
    def find_header_file(file_name):
        if file_name.split(".")[-1] == "h":
            headers.append(file_name)
        
    traverse_dir(targetDir, find_header_file)
    headers = filter(lambda h: "umbrella" not in h and "Subclass" not in h and "ComponentSwift.h" != h, headers)
    headerFile = generate_umbrella_header(headers)

    # write
    umbrellaPath = "/SupportFiles/ComponentSwift.h"
    f = open(targetDir + umbrellaPath, "w+")
    f.write(headerFile)
    print("Umbrella header generated!")
    f.close()
