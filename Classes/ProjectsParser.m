//
//  ProjectsParser.m
//  Pivotal
//
//  Created by Antonio on 08/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "ProjectsParser.h"
#import "Project.h"


@implementation ProjectsParser

-(id)parse:(NSData*)projectsData {
	[projects release];
	projects = [[NSMutableArray alloc] init];
	
	parser = [[NSXMLParser alloc] initWithData:projectsData];
	[parser setDelegate:self];
	
	[parser parse];	
	
	[parser release];
	
	return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{
	NSLog(@"Open tag: %@", elementName);
	
	if([elementName isEqualToString:@"project"]) {
		currentProject = [[Project alloc] init];
		[projects addObject:currentProject];
		currentNode = OTHER;
	}
	else {
		if([elementName isEqualToString:@"name"]) {
			currentNode = NAME;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"id"]) {
			currentNode = IDENTIFIER;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"iteration_length"]) {
			currentNode = ITERATION_LENGHT;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"week_start_day"]) {
			currentNode = WEEK_DAY;
			currentNodeContent = [[NSMutableString alloc] init];
		} else {
			currentNode = OTHER;
		}
	}
}

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	NSLog(@"Close tag: %@", elementName);
	
	if([elementName isEqualToString:@"project"]) {
		[currentProject release];
	}
	else {
		if([elementName isEqualToString:@"name"]) {
			[currentProject setName:currentNodeContent];
		} else if([elementName isEqualToString:@"id"]) {
			[currentProject setIdentifier:[currentNodeContent intValue]];
		} else if([elementName isEqualToString:@"iteration_length"]) {
			[currentProject setIterationLength:[currentNodeContent intValue]];
		} else if([elementName isEqualToString:@"week_start_day"]) {
			if([currentNodeContent isEqualToString:@"Monday"]) {
				[currentProject setWeekStartDay:0];
			} else if([currentNodeContent isEqualToString:@"Tuesday"]) {
				[currentProject setWeekStartDay:1];				
			} else if([currentNodeContent isEqualToString:@"Wednesday"]) {
				[currentProject setWeekStartDay:2];				
			} else if([currentNodeContent isEqualToString:@"Thursday"]) {
				[currentProject setWeekStartDay:3];				
			} else if([currentNodeContent isEqualToString:@"Friday"]) {
				[currentProject setWeekStartDay:4];				
			} else if([currentNodeContent isEqualToString:@"Saturday"]) {
				[currentProject setWeekStartDay:5];				
			} else if([currentNodeContent isEqualToString:@"Sunday"]) {
				[currentProject setWeekStartDay:6];				
			}
		} else {
			currentNode = OTHER;
		}
	}
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{   
	[currentNodeContent appendString:string];
}

-(NSMutableArray*) getProjects {
//	[projects release];
	return projects;
}
- (void)dealloc
{
	[super dealloc];
}

@end
