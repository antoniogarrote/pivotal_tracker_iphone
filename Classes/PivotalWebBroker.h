//
//  PivotalWebBroker.h
//  Pivotal
//
//  Created by Antonio on 08/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#define PIVOTAL_API_URL "http://www.pivotaltracker.com/services/v2"

@class NSURLCredential;
@class NSMutableURLRequest;
@class NSMutableData;
@class NSMutableDictionary;
@class ProjectsParser;
@class Project;

@interface PivotalWebBroker : NSObject {
	NSURLCredential* credential;
	NSString *token;
	NSMutableURLRequest *request;
	NSMutableData *responseData;	
	NSMutableDictionary *tokenDictionary;
	
	NSMutableArray* projects;
}

-(id)initWithToken:(NSString*)aToken;
-(id)initWithLogin:(NSString*)login andPassword:(NSString*)password;
-(NSMutableArray*) storiesForProject:(Project*)aProject;

@property(retain,nonatomic,readwrite) NSMutableArray* projects;

@end
