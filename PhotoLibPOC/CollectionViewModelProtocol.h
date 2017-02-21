//
//  CollectionViewModelProtocol.h
//  PhotoLibPOC
//
//  Created by Bala on 21/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CollectionViewModelProtocol <NSObject>

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
- (NSString *)identifierForItemAtSection:(NSInteger)section;

/**
 Returns the data of the corresponding item that the cell will use to set any properties & perform any additional needed configuration, for the specified section.
 
 This method must always return a valid view object.
 
 @param row An index number identifying a row in Section. This index value is 0-based.
 @param section An index number identifying a section in view. This index value is 0-based.
 @return Data for the cell to configure.
 */
- (id)dataForItemAtRow:(NSInteger)row inSection:(NSInteger)section;

/**
 Returns the size of the item at specified section.
 
 @param section The index number of the section whose item's size are needed.
 @param fullSize Size of the collection view
 @return The width and height of the specified section items.
 */
- (CGSize)sizeForItemAtSection:(NSInteger)section ofFullSize:(CGSize)fullSize;

/**
 Returns the spacing between successive rows or columns of a section.
 This spacing is not applied to the space between the header and the first line or between the last line and the footer.
 
 @param section The index number of the section whose line spacing is needed.
 @return The minimum space (measured in points) to apply between successive lines in a section.
 */
- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section;

/**
 spacing between successive items in the rows or columns of a section.
 
 This spacing is used to compute how many items can fit in a single line, but after the number of items is determined, the actual spacing may possibly be adjusted upward.
 
 @param section The index number of the section whose inter-item spacing is needed.
 @return The minimum space (measured in points) to apply between successive items in the lines of a section.
 */

- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

/**
 Returns the size of the header view in the specified section.
 
 @param section The index of the section whose header size is being requested.
 @param fullSize Size of the collection view
 @return The size of the header. If you return a value of size (0, 0), no header is added.
 */
- (CGSize)referenceSizeForHeaderInSection:(NSInteger)section withFullSize:(CGSize)fullSize;

/**
 Returns the size of the footer view in the specified section.
 
 @param section The index of the section whose footer size is being requested.
 @param fullSize Size of the collection view
 @return The size of the footer. If you return a value of size (0, 0), no header is added.
 */
- (CGSize)referenceSizeForFooterInSection:(NSInteger)section withFullSize:(CGSize)fullSize;

@end
