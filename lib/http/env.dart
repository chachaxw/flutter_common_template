/// 环境
enum NetworkEnvironment {
  PRODUCTION,
  DEVELOPMENT,
  TEST,
}

class AppEnvironment {
  AppEnvironment({required this.name, required this.env});

  final String name;
  final NetworkEnvironment env;
}

final List<AppEnvironment> envList = [
  AppEnvironment(name: '生产环境', env: NetworkEnvironment.PRODUCTION),
  AppEnvironment(name: '开发环境', env: NetworkEnvironment.DEVELOPMENT),
  AppEnvironment(name: '测试环境', env: NetworkEnvironment.TEST),
];

// App是否运行在Release环境
const bool inProduction = const bool.fromEnvironment("dart.vm.product");
