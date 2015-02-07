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

#import <Foundation/Foundation.h>

@class Claim;
@interface FileSystemUtilities : NSObject

#define _CLAIMS_FOLDER @"claims"
#define _CLAIMANTS_FOLDER @"claimants"
#define _CLAIM_PREFIX @"claim_"
#define _CLAIMANT_PREFIX @"claimant_"
#define _ATTACHMENT_FOLDER @"attachments"
#define _OPEN_TENURE_FOLDER @"Open Tenure"

+ (BOOL)createFolder:(NSString *)folderName;
+ (BOOL)createClaimsFolder;
+ (BOOL)createOpenTenureFolder;
+ (BOOL)createClaimantsFolder;
+ (BOOL)createClaimFolder:(NSString *)claimId;
+ (BOOL)createClaimantFolder:(NSString *)personId;
+ (BOOL)removeClaimantFolder:(NSString *)personId;
+ (BOOL)deleteClaim:(NSString *)claimId;
+ (BOOL)deleteClaimant:(NSString *)personId;
+ (BOOL)deleteFile:(NSString *)file;
+ (BOOL)deleteDocumentsFolder;
+ (BOOL)deleteCompressedClaim:(NSString *)claimId;
+ (int)getUploadProgress:(Claim *)claim;
+ (NSString *)getClaimsFolder;
+ (NSString *)getClaimantsFolder;
+ (NSString *)getClaimFolder:(NSString *)claimId;
+ (NSString *)getAttachmentFolder:(NSString *)claimId;
+ (NSString *)getCompressClaim:(NSString *)claimId;
+ (NSString *)getOpentenureFolder;
+ (BOOL)copyFileInAttachFolder:(NSString *)claimId source:(NSString *)source;
+ (NSString *)getJsonClaim:(NSString *)claimId;
+ (NSString *)getJsonAttachment:(NSString *)attachmentId;
+ (NSString *)matchTypeCode:(NSString *)original;

+ (NSString *)getClaimantImagePath:(NSString *)personId;

+ (NSURL *)applicationDocumentsDirectory;
+ (NSURL *)applicationHiddenDocumentsDirectory;

+ (BOOL)copyFileFromSource:(NSURL *)source toDestination:(NSURL *)destination;

@end