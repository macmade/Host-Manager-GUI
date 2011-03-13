/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      AboutWindowController.h
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

@class Execution;

/*!
 * @class       AboutWindowController
 * @abstract    ...
 */
@interface AboutWindowController: NSWindowController
{
@protected
    
    Execution   * exec;
    NSTextField * versionField;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet NSTextField * versionField;

@end
