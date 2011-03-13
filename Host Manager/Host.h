/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      Host.h
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

/*!
 * @class       Host
 * @abstract    ...
 */
@interface Host: NSObject
{
@protected
    
    NSString * name;
    NSString * ip;
    
@private
    
    id r1;
    id r2;
}

@property( copy, readwrite ) NSString * name;
@property( copy, readwrite ) NSString * ip;

@end
