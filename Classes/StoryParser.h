//
//  StoryParser.h
//  Pivotal
//
//  Created by Antonio on 08/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "ParserConstants.h"

@class Story;

@interface StoryParser : NSObject {
	NSXMLParser *parser;
	NSMutableArray *stories;
	Story *currentStory;
	int currentNode;	
	NSMutableString *currentNodeContent;	
}

-(id) parse:(NSData*)storiesData;

-(void)parser:(NSXMLParser*)parser
 didStartElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
 qualifiedName:(NSString*)qName
 attributes:(NSDictionary*)attributeDict;

-(void)parser:(NSXMLParser*)parser 
 didEndElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
 qualifiedName:(NSString*)qName;

-(void)parser:(NSXMLParser*)parser
 foundCharacters:(NSString*)string;

-(NSMutableArray*) getStories;

@end