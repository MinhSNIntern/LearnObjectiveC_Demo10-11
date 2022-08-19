//
//  CollectionViewController.m
//  Demo10
//
//  Created by vfa on 8/19/22.
//

#import "CollectionViewController.h"
#import "MyCollectionViewCell.h"
#import "Header/Header.h"
#import "Footer/Footer.h"

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(NSArray *) allImages{
    
    static NSArray *allImageSections = nil;
    if(allImageSections == nil){
        allImageSections = @[[UIImage imageNamed:@"Image"],
                              [UIImage imageNamed:@"Image-1"],
                              [UIImage imageNamed:@"Image-2"]];
        
    }
    return  allImageSections;
}

-(UIImage *) randomImage{
    return [self allImages][arc4random_uniform((uint32_t)[self allImages].count)];
    
}
-(NSArray *) allSectionColors{
    
    static NSArray *allColors = nil;
    
    if(allColors ==nil){
        allColors = @[UIColor.redColor,
                      UIColor.greenColor,
                      UIColor.blueColor];
        
    }
    return  allColors;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if(self != nil){
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class]) bundle:[NSBundle mainBundle]];
        [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
        
        UINib *headerNib = [UINib nibWithNibName:NSStringFromClass([Header class]) bundle:[NSBundle mainBundle]];
        
        [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        UINib *footerNib = [UINib nibWithNibName:NSStringFromClass([Footer class]) bundle:[NSBundle mainBundle]];
        [self.collectionView registerNib:footerNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    }
    return  self;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"Header";
    
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        reuseIdentifier = @"Footer";
    
    }
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
    
        Header *header = (Header *) view;
        
        header.headerLabel.text = [NSString stringWithFormat:@"Section Header %lu",(unsigned long)indexPath.section+1];
        [header.headerLabel sizeToFit];
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        Footer *footer = (Footer *) view;
        
        NSString *title = [NSString stringWithFormat:@"Section Header %lu",(unsigned long)indexPath.section+1];
        [footer.footerBtn setTitle:title forState:UIControlStateNormal];
        [footer.footerBtn sizeToFit];
    }
    return  view;
}
- (UIContextMenuConfiguration *)collectionView:(UICollectionView *)collectionView contextMenuConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point{
    UIContextMenuConfiguration *configuration = [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil actionProvider:^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
        NSMutableArray * action = [[NSMutableArray alloc] init];
        
        [action addObject:[UIAction actionWithTitle:@"Copy" image:[UIImage systemImageNamed:@"star"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
            MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [[UIPasteboard generalPasteboard] setImage:cell.imageView.image];
        }]];
        
        UIMenu *menu = [UIMenu menuWithTitle:@"Context Menu" children:action];
        return menu;
    }];
    return configuration;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    UIPinchGestureRecognizer *pinch =[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinches:)];
    
    for(UIGestureRecognizer *recognizer in
        self.collectionView.gestureRecognizers){
    if([recognizer isKindOfClass:[pinch class]]){
        [recognizer requireGestureRecognizerToFail:pinch];
    }
    }
    [self.collectionView addGestureRecognizer:pinch];
    
    // Do any additional setup after loading the view.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) handlePinches:(UIPinchGestureRecognizer *) sender{
    
    CGSize defaultLayoutItems = CGSizeMake(80, 120);
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.itemSize = CGSizeMake(defaultLayoutItems.width*sender.scale, defaultLayoutItems.height*sender.scale);
    
    [layout invalidateLayout];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return  3+ arc4random_uniform(4);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 5 + arc4random_uniform(6);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if([self randomImage] == nil) NSLog(@"Null");
    cell.imageView.image = [self randomImage];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;

    // Configure the cell
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];

    [UIView animateWithDuration:0.2 animations:^{
        selectedCell.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            selectedCell.alpha = 1.0f;
        }];
    }];
}


 
 //use if want to show highlight animation
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.2 animations:^{
        selectedCell.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.2 animations:^{
        selectedCell.transform = CGAffineTransformMakeScale(1, 1);
    }];
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/


// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item



@end
