/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        MainWindowController.m
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "MainWindowController.h"
#import "Host.h"
#import "Execution.h"

@interface MainWindowController( Private )

- ( void )getHosts;

@end

@implementation MainWindowController( Private )

- ( void )getHosts
{
    NSTask       * task;
    NSPipe       * pipe;
    NSFileHandle * output;
    NSData       * data;
    NSString     * rawHosts;
    NSArray      * lines;
    NSString     * line;
    NSRange        range;
    NSString     * hostname;
    NSString     * ip;
    Host         * host;
    
    [ hosts release ];
    
    hosts = [ [ NSMutableArray arrayWithCapacity: 50 ] retain ];
    task  = [ NSTask new ];
    pipe  = [ NSPipe pipe ];
    
    [ task setLaunchPath: @"/usr/bin/dscl" ];
    [ task setArguments: [ NSArray arrayWithObjects: @"localhost", @"-list", @"/Local/Default/Hosts", @"IPAddress", nil ] ];
    [ task setStandardOutput: pipe ];
    [ task launch ];
    
    output   = [ pipe fileHandleForReading ];
    data     = [ output readDataToEndOfFile ];
    rawHosts = [ [ NSString alloc ] initWithData: data encoding: NSUTF8StringEncoding ];
    lines    = [ rawHosts componentsSeparatedByString: @"\n" ];
    
    for( line in lines )
    {
        range = [ line rangeOfString: @" " ];
        
        if( range.location == NSNotFound )
        {
            continue;
        }
        
        hostname  = [ line substringToIndex: range.location ];
        range     = [ line rangeOfString: @" " options: NSBackwardsSearch ];
        ip        = [ line substringFromIndex: range.location + 1 ];
        host      = [ Host new ];
        host.name = hostname;
        host.ip   = ip;
        
        [ hosts addObject: host ];
        [ host release ];
    }
    
    [ rawHosts release ];
    
    if( tableView != nil )
    {
        [ tableView reloadData ];
    }
}

@end

@implementation MainWindowController

@synthesize tableView;
@synthesize addButton;
@synthesize removeButton;
@synthesize createPanel;
@synthesize hostField;
@synthesize ipField;

- ( id )init
{
    if( ( self = [ super initWithWindowNibName: @"MainWindow" owner: self ] ) )
    {
        [ self getHosts ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ tableView    release ];
    [ addButton    release ];
    [ removeButton release ];
    [ hosts        release ];
    [ createPanel  release ];
    [ hostField    release ];
    [ ipField      release ];
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    tableView.delegate   = self;
    tableView.dataSource = self;
}

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )table
{
    ( void )table;
    
    return [ hosts count ];
}

- ( id )tableView: ( NSTableView * )table objectValueForTableColumn: ( NSTableColumn * )column row: ( NSInteger )rowIndex
{
    Host * host;
    
    ( void )table;
    ( void )column;
    
    host = [ hosts objectAtIndex: rowIndex ];
    
    if( [ [ column identifier ] isEqualToString: @"host" ] )
    {
        return host.name;
    }
    else if( [ [ column identifier ] isEqualToString: @"ip" ] )
    {
        return host.ip;
    }
    
    return @"";
}

- ( void )tableViewSelectionDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ removeButton setEnabled: YES ];
}

- ( void )sheetDidEnd: ( NSWindow * )sheet returnCode: ( int )returnCode contextInfo: ( void * )contextInfo
{
    ( void )sheet;
    ( void )returnCode;
    ( void )contextInfo;
}

- ( IBAction )createHost: ( id )sender
{
    Host      * host;
    NSAlert   * alert;
    Execution * exec;
    BOOL        canCreateHost;
    char      * args[ 6 ];
    
    ( void )sender;
    
    canCreateHost = YES;
    
    for( host in hosts )
    {
        if( [ host.name isEqualToString: [ hostField stringValue ] ] )
        {
            canCreateHost = NO;
            break;
        }
    }
    
    if( canCreateHost == NO )
    {
        alert = [ NSAlert new ];
        
        [ alert setAlertStyle:      NSInformationalAlertStyle ];
        [ alert setMessageText:     NSLocalizedString( @"ExistingHost", nil ) ];
        [ alert setInformativeText: NSLocalizedString( @"ExistingHostText", nil ) ];
        [ alert runModal ];
        [ alert release ];
        
        return;
    }
    
    if( [ [ hostField stringValue ] length ] == 0 || [ [ ipField stringValue ] length ] == 0 )
    {
        NSBeep();
        
        return;
    }
    
    exec      = [ Execution new ];
    args[ 0 ] = "localhost";
    args[ 1 ] = "-create";
    args[ 2 ] = ( char * )[ [ NSString stringWithFormat: @"/Local/Default/Hosts/%@", [ hostField stringValue ] ] cStringUsingEncoding: NSASCIIStringEncoding ];
    args[ 3 ] = "IPAddress";
    args[ 4 ] = ( char * )[ [ ipField stringValue ] cStringUsingEncoding: NSASCIIStringEncoding ];
    args[ 5 ] = NULL;
    
    [ exec executeWithPrivileges: "/usr/bin/dscl" arguments: args io: NULL ];
    
    [ exec release ];
    [ self getHosts ];
    [ createPanel orderOut: sender ];
    [ NSApp endSheet: createPanel returnCode: 0 ];
}

- ( IBAction )cancelCreateHost: ( id )sender
{
    ( void )sender;
    
    [ createPanel orderOut: sender ];
    [ NSApp endSheet: createPanel returnCode: 1 ];
}

- ( IBAction )addHost: ( id )sender
{
    ( void )sender;
    
    [ NSApp beginSheet:     createPanel
            modalForWindow: self.window
            modalDelegate:  self
            didEndSelector: @selector( sheetDidEnd: returnCode: contextInfo: )
            contextInfo:    nil
    ];
}

- ( IBAction )removeHost: ( id )sender
{
    Host      * host;
    Execution * exec;
    char      * args[ 4 ];
    
    ( void )sender;
    
    host      = [ hosts objectAtIndex: [ tableView selectedRow ] ];
    exec      = [ Execution new ];
    args[ 0 ] = "localhost";
    args[ 1 ] = "-delete";
    args[ 2 ] = ( char * )[ [ NSString stringWithFormat: @"/Local/Default/Hosts/%@", host.name ] cStringUsingEncoding: NSASCIIStringEncoding ];
    args[ 3 ] = NULL;
    
    [ exec executeWithPrivileges: "/usr/bin/dscl" arguments: args io: NULL ];
    [ exec release ];
    [ self getHosts ];
}

@end
