//
//  StoryParser.m
//  Pivotal
//
//  Created by Antonio on 08/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "StoryParser.h"
#import "Story.h"


@implementation StoryParser

-(id) parse:(NSData*)storiesData; {
	[stories release];
	stories = [[NSMutableArray alloc] init];
	
	parser = [[NSXMLParser alloc] initWithData:storiesData];
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
	
	if([elementName isEqualToString:@"story"]) {
		currentStory = [[Story alloc] init];
		currentNode = OTHER;
	}
	else {
		if([elementName isEqualToString:@"name"]) {
			currentNode = NAME;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"id"]) {
			currentNode = IDENTIFIER;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"story_type"]) {
			currentNode = STORY_TYPE;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"url"]) {
			currentNode = URL;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"estimate"]) {
			currentNode = ESTIMATE;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"current_state"]) {
			currentNode = CURRENT_STATE;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"description"]) {
			currentNode = DESCRIPTION;
			currentNodeContent = [[NSMutableString alloc] init];		
		} else if([elementName isEqualToString:@"name"]) {
			currentNode = NAME;
			currentNodeContent = [[NSMutableString alloc] init];	
		} else if([elementName isEqualToString:@"requested_by"]) {
			currentNode = REQUESTED_BY;
			currentNodeContent = [[NSMutableString alloc] init];				
		} else if([elementName isEqualToString:@"owned_by"]) {
			currentNode = OWNED_BY;
			currentNodeContent = [[NSMutableString alloc] init];			
		} else if([elementName isEqualToString:@"created_at"]) {
			currentNode = CREATED_AT;
			currentNodeContent = [[NSMutableString alloc] init];
		} else if([elementName isEqualToString:@"accepted_at"]) {
			currentNode = ACCEPTED_AT;
			currentNodeContent = [[NSMutableString alloc] init];			
		} else if([elementName isEqualToString:@"labels"]) {
			currentNode = LABELS;
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
	
	if([elementName isEqualToString:@"story"]) {
		if([currentStory storyType]==FEATURE) {
			[stories addObject:currentStory];	
		}
		[currentStory release];
	} else {
		if([elementName isEqualToString:@"name"]) {
			[currentStory setName:currentNodeContent];
		} else if([elementName isEqualToString:@"id"]) {
			[currentStory setIdentifier:[currentNodeContent intValue]];
		} else if([elementName isEqualToString:@"story_type"]) {
			if([currentNodeContent isEqualToString:@"feature"]) {
				[currentStory setStoryType:FEATURE];
			} else if([currentNodeContent isEqualToString:@"bug"]) {
				[currentStory setStoryType:BUG];				
			} else if ([currentNodeContent isEqualToString:@"chore"]) {
				[currentStory setStoryType:CHORE];			
			} else if ([currentNodeContent isEqualToString:@"release"]) {
				[currentStory setStoryType:RELEASE];
			}
		} else if([elementName isEqualToString:@"url"]) {
			[currentStory setUrl:currentNodeContent];
		} else if([elementName isEqualToString:@"estimate"]) {
			[currentStory setPoints:[currentNodeContent intValue]];			
		} else if([elementName isEqualToString:@"current_state"]) {
			if([currentNodeContent isEqualToString:@"unassigned"]) {
				[currentStory setState:PENDING];
			} else if([currentNodeContent isEqualToString:@"not yet started"]) {
				[currentStory setState:PENDING];
			} else if([currentNodeContent isEqualToString:@"unscheduled"]) {
				[currentStory setState:PENDING];
			} else if([currentNodeContent isEqualToString:@"in progress"]) {
				[currentStory setState:WORKING];	
			} else if([currentNodeContent isEqualToString:@"started"]) {
				[currentStory setState:WORKING];
			} else if ([currentNodeContent isEqualToString:@"finished"]) {
				[currentStory setState:FINISHED];			
			} else if ([currentNodeContent isEqualToString:@"delivered"]) {
				[currentStory setState:FINISHED];
			} else if ([currentNodeContent isEqualToString:@"accepted"]) {
				[currentStory setState:FINISHED];
			} else if ([currentNodeContent isEqualToString:@"rejected"]) {
				[currentStory setState:WORKING];
			}
		} else if([elementName isEqualToString:@"description"]) {
			[currentStory setDescription:currentNodeContent];		
		} else if([elementName isEqualToString:@"name"]) {
			[currentStory setName:currentNodeContent];	
		} else if([elementName isEqualToString:@"requested_by"]) {
			[currentStory setRequested:currentNodeContent];				
		} else if([elementName isEqualToString:@"owned_by"]) {
			[currentStory setOwnedBy:currentNodeContent];
		} else if([elementName isEqualToString:@"created_at"]) {
			[currentStory setCreatedAt:currentNodeContent];
		} else if([elementName isEqualToString:@"accepted_at"]) {
			[currentStory setAcceptedAt:currentNodeContent];
		} else if([elementName isEqualToString:@"labels"]) {
			[currentStory setLabels:currentNodeContent];
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

-(NSMutableArray*) getStories {
	//	[projects release];
	return stories;
}
- (void)dealloc
{
	[stories release];
	[super dealloc];
}

@end