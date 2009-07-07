//
//  ProjectsParser.h
//  Pivotal
//
//  Created by Antonio on 08/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "ParserConstants.h"

@class Project;

@interface ProjectsParser : NSObject {
	NSXMLParser *parser;
	NSMutableArray *projects;
	Project *currentProject;
	int currentNode;
	NSMutableString *currentNodeContent;
}

-(id) parse:(NSData*)projectsData;

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

-(NSMutableArray*) getProjects;
@end
