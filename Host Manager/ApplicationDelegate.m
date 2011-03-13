/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "AboutWindowController.h"

@implementation ApplicationDelegate

- ( void )applicationDidFinishLaunching: ( NSNotification * )notification
{
    mainWindowController  = [ MainWindowController  new ];
    aboutWindowController = [ AboutWindowController new ];
    
    ( void )notification;
    
    [ mainWindowController.window center ];
    [ mainWindowController showWindow: nil ];
    [ NSApp activateIgnoringOtherApps: YES ];
}

- ( void )applicationWillTerminate: ( NSNotification * )notification
{
    ( void )notification;
    
    [ mainWindowController  release ];
    [ aboutWindowController release ];
}

- ( IBAction )showAboutWindow: ( id )sender
{
    [ aboutWindowController.window center ];
    [ aboutWindowController showWindow: sender ];
    [ NSApp activateIgnoringOtherApps: YES ];
}

@end
