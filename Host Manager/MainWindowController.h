/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      MainWindowController.h
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

@class AboutWindowController;

/*!
 * @class       MainWindowController
 * @abstract    ...
 */
@interface MainWindowController: NSWindowController < NSTableViewDataSource, NSTableViewDelegate >
{
@protected
    
    NSTableView    * tableView;
    NSButton       * addButton;
    NSButton       * removeButton;
    NSMutableArray * hosts;
    NSPanel        * createPanel;
    NSTextField    * hostField;
    NSTextField    * ipField;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet NSTableView * tableView;
@property( nonatomic, retain ) IBOutlet NSButton    * addButton;
@property( nonatomic, retain ) IBOutlet NSButton    * removeButton;
@property( nonatomic, retain ) IBOutlet NSPanel     * createPanel;
@property( nonatomic, retain ) IBOutlet NSTextField * hostField;
@property( nonatomic, retain ) IBOutlet NSTextField * ipField;

- ( IBAction )addHost: ( id )sender;
- ( IBAction )createHost: ( id )sender;
- ( IBAction )cancelCreateHost: ( id )sender;
- ( IBAction )removeHost: ( id )sender;

@end
