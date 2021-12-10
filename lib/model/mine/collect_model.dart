

/// curPage : 1
/// datas : [{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>今天意外在崩溃上报平台发现一个异常为UndeclaredThrowableException，看名字就比较好奇，大家可以搜索下，尝试回答：</p>\r\n<ol>\r\n<li>什么时候会抛出此异常？</li>\r\n<li>为什么[1]中重新封装为此异常抛出，这么设计的原因是？</li>\r\n</ol>","envelopePic":"","id":228235,"link":"https://www.wanandroid.com/wenda/show/20514","niceDate":"2021-11-19 09:16","origin":"","originId":20514,"publishTime":1637284614000,"title":"每日一问 UndeclaredThrowableException 是什么异常？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>问题如题：</p>\r\n<p>ViewGroup 的 measureChild 方法和 measureChildWithMargins 方法的区别是什么，如何在实际开发中决定选择使用哪一个？</p>\r\n<p>来源：<a href=\"https://wanandroid.com/wenda/show/8857?fid=833&amp;date=2021_10_12_09_13_15&amp;message=ViewGroup#msg_id2204\">可以从这里提问</a>，欢迎大家踊跃提问~</p>","envelopePic":"","id":222612,"link":"https://wanandroid.com/wenda/show/20130","niceDate":"2021-10-13 14:05","origin":"","originId":20130,"publishTime":1634105137000,"title":"【大家提问】 | ViewGroup 的 measureChild 方法和 measureChildWithMargins 方法的区别是什么？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":360,"chapterName":"小编发布","courseId":13,"desc":"<p>这是一个收集建议、功能的帖子。</p>\r\n<p>如果你有：</p>\r\n<ol>\r\n<li>想要添加的功能；</li>\r\n<li>觉得目前需要改进的地方；</li>\r\n</ol>\r\n<p>欢迎提出，会在评估后安排更新~</p>","envelopePic":"","id":222380,"link":"https://www.wanandroid.com/wenda/show/20087","niceDate":"2021-10-12 15:35","origin":"","originId":20087,"publishTime":1634024135000,"title":"给 wanandroid 提个意见吧！","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>Gson大家一定不陌生，在很多项目中都大规模使用。</p>\r\n<p>例如常见的：</p>\r\n<pre><code>网络请求\r\n    -&gt;返回Json数据\r\n    -&gt;Gson解析为对象\r\n    -&gt;渲染页面\r\n</code></pre><p>很多时候，历史项目包含很多Gson解析对象在UI线程的操作，或者说即使在子线程其实也会影响页面展现速度。</p>\r\n<p>大家都了解Gson对于对象的解析，如果不单独的配置TypeAdapter，那么其实内部是充满反射的。</p>\r\n<p>问题来了：</p>\r\n<p><strong>有没有什么低侵入的方案可以尽可能去除反射操作，从而提升运行效率？描述思路即可。</strong></p>","envelopePic":"","id":216415,"link":"https://wanandroid.com/wenda/show/19623","niceDate":"2021-08-31 18:51","origin":"","originId":19623,"publishTime":1630407076000,"title":"每日一问 | Gson中序列化对象的操作有低侵入的优化方案吗？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>了解应用启动相关代码的同学一定知道：</p>\r\n<p>我们的应用启动时，每个进程会对应一个ActivityThread对象，而Application对象在正常情况下也是每个进程只有一个？</p>\r\n<p>但是如果你看ActivityThread的源码，你会发现：</p>\r\n<pre><code>public final class ActivityThread {\r\n    final ArrayList&lt;Application&gt; mAllApplications\r\n                = new ArrayList&lt;Application&gt;();\r\n    ...\r\n}\r\n</code></pre><p><a href=\"https://cs.android.com/android/platform/superproject/+/master:frameworks/base/core/java/android/app/ActivityThread.java;l=237?q=ActivitYtHREAD&amp;sq=&amp;ss=android%2Fplatform%2Fsuperproject\">源码直达</a></p>\r\n<p>问题来了：</p>\r\n<ol>\r\n<li>什么情况下一个ActivityThread对象，会对应多个Application对象，即mAllApplications.size() &gt; 1；</li>\r\n<li>如果找到了1的情况，支持这个目的是？</li>\r\n</ol>\r\n<blockquote>\r\n<p>本问题归因为好奇，硬说使用场景在一些插件化中会尝试构造Application会调用这个，但是这个肯定不是google的本意。</p>\r\n</blockquote>","envelopePic":"","id":215620,"link":"https://wanandroid.com/wenda/show/19550","niceDate":"2021-08-27 09:00","origin":"","originId":19550,"publishTime":1630026023000,"title":"每日一问 | 好奇ActivityThread中为什么会有一个 Application的集合？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>今天我们来讨论下 Jetpack 中的 ViewModel:</p>\r\n<p>大家都知道 ViewModel 有一个特点就是能够在 Activity 发生重建时做数据的恢复。</p>\r\n<p>我们就针对这个「重建」与「恢复」问一些问题：</p>\r\n<ol>\r\n<li>ViewModel 在 Activity 发生旋转等配置发生变化所导致的重建，能恢复数据吗？</li>\r\n<li>如果 1 能，尝试从源码角度分析，数据存在哪？怎么存储的？怎么读取的？</li>\r\n<li>当 Activity 切换到后台，被系统杀死（进程存活），此时回到 Activity 导致的重建，ViewModel 的数据能恢复吗？为什么？</li>\r\n</ol>","envelopePic":"","id":207249,"link":"https://www.wanandroid.com/wenda/show/18930","niceDate":"2021-07-15 09:06","origin":"","originId":18930,"publishTime":1626311178000,"title":"每日一问 | ViewModel 在什么情况下的「销毁重建」能够对数据进行无缝恢复？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>关于 Activity 重建，我们探究几个问题：</p>\r\n<ol>\r\n<li>当前 app 正在前台运行，不在栈顶的 Activity 有可能会因为系统资源，例如内存等不足回收吗？</li>\r\n<li>当 app 处于后台运行，app 进程未被杀死，其内部的 Activity 会被回收吗？</li>\r\n<li>当 app 处于后台运行，app 的进程会被杀死吗？</li>\r\n</ol>\r\n<p>如果有能力，建议解释过程中可以配合源码，不一定要全部答出来~</p>","envelopePic":"","id":207248,"link":"https://www.wanandroid.com/wenda/show/18965","niceDate":"2021-07-15 09:05","origin":"","originId":18965,"publishTime":1626311143000,"title":"每日一问 | 关于 Activity 重建，值得探究的几个问题","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>欢迎分享：</p><br><p>1. 你觉得不错的学习习惯；</p><p>2. 正在使用的不错的 App</p>","envelopePic":"","id":204923,"link":"https://www.wanandroid.com/wenda/show/8483","niceDate":"2021-07-03 21:55","origin":"","originId":8483,"publishTime":1625320512000,"title":"每日一问 你有什么好的学习习惯 或者 不错的 app 推荐给大家？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>最近很多同学烦恼，Flutter和Kotlin不知道该重点学习哪个。</p><p>如果是你要做选择，你会怎么选？</p><p>答题格式:</p><p>我会选Kotlin，因为...</p>","envelopePic":"","id":204922,"link":"https://wanandroid.com/wenda/show/8435","niceDate":"2021-07-03 21:54","origin":"","originId":8435,"publishTime":1625320490000,"title":"讨论 | Flutter Kotlin 如果二选一学习，你会怎么选？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>可以从常见出问题场景、检测方案等方面回答。</p>","envelopePic":"","id":204921,"link":"https://www.wanandroid.com/wenda/show/8206","niceDate":"2021-07-03 21:54","origin":"","originId":8206,"publishTime":1625320446000,"title":"每日一问 | Android 中关于内存泄露有哪些注意点？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>这个问题其实不算一个太好的问题，但是也能考察事件的分发流程，搞清楚 Window,Activity,DecorView 在事件分发环节的调用流程。</p>","envelopePic":"","id":204920,"link":"https://www.wanandroid.com/wenda/show/11363","niceDate":"2021-07-03 21:53","origin":"","originId":11363,"publishTime":1625320401000,"title":"每日一问  为什么 Dialog 默认弹出后 Activity 就无法响应用户事件了？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>以后偶尔会出现这种作业，感兴趣的可以做一下。</p>\r\n<blockquote>\r\n<p>该效果来自app: 莫比健身</p>\r\n</blockquote>\r\n<p><img src=\"https://wanandroid.com/blogimgs/81c87faf-49e4-4041-80c8-9e188d1390c4.gif\" alt=\"F45BE934CF17DDDA5FF8A25A0E6F9E22.gif\" width=\"360px\" /></p>\r\n<p>注意看小船。</p>\r\n<p>大家感兴趣可以实现一下，留言区可以贴：</p>\r\n<ol>\r\n<li>实现思路讨论；</li>\r\n<li>或者自己实现的博客 ；</li>\r\n<li>或者自己实现的开源项目；</li>\r\n</ol>","envelopePic":"","id":204919,"link":"https://wanandroid.com/wenda/show/12773","niceDate":"2021-07-03 21:51","origin":"","originId":12773,"publishTime":1625320266000,"title":"一期讨论 | 有趣的效果 小船儿游而游","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>之前我在公众号写了一篇：<a href=\"https://mp.weixin.qq.com/s/rJkxRDlor1ZUfdmfwvqwNg\">这些年“崛起”的Android技术博主们</a>，也有很多朋友自荐、推荐。</p>\r\n<p>于是我就开了个帖子收集吧，大家直接留言即可。</p>\r\n<p>所有收录博客会展现在：</p>\r\n<p><a href=\"https://wanandroid.com/navi\">wanandroid 导航</a> 优秀的博客一栏。</p>\r\n<p>希望与大家共建内容生态。</p>","envelopePic":"","id":204917,"link":"https://wanandroid.com/wenda/show/13347","niceDate":"2021-07-03 21:49","origin":"","originId":13347,"publishTime":1625320190000,"title":"博客收集 | 欢迎推荐优秀博主","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>谈到 RecyclerView，相信不少同学，张口都能说出它的几级缓存机制：</p>\r\n<p>例如：</p>\r\n<ul>\r\n<li>一级缓存：mAttachedScrap 和 mChangedScrap </li>\r\n<li>二级缓存：mCachedViews </li>\r\n<li>三级缓存：ViewCacheExtension </li>\r\n<li>四级缓存：RecycledViewPool </li>\r\n</ul>\r\n<p>然后说怎么用，就是先从 1 级找，然后 2 级...然后4 级，找不到 create ViewHolder。</p>\r\n<p>那么，有没有思考过，其实上面几级缓存都属于“内存缓存&quot;，那么这么分级肯定有一定区别。</p>\r\n<p>问题来了：</p>\r\n<ol>\r\n<li>每一级缓存具体作用是什么？</li>\r\n<li>分别在什么场景下会用到哪些缓存呢？</li>\r\n</ol>","envelopePic":"","id":204916,"link":"https://www.wanandroid.com/wenda/show/14222","niceDate":"2021-07-03 21:47","origin":"","originId":14222,"publishTime":1625320079000,"title":"每日一问 | RecyclerView的多级缓存机制，每级缓存到底起到什么样的作用？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>View 的三大流程：测量、布局、绘制，我想大家应该都烂熟于心。</p>\r\n<p>而在绘制阶段，ViewGroup 不光要绘制自身，还需循环绘制其一众子 View，这个绘制策略默认为顺序绘制，即 [0 ~ childCount)。</p>\r\n<p>这个默认的策略，有办法调整吗？</p>\r\n<p>例如修改成 (childCount ~ 0]，或是修成某个 View 最后绘制。同时又有什么场景需要我们做这样的修改？</p>\r\n<p>问题来了：</p>\r\n<ol>\r\n<li>这个默认的策略，有办法调整吗？</li>\r\n<li>修改了之后，事件分发需要特殊处理吗？还是需要特殊处理。</li>\r\n</ol>","envelopePic":"","id":204915,"link":"https://www.wanandroid.com/wenda/show/14409","niceDate":"2021-07-03 21:46","origin":"","originId":14409,"publishTime":1625320009000,"title":"每日一问| View 绘制的一个细节，如何修改 View 绘制的顺序？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>之前写代码，需要在一些特殊时机做一些事情，例如释放内存等，特殊时机包含：</p>\r\n<ol>\r\n<li>应用退出（用户back 退出，没有任何 Activity 了，但进程还存活的情况）</li>\r\n<li>应用 Home 按键置于后台</li>\r\n</ol>\r\n<p>问题来了，怎么方便的判断这两种时机呢？</p>\r\n<p><strong>注意：需要考虑屏幕旋转异常情况。</strong></p>","envelopePic":"","id":204914,"link":"https://wanandroid.com/wenda/show/14774","niceDate":"2021-07-03 21:46","origin":"","originId":14774,"publishTime":1625319989000,"title":"每日一问 | 如何判断应用退出，或者到后台了？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>最近实在是太忙了，抽空更新一问。</p>\r\n<p>想到一个非常有意思的问题：</p>\r\n<p>如果 app 启动了一个 Activity，那么在这个 Activity 展示的情况下，问题来了：</p>\r\n<p>1.上述场景背后至少有多少个线程？<br>2.每个线程具体的作用是什么？</p>","envelopePic":"","id":204913,"link":"https://www.wanandroid.com/wenda/show/15188","niceDate":"2021-07-03 21:41","origin":"","originId":15188,"publishTime":1625319685000,"title":"每日一问 | 启动了Activity 的 app 至少有几个线程？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>记得mipmap刚出来的时候，出现过很多言论，XXX类型图片放mipmap更好。</p>\r\n<p>如今的观念基本停留在，仅将app icon放置到mipmap，其他的图片都放到drawable。</p>\r\n<p>那么我们想想：</p>\r\n<ol>\r\n<li>google 为啥要搞个mipmap，或者mipmap有什么特殊的能力？</li>\r\n<li>从源码上能做出相关分析吗？</li>\r\n</ol>","envelopePic":"","id":204912,"link":"https://wanandroid.com/wenda/show/17666","niceDate":"2021-07-03 21:38","origin":"","originId":17666,"publishTime":1625319531000,"title":"每日一问 | mipmap vs drawable，傻傻分不清楚？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>很多时候我们在自定义 View 的需要做动画的时候，我们可以依赖属性动画的回调周期性修改 自定义的属性值，然后调用 invalidate 方法实现。</p>\r\n<p>不过我还见过一个比较野的路子，它在 onDraw 里面直接修改属性，然后调用 invalidate() 方法。</p>\r\n<p>运行起来好像也没问题。</p>\r\n<p>那么问题来了：</p>\r\n<ol>\r\n<li>在 onDraw 里面调用 修改绘制相关属性（例如画圆，修改半径） invalidate() ，这种与属性动画的回调调用 invalidate()源码分析有什么区别？</li>\r\n<li>在 onDraw 里面调用  invalidate() 会存在什么问题？</li>\r\n</ol>","envelopePic":"","id":204911,"link":"https://www.wanandroid.com/wenda/show/17629","niceDate":"2021-07-03 21:35","origin":"","originId":17629,"publishTime":1625319310000,"title":"每日一问 | onDraw 里面调用 invalidate 做动画，有什么问题？","userId":31008,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>大家应该都清楚app上内存是非常宝贵的资源，而Bitmap几乎是app里面占据内存最大的一个部分。</p>\r\n<p>不少同学也清楚，Bitmap占据的内存计算为：</p>\r\n<pre><code>宽 * 高 * 单个像素所需字节数\r\n</code></pre><p>今天有个很常规，但是你可能没有太关注的问题：</p>\r\n<ol>\r\n<li>Bitmap所占用的内存，是app的哪部分的内存？或者说app运行时可使用Java内存为512M，Bitmap占据的内存可以超过512M吗?</li>\r\n<li>问题1中所描述的，需要区分Android版本吗（5.0以下不考虑）？</li>\r\n<li>问题1，问题2如果都搞清楚，经常在一些blog看到这样的代码：设置fresco图片缓存空间为Java内存的白分比，例如1/4，合适吗？</li>\r\n</ol>","envelopePic":"","id":204910,"link":"https://wanandroid.com/wenda/show/17874","niceDate":"2021-07-03 21:34","origin":"","originId":17874,"publishTime":1625319256000,"title":"每日一问 | 听说你做过内存优化 之 Bitmap内存占用到底在哪？","userId":31008,"visible":0,"zan":0}]
/// offset : 0
/// over : false
/// pageCount : 2
/// size : 20
/// total : 25

class CollectModel {
  int? curPage;
  List<Article>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  CollectModel(
      {this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total});

  CollectModel.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = new List<Article>.empty(growable: true);
      json['datas'].forEach((v) {
        datas?.add(new Article.fromJson(v));
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    if (this.datas != null) {
      data['datas'] = this.datas?.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class Article {
  String? author;
  int? chapterId;
  String? chapterName;
  int? courseId;
  String? desc;
  String? envelopePic;
  int? id;
  String? link;
  String? niceDate;
  String? origin;
  int? originId;
  int? publishTime;
  String? title;
  int? userId;
  int? visible;
  int? zan;

  Article(
      {this.author,
        this.chapterId,
        this.chapterName,
        this.courseId,
        this.desc,
        this.envelopePic,
        this.id,
        this.link,
        this.niceDate,
        this.origin,
        this.originId,
        this.publishTime,
        this.title,
        this.userId,
        this.visible,
        this.zan});

  Article.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    courseId = json['courseId'];
    desc = json['desc'];
    envelopePic = json['envelopePic'];
    id = json['id'];
    link = json['link'];
    niceDate = json['niceDate'];
    origin = json['origin'];
    originId = json['originId'];
    publishTime = json['publishTime'];
    title = json['title'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['chapterId'] = this.chapterId;
    data['chapterName'] = this.chapterName;
    data['courseId'] = this.courseId;
    data['desc'] = this.desc;
    data['envelopePic'] = this.envelopePic;
    data['id'] = this.id;
    data['link'] = this.link;
    data['niceDate'] = this.niceDate;
    data['origin'] = this.origin;
    data['originId'] = this.originId;
    data['publishTime'] = this.publishTime;
    data['title'] = this.title;
    data['userId'] = this.userId;
    data['visible'] = this.visible;
    data['zan'] = this.zan;
    return data;
  }}