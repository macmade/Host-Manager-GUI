/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        Host.m
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "Host.h"

@implementation Host

@synthesize name;
@synthesize ip;

- ( id )init
{
    if( ( self = [ super init ] ) )
    {}
    
    return self;
}

- ( void )dealloc
{
    [ name release ];
    [ ip   release ];
    
    [ super dealloc ];
}

- ( NSString * )description
{
    NSString * description;
    
    description = [ super description ];
    
    return [ NSString stringWithFormat: @"%@: %@ - %@", description, name, ip ];
}

@end
