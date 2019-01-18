//
//  TipViewController.m
//  TipCalculator
//
//  Created by Spencer Symington on 2019-01-18.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTotalField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentField;
@property (weak, nonatomic) IBOutlet UITextField *totalField;
@property (weak, nonatomic) IBOutlet UITextField *tipAmountField;
@property (weak, nonatomic) IBOutlet UILabel *tipRating;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;


@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.billTotalField.delegate = self;
    self.tipPercentField.delegate = self;
    self.tipAmountField.delegate = self;
    self.totalField.delegate = self;
    
}
- (IBAction)sliderChanged:(UISlider*)slider {
    NSLog(@"slider changed %f",slider.value);
    self.tipPercentField.text = [NSString stringWithFormat:@"%.01f" ,slider.value];
    [self calculateValuesWithTag:4];
}
-(void)calculateValuesWithTag:(long int)tag{
    float billAmount = [self.billTotalField.text floatValue];
    float tipPercent = [self.tipPercentField.text floatValue];
    float tipAmount = [self.tipAmountField.text floatValue];
    float totalAmount = [self.totalField.text floatValue];
    
    [self calculateValuesWithTag:tag andBill:billAmount andPercent:tipPercent andTipAmount:tipAmount andTotalAmt:totalAmount];
    
}
-(void)calculateValuesWithTag:(long int)tag andBill:(float)bill andPercent:(float)percent andTipAmount:(float)tipAmt andTotalAmt:(float)totalAmt{
    //this method is called specifically when we need to append a textFields value in order to get real time updates
    
    //get all the values
    float billAmount = bill;
    float tipPercent = percent;
    float tipAmount = tipAmt;
    float totalAmount = totalAmt;
    
    //calculate based on tip percent
    if(tag == 0 || tag == 1 || tag == 4){
        
        
        tipAmount = (tipPercent/100)*billAmount;
        
        self.tipAmountField.text = [NSString stringWithFormat:@"%.02f",tipAmount ];
        
        //getting value from text field to avoid rounding errors
        self.totalField.text = [NSString stringWithFormat:@"%.02f",(billAmount + [self.tipAmountField.text floatValue]) ];
        
    }else if (tag == 2){
        //if a specific tip ampount was entered
        //calculate the tip percent and the total with tip
        //TODO check for 0.00 total
        tipPercent = (tipAmount / billAmount)*100;
        totalAmount = billAmount + tipAmount;
        self.tipPercentField.text = [NSString stringWithFormat:@"%.01f", tipPercent ];
        self.totalField.text = [NSString stringWithFormat:@"%.02f",totalAmount];
        
        
        
        
    }else if(tag == 3){
        //the desired total was entered
        //calculate the tipPercent and the tipAmount
        tipAmount = totalAmount - billAmount;
        tipPercent = (tipAmount / billAmount)*100;
        
        self.tipPercentField.text = [NSString stringWithFormat:@"%.01f", tipPercent ];
        self.tipAmountField.text = [NSString stringWithFormat:@"%.02f",tipAmount ];
    }
    
    if(tag != 4){
        //only update the slider if the slider wasn't changed
        self.tipSlider.value = tipPercent;
    }
    [self rateTip:tipPercent];
    
    
}
-(void)rateTip:(float)tipPercent{
    
    if(tipPercent < 0){
        self.tipRating.text = @"that... is stealing...";
        return;
    }
    if(tipPercent < 5.0 ){
         self.tipRating.text = @"terrible";
        return;
    }
    if(tipPercent < 7.0 ){
        self.tipRating.text = @"pretty bad";
        return;
    }
    if(tipPercent < 10.0 ){
        self.tipRating.text = @"cheap";
        return;
    }
    if(tipPercent < 12.0 ){
        self.tipRating.text = @"OK";
        return;
    }
    if(tipPercent < 15.5 ){
        self.tipRating.text = @"Good";
        return;
    }
    if(tipPercent < 18.0 ){
        self.tipRating.text = @"Savy";
        return;
    }
    if(tipPercent < 23.0 ){
        self.tipRating.text = @"Great";
        return;
    }
    
    if(tipPercent < 30.0 ){
        self.tipRating.text = @"Awesome";
        return;
    }
    
    if(tipPercent < 36.5 ){
        self.tipRating.text = @"Generous";
        return;
    }
    if(tipPercent < 50.5 ){
        self.tipRating.text = @"Charitable";
        return;
    }
    if(tipPercent < 70.5 ){
        self.tipRating.text = @"Altruistic";
        return;
    }
    
    if(tipPercent < 85.5 ){
        self.tipRating.text = @"Benevolent";
        return;
    }
    if(tipPercent < 100 ){
        self.tipRating.text = @"Baller";
        return;
    }
    if(tipPercent > 100 ){
        self.tipRating.text = @"Baller+";
        return;
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    float billAmount = [self.billTotalField.text floatValue];
    float tipPercent = [self.tipPercentField.text floatValue];
    float tipAmount = [self.tipAmountField.text floatValue];
    float totalAmount = [self.totalField.text floatValue];
    
    
    if([textField isEqual:self.billTotalField]){
        if(range.length == 1){
            
            NSString *newValueString = [self.billTotalField.text substringFromIndex:range.length];
            billAmount = [newValueString floatValue];
        }else{
            
            NSString *newValueString = [self.billTotalField.text stringByAppendingString:string];
            billAmount = [newValueString floatValue];
        }
       
        
        
    }else if([textField isEqual:self.tipPercentField]){
        
        
        if(range.length == 1){
            NSString *newValueString = [self.tipPercentField.text substringFromIndex:range.length];
            tipPercent = [newValueString floatValue];
            
        }else{
            
            NSString *newValueString = [self.tipPercentField.text stringByAppendingString:string];
            tipPercent = [newValueString floatValue];
        }
        
    }else if([textField isEqual:self.tipAmountField]){
        if(range.length == 1){
            
            
            NSString *newValueString = [self.tipAmountField.text substringFromIndex:range.length];
            tipAmount = [newValueString floatValue];
        }else{
            
            NSString *newValueString = [self.tipAmountField.text stringByAppendingString:string];
            tipAmount = [newValueString floatValue];
        }
        
        
    }else if([textField isEqual:self.totalField]){
        if(range.length == 1){
            
            NSString *newValueString = [self.totalField.text substringFromIndex:range.length];
            totalAmount = [newValueString floatValue];
        }else{
            
            NSString *newValueString = [self.totalField.text stringByAppendingString:string];
            totalAmount = [newValueString floatValue];
        }
        
        
    }
    
    
    [self calculateValuesWithTag:textField.tag andBill:billAmount andPercent:tipPercent andTipAmount:tipAmount andTotalAmt:totalAmount];
    
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"enter was pressed");
    //TODO use tag to tell which on was pressed
    [self calculateValuesWithTag:textField.tag];
    
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


