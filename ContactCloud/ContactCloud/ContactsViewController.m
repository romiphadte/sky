//
//  ContactsViewController.m
//  ContactCloud
//
//  Created by Neeraj Baid on 9/21/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@property (strong, nonatomic) NSMutableArray *allResults;
@property (strong, nonatomic) NSMutableArray *serverSearchResults;

@end

@implementation ContactsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _allResults = [[NSUserDefaults standardUserDefaults] objectForKey:@"Local Contacts"];
    
    NSSortDescriptor *server = [[NSSortDescriptor alloc] initWithKey:@"isFromServer" ascending:YES];
    NSSortDescriptor *fullName = [[NSSortDescriptor alloc] initWithKey:@"FullName" ascending:YES];
    _allResults = [[_allResults sortedArrayUsingDescriptors:[NSArray arrayWithObjects:server, fullName, nil]] mutableCopy];
    
    [self.searchDisplayController setActive:YES];
    [self.searchDisplayController.searchBar becomeFirstResponder];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Results";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *currentInfo = [_allResults objectAtIndex: indexPath.row];
    if ([[currentInfo objectForKey: @"isFromServer"] isEqualToString:@"YES"])
        cell.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    else
    {
        cell.detailTextLabel.text = [currentInfo objectForKey:@"Phone"];
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    }
    
    cell.textLabel.text = [currentInfo objectForKey:@"FullName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [_allResults count] - [_serverSearchResults count])
    {}
        //* do some segue
        //* is a saved contact, load that data
    else
    {}
        //* is not a saved contact, send request
}

#pragma mark - Search

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [_allResults removeAllObjects];
    
    PFQuery *fullNameQuery = [PFQuery queryWithClassName:@"CLASS NAME FOR FULL NAME"];
    [fullNameQuery whereKey:@"fullname" containsString:searchText];
    // * server waiting spinner on + appear
    [fullNameQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // * server waiting spinner off + disappear
        // * parse objects to fit data structure of _allResults
        // * key:isFromServer value: YES
        _serverSearchResults = [objects mutableCopy];
        NSLog(@"%@", [_serverSearchResults description]);
    }];
    
    NSArray *contacts = [[NSUserDefaults standardUserDefaults] objectForKey:@"Local Contacts"];
    
    // Filter the array using NSPredicate
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"FullName contains[c] %@", searchText];
    NSMutableArray *searchResults = [NSMutableArray arrayWithArray:[contacts filteredArrayUsingPredicate:pred]];
    _allResults = searchResults;
    
    /*
    NSSet *intermediate = [NSSet setWithArray:searchResults];
    [intermediate addObjectsFromArray:_serverSearchResults];
    _allResults = [intermediate allObjects];
     */
    
    NSSortDescriptor *server = [[NSSortDescriptor alloc] initWithKey:@"isFromServer" ascending:YES];
    NSSortDescriptor *fullName = [[NSSortDescriptor alloc] initWithKey:@"FullName" ascending:YES];
    _allResults = [[_allResults sortedArrayUsingDescriptors:[NSArray arrayWithObjects:server, fullName, nil]] mutableCopy];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
