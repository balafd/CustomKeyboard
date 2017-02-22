//
//  TableViewModelProtocol.h
//  PhotoLibPOC
//
//  Created by Bala on 21/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

@protocol TableViewModelProtocol <NSObject>

/**
 Returns an array of reuse identifier that the collection view will use, register either a class or a nib from which to instantiate a cell.
 
 @return An array of reuse identifier. This doesn't include Section Header/Footer reusable view identifier.
 */
- (NSArray *)cellIdentifiers;

/**
 The number of sections in the More Screen
 
 @return The number of sections.
 */
- (NSInteger)numberOfSections;

/**
 The number of options available in the more screen for the specified section, based on the User account privilege.
 
 @param section An index number identifying a section in view. This index value is 0-based.
 @return The number of options available in section.
 */
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

/**
 Returns the Reuse Identifier that the collection view will use, for the specified section.
 
 @param section An index number identifying a section in view. This index value is 0-based.
 @return A reuse identifier string that is used to identify the corresponding cell for the section.
 */
- (NSString *)identifierForItemAtRow:(NSInteger)row inSection:(NSInteger)section;

/**
 Returns the data of the corresponding item that the cell will use to set any properties & perform any additional needed configuration, for the specified section.
 
 This method must always return a valid view object.
 
 @param row An index number identifying a row in Section. This index value is 0-based.
 @param section An index number identifying a section in view. This index value is 0-based.
 @return Data for the cell to configure.
 */
- (id)dataForItemAtRow:(NSInteger)row inSection:(NSInteger)section;

- (void)didTapItemAtRow:(NSInteger)row inSection:(NSInteger)section;

- (CGFloat)heightForItemAtRow:(NSInteger)row inSection:(NSInteger)section;

@end
