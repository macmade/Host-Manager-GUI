/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        AboutWindowController.m
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "AboutWindowController.h"
#import "Execution.h"

@implementation AboutWindowController

@synthesize versionField;

- ( id )init
{
    if( ( self = [ super initWithWindowNibName: @"AboutWindow" owner: self ] ) )
    {
        exec = [ Execution new ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ versionField setStringValue: [ [ NSBundle mainBundle ] objectForInfoDictionaryKey: @"CFBundleShortVersionString" ] ];
}

@end
