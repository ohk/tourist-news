#  Test Case OHK Tourist News

# Architecture (MVVM)

I had two options, MVC and MVVM. My choice here was MVVM. On the MVC side, ui and workflow must be in the same file. This means that changes to be made during development may break the workflow or the ui. It will cause administrative problems during test. For these reasons, I chose MVVM.

# Libraries Used in the Project

RXSwift -> Reactive Programming for MVVM
RXCocoa -> Reactive Programming for MVVM
Lottie -> Loading animation
SDWebImage -> Image caching and optimizer

# Project Architecture

Util -> Project global reachable
Network -> Network files
Extension -> Project Global Extensions
Data -> Data Models
Resources -> Project Resources
Views -> UI & UIModels
Commons -> AppDelegate & SceneDelegate files
