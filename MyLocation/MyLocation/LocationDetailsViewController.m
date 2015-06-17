//
//  LocationDetailsViewController.m
//  MyLocation
//
//  Created by wangx on 15/5/3.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LocationDetailsViewController.h"
#import "CategoryPickViewController.h"
#import "HudView.h"
#import "Location.h"
@implementation LocationDetailsViewController{
    NSString *_descriptionText;
    NSString *_categoryName;
    NSDate *_date;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.descriptionTextView.text=_descriptionText;
    self.categoryLabel.text=_categoryName;
    self.dateLabel.text=[self formateDate:_date];
    self.latitudeLabel.text=[NSString stringWithFormat:@"%.8f",self.coordinate.latitude];
    self.longitudeLabel.text=[NSString stringWithFormat:@"%.8f",self.coordinate.longitude];
    if (self.placemark!=nil) {
        self.addressLabel.text=[self stringFromPlacemark:self.placemark];
    }else{
        self.addressLabel.text=@"No Address Found";
    }
    self.dateLabel.text=[self formateDate:[NSDate date]];
    
    UITapGestureRecognizer *gestureRecognzer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard:)];
    gestureRecognzer.cancelsTouchesInView=NO;
    [self.tableView addGestureRecognizer:gestureRecognzer];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _descriptionText=@"";
        _categoryName=@"No Category";
        _date=[NSDate date];
    }
    return self;
}

-(void)hideKeyboard:(UIGestureRecognizer *)gestureRecognzer{
    CGPoint point=[gestureRecognzer locationInView:self.tableView];
    NSIndexPath *indexPath=[self.tableView indexPathForRowAtPoint:point];
    if (indexPath!=nil&&indexPath.section==0&&indexPath.row==0) {
        return ;
    }
    [self.descriptionTextView resignFirstResponder];
}

-(NSString *)stringFromPlacemark:(CLPlacemark *)thePlacemark{
    NSString *result=[NSString stringWithFormat:@"%@ %@\n %@ %@ %@",thePlacemark.subThoroughfare,thePlacemark.thoroughfare,thePlacemark.locality,thePlacemark.administrativeArea,thePlacemark.postalCode];
    return result;
}
-(NSString *)formateDate:(NSDate *)theDate{
    static NSDateFormatter *formatter=nil;
    if (formatter==nil) {
        formatter=[[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return [formatter stringFromDate:theDate];
}
#pragma mark UITableViewDelegate返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0){
        return 88;
    }else if (indexPath.section==2&&indexPath.row==2){
        CGRect rect=CGRectMake(100, 10, 205, 10000);
        self.addressLabel.frame=rect;
        [self.addressLabel sizeToFit];
        
        rect.size.height=self.addressLabel.frame.size.height;
        self.addressLabel.frame=rect;
        return self.addressLabel.frame.size.height+20;
    }else{
        return 44;
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    _descriptionText=[textView.text stringByReplacingCharactersInRange:range withString:text];
    return YES;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0||indexPath.section==1){
        return  indexPath;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        [self.descriptionTextView becomeFirstResponder];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    _descriptionText=textView.text;
}

-(IBAction)done:(id)sender{
    //NSLog(@"Description '%@'",_descriptionTextView);
    //[self closeScreen];
    HudView *hudView = [HudView hudInView:self.navigationController.view animated:YES]; hudView.text = @"Tagged";
    Location *location=[NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    location.locationDescription=_descriptionText;
    location.category=_categoryName;
    location.latitude=@(self.coordinate.latitude);
    location.longitude=@(self.coordinate.latitude);
    location.date=_date;
    location.placemark=self.placemark;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error:%@",error);
        abort();
    }
    
    [self performSelector:@selector(closeScreen) withObject:nil afterDelay:0.6];
}
-(IBAction)cancel:(id)sender{
    [self closeScreen];
}
-(void)closeScreen{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"PickCategory"]) {
        CategoryPickViewController *controller=segue.destinationViewController;
        controller.selectedCategoryName=_categoryName;
        self.categoryLabel.text=_categoryName;
    }
}

@end
