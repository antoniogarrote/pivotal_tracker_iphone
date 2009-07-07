//
//  UIBranaController.m
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "UIBranaController.h"
#import "UIBranaView.h"
#import "UIBranaCell.h"
#import "Story.h"
#import "StoryManager.h"
#import "PivotalWebBroker.h"
#import "MainController.h"
#import "DevelopersController.h"
#import "Developer.h"

@implementation UIBranaController


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		storyManager = [[StoryManager alloc] init];
		cells = [[NSMutableArray alloc] init];
		pivotalWeb = [[PivotalWebBroker alloc] initWithLogin:USER_NAME andPassword:PASSWORD];
		selectedStory = nil;
    }
    return self;
}

// Releases the old story manager and stores the new
-(void)setStoryManager:(StoryManager*)aStoryManager {
	[storyManager release];
	[aStoryManager retain];
	
	storyManager = aStoryManager;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
-(void)pinchedStoriesFromTopInitial:(CGPoint)ui topFinal:(CGPoint)uf downInitial:(CGPoint)di downFinal:(CGPoint)df {
	NSLog(@"EN PINCEHD STORIES");
	NSMutableArray *upperStories = [[NSMutableArray alloc] initWithCapacity:[storyManager totalStories]];
	NSMutableArray *pinchedStories = [[NSMutableArray alloc] initWithCapacity:[storyManager totalStories]];
	NSMutableArray *lowerStories = [[NSMutableArray alloc] initWithCapacity:[storyManager totalStories]];	
	
	Story *currentStory;
	int looking = 0;
	CGFloat extreme = uf.y;
	BOOL adding = YES;
	
	[cells sortUsingSelector:@selector(compareYFrame:)];
	for (UIBranaCell *cell in cells) {
		switch (looking) {
			case 0:
				extreme = ui.y;
				break;
			case 1:
				extreme = di.y;
				break;
			default:
				extreme = 10000;
				break;
		}
		
		CGFloat cellExtreme = 0;
		switch (looking) {
			case 0:
				cellExtreme = [cell frame].origin.y;				
				break;
			default:
				cellExtreme = [cell frame].origin.y + [cell bounds].size.height;								
				break;
		}
		if (cellExtreme < extreme) {
			if([cell story] != currentStory) {
				adding = YES;
				currentStory = [cell story];
			} 			
		} else {
			looking++;
		}

		if(adding) {
			adding = NO;
			switch (looking) {
				case 0:
					[upperStories addObject:currentStory];
					break;
				case 1:
					[pinchedStories addObject:currentStory];
					break;
				default:
					[lowerStories addObject:currentStory];
					break;
			}
		}
	}
	
	for(UIBranaCell *cell in cells) {
		[cell removeFromSuperview];
	}
	
	CGFloat width = [[self view] bounds].size.width;
	CGFloat height = [[self view] bounds].size.height;
	[self fillRectWithStories:upperStories forHeight:uf.y andWidth:width startingAt:0];
	[self fillRectWithStories:pinchedStories forHeight:(df.y - uf.y) andWidth:width startingAt:uf.y];
	[self fillRectWithStories:lowerStories forHeight:(height - df.y) andWidth:width startingAt:df.y];
	
}
*/

-(void)pinchedStoriesFromTopInitial:(CGPoint)ui topFinal:(CGPoint)uf downInitial:(CGPoint)di downFinal:(CGPoint)df {
	NSLog(@"EN PINCEHD STORIES");
	NSMutableArray *upperStories = [[NSMutableArray alloc] initWithCapacity:[storyManager totalStories]];
	NSMutableArray *pinchedStories = [[NSMutableArray alloc] initWithCapacity:[storyManager totalStories]];
	NSMutableArray *lowerStories = [[NSMutableArray alloc] initWithCapacity:[storyManager totalStories]];	
	
	Story *currentStory;
	int looking = 0;
	CGFloat extreme = uf.y;
	BOOL adding = YES;
	
	if([cells count] > 0) {
		currentStory = [[cells objectAtIndex:0] story];
	}
	
	//[cells sortUsingSelector:@selector(compareYFrame:)];
	for (UIBranaCell *cell in cells) {
		switch (looking) {
			case 0:
				extreme = ui.y;
				break;
			case 1:
				extreme = di.y;
				break;
			default:
				extreme = 10000;
				break;
		}
		
		CGFloat cellExtreme = 0;
		switch (looking) {
			case 0:
				cellExtreme = [cell frame].origin.y + [cell bounds].size.height;
				//cellExtreme = [cell frame].origin.y;				
				break;
			default:
				cellExtreme = [cell frame].origin.y;												
				//cellExtreme = [cell frame].origin.y + [cell bounds].size.height;								
				break;
		}
		if (cellExtreme < extreme) {
			if([cell story] != currentStory) {
				adding = YES;
				currentStory = [cell story];
			} 			
		} else {
			looking++;
			if([cell story] != currentStory) {
				adding = YES;
				currentStory = [cell story];				
			}
		}
		
		if(adding) {
			adding = NO;
			switch (looking) {
				case 0:
					[upperStories addObject:currentStory];
					break;
				case 1:
					[pinchedStories addObject:currentStory];
					break;
				default:
					[lowerStories addObject:currentStory];
					break;
			}
		}
	}
	
	
	//CGFloat width = [[self view] bounds].size.width;
	//CGFloat height = [[self view] bounds].size.height;
	////[self fillRectWithStories:upperStories forHeight:uf.y andWidth:width startingAt:0];
	//CGFloat forHeight = uf.y;
	//CGFloat andWidth = width;
	//CGFloat startingAt = 0;
	NSMutableArray *cellsForStories = [[NSMutableArray alloc] initWithCapacity:[cells count]];
	
	int numRows = [self countRows:upperStories storingThemIn:&cellsForStories startingAtY:ui.y endingWith:di.y andMode:0];
	CGFloat totalOffset = ui.y - uf.y;
	CGFloat offsetPerCell = totalOffset / numRows;
	CGFloat newCellHeight = 0;
	BOOL pinchingTop = NO;
	
	
	if([upperStories count] > 0) {		
		newCellHeight = [[cellsForStories objectAtIndex:0] bounds].size.height - offsetPerCell;
		for(UIBranaCell* cell in cellsForStories) {
			CGRect theRect = [cell bounds];
			CGRect theFrame = [cell frame];
			if (theFrame.origin.y != 0) {
				theFrame.origin.y -= offsetPerCell;
			}
			theRect.size.height = newCellHeight;
			theFrame.size.height = newCellHeight;
			[cell setBounds:theRect];
			[cell setFrame:theFrame];
		}
		NSLog(@"UPPER: %f, %f",[[cellsForStories objectAtIndex:0] frame].origin.y, [[cellsForStories objectAtIndex:0] bounds].size.height);
	} else {
		pinchingTop = YES;
	}
	// pinched stories
	totalOffset = (ui.y - uf.y) + (df.y - di.y);
		
	CGFloat upperOffset = (ui.y - uf.y);
	CGFloat lowerOffset = (df.y - di.y);
	
	cellsForStories = [[NSMutableArray alloc] initWithCapacity:[cells count]];
	numRows = [self countRows:pinchedStories storingThemIn:&cellsForStories startingAtY:ui.y endingWith:di.y andMode:1];
	
	CGFloat upperOffsetPerCell = (upperOffset / numRows);
	CGFloat lowerOffsetPerCell = (lowerOffset / numRows);
	
	int yForFirstRow =  [[cellsForStories objectAtIndex:0] frame].origin.y;
	int xForFirstRow =  [[cellsForStories objectAtIndex:0] frame].origin.x;	
	if(xForFirstRow != 0) {
		NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
		for(UIBranaCell *tmpCell in cells) {
			if(tmpCell.frame.origin.y == yForFirstRow && tmpCell.frame.origin.x < xForFirstRow) {
				[tmpArray addObject:tmpCell];
			}
		}
		for(UIBranaCell* cell in cellsForStories) {
			[tmpArray addObject:cell];
		}
		[cellsForStories release];
		cellsForStories = tmpArray;
	}
	
	offsetPerCell = totalOffset / numRows;
	newCellHeight = [[cellsForStories objectAtIndex:0] bounds].size.height + offsetPerCell;
	
	if([[cellsForStories objectAtIndex:0] frame].origin.y != 0 && 
	   ([[cellsForStories lastObject] frame].origin.y + [[cellsForStories lastObject] bounds].size.height) != 400) {
		
		CGFloat firstRowHeight = [[cellsForStories objectAtIndex:0] frame].origin.y;
/*		
		for(UIBranaCell *cell in cellsForStories) {
			if([cell frame].origin.y == firstRowHeight) {
				CGRect theFirstFrame = [cell frame];
				theFirstFrame.origin.y -= offsetPerCell;
				[cell setFrame:theFirstFrame];			
			}
		}
*/				
		for(UIBranaCell* cell in cellsForStories) {
			CGRect theRect = [cell bounds];
			CGRect theFrame = [cell frame];
			//theFrame.origin.y += lowerOffsetPerCell;
			if(theFrame.origin.y != firstRowHeight) {
				theFrame.origin.y += offsetPerCell;
			}
			theFrame.origin.y -= upperOffset;
			theRect.size.height = newCellHeight;
			theFrame.size.height = newCellHeight;
			[cell setBounds:theRect];
			[cell setFrame:theFrame];
		}
	} else if([[cellsForStories objectAtIndex:0] frame].origin.y == 0) { // las celdas seleccionadas empiezan en la parte superior
		CGFloat firstRowHeight = [[cellsForStories objectAtIndex:0] frame].origin.y;
			
		for(UIBranaCell* cell in cellsForStories) {
			CGRect theRect = [cell bounds];
			CGRect theFrame = [cell frame];
			//theFrame.origin.y += lowerOffsetPerCell;
			if(theFrame.origin.y != firstRowHeight) {
				theFrame.origin.y += offsetPerCell;
			}
			//theFrame.origin.y -= upperOffset;
			theRect.size.height = newCellHeight;
			theFrame.size.height = newCellHeight;
			[cell setBounds:theRect];
			[cell setFrame:theFrame];
		}
		
	} else { // las celdas seleccionadas terminan en la parte inferior
		
		for(UIBranaCell* cell in cellsForStories) {
			CGRect theRect = [cell bounds];
			CGRect theFrame = [cell frame];
			theFrame.origin.y -= offsetPerCell;
			//theFrame.origin.y -= upperOffset;
			theRect.size.height = newCellHeight;
			theFrame.size.height = newCellHeight;
			[cell setBounds:theRect];
			[cell setFrame:theFrame];
		}
	}

	NSLog(@"PINCHED: %f, %f",[[cellsForStories objectAtIndex:0] frame].origin.y, ([[cellsForStories lastObject] frame].origin.y + [[cellsForStories lastObject] bounds].size.height));
	
	// lower stories
	totalOffset = df.y - di.y;
	if(pinchingTop == YES) {
		totalOffset = totalOffset * 2;
	}
	
	cellsForStories = [[NSMutableArray alloc] initWithCapacity:[cells count]];
	numRows = [self countRows:lowerStories storingThemIn:&cellsForStories startingAtY: ui.y endingWith:di.y andMode:2];
	
	BOOL firstRowPinchingTop = YES;
	yForFirstRow =  [[cellsForStories objectAtIndex:0] frame].origin.y;
	xForFirstRow =  [[cellsForStories objectAtIndex:0] frame].origin.x;	
	if(xForFirstRow != 0) {
		NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
		for(UIBranaCell *tmpCell in cells) {
			if(tmpCell.frame.origin.y == yForFirstRow && tmpCell.frame.origin.x < xForFirstRow) {
				[tmpArray addObject:tmpCell];
			}
		}
		for(UIBranaCell* cell in cellsForStories) {
			[tmpArray addObject:cell];
		}
		[cellsForStories release];
		cellsForStories = tmpArray;
	}
	
	offsetPerCell = totalOffset / numRows;
	if([cellsForStories count] > 0) {
		newCellHeight = [[cellsForStories objectAtIndex:0] bounds].size.height - offsetPerCell;
		for(UIBranaCell* cell in cellsForStories) {
			if(firstRowPinchingTop == YES && yForFirstRow != [cell frame].origin.y) {
				firstRowPinchingTop = NO;
			}
			CGRect theRect = [cell bounds];
			CGRect theFrame = [cell frame];
			CGFloat totaHeight = [[cell superview] frame].size.height;
			if (theFrame.origin.y + theFrame.size.height < totaHeight) {
				//theFrame.origin.y += offsetPerCell;
				if (pinchingTop == YES) {
					if(firstRowPinchingTop == YES) {
						theFrame.origin.y += ((df.y - di.y) * 2);				
					} else {
						theFrame.origin.y += (df.y - di.y);
						theFrame.origin.y += ((df.y -di.y) / (numRows));						
					}
				} else {
					theFrame.origin.y += (df.y - di.y);
				}				
			}
			theRect.size.height = newCellHeight;
			theFrame.size.height = newCellHeight;
			[cell setBounds:theRect];
			[cell setFrame:theFrame];
		}
		NSLog(@"LOWER: %f, %f",[[cellsForStories objectAtIndex:0] frame].origin.y, [[cellsForStories objectAtIndex:0] bounds].size.height);		
		NSLog(@"--------------------------");
	}	
	//[self fillRectWithStories:pinchedStories forHeight:(df.y - uf.y) andWidth:width startingAt:uf.y];
	//[self fillRectWithStories:lowerStories forHeight:(height - df.y) andWidth:width startingAt:df.y];
	
}

-(int)countRows:(NSMutableArray*)stories storingThemIn:(NSMutableArray**)collectedCells startingAtY:(CGFloat)startY endingWith:(CGFloat)downY andMode:(int)mode{
	if([stories count]==0) {
		return 1;
	}
	int counter = 1;
	CGFloat rowHeight = 0;
	    //*collectedCells = [[NSMutableArray alloc] initWithCapacity:[cells count]];						
	int cellCounter = 0;
	
	BOOL initiated = NO; //checks if the first cell is found before starting counting rows
	while(!initiated && cellCounter < [cells count]) {
		UIBranaCell *tmpCell = [cells objectAtIndex:cellCounter];
		if([tmpCell story] == [stories objectAtIndex:0]) {
			if([tmpCell frame].origin.y <= startY && ([tmpCell frame].origin.y + [tmpCell bounds].size.height) <= startY && mode ==0) {			
				initiated = YES;
				rowHeight = [tmpCell frame].origin.y;				
			} else if([tmpCell frame].origin.y <= startY && ([tmpCell frame].origin.y + [tmpCell bounds].size.height) >= startY && mode ==1) {
				initiated = YES;
				rowHeight = [tmpCell frame].origin.y;
			} else if([tmpCell frame].origin.y >= downY && ([tmpCell frame].origin.y + [tmpCell bounds].size.height) >= downY && mode ==2) {
				initiated = YES;
				rowHeight = [tmpCell frame].origin.y;				
			} else {
				cellCounter++;				
			}
		} else {
			cellCounter++;				
		}
	}
	
	for(Story* story in stories) {
		if (initiated) {
			BOOL nextStory = NO;
			while(!nextStory) {
				UIBranaCell* thisCell = [cells objectAtIndex:cellCounter];
				if([thisCell story] == story) {
					BOOL cellFound = NO;
				    if( ([thisCell frame].origin.y + [thisCell bounds].size.height) <= startY && 
						[thisCell frame].origin.y < startY &&
						mode == 0) {
						[*collectedCells addObject:thisCell];												
						cellFound = YES;					
				    } else if( ([thisCell frame].origin.y + [thisCell bounds].size.height) >= startY && 
					           [thisCell frame].origin.y <= downY &&
							   mode == 1) {
						[*collectedCells addObject:thisCell];						
						cellFound = YES;											
					} else if( ([thisCell frame].origin.y + [thisCell bounds].size.height) >= downY && 
							   [thisCell frame].origin.y >= downY &&
							   mode == 2) {
						[*collectedCells addObject:thisCell];						
						cellFound = YES;											
					}
					if ([thisCell frame].origin.y !=rowHeight && cellFound) {
						counter++;
						rowHeight = [thisCell frame].origin.y;
					}
					cellCounter++;					
				} else {
					nextStory = YES;
				}
				
				if(cellCounter >= [cells count]) {
					break;
				}
			}		
		}
	}
	
	return counter;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
	CGRect frame = [introButtons frame];
	frame.origin.y += 200;
	[introButtons setFrame:frame];
	
	CGRect rosieframe = [rosie frame];
	rosieframe.origin.y -= 2000;
	[rosie setFrame:rosieframe];
	
	if([theTextField isSecureTextEntry]) {
		//UIWindow* win = [intro window];
		[intro removeFromSuperview];
		/*[win addSubview:branaView];
		[self setView:branaView];
		CGRect branaFrame =  [branaView frame];
		branaFrame.origin.x = 0;
		branaFrame.origin.y = 0;
		[branaView setFrame:branaFrame];
		*/
		[branaView addSubview:[self view]];
		[self realLoading];		
	}
	return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)theTextField {
	
	//if(theTextField == login || theTextField == password) {
		CGRect frame = [introButtons frame];
		frame.origin.y -= 200;
		[introButtons setFrame:frame];
	
      	CGRect rosieframe = [rosie frame];
		rosieframe.origin.y += 2000;
		[rosie setFrame:rosieframe];
	//}
	
	return YES;
}

-(void)realLoading {
	//TESTING
	[storyManager release];
	storyManager = [[StoryManager alloc] init];
	cells = [[NSMutableArray alloc] init];
	
	pivotalWeb = [[PivotalWebBroker alloc] initWithToken:TOKEN];
	NSMutableArray* projects = [pivotalWeb projects];
	Project* aProject = (Project*) [projects objectAtIndex:1];
	NSMutableArray* stories = [pivotalWeb storiesForProject:aProject];
	
	//[storyManager loadDemoStories];
	[storyManager loadStories:stories];
	//
    [super viewDidLoad];
	int points = [storyManager totalPoints];
	int remainingStories = [storyManager totalStories];
	
	int factorH = 0;
	int factorW = 0;
    BOOL cycle = NO;
	
	while (((BRANA_WIDTH_RATIO + factorW) * (BRANA_HEIGHT_RATIO + factorH)) < points) {
		if(cycle) {
			factorH++;
		} else {
			factorW++;
		}
		cycle = !cycle;
	}
	
	CGFloat width = [[self view] bounds].size.width;
	CGFloat height = [[self view] bounds].size.height;
	
	CGFloat cellWidth = width / (BRANA_WIDTH_RATIO + factorW);
	CGFloat cellHeight = height / (BRANA_HEIGHT_RATIO + factorH);
	defaultCellWidth = cellWidth;
	defaultCellHeight = cellHeight;
	
	int cellsPerRow = width / cellWidth;	
	int rowsPerBrana = height / cellHeight;	
	
	
	int storyCounter = 0;
	Story* currentStory = [storyManager storyAtIndex:storyCounter];
	int currentRemainingPoints = [currentStory points] - 1;
	
	for(int currentRow=0; currentRow<rowsPerBrana; currentRow++) {		
		for(int currentCell=0; currentCell<cellsPerRow; currentCell++) {
			if(remainingStories!=0) {
				CGRect nextFrame;
				nextFrame.origin.x = currentCell * cellWidth;
				nextFrame.origin.y = currentRow * cellHeight;
				nextFrame.size.height = cellHeight;
				nextFrame.size.width = cellWidth;
				
				int position = INNER;
				if(currentRemainingPoints == ([currentStory points]-1)) {
					position = LEFT_EDGE;
				} else if(currentRemainingPoints == 0) {
					position = RIGHT_EDGE;	
				}
				
				if([currentStory points] == 1) {
					position = UNICELL;
				}
				
				UIBranaCell *aCell = [[UIBranaCell alloc] initWithFrame:nextFrame story:currentStory andPosition:position];
				[cells addObject:aCell];
				[aCell setBranaController:self];
				[[self view] addSubview:aCell];
				
				if(currentRemainingPoints == 0) {
					remainingStories--;
					storyCounter++;
					currentStory = [storyManager storyAtIndex:storyCounter];
					currentRemainingPoints = [currentStory points];
				}
				
				currentRemainingPoints--;
			}
		}
	}	
	NSLog(@"TERMINE DE AÑADIR CELLS");
	
	//Developers
	developersController = [[DevelopersController alloc] initWithStories:stories 
																	view:[self view] 
														   andController:self];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	UIWindow* win = [[self view] window];
	[[self view] removeFromSuperview];
	[win addSubview:intro];
	
	CGRect frame = [intro frame];
	frame.origin.y +=20;
	[intro setFrame:frame];
	
	
	/*
	//TESTING
	[storyManager release];
	storyManager = [[StoryManager alloc] init];
	cells = [[NSMutableArray alloc] init];

	pivotalWeb = [[PivotalWebBroker alloc] initWithToken:@"a5fbb74ce05eb47adc5847cb83e9fb84"];
	NSMutableArray* projects = [pivotalWeb projects];
	Project* aProject = (Project*) [projects objectAtIndex:1];
	NSMutableArray* stories = [pivotalWeb storiesForProject:aProject];

	//[storyManager loadDemoStories];
	[storyManager loadStories:stories];
	//
    [super viewDidLoad];
	int points = [storyManager totalPoints];
	int remainingStories = [storyManager totalStories];
	
	int factorH = 0;
	int factorW = 0;
    BOOL cycle = NO;
	
	while (((BRANA_WIDTH_RATIO + factorW) * (BRANA_HEIGHT_RATIO + factorH)) < points) {
		if(cycle) {
			factorH++;
		} else {
			factorW++;
		}
		cycle = !cycle;
	}
	
	CGFloat width = [[self view] bounds].size.width;
	CGFloat height = [[self view] bounds].size.height;
	
	CGFloat cellWidth = width / (BRANA_WIDTH_RATIO + factorW);
	CGFloat cellHeight = height / (BRANA_HEIGHT_RATIO + factorH);
	defaultCellWidth = cellWidth;
	defaultCellHeight = cellHeight;
	
	int cellsPerRow = width / cellWidth;	
	int rowsPerBrana = height / cellHeight;	
	
	
	int storyCounter = 0;
	Story* currentStory = [storyManager storyAtIndex:storyCounter];
	int currentRemainingPoints = [currentStory points] - 1;
	
	for(int currentRow=0; currentRow<rowsPerBrana; currentRow++) {		
		for(int currentCell=0; currentCell<cellsPerRow; currentCell++) {
			if(remainingStories!=0) {
				CGRect nextFrame;
				nextFrame.origin.x = currentCell * cellWidth;
				nextFrame.origin.y = currentRow * cellHeight;
				nextFrame.size.height = cellHeight;
				nextFrame.size.width = cellWidth;
			
				int position = INNER;
				if(currentRemainingPoints == ([currentStory points]-1)) {
					position = LEFT_EDGE;
				} else if(currentRemainingPoints == 0) {
					position = RIGHT_EDGE;	
				}
			
				if([currentStory points] == 1) {
					position = UNICELL;
				}
			
				UIBranaCell *aCell = [[UIBranaCell alloc] initWithFrame:nextFrame story:currentStory andPosition:position];
				[cells addObject:aCell];
				[aCell setBranaController:self];
				[[self view] addSubview:aCell];
			
				if(currentRemainingPoints == 0) {
					remainingStories--;
					storyCounter++;
					currentStory = [storyManager storyAtIndex:storyCounter];
					currentRemainingPoints = [currentStory points];
				}
			
				currentRemainingPoints--;
			}
		}
	}	
	NSLog(@"TERMINE DE AÑADIR CELLS");
	
	//Developers
	developersController = [[DevelopersController alloc] initWithStories:stories 
																	view:[self view] 
														   andController:self];
	 */
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


// Cells Events

-(void)singleTouchInCell:(UIBranaCell*)cell {	
	[self setSelectedStory:[cell story]];
	[mainController changeSelectedStory:selectedStory];
	for(UIBranaCell *c in cells) {
		if([c selected] == YES) {
			[c setSelected:NO];
			[c setNeedsDisplay];
		}
		
		if([c story] == [cell story]) {
			[c setSelected:YES];
			[c setNeedsDisplay];			
		}
	}	
}

-(void)setDeveloper:(Developer*)developer showing:(BOOL)mustShow {
	for(Story *story in [developer stories]) {
		for(UIBranaCell *c in cells) {
			if([c story] == story) {
				[c setShowUser:mustShow];
				[c setNeedsDisplay];
			}
		}
	}
}

// Deallocation
- (void)dealloc {
	[storyManager release];
	[cells release];
	[pivotalWeb release];	
    [super dealloc];
}

@synthesize storyManager;
@synthesize mainController;
@synthesize selectedStory;
@synthesize defaultCellWidth;
@synthesize defaultCellHeight;
@synthesize intro;
@synthesize login;
@synthesize password;
@synthesize introButtons;
@synthesize rosie;
@synthesize branaView;


// Private methods
-(NSMutableArray*)storiesInRegionBetween:(CGPoint)upperPoint and:(CGPoint)lowerPoing {
	
}

-(void)fillRectWithStories:(NSMutableArray*)stories forHeight:(CGFloat)height andWidth:(CGFloat)width startingAt:(CGFloat)startingHeight {

	int points = 0;
	StoryManager* tmpStoryManager = [[StoryManager alloc] init];
	[tmpStoryManager loadStories:stories];
	
	points = [tmpStoryManager totalPoints];
	int remainingStories = [tmpStoryManager totalStories];
	
	int factorH = 0;
	int factorW = 0;
    BOOL cycle = NO;
	
	int widthRatio = 0;
	int heightRatio = 0;
		
	if(width>height) {
		widthRatio = 1;
		heightRatio = ((int)width/(int)height);
		if (heightRatio == 0) { 
			heightRatio = 1;
		}
	} else {
		heightRatio = 1;
		widthRatio = ((int)height/(int)width);
		if (widthRatio == 0) { 
			widthRatio = 1;
		}
	}
	
	if((widthRatio * heightRatio) != points)  {
		if((widthRatio * heightRatio) > points) {
			while (((widthRatio + factorW) * (heightRatio + factorH)) > points) {
				if(cycle) {
					if((heightRatio + factorH) > 1) {
						factorH--;
					}
				} else {
					if((widthRatio + factorW) > 1) {
						factorW--;
					}
				}
				cycle = !cycle;
			}		
		} else {
			while (((widthRatio + factorW) * (heightRatio + factorH)) < points) {
				if(cycle) {
					factorH++;
				} else {
					factorW++;
				}
				cycle = !cycle;
			}
		}
	}
	
	CGFloat cellWidth = width / (widthRatio + factorW);
	CGFloat cellHeight = height / (heightRatio + factorH);
	
	int cellsPerRow = width / cellWidth;	
	int rowsPerBrana = height / cellHeight;	
		
	int storyCounter = 0;
	Story* currentStory = [tmpStoryManager storyAtIndex:storyCounter];
	int currentRemainingPoints = [currentStory points];
	
	for(int currentRow=0; currentRow<rowsPerBrana; currentRow++) {		
		for(int currentCell=0; currentCell<cellsPerRow; currentCell++) {
			if(remainingStories!=0) {
				CGRect nextFrame;
				nextFrame.origin.x = currentCell * cellWidth;
				nextFrame.origin.y = currentRow * cellHeight + startingHeight;
				nextFrame.size.height = cellHeight;
				nextFrame.size.width = cellWidth;
				
				int position = INNER;				
				if(currentRemainingPoints == [currentStory points]) {
					position = LEFT_EDGE;
				} else if(currentRemainingPoints == 0) {
					position = RIGHT_EDGE;	
				}				
				
				
				UIBranaCell *aCell = [[UIBranaCell alloc] initWithFrame:nextFrame story:currentStory andPosition:position];
				[aCell setBranaController:self];
				[cells addObject:aCell];
				[[self view] addSubview:aCell];
				
				if(currentRemainingPoints == 0) {
					remainingStories--;
					storyCounter++;
					currentStory = [tmpStoryManager storyAtIndex:storyCounter];
					currentRemainingPoints = [currentStory points] + 1;
				}
				
				currentRemainingPoints--;
			}
		}
	}	
}

// Actions
-(void) resetBrana {
	NSLog(@"A RESETEAR");
	[(UIBranaView*)[self view] scheduleReset];
	[[self view] setNeedsDisplay];
}

-(void) flipStoryForCell:(UIBranaCell*)cell {
	NSLog(@"Flipping story for cell");
	[self singleTouchInCell:cell];
	[mainController flipView:[cell story]];
}

//

-(NSMutableArray*) getCells {
	return cells;
}

@end
