# flutter_common_template

flutter 项目通用模板

![building](https://img.shields.io/badge/building-passing-green)
![issues](https://img.shields.io/github/issues/chachaxw/flutter_common_template)
![forks](https://img.shields.io/github/forks/chachaxw/flutter_common_template)
![stars](https://img.shields.io/github/stars/chachaxw/flutter_common_template)
![license](https://img.shields.io/github/license/chachaxw/flutter_common_template)

## 1.1 开始

这份说明将为你展示该项目结构、所用工具以及运行环境、代码规范等，请认真阅读

### 1.1.1 🔨 运行

> 升级 Dart SDK 到 beta 2.12.0-0 以上版本，正常情况下运行会出现报错，需要在命令行后面
> 添加 `--no-sound-null-safety`，绕过最新版 Dart 的 null-safety 机制，具体可以访问
> [no-sound-null-safety](https://dart.dev/go/no-sound-null-safety) 查看详细说明

默认生产环境 `flutter run`

测试环境 `flutter run -t lib/main_test.dart`

开发环境 `flutter run -t lib/main_dev.dart`

建议运行前配置国内镜像

```Dart
/// 配置全局环境变量
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

## 1.2 🔧 开发环境

- [VS Code](https://code.visualstudio.com/)
- [XCode](https://developer.apple.com/xcode/)
- [Dart](https://nodejs.org/en/)
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Fastlane](https://docs.fastlane.tools/)
- [Mac 命令行工具](https://zhuanlan.zhihu.com/p/53380250)

## 1.3 ✨ VSCode 插件推荐

- [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
- [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [GitLens](https://gitlens.amod.io)
- [Path Autocomplete](https://marketplace.visualstudio.com/items?itemName=ionutvmi.path-autocomplete)
- [Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer)
- [TODO Highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight)
- [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)

## 1.4 👣 可运行的命令

### 1.4.1 全平台打包

开发环境 `./build.sh dev`

测试环境 `./build.sh test`

生产环境 `./build.sh`

### 1.4.2 iOS 构建

生产环境构建 `flutter build ios --release`

测试环境构建 `flutter build ios -t lib/main_test.dart --release`

开发环境构建 `flutter build ios -t lib/main_dev.dart --release`

### 1.4.3 安卓构建

生产环境构建 `flutter build apk --target-platform=android-arm64`

测试环境构建 `flutter build apk -t lib/main_test.dart --target-platform=android-arm64`

开发环境构建 `flutter build apk -t lib/main_dev.dart --target-platform=android-arm64`

### 1.4.4 部署流程

`master` 开发分支, CI 自动打包为开发版

`staging/*` 稳定测试分支, CI 自动打包为测试版, 发布给测试和内部人员试用

`release/*` 发布分支, CI 自动打包为版发布版, 对外正式发布

## 1.5 🏯 项目架构说明

### 1.5.1 项目目录结构

```dart

|-- flutter
    |-- .gitignore                          # Git ignore 配置（禁止随意篡改配置!!!）
    |-- pubspec.yaml                        # 依赖配置和图片配置
    |-- android                             # 安卓文件
    |   |-- ...
    |-- build                               # 打包文件
    |   |-- ...
    |   |-- ios
    |       |-- ...
    |-- ios                                 # ios文件
    |   |-- ...
    |-- lib
    |   |-- app.dart                        # App 全局页面
    |   |-- env.dart                        # App 环境变量配置
    |   |-- main.dart                       # 入口文件(默认生产环境)
    |   |-- main_dev.dart                   # 入口文件(开发环境)
    |   |-- main_test.dart                  # 入口文件(测试环境)
    |   |-- routes.dart                     # APP 页面路由配置
    |   |-- store.dart
    |   |-- actions                         # 全局actions
    |   |   |-- actions.dart                # 暴露导出文件
    |   |   |-- base_actions.dart
    |   |   |-- ...
    |   |-- models                          # 全局models
        |   |-- models.dart                 # 暴露导出文件
    |   |   |-- app_state.dart
    |   |   |-- ...
    |   |   |-- bean                        # 服务端返回数据model
    |   |       |-- task_model.dart
    |   |       |-- task_model.g.dart
    |   |       |-- ...
    |   |-- pages                           # 页面模块
    |   |   |-- pages.dart                  # 全局页面导出文件
    |   |   |-- home                        # 单个页面模块
    |   |   |   |-- home.dart
    |   |   |   |-- home_page.dart
    |   |   |   |-- actions
    |   |   |   |   |-- actions.dart
    |   |   |   |   |-- home_actions.dart
    |   |   |   |   |-- ...
    |   |   |   |-- models
    |   |   |   |   |-- home_state.dart
    |   |   |   |   |-- models.dart
    |   |   |   |   |-- ...
    |   |   |   |-- view_models
    |   |   |   |   |-- home_view_model.dart
    |   |   |   |   |-- ...
    |   |   |   |-- widgets
    |   |   |       |-- drop_menu.dart
    |   |   |       |-- ...
    |   |-- services                         # API请求服务
    |   |   |-- ...
    |   |-- utils                            # 全局工具函数
    |   |   |-- ...
    |   |-- widgets                          # 全局公共组件
    |       |-- checkbox.dart
    |       |-- picker
    |           |-- ...
    |-- test
        |-- widget_test.dart
```

## 1.6 技术栈

[`Flutter`](https://flutterchina.club/) [`Dart`](https://www.dartcn.com/) [`Redux`](https://github.com/reduxjs/redux) [`Async Redux`](https://pub.flutter-io.cn/packages/async_redux)

### 项目结构详细说明

我们使用[Dart](https://www.dartcn.com/)作为编码标准，开始之前请阅读。

#### Widgets

Widgets 目录只能放全局的公共组件并保证该文件夹没有冗余的代码和文件, 该目录后期可以独立为一个组件库, 不断迭代完善这个组件库, 方便后期扩展使用

```dart
|-- widgets                              # 全局组件目录
|   |-- checkbox.dart
|   |-- ...
|   |-- picker
|       |-- picker.dart
|       |-- picker_body.dart
|       |-- picker_dialog.dart
|       |-- picker_header.dart
|       |-- ...
```

#### Actions

Actions 目录只能放全局的公共的 actions, 比如全局的 Loading Action, Alert Action, Dialog Action 等。该目录下包含一个`BaseAction`抽象类, 其他所有的 Actions 都需要继承该 BaseAction 类, 方便在 Actions 中获取 State 数据. 我们的业务逻辑统统都可以放到 Action 当中的 reduce 函数中, 该函数可以是同步函数, 也可以是异步函数, 同时需要返回`AppState`.

```Dart
/// Actions目录结构
|-- actions                              # 全局组件目录
|   |-- actions.dart
|   |-- base_actions.dart                # Base Actions
|   |-- ...
```

```BaseAction
/// BaseAction基本内容
import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/pages/login/models/models.dart';

abstract class BaseAction extends ReduxAction<AppState> {
  LoginState get loginState => state.loginState;
  MainState get mainState => state.mainState;
}
```

ShowToastAction 继承 BaseAction 类示例:

```Dart
import 'package:flutter_common_template/actions/actions.dart';

class ShowToastAction extends BaseAction {
  String msg;
  BuildContext context;

  ShowToastAction(this.msg, this.context);

  @override
  AppState reduce() {
    Toast.show(msg, context, gravity: 1, duration: 2);
    return null;
  }
}
```

具体详情可以 👉[Action Subclassing](https://pub.flutter-io.cn/packages/async_redux#action-subclassing)

#### Models

Models 目录包含全局的 AppState 和 CommonState, AppState 是全局的基础数据状态, 包含用户信息, 登录信息等基础信息, CommonState 是全局通用数据状态, 例如路点数据, 定位数据, 对话框状态等通用数据可以放该文件.
Model 基本结构如下

```Dart
class MainState {
  bool isLoading;

  MainState({this.isLoading});

  static MainState initialState() => MainState(isLoading: false);

  MainState copy({ bool isLoading }) =>
      MainState(isLoading: isLoading ?? this.isLoading);
}

```

所有的 Model 基本包含两个要素，一个`initialState` 初始化状态的方法, 一个修改状态的`copy`方法, 当 Action 当中需要修改状态时, 可以借助该类下面的 copy 方法来修改状态, 以便重新渲染 UI 界面.具体详情可以 👉[State Declaration](https://pub.flutter-io.cn/packages/async_redux#state-declaration)

#### View Model

View Model 主要用来连接 Action 和 State, 页面的数据绑定和页面按钮等事件触发均需通过 View Model 来连接, 模块与模块之间的职责需划分清楚, 所有的 View Model 均需继承 BaseModel(async_redux 库中的基类), 以便可以访问`dispatch`方法和全局的`state`数据状态, ViewModel 的成员变量均需带上`@required`字符, 表明该成员必需存在.
View Model 示例

```Dart
import 'package:flutter_common_template/pages/login/actions/actions.dart';

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  bool isLoading;
  Function sendCode;

  ViewModel.build({
    @required this.isLoading,
    @required this.sendCode,
  }) : super(equals: [isLoading]);

  @override
  ViewModel fromStore() {
    return new _ViewModel.build(
      isLoading: state.mainState.isLoading,
      sendCode: () => dispatch(SendCodeAction()),
    );
  }
}
```

TODO: 待完善...

#### 整体架构图

![前端架构](https://cti-retail-staging.oss-cn-hangzhou.aliyuncs.com/console-web/%E5%89%8D%E7%AB%AF%E6%9E%B6%E6%9E%84.001.jpeg)

#### 经验法则

1. 不要把业务逻辑放 `Widgets` 中
2. 不要把业务逻辑放 `Connectors` 中
3. 不要把业务逻辑放 `ViewModels` 中
4. 不要把业务逻辑放 `Reducers` 中
5. 不要把业务逻辑放 `ViewModels` 中
6. 不要把业务逻辑放 `State` 中

### 引入资源说明

1. 图片资源需要在 `pubspec.yaml` 中引入才可以使用

   ```Dart
       flutter:
       assets:
           - images/cat.png
           - images/2x/cat.png
           - images/3x/cat.png
   ```

   ```Dart
      /// 页面中引入使用图片
      new Image.asset('images/cat.png');
   ```

TODO: 待完善...

## 1.7 🌿Git 分支管理说明

```Git
git-flow 是目前流传最广的 Git 分支管理实践。git-flow 围绕的核心概念是版本发布（release)
git-flow 流程中包含 5 类分支，分别是 master、develop、新功能分支（feature）、发布分支（release）和 hotfix
```

### 相关分支说明

| 分支类型 | 命名规范   | 创建自             | 合并到             | 说明                               |
| -------- | ---------- | ------------------ | ------------------ | ---------------------------------- |
| master   | master     |                    |                    | 开发主分支                         |
| feature  | feature/\* | master             | master             | 新功能                             |
| staging  | staging/\* | develop            | release 和 master  | 稳定测试版本发布                   |
| release  | release/\* | staging            | develop 和 master  | 新版本发布                         |
| hotfix   | hotfix/\*  | staging 或 release | release 和 staging | staging 或 release 中 bug 修复分支 |
| bugfix   | bugfix/\*  | master             | master             | master 中 bug 修复分支             |

1. `master`为开发分支, 是一个进行代码集成的分支, 该分支会及时合并最新代码, 新需求的开发都从此分支上创建
2. `feature/my-awesome-feature` 为新功能分支, 开发新需求时, 需从`master`分支创建
3. `hotfix/fix-my-bug` 为热修复 bug 分支, 主要是针对`release`或`staging`分支测试出现的 bug 进行修复
4. `release/0.0.1`分支为部署到持续集成服务器上进行测试的分支, 是一个相对稳定的可供测试的分支
5. `staging` 是部署到测试环境中的代码, 一般不允许随意合并其他分支到此分支上
6. `bugfix/fix-my-bug` 为主分支修复 bug 分支, 主要是针对`master`或`feature`分支测试出现的 bug 进行修复

### `feature`分支创建流程

1. 从 `master`分支创建一个新的`feature`分支, 如`feature/my-awesome-feature`
2. 在该`feature`分支上进行开发相关需求，完成后提交代码并 push 到远端仓库
3. 当代码完成之后，提`pull request`, 代码审核通过后合并到`master`分支, 之后可删除当前`feature`分支

### `bugfix`分支创建流程

1. 从`master`分支创建一个新的`bugfix`分支，如 `bugfix/fix-my-bug`
2. 进行相关的 bug 修复并在本地测试通过
3. 当 bug 修复之后，提`pull request`, 合并`bugfix/fix-my-bug`分支到`master`分支

### `hotfix`分支创建流程

1. 从`master`分支创建一个新的`staging`分支，如 `staging/0.0.1`
2. 把`staging`分支部署到持续集成服务器上, 并交给相关测试人员进行测试
3. 对于测试中发现的问题，直接在`staging`分支上创建`hotfix/fix-my-bug`分支, 进行相关的 bug 修复
4. 当 bug 修复之后，提`pull request`, 合并`hotfix/fix-bug`分支到`staging`分支, 再次部署并交给测试人员进行测试

### `staging`分支创建流程

1. 从`master`分支创建一个新的`staging`分支，如 `staging/0.0.1`
2. 把`staging`分支部署到持续集成服务器上, 并交给相关测试人员进行测试

### `release`分支创建流程

1. 从`staging`分支创建一个新的`release`分支, 如 `release/0.0.1`
2. 把`release`分支推到远端, 部署到持续集成服务器上线

### 代码提交说明

严格规范 commit message，编写 message 时需要加上 type 前缀或者直接运行 git cz 来按步骤提交
type 用于说明 commit 的类别，只允许使用下面 7 个标识

```git
1. feat：新功能（feature）
2. fix：修补 bug
3. docs：文档（documentation）
4. style： 格式（不影响代码运行的变动）
5. refactor：重构（即不是新增功能，也不是修改 bug 的代码变动）
6. test：增加测试
7. chore：构建过程或辅助工具的变动
```

### Git hooks 配置说明

1. 安装 git_hooks 库
2. 设置环境变量

   ```Flutter
   # Pub
   export PATH="$PATH":"$HOME/flutter/.pub-cache/bin"

   # Dart
   export PATH=$HOME/flutter/bin/cache/dart-sdk/bin:$PATH
   ```

3. 本地激活 git_hooks 命令 `pub global activate git_hooks`
4. 移动到项目根目录运行 `git_hooks create`

## 1.8 Xcode 11.4 支持特殊说明

<https://flutter.dev/docs/development/ios-project-migration>

## 1.9 问题帮助

1. 使用 flutter upgrade 或 flutter pub get 等命令时，提示 waiting for another flutter command to release the startup lock

   > 先打开任务管理器，结束掉所有 dart 进程。然后打开你的 flutter 安装文件夹，
   > 找到\bin\cache 中的 lockfile 文件删除。之后重启 VS Code。

2. 国内使用 flutter 指南 <https://flutter.dev/community/china>
3. 遇到如下错误

   ```Flutter
    * What went wrong:
    A problem occurred evaluating project ':app'.
    > Could not resolve all artifacts for configuration 'classpath'.
    > Could not resolve com.android.tools.build:gradle:3.5.0.
        Required by:
            unspecified:unspecified:unspecified
        > Could not resolve com.android.tools.build:gradle:3.5.0.
            > Could not get resource 'https://dl.google.com/dl/android/maven2/com/android/tools/build/gradle/3.5.0/gradle-3.5.0.pom'.
                > Could not GET 'https://dl.google.com/dl/android/maven2/com/android/tools/build/gradle/3.5.0/gradle-3.5.0.pom'.
   ```

   尝试在 `${rootProject}/android/build.gradle` 下修改

   ```Android
   buildscript {
       repositories {
   //        google()
   //        jcenter()
           maven { url 'https://maven.aliyun.com/repository/google' }
           maven { url 'https://maven.aliyun.com/repository/jcenter' }
           maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
       }

       dependencies {
           classpath 'com.android.tools.build:gradle:3.2.1'
       }
   }

   allprojects {
       repositories {
   //        google()
   //        jcenter()
           maven { url 'https://maven.aliyun.com/repository/google' }
           maven { url 'https://maven.aliyun.com/repository/jcenter' }
           maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
       }
   }

   ```

4. 每次切换分支，最好 flutter upgrade 一下，不然可能出现打包问题。

5. 打包失败, 考虑./gradlew clean 一下

6. 打包出现 OOM, 此时可以在 gradle.properties 配置一下内存大小。

7. 不能 hot reload, 那一定是姿势不对, flutter 工程下 flutter attach 之后, native 工程这边需要重新打一个调试包装到手机上, 然后进入 flutter 模块才可以的

8. 我的机器打的调试包怎么跑不起来, 出现了 JNI native 之类的一些错误提示, 这类问题, 优先考虑你的 flutter 版本和大家一致吗? channel 和大家一致吗？

9. 2x,3x 图似乎加载不了, 那是因为你使用了中文, flutter 会把资源反倒一个 mainifest 中，它是一个 map, 如果使用中文, map 的 key 就和路径对不上了, 找不到的话, 就会找默认图啦, 也就是一倍图

## 2.0 学习资源

入门资源:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Awesome Flutter](https://github.com/Solido/awesome-flutter)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
