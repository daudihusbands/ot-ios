/**
 * ******************************************************************************************
 * Copyright (C) 2014 - Food and Agriculture Organization of the United Nations (FAO).
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *    1. Redistributions of source code must retain the above copyright notice,this list
 *       of conditions and the following disclaimer.
 *    2. Redistributions in binary form must reproduce the above copyright notice,this list
 *       of conditions and the following disclaimer in the documentation and/or other
 *       materials provided with the distribution.
 *    3. Neither the name of FAO nor the names of its contributors may be used to endorse or
 *       promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,STRICT LIABILITY,OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * *********************************************************************************************
 */

#import "FieldPayloadEntity.h"

@implementation FieldPayloadEntity

@synthesize frcPredicate;

#pragma mark - Overridden getters

/*!
 Override tên bảng dữ liệu vào abstract class
 */
- (NSString *)entityName {
    return @"FieldPayload";
}

/*!
 Override trường dữ liệu làm section
 */
- (NSString *)mainTableSectionNameKeyPath {
    return @"attributeId";
}

/*!
 Override cache cho table
 */
- (NSString *)mainTableCache {
    return @"FieldPayloadCache";
}

/*!
 Override tên trường sẽ được sắp xếp
 */
- (NSArray *)sortKeys {
    return @[@"attributeId"];
}

- (BOOL)sortAscending {
    return YES;
}

/*!
 Override kích thước khối dữ liệu
 */
- (NSUInteger)fetchBatchSize {
    return 30;
}

/*!
 Override predicate mặc định
 */
- (NSPredicate *)frcPredicate {
    return nil;
}

/*
 Override định nghĩa câu truy vấn
 */
- (NSPredicate *)searchPredicateWithSearchText:(NSString *)searchText scope:(NSInteger)scope {
    return [NSPredicate predicateWithFormat:@"(attributeId == %@)", searchText];
}

#pragma mark - Entity

/*!
 Shared NSManagedObjectContext
 */
+ (FieldPayloadEntity *)context {
    static dispatch_once_t once;
    __strong static id context = nil;
    dispatch_once(&once, ^{
        context = [self new];
    });
    return context;
}

+ (FieldPayload *)createObject {
    NSManagedObjectContext *context = [[[self context] fetchedResultsController] managedObjectContext];
    NSEntityDescription *entity = [[[[self context] fetchedResultsController] fetchRequest] entity];
    
    FieldPayload *entityObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    entityObject.attributeId = [[[NSUUID UUID] UUIDString] lowercaseString];
    return entityObject;
}

- (FieldPayload *)createObject {
    FieldPayload *entityObject = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:self.managedObjectContext];
    entityObject.attributeId = [[[NSUUID UUID] UUIDString] lowercaseString];
    return entityObject;
}

+ (FieldPayload *)getEntityById:(NSString *)attributeId {
    [[self context] filterContentForSearchText:attributeId scope:0];
    if ([self context]->_filteredObjects.count > 0) {
        return [[self context]->_filteredObjects firstObject];
    }
    return nil;
}

- (FieldPayload *)getObjectBySectionElementPayload:(SectionElementPayload *)sectionElementPayload andFieldTemplate:(FieldTemplate *)fieldTemplate sortKeys:(NSArray *)sortKeys {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sectionElementPayload == %@) and (fieldTemplate == %@)", sectionElementPayload, fieldTemplate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:[self entityName] inManagedObjectContext:self.managedObjectContext]];
    [fetchRequest setPredicate:predicate];
    // Make sure the results are sorted as well.
    NSMutableArray *sortDescriptors = [NSMutableArray array];
    for (NSString *key in sortKeys) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
        [sortDescriptors addObject:sortDescriptor];
    }
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Execute the fetch.
    NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return [objects firstObject];
}

@end
