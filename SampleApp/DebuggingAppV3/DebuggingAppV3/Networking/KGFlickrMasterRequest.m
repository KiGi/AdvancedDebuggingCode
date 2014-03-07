//
//  KGMasterRequest.m
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/7/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import "KGFlickrMasterRequest.h"

#import "KGFlickrItem.h"
#import "KGFlickrMedia.h"
#import "KGFlickrTag.h"
#import "NSDictionary+KGSafeExtract.h"

static AFHTTPClient *flickrNetworkClient = nil;

@implementation KGFlickrMasterRequest

+ (void) initialize
{
    if ( flickrNetworkClient == nil )
    {
        flickrNetworkClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.flickr.com"]];
        [flickrNetworkClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        // If you do not do this, json will not parse!
        [flickrNetworkClient setDefaultHeader:@"Accept" value:@"application/json"];
    }
}



+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
 successHandler:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
 failureHandler:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
 finallyHandler:(void (^)())finally
{
    [flickrNetworkClient getPath:path
                      parameters:parameters
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             if ( success )
                                 success( operation, responseObject );
                             if ( finally )
                                 finally();
                         }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             if ( failure )
                                 failure( operation, error );
                             if ( finally )
                                 finally();
                         }];
}

+ (NSDate *)dateFromServerDate:(NSString *)serverDate
{
    __strong static NSDateFormatter *serverDateFormatter = nil;
    
    NSRange endRange = { serverDate.length - 4, 4 };
    NSString *convertServerDate = [serverDate stringByReplacingOccurrencesOfString:@":" withString:@"" options:NSBackwardsSearch range:endRange];
    
    if ( serverDateFormatter == nil )
    {
        serverDateFormatter = [[NSDateFormatter alloc] init];
        serverDateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd'T'HH:mm:ssZZZ" options:0 locale:[NSLocale currentLocale]];
    }
    
    NSDate *convertDate = nil;
    NSRange range = {0,0};
    NSError *error = nil;
    
    [serverDateFormatter getObjectValue:&convertDate forString:convertServerDate range:&range error:&error];
    
    return convertDate;
}


+ (void) convertJSONToObjects:(NSDictionary *)flickrMetaDict
{
    NSArray *items = [flickrMetaDict objectForKey:@"items"];
    
    for ( NSDictionary *itemDict in items )
    {
        KGFlickrItem *item = [KGFlickrItem createFlickrItem];
        
        item.title = [itemDict safeStringForKey:@"title"];
        item.link = [itemDict safeStringForKey:@"link"];
        NSString *rawDateTaken = [itemDict safeStringForKey:@"date_taken"];
        item.dateTaken = [self dateFromServerDate:rawDateTaken];
        item.flickrDescription = [itemDict safeStringForKey:@"description"];
        NSString *rawPublishDate = [itemDict safeStringForKey:@"published"];
        item.published = [self dateFromServerDate:rawPublishDate];
        item.authorName = [itemDict safeStringForKey:@"author"];
        item.authorFlickrID = [itemDict safeStringForKey:@"author_id"];
        
        // Pull out media items, usually just one
        NSDictionary *mediaDict = [itemDict objectForKey:@"media"];
        
        for ( NSString *key in [mediaDict allKeys] )
        {
            KGFlickrMedia *media = [KGFlickrMedia createFlickrMedia];
            NSString *urlString = [mediaDict safeStringForKey:key];
            media.mediaSize = key;
            media.mediaURL = urlString;
            media.item = item;
        }
        
        NSString *tags = [itemDict safeStringForKey:@"tags"];
        
        NSArray *tagsSeperated = [tags componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        for ( NSString *tagRaw in tagsSeperated )
        {
            KGFlickrTag *tag =[KGFlickrTag createFlickrTag];
            tag.tagValue = tagRaw;
            tag.complexTagValue = ([tagRaw rangeOfString:@":"].location != NSNotFound);
            tag.item = item;
        }
        //        LoggingOnlyComposeString debugString = ^ { return [NSString stringWithFormat:@"Original JSON:%@\nObject is %@", itemDict, item];};
        //DNSLog(debugString());
    }
    
    [KGFlickrItem saveAllModfiedFlickrItems];
    
}


+ (NSDictionary *) tryMassagedData:(NSData *)brokenData
{
    NSMutableString *jsonString = [[NSMutableString alloc] initWithData:brokenData encoding:NSUTF8StringEncoding];
    
    NSRange replaceRange = {0, jsonString.length};
    [jsonString replaceOccurrencesOfString:@"\\'" withString:@"" options:0 range:replaceRange];
    NSData *fixedData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:fixedData options:0 error:&error];
    
    if ( error )
        return nil;
    else
        return responseDict;
}

@end
