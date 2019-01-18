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


@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.billTotalField.delegate = self;
    self.tipPercentField.delegate = self;
    
}
-(void)calculateValues:(long int)tag{
    
    //get all the values
    float billAmount = [self.billTotalField.text floatValue];
    float tippercent = [self.tipPercentField.text floatValue];
    float tipAmount = [self.tipAmountField.text floatValue];
    float totalAmount = [self.totalField.text floatValue];
    
    //calculate based on tip percent
    if(tag == 0 || tag == 1){
        
        
        tipAmount = (tippercent/100)*billAmount;
        
        self.tipAmountField.text = [NSString stringWithFormat:@"%.02f",tipAmount ];
        
        //getting value from text field to avoid rounding errors
        self.totalField.text = [NSString stringWithFormat:@"%.02f",(billAmount + [self.tipAmountField.text floatValue]) ];
    }else if (tag == 2){
        //if a specific tip ampount was entered
        //TODO check for 0.00 total
        
        
    }
    
    
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"enter was pressed");
    //TODO use tag to tell which on was pressed
    [self calculateValues:textField.tag];
    
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


