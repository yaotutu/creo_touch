Flutter 编码规则

你是一名 Flutter、Dart、Riverpod、Freezed、Flutter Hooks 和 Supabase 方面的专家。

核心原则
- 编写简洁、技术性强的 Dart 代码，并提供准确的示例。
- 在适当情况下，使用函数式和声明式编程模式。
- 优先使用组合（composition）而非继承（inheritance）。
- 使用描述性变量名，并带有辅助动词（如 isLoading、hasError）。
- 文件结构：导出组件（exported widget）、子组件（subwidgets）、辅助方法（helpers）、静态内容（static content）、类型定义（types）。

目录文件结构规范
	1.	services/：存放业务逻辑（计算、转换、本地存储等）。
	2.	data/：存放远程数据交互（API 请求、数据库访问等）。
	3.	providers/：存放状态管理（如 Riverpod）。
	4.	presentation/screens/：存放 UI 页面。
	5.	presentation/widgets/：存放可复用组件。
	6.	core/：存放全局配置（常量、日志、主题等）。
	7.	models/：存放数据模型。
	8.	utils/：存放工具类、辅助函数。
	9.	assets/：存放静态资源（如图片、字体等）。
	10.	test/：存放测试代码。
  11.	locales/：存放国际化（i18n）文件。
  12.	themes/：存放主题配置文件。
  13.	routes/：存放路由配置文件。
  14.	extensions/：存放扩展方法。
  15. notifications/：存放通知相关代码。
  16. constants/：存放常量文件。
  17. hooks/：存放 Flutter Hooks 相关代码。
  

Dart/Flutter
- 对于不可变的 Widget，尽量使用 const 构造函数。
- 使用 Freezed 管理不可变状态类和联合类型（union）。
- 简单的函数和方法使用箭头函数（=>）。
- 单行的 getter 和 setter 应使用表达式体（expression body）。
- 使用尾随逗号（trailing commas）优化代码格式，提高 git diff 可读性。

错误处理与验证
- 在界面（view）中使用 SelectableText.rich 处理错误，而不是 SnackBar。
- 错误信息应显示为 SelectableText.rich，并使用红色提高可见性。
- 界面应在自身逻辑内处理空状态（empty states）。
- 使用 AsyncValue 进行正确的错误处理和加载状态管理。

Riverpod 相关规范
- 使用 @riverpod 注解自动生成 Provider。
- 优先使用 AsyncNotifierProvider 和 NotifierProvider，避免使用 StateProvider。
- 避免 StateProvider、StateNotifierProvider 和 ChangeNotifierProvider。
- 使用 ref.invalidate() 手动触发 Provider 更新。
- 确保异步操作在 Widget 被销毁时正确取消，以避免内存泄漏。

性能优化
- 尽可能使用 const 组件，优化 Widget 重新构建。
- 优化 ListView，使用 ListView.builder 等方法提升性能。
- 本地静态图片使用 AssetImage，远程图片使用 cached_network_image。
- 在 Supabase 操作中正确处理错误，包括网络错误。

关键约定
1. 使用 GoRouter 或 auto_route 进行导航和深度链接管理。
2. 优化 Flutter 性能指标（如首屏加载时间、可交互时间）。
3. 优先使用 StatelessWidget
   - 对于需要依赖状态的组件，使用 ConsumerWidget 配合 Riverpod。
   - 当同时使用 Riverpod 和 Flutter Hooks 时，使用 HookConsumerWidget。

UI 与样式
- 优先使用 Flutter 内置组件，并根据需求创建自定义组件。
- 使用 LayoutBuilder 或 MediaQuery 实现响应式设计。
- 通过 ThemeData 实现全局一致的样式。
- 使用 Theme.of(context).textTheme.titleLarge 代替 headline6，使用 headlineSmall 代替 headline5 等。

数据模型与数据库规范
- 数据库表中应包含 createdAt、updatedAt 和 isDeleted 字段。
- 数据模型使用 @JsonSerializable(fieldRename: FieldRename.snake) 进行序列化。
- 对于只读字段，使用 @JsonKey(includeFromJson: true, includeToJson: false)。

组件与 UI 相关
- 优先创建私有 Widget 类，而不是在 build() 方法里写 Widget _build... 方法。
- 下拉刷新功能应使用 RefreshIndicator 实现。
- TextField 组件应合理设置 textCapitalization、keyboardType 和 textInputAction。
- Image.network 必须设置 errorBuilder 处理加载失败情况。

### Flutter Hooks 相关
- 优先使用 Flutter Hooks（`flutter_hooks`） 来管理组件状态，而不是 `StatefulWidget`。  
- 当组件涉及到副作用（如订阅、动画控制器、控制器实例化等）时，优先使用 Hooks（如 `useEffect`、`useAnimationController`、`useTextEditingController`）。  
- 当组件涉及到 Riverpod 时，使用 `HookConsumerWidget` 代替 `ConsumerWidget`，结合 `useProvider` 来读取 Provider。  
- 避免在 Hooks 内部直接创建对象，应使用 `useMemoized` 或 `useState` 来确保对象在组件生命周期内正确管理。  
- 对于复杂状态管理，结合 Riverpod Hooks（`hooks_riverpod`）使用，如 `useProvider` 和 `useStateNotifier` 等。  

💡 示例：
```dart
class MyWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final count = useState(0);

    return Column(
      children: [
        TextField(controller: controller),
        Text('计数: ${count.value}'),
        ElevatedButton(
          onPressed: () => count.value++,
          child: Text('增加'),
        ),
      ],
    );
  }
}
```

其他注意事项
- 使用 log 代替 print 进行调试日志输出。
- 适当使用 Flutter Hooks 和 Riverpod Hooks。
- 代码行长度不超过 80 字符，多参数函数在右括号 ) 之前添加逗号 ,。
- 枚举类型持久化到数据库时，应使用 @JsonValue(int)。

代码生成
- 使用 build_runner 自动生成代码（如 Freezed、Riverpod、JSON 序列化）。
- 修改带注解的类后，运行：
  flutter pub run build_runner build --delete-conflicting-outputs

文档规范
- 为复杂逻辑和非直观代码提供注释和文档。
- 遵循 Flutter、Riverpod 和 Supabase 官方最佳实践。

！！！注意
- 这是一个flutter-elinux的项目，并不是传统的一个flutter项目，是由索尼团队维护的flutter在嵌入式平台的解决方案。
- 当运行项目的时候应该执行以下命令来执行项目
```
flutter-elinux run -d orangepi-3b
```

参考
请查阅 Flutter、Riverpod 和 Supabase 官方文档，以获取 组件、状态管理、后端集成 的最佳实践。