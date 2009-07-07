//
//  PivotalWebBroker.m
//  Pivotal
//
//  Created by Antonio on 08/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "PivotalWebBroker.h"
#import "ProjectsParser.h"
#import "StoryParser.h"
#import "Project.h"

@implementation PivotalWebBroker

@synthesize projects;

-(id)initWithToken:(NSString*)aToken {
	[super init];
  	token = aToken;
	
	//Retrieving projects
	request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.pivotaltracker.com/services/v2/projects"]];
	
	tokenDictionary = [[NSMutableDictionary alloc] init];
	[tokenDictionary setValue:token forKey:@"X-TrackerToken"];	
	[request setAllHTTPHeaderFields:tokenDictionary];
	
	NSURLResponse *response = [NSURLResponse alloc];
	NSError *error = [NSError alloc];
	
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	//NSString *xmlData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	
	ProjectsParser *parser = [[ProjectsParser alloc] init];
	[parser parse:data];
	
	projects = [parser getProjects];
	[projects retain];
	
	//[response release];
	//[error release];
	//[data release];
	
	return self;
}

-(id)initWithLogin:(NSString*)login andPassword:(NSString*)password {
	[super init];
	
/*
	credential = [NSURLCredential credentialWithUser:login
								  password:password
								  persistence:NSURLCredentialPersistenceForSession];
	
	NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc]
											 initWithHost:@"www.pivotaltracker.com"
											 port:0
											 protocol:@"http"
											 realm:nil
											 authenticationMethod:NSURLAuthenticationMethodHTTPBasic];
	
	[[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credential
													  forProtectionSpace:protectionSpace];

	request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.pivotaltracker.com/services/tokens/active"]];
	[request setHTTPMethod:@"POST"];

	


	NSURLResponse *response = [NSURLResponse alloc];
	NSError *error = [NSError alloc];
	
	NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSInteger rc = [((NSHTTPURLResponse*) response) statusCode];
	NSString *desc = [error description];
	data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	
	token = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	
	token = @"parsing result";

	
	
	responseData = [[NSMutableData alloc] init];
	
	//request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mobixell.adonfly.mobi/api_v1/users/9/campaigns"]];
    //[[NSURLConnection alloc] initWithRequest:request delegate:self];
*/	
	
	request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.pivotaltracker.com/services/tokens/active"]];
	[request setHTTPMethod:@"POST"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	return self;
}

-(NSMutableArray*) storiesForProject:(Project*)aProject {	
	
	
	NSString* storiesUrl = [[NSString alloc] initWithFormat:@"http://www.pivotaltracker.com/services/v2/projects/%d/stories",[aProject identifier]];
	[request setURL:[NSURL URLWithString:storiesUrl]];
	
	NSURLResponse *response = [NSURLResponse alloc];
	NSError *error = [NSError alloc];
	
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];	
	
	StoryParser *parser = [[StoryParser alloc] init];
	[parser parse:data];
	
	NSMutableArray* stories = [parser getStories];
	[stories retain];
	
	//[error release];
	//[data release];
	//[response release];
	
	return stories;
}

// HTTP
/*
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *desc = [error description];
	token = desc;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	token = @"error";
}

-(void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:@"xxxxxx"
                                                 password:@"xxxxxx"
                                              persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // inform the user that the user name and password
        // in the preferences are incorrect
        token = @"error";
    }
}
*/
//

-(void) dealloc
{
	[credential release];
	[request release];
	[token release];
	[tokenDictionary release];
	[super dealloc];
}

@end
