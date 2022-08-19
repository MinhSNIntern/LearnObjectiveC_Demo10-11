//
//  SceneDelegate.m
//  Demo10
//
//  Created by vfa on 8/19/22.
//

#import "SceneDelegate.h"
#import "CollectionViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate
-(UICollectionViewFlowLayout * ) flowLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.minimumLineSpacing = 20.0f;
    layout.minimumInteritemSpacing = 10.0f;
    layout.itemSize = CGSizeMake(80, 120);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    layout.headerReferenceSize = CGSizeMake(300, 50);
    layout.footerReferenceSize = CGSizeMake(300, 50);
    return layout;
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    UIWindowScene *windowScene = (UIWindowScene *) scene;
       _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
       CollectionViewController* initViewController = [[CollectionViewController alloc] initWithCollectionViewLayout:[self flowLayout]];
       UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:initViewController];
       _window.rootViewController = navController;
       [_window makeKeyAndVisible];
       _window.windowScene = windowScene;
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
