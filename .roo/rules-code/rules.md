
你是一名 Flutter、Dart、Riverpod、Freezed、Flutter Hooks 和 Supabase 方面的专家。

## 项目定位说明
本项目是一个运行在嵌入式 Linux 系统上的触控式 UI 程序，用于控制 3D 打印机的核心功能，包括打印任务的管理、温度控制、文件浏览、打印进度监控等。其运行环境为固定安装在 3D 打印机上的触摸屏设备，并非手机或传统桌面应用，因此在UI/UX、交互逻辑、控件大小、信息结构上都需要针对触控屏进行特别优化。

## 编码规则
核心原则
- 编写简洁、技术性强的 Dart 代码，并提供准确的示例。
- 在适当情况下，使用函数式和声明式编程模式。
- 优先使用组合（composition）而非继承（inheritance）。
- 使用描述性变量名，并带有辅助动词（如 isLoading、hasError）。
- 文件结构：导出组件（exported widget）、子组件（subwidgets）、辅助方法（helpers）、静态内容（static content）、类型定义（types）。

目录文件结构规范
1.  services/：存放业务逻辑（计算、转换、本地存储等）。
2.  data/：存放远程数据交互（API 请求、数据库访问等）。
3.  providers/：存放状态管理（如 Riverpod）。
4.  ui/pages/：每个页面一个文件夹，存放 UI 页面及其私有组件。
      示例结构：
        ui/pages/home/
          ├── home_screen.dart              # 页面入口
          └── widgets/
              └── home_status_card.dart     # 页面专属组件
5.  ui/shared_widgets/：存放多个页面共用的可复用组件。
6.  core/：存放全局配置（常量、日志、主题等），包含：
    - AppConfig: 全局应用配置（基础URL、日志级别等）
    - logger/: 日志模块相关实现
7.  models/：存放数据模型。
8.  utils/：存放工具类、辅助函数。
9.  assets/：存放静态资源（如图片、字体等）。
10. test/：存放测试代码。
11. locales/：存放国际化（i18n）文件。
12. themes/：存放主题配置文件。
13. routes/：存放路由配置文件。
14. extensions/：存放扩展方法。
15. notifications/：存放通知相关代码。
16. constants/：存放常量文件。
17. hooks/：存放 Flutter Hooks 相关代码。
  

Dart/Flutter
- 对于不可变的 Widget，尽量使用 const 构造函数。
- 使用 Freezed 管理不可变状态类和联合类型（union），所有 Freezed 类必须声明为 abstract：
  ```dart
  @freezed
  abstract class Model with _$Model {
    factory Model({required String name}) = _Model;
  }
  ```
- 简单的函数和方法使用箭头函数（=>）。
- 单行的 getter 和 setter 应使用表达式体（expression body）。
- 使用尾随逗号（trailing commas）优化代码格式，提高 git diff 可读性。

错误处理与验证
- 在界面（view）中使用 SelectableText.rich 处理错误，而不是 SnackBar。
- 错误信息应显示为 SelectableText.rich，并使用红色提高可见性。
- 界面应在自身逻辑内处理空状态（empty states）。
- 使用 AsyncValue 进行正确的错误处理和加载状态管理。

## 状态管理规范
- 优先使用 Flutter Hooks (`flutter_hooks`) 箱管理与组件生命周期强绑定的简单状态
- 仅在需要跨组件共享或全局持久化状态（如接口数据、WebSocket更新）时考虑使用 hooks_riverpod
- 使用 hooks_riverpod 时应遵循最小化原则，避免过度使用
- 确保异步操作在 Widget 被销毁时正确取消，以避免内存泄漏

性能优化
- 尽可能使用 const 组件，优化 Widget 重新构建。
- 优化 ListView，使用 ListView.builder 等方法提升性能。
- 本地静态图片使用 AssetImage，远程图片使用 cached_network_image。
- 在 Supabase 操作中正确处理错误，包括网络错误。

关键约定
1. 使用 GoRouter 或 auto_route 进行导航和深度链接管理。

2. 优化 Flutter 性能指标：
   - 缩短首屏加载时间。
   - 降低 widget 重建次数。
   - 缩短用户可交互时间（TTI）。

3. 优先使用 StatelessWidget 或 HookWidget 构建组件：
   - 若组件仅依赖与生命周期强绑定的状态（如UI控制、动画、计数器），使用 HookWidget。
   - 若组件需要访问全局持久化状态（通过 Riverpod 读取或监听接口数据、WebSocket更新），使用 HookConsumerWidget。
   - 尽量避免直接使用 StatefulWidget，除非有特殊需求（如动画控制器或生命周期）。

4. 状态管理优先级：
   - 优先使用 `HookWidget` + `useState`/`useMemoized` 管理局部状态
   - 对于需要跨组件共享的状态，考虑使用 `ChangeNotifier` + `ValueListenableBuilder`
   - 最后考虑使用 Riverpod 进行全局状态管理
   - 避免在状态管理中直接处理副作用

UI 与样式
- 优先使用 Flutter 内置组件，并根据需求创建自定义组件。
- 使用 LayoutBuilder 或 MediaQuery 实现响应式设计。
- 通过 ThemeData 实现全局一致的样式。
- 所有样式必须优先使用 `themes/app_theme.dart` 中定义的主题样式。
- 通过 Theme.of(context) 访问主题属性，例如：
  ```dart
  Theme.of(context).textTheme.titleLarge
  Theme.of(context).colorScheme.primary
  ```
- 所有样式应优先使用 app_theme 中的主题定义，当主题无法满足需求时：
  1. 首先考虑扩展 app_theme 中的主题定义
  2. 在迫不得已的情况下允许使用硬编码样式，包括但不限于：
     - 需要临时调试或快速验证UI效果
     - 遇到主题系统无法实现的特殊视觉效果
     - 在原型开发阶段快速迭代
- 所有硬编码样式必须添加明确注释说明原因，例如：
  ```dart
  // 临时硬编码：主题系统暂不支持此特殊渐变效果
  final gradient = LinearGradient(...);
  ```
- 硬编码样式应在后续版本中尽快迁移到主题系统
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
- 优先使用 `HookWidget` + `useState`/`useMemoized` 管理组件状态
- 避免在 Hooks 内部直接创建对象，应使用 `useMemoized` 或 `useState` 来确保对象在组件生命周期内正确管理
- 对于复杂状态管理，可使用 `ValueNotifier` + `ValueListenableBuilder` 组合

💡 示例：
```dart
class CounterWidget extends HookWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    final controller = useTextEditingController();

    return Column(
      children: [
        TextField(controller: controller),
        Text('计数: ${counter.value}'),
        ElevatedButton(
          onPressed: () => counter.value++,
          child: const Text('增加'),
        ),
      ],
    );
  }
}
```

其他注意事项
## 日志规范
- 使用统一的AppLogger模块记录日志，禁止直接使用print
- 日志级别分为：debug, info, warning, error, fatal
- 每个模块应创建自己的LoggerModule实例：
  ```dart
  final logger = AppLogger.module('模块名');
  ```
- 日志格式：[时间][模块][级别] 消息
- 通过AppConfig.setLogLevel()动态控制日志级别
- 错误日志必须包含error对象和stackTrace(可选)

## 配置规范
- 全局配置使用AppConfig统一管理
- 配置项包括：
  - baseUrl: 服务端基础地址
  - logLevel: 日志输出级别
- 配置应在应用启动时初始化：
  ```dart
  void main() async {
    await AppConfig.initialize();
    runApp(const MyApp());
  }
  ```
- 使用 log 代替 print 进行调试日志输出。
- 优先使用 Flutter Hooks 管理组件状态。
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

## 交互模式与设备特点
	•	UI 应适配触摸屏操作，不假设用户具备键鼠设备。
	•	交互按钮需满足手指操作最小尺寸：48×48 dp。
	•	避免多层嵌套的页面结构，优先采用**“卡片式”或“仪表盘式”布局**，快速展示核心状态。
	•	所有重要按钮都应有触控反馈（ripple、scale、颜色变化）。
	•	在状态敏感页面中（如打印进行中），应提供硬件级 UI 锁定（防止误触）。
	•	所有操作必须考虑“误触容错机制”：如“开始打印”需要二次确认。
## 界面布局建议
	•	主界面应展示当前打印任务、打印进度、打印机状态（温度、移动、材料）。
	•	使用信息卡片化布局展示打印任务状态、当前材料等信息。
	•	所有操作按钮应尽可能集中于屏幕底部或右下角，方便右手单手触控。
	•	复杂的操作（如调平、轴移动）应设计为引导式操作流程（step-by-step）。
	•	保持全局统一的导航方式，例如底部导航栏或侧边栏，避免因小屏幕误导用户行为路径。


  🎨 UI / UX 设计指南（适用于 3D 打印机触控屏）

📱 用户操作环境假设

- 设备为固定在打印机上的 4~7 寸电容式触控屏。
- 用户多数为非专业技术人员，可能手带手套。
- 操作环境存在震动、油污、手误风险，误触率较高。
- 不支持鼠标、键盘、悬浮操作，仅支持触控输入。

---

🖼️ 界面与交互设计规范

- 操作区域尺寸 ≥ 48x48 dp，适合手指点击。
- 所有按钮需有明显点击反馈（颜色、阴影、震动）。
- UI 模块化，采用卡片式信息组织结构。
- 使用扁平导航结构，减少层级，提高效率。
- 弹窗支持空白区域点击关闭。

---

🎯 核心模块建议布局

✅ 主控制台（仪表盘）

- 展示：打印状态、进度条、温度、风扇转速。
- 快捷操作：暂停、恢复、终止。
- 异常提示：错误状态、断电恢复等。

📂 文件选择页

- 展示 SD/U盘文件，支持点击、滚动、排序。
- 操作：开始打印、详情、删除。

🔧 打印控制页

- 控制温度、风扇、Z轴等。
- 操作反馈：成功、失败、处理中。
- 加热操作加 loading 状态提示。

---

🎨 颜色与字体建议

- 深灰背景 + 高亮主色（蓝/绿）+ 红/黄状态色。
- 状态色规范：
  - 正常（绿色）
  - 加热中 / 工作中（蓝色）
  - 错误/中断（红色）
  - 警告 / 未连接（黄色）
- 字体字号 ≥ 16dp，重要信息加粗。
- 按钮需图标+文字组合。

---

⚠️ 安全性与误触防护

- 破坏性操作需二次确认。
- 确认弹窗按钮分离，防误触。
- 提供“锁屏”模式防误触或调试用。

---

📲 动画与反馈建议

- 使用 flutter_animate 优化页面切换。
- 页面过渡使用 Slide 或 Fade 动画。
- 状态变化：颜色 + 图标反馈，减少文字说明。

---
