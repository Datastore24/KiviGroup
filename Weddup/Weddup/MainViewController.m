//
//  MainViewController.m
//  Weddup
//
//  Created by Кирилл Ковыршин on 11.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "API.h" //Обращение к API
#import "ParserArticles.h" //Парсинг новостей
#import "ParsingResponseArticle.h" //Парсинг ответа от сервера
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "UIImage+Resize.h"//Ресайз изображения
#import "ParseDate.h"//Парсинг даты
#import "SingleTone.h"
#import "BBlock.h"

//Обновление
#import "KYPullToCurveVeiw.h"
#import "KYPullToCurveVeiw_footer.h"



@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (assign,nonatomic) NSUInteger newsCount;
@property (assign,nonatomic) NSUInteger offset;
@property (assign,nonatomic) NSUInteger maxCount;
@property (strong, nonatomic) NSMutableArray * arrayResponse; //массив данных

@property (nonatomic, strong) KYPullToCurveVeiw *headerView;
@property (nonatomic, strong) KYPullToCurveVeiw_footer *footerView;

@property (assign,nonatomic) BOOL isRefresh;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsCount = 10;
    self.offset = 0;
    self.arrayResponse = [NSMutableArray array]; // Создание массива данных
    
    self.headerView.alpha=0;
    self.footerView.alpha=0;
    self.isRefresh = YES;

    //Настройка разделителя статей
    [self.mainTableView setSeparatorColor:[UIColor purpleColor]];
    //
    
    //Параметры кнопки меню---------------------------------------
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    self.logoImage.frame=CGRectMake(0, 0, self.view.frame.size.width, 84);
    self.logoView.frame=CGRectMake(0, 64, self.view.frame.size.width, self.logoImage.frame.size.height+5);
    self.mainTableView.frame=CGRectMake(0, 64+self.logoView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.logoView.frame.size.height-64);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self getArticlesFromWeddup];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Получение статей
-(void) getArticlesFromWeddup{
    //Передаваемые параметры
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [NSNumber numberWithInteger:self.newsCount],@"count",
                             [NSNumber numberWithInteger:self.offset],@"offset",
                             nil];
    API * api =[API new]; //создаем API
    [api getDataFromServerWithParams:params method:@"action=load_articles" complitionBlock:^(id response) {
        //Запуск парсера
        ParsingResponseArticle * parsingResponce =[[ParsingResponseArticle alloc] init];
        //парсинг данных и запись в массив
        [parsingResponce parsing:response andArray:self.arrayResponse andView:self.view  andBlock:^{
            
            
            self.maxCount = [parsingResponce.article_count integerValue];

            if (self.isRefresh) {
                
                [self.headerView stopRefreshing];
                self.mainTableView.scrollEnabled = YES;
                
            }
            else {
                
                [self.footerView stopRefreshing];
                self.mainTableView.scrollEnabled = YES;
                
                
            }
                     [self reloadTableViewWhenNewEvent];
            
        }];
        
    }];
}

//Для рефрешера
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    /*
     Относительно предупреждений, это было связано с тем, что блок является объектом (сущностью в памяти) и такой объект должен быть высвобождени из памяти (потом). Объекты, которые инициализируются внутри блока имеют strong ссылку и эти объекты поставлены в зависимость от жизни объекта ViewController. Таким образом компилятор предупреждает о том, что возможно блок не сможет быть высвобожден из памяти.
     Чтоб это исправить, мы должны указать объектам, которые инициализируются внутри блока, что их жизнь, в данном конкретном случае зависит не от вью контроллера, а от блока.
     Для этого необходимо создать локальную переменную (как приведено ниже), которая будет иметь weak (слабую) ссылку на объект. Теперь блок может быть высвобожден из памяти
     Под эту тему нашел оч хороший класс, который реализует основные задачи с блоками в GCD, а так же прием описанный выше. Я этот класс дополнил возможностью выполнения задачи синхронно, в общем можно пользоваться
     
     */
    
    self.headerView = [[KYPullToCurveVeiw alloc]initWithAssociatedScrollView:self.mainTableView withNavigationBar:YES];
    
    
    BBlockWeakSelf wself = self;
    [self.headerView  addRefreshingBlock:^{
        
        wself.isRefresh = YES;
        wself.mainTableView.scrollEnabled = NO;
        wself.offset = 0;
        wself.newsCount=10;
        [wself getArticlesFromWeddup];
        
    }];
    
    
    self.footerView = [[KYPullToCurveVeiw_footer alloc]initWithAssociatedScrollView:self.mainTableView withNavigationBar:YES];
    
    
    
    [self.footerView addRefreshingBlock:^{
        
        if (wself.offset + wself.newsCount < wself.maxCount) {
            wself.isRefresh = NO;
            wself.mainTableView.scrollEnabled = NO;
            wself.offset = self.offset + self.newsCount;
            [wself getArticlesFromWeddup];
        }else{
            wself.offset=wself.maxCount;
            wself.mainTableView.scrollEnabled = YES;
            wself.newsCount=wself.maxCount;
            [wself.footerView stopRefreshing];
        }
        
    }];
    
    
}

//

//Обновление таблицы
- (void)reloadTableViewWhenNewEvent {
    
    
    [self.mainTableView
     reloadSections:[NSIndexSet indexSetWithIndex:0]
     withRowAnimation:UITableViewRowAnimationFade];
    
    self.mainTableView.scrollEnabled = YES;
    
    //    Перезагрузка таблицы с
    //    анимацией
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.arrayResponse.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"newsCell";
    
    
    UITableViewCell *newsCell =
    [tableView dequeueReusableCellWithIdentifier:identifier
                                    forIndexPath:indexPath];
    
    ParserArticles * parser = [self.arrayResponse objectAtIndex:indexPath.row];
    
    
    [BBlock dispatchOnMainThreadSync:^{
        for (UIView * view in newsCell.contentView.subviews) {
            
            [view removeFromSuperview];
        }
        
        [self setActivityIndicatorForCell:parser cell:newsCell];
    }];
    
    
    
    [newsCell.contentView addSubview:[self getViewForCellWithResponse:parser cell:newsCell]];
    
    return newsCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ParserArticles * parse = [self.arrayResponse objectAtIndex:indexPath.row];
    
    return parse.targetHeightText+parse.targetHeightImage+5;
    
    
}



-(UIView *) getViewForCellWithResponse: (ParserArticles *) response  cell :(UITableViewCell *) cell{
    
    UIView * resultView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, response.targetHeightText+response.targetHeightImage)];
    
    UILabel * dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-130, 8, 100, 20)];
    dateLabel.textAlignment = NSTextAlignmentRight;
    
    ParseDate * parseDate =[[ParseDate alloc] init];
    
    //Изменения даты
    if([response.article_date isEqual:[parseDate dateFormatToDay]]){
        dateLabel.text = @"сегодня";
    }else if([response.article_date isEqual:[parseDate dateFormatToYesterDay]]){
        dateLabel.text = @"вчера";
    }else if([response.article_date isEqual:[parseDate dateFormatToDayBeforeYesterday]]){
        dateLabel.text = @"позавчера";
    }else{
        dateLabel.text = response.article_date;
    }
    //
    
    dateLabel.textColor = [UIColor lightGrayColor];
    dateLabel.font = [UIFont systemFontOfSize:11];
    
    
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 33, 200, response.targetHeightText)];
    
    
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.selectable =NO;
    textView.userInteractionEnabled = NO;
    textView.font=[UIFont systemFontOfSize:15];
    textView.textColor = [UIColor purpleColor];
    textView.text=response.article_name;
    
    
    
    
    
    
    UIView * conteinerImage = [[UIView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height/2 - 35, 70, 70)];
    conteinerImage.layer.cornerRadius = 35.0;
    conteinerImage.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    conteinerImage.layer.shadowOffset = CGSizeMake(3, 3);
    conteinerImage.layer.shadowOpacity = 1;
    conteinerImage.layer.shadowRadius = 1.0;
    conteinerImage.clipsToBounds = NO;
    
    
    
    
    __block UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 70, 70)];
    //imageView.center = CGPointMake(cell.center.x, cell.center.y);

    
    //SingleTone с ресайз изображения
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:response.article_general_photo
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if(image){
                                [BBlock dispatchOnMainThreadSync:^{
                                    for (UIView * view in cell.contentView.subviews) {
                                        
                                        if (view.tag == 25) {
                                            
                                            [view removeFromSuperview];
                                            
                                        }
                                        
                                    }
                                }];
                                
                                [UIView transitionWithView:imageView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                    imageView.image = image;
                                    
                                    /*
                                     UIViewContentModeScaleToFill,
                                     UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
                                     UIViewContentModeScaleAspectFill,
                                     */
                                    imageView.contentMode=UIViewContentModeScaleAspectFill;
                                    imageView.layer.cornerRadius = 35.0;
                                    imageView.layer.masksToBounds = YES;
                                    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
                                    imageView.layer.borderWidth = 3.0;
                                    //imageView.layer.masksToBounds = YES;
                                    //imageView.clipsToBounds = YES;
                                } completion:nil];
                                
                                
                                
                            }
                        }];
    [resultView addSubview:dateLabel];
    [resultView addSubview:textView];
    [conteinerImage addSubview:imageView];
    [resultView addSubview:conteinerImage];
    
    
    return resultView;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Другое окно с деталями заказа
    /*
    DetailNewsViewController *detailNews = [self.storyboard
                                            instantiateViewControllerWithIdentifier:@"detailNews"];
    
    detailNews.arrayWithData = self.arrayResponse;
    
    
    [[SingleTone sharedManager] setNewsArticleId:indexPath.row]; //Создание синглтона, который передаст ID заказа
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:detailNews
                                         animated:YES];
     */
    
}

- (void)setActivityIndicatorForCell:(ParserArticles *) response cell :(UITableViewCell *) cell
{
    
    if (response.targetHeightImage > 0) {
        
        
        UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc]
                                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.tag = 25;
        [indicator startAnimating];
        indicator.frame = CGRectMake(self.view.frame.size.width / 2 - 10,
                                     response.targetHeightImage / 2 - 10, 20, 20);
        [cell.contentView addSubview:indicator];
        
    }
    
}



@end
