
# 中海油地层结构建模项目文档

## 项目背景

测井技术作为地下地质信息获取的核心手段，通过井孔内岩石物理参数（如电阻率、声波速度、放射性等）的精密测量，为油气勘探、地质构造解析及水文工程提供了关键数据支撑。现代井壁成像仪器（如FMI、UBI、声电成像仪）已能对井周地层进行可视化扫描，精准识别层理、裂缝及溶蚀孔洞等微观结构，并生成包含岩层产状（倾向、倾角、走向）的高分辨率数据。然而，传统建模方法依赖的离散化井周局部信息仅能反映井眼附近的构造特征，无法准确预测地层的延伸规律。尤其在挤压或伸展构造区（如褶皱转折端），基于平行层假设的建模方法因忽略地层厚度变化、岩层旋转等动态特征，导致储层几何形态误差增大，严重制约复杂构造区的资源评价精度。针对上述问题，本项目提出一种基于蛛网算法的新型建模框架，构建符合地质力学规律的地质模型，为复杂构造区的资源勘探与开发提供高精度地质模型支撑。

## 预备知识

### 地层构造
1. 褶皱构造
   1. 褶皱构造是岩层在构造应力（如挤压）作用下发生的弯曲变形。反映区域水平挤压作用，常见于造山带，是油气储集的重要构造。

   2. 分类：

      - 背斜（Anticline）：岩层向上拱起，核心部位为老地层。

      - 向斜（Syncline）：岩层向下弯曲，核心部位为新地层。

      - 单斜（Monocline）：岩层向单一方向倾斜的平缓弯曲。
    ![图0](./assets/背斜和向斜.png "背斜和向斜")
    ![图1](./assets/单斜构造.png "单斜")
   3. 相似褶皱和平行褶皱
      - **相似褶皱**（similar fold）是一种褶皱几何模式，褶皱中各岩层成相似弯曲，即其曲率半径大致相等，但没有共同的曲率中心，故褶皱形态在一定深度内保持不变。同一岩层的真厚度在翼部变薄、在转折端加厚,但顺轴面方向的视厚度在褶皱的不同部位大致相等（图中不同部位黑色竖线大致相等）。
      ![图2](./assets/相似褶皱.png "相似褶皱")
      - **平行褶皱**（parallel fold）是一种褶皱几何模式。组成褶皱的各褶皱面作平行弯曲，同一褶皱层的厚度保持不变，所以也称为等厚褶皱（isopach fold）；弯曲的各层具有同一曲率中心，所以又称同心褶皱（concentric fold）（图中与层面线垂直的黑色竖线大致相等）。
      ![图3](./assets/等厚褶皱.png "平行褶皱")

2. 断层构造
   1. 岩层因构造应力发生破裂并沿破裂面发生明显位移。
   2. 分类：
      - 正断层（Normal Fault）：受拉张力作用，上盘相对下降。
      - 逆断层（Reverse Fault）：受挤压力作用，上盘相对上升。
      - 走滑断层（Strike-Slip Fault）：两盘沿断层走向水平滑动。
   ![图4](./assets/断层示意图.png "断层")
   3. 描述断层的要素：
      - 断盘：断层面两侧发生相对位移的岩体，称为断（层）盘。当断层面倾斜时，位于断层面上方的称为上盘，下方的称为下盘；当断层面近于直立时，则以方位相称，如东盘、西盘等；也可根据两盘相对移动的关系，把相对上升的称为上升盘，把相对下降的称为下降盘。
      - 断距：断层两盘岩体沿断层面发生相对滑动的距离。断距的大小常常是衡量断层规模的重要标志，断距又分为总断距（地层断距）、水平地层断距及垂（铅）直地层断距。
   ![图5](./assets/断层面.webp "断层面")
   ![图6](./assets/断层滑距和断距.png "断层滑距和断距")

### 岩层产状

岩层产状是指即岩层的产出状态，由地层倾角、走向和倾向构成岩层在空间产出的状态和方位的总称。现有的测井工具可以直接得到各个深度的岩层产状以及井斜数据，其中：

- 地层倾角：层面上的倾斜线和它在水平面上投影的夹角，称倾角，又称真倾角(下图中的α均表示真倾角)；倾角的大小表示岩层的倾斜程度。视倾斜线和它在水平面上投影的夹角，称视倾角(γ)。真倾角只有一个，而视倾角可有无数个，任何一个视倾角都小于该层面的真倾角。
设ABCD 为地层层面，ABEF 为水平面，AB、CD 为走向线，AFD 面为与走向垂直的断面。
![图7](./assets/真倾角和视倾角.png "真倾角和视倾角")
- 方位角：方位角，又称地平经度(Azimuth angle，缩写为Az)，是在平面上量度物体之间的角度差的方法之一。是从某点的指北方向线起，依顺时针方向到目标方向线之间的水平夹角。（以太阳为例）
![图8](./assets/太阳方位角.png "太阳方位角")
- 方位角表示法：一般记录倾向和倾角 ，如SW205°∠65°，即倾向为南西205°，倾角65°，其走向则为NW295°或SE115°（通常取115°）。
- 走向：岩层层面与任一假想水平面的交线称走向线，也就是同一层面上等高两点的连线；走向线两端延伸的方向称岩层的走向，岩层的走向也有两个方向，彼此相差180°，通常用小于180°的方位角表示。岩层的走向表示岩层在空间的水平延伸方向。 

**加上走向和水平方位角的关系**


- 倾向：层面上与走向线垂直并沿斜面向下所引的直线叫倾斜线，它表示岩层的最大坡度；倾斜线在水平面上的投影所指示的方向称岩层的倾向，又叫真倾向，真倾向只有一个，倾向表示岩层向哪个方向倾斜。
![图9](./assets/岩层产状.png "岩层产状")
![图10](./assets/岩层产状示例.png)
- 井轨迹水平投影：将钻井轨迹投影到水平面上。
![图11](./assets/井轨迹投影.png "井轨迹投影")
- 井斜角（α表示）：井斜角是钻井专业术语，又叫井斜，通常定义为井眼轴线上某点的切线与铅垂线的夹角。
- 井斜方位角（β表示）：井眼轴线的切线在水平投影面上的方向。以正北方向线为始边顺时针转至该水平投影线之间所夹的角度来表示。
![图12](./assets/井斜角和井斜方位角.png)


### 地质分层

**加上地质分层的相关概念**

### 极射赤平投影
极射赤平投影是一种以球面投影为基础的几何方法，通过将三维空间中的方向、平面或线投影到一个参考平面（通常为赤道平面），形成二维图形，保留原始结构的空间关系。
在未说明的情况下默认使用上级射点发出射线，例如下图中线PB投影到赤平面上为B'，将倾斜面NBSA与球面的无数个交点与P点连城直线并投影到赤平面得到弧线NB'S
![图13](./assets/级射赤平投影图.png "级射赤平投影图")

### 吴氏网
吴氏网是一种基于等角极射赤平投影的网格工具，用于将三维空间中的方向、平面和线投影到二维平面上，同时保持原始角度关系不变。A图吴氏网的经线可以用下图B的下半圆球面与过圆心的倾斜大圆（倾斜面）的交点形成的直线投影在赤平面（图B中的半球切面）投出的无数个点形成弧线得到，同理，吴氏网的纬线可由下半圆球面与不过圆心的直立小圆的交点形成的直线投影在赤平面投出的无数个点形成弧线得到。之后，从N向顺时针360°标方位。
经线弧NES到弧NS之间的一系列弧线分别表示倾斜平面倾角0度到90度，经线弧NWS到弧NS之间的一系列弧线也分别表示倾斜平面倾角0度到90度。
![图14](./assets/极射赤平投影得到吴氏网.png "极射赤平投影得到吴氏网")

### 利用吴氏网进行极射赤平投影
倾斜面NDS与倾斜面法线（法向量）OF的极射赤平投影示例：法线OF投影到赤平面上得到该倾斜面NSD的极点F'，平面法线的投影示例如下图，D'E表示倾斜面倾角大小40°（B图弧ND'S对应吴氏网40°经线）,同理WF'表示法线倾角大小为50°（WE处的纬线与50°经线交点）：
![图15](./assets/平面法向量直线投影.png)

### 构造轴线与构造剖面
构造轴线概念
- 褶皱的构造轴线又叫褶皱轴（Fold Axis）：褶皱中岩层弯曲的枢纽线（枢纽的延伸方向）。
  - 轴面（Axial Plane）：平分褶皱两翼的假想平面，枢纽线通常位于轴面内。
  - 褶皱构造图示如下：
  ![图16](./assets/褶皱构造图示.png "褶皱构造图示")
- 单斜构造的构造轴线通常是走向线
- 断层的构造轴线是断层带的主破裂面走向线或多条断层的平均走向线。
构造轴线与投影平面确定（图解法
- 单斜构造和断层构造的构造轴线为走向线，投影平面为与走向线垂直一系列平面。
- 枢纽线水平的褶皱构造使用π图解法确定构造轴线（见下图）：
  褶皱构造两翼各点处的切平面法线向量（至少两个法向量）$P_1,P_2,P_3,P_4,P_5,P_6$形成的π圆面（下图粉色平面）为投影平面。投影平面的法向量$\beta$为构造轴线。
  具体步骤：
   1.从数据中得到，褶皱上至少两点处切平面的产状，并跟距产状得到各切平面法向量（$P_i$）在赤平面上的投影点。
   2.多个法向量的投影点（至少两个）可在赤平面上拟合一个大圆，该大圆对应的平面就是投影面（π圆面），该投影面法向量就是构造轴线$\beta$在赤平面上投影为一个点。
   3.将该投影平面（π圆面）或与其平行的平面作为二维地质构造剖面（二维构造剖面为地质体内部​​构造特征​​、​​岩性分布​​及​​地质事件序列​​的图解模型，与构造轴线相垂直。）
   ![图17](./assets/图解法求褶皱枢纽.png "图解法")

### 蛛网法

蛛网法可以根据给定岩层产状和构造轴线来生成二维构造剖面，其主要步骤分为以下两步：
1. 在第一步中，导向网是根据井筒轨迹上的倾角数据生成的。初始导向网由相邻两倾角的垂线的中分线构成（这些中分线位于两倾角的中点处，见下图b）。为了在下一步中最大限度地利用输入数据延伸地层，还在初始网集中额外加入了最顶端和最底端倾角的垂线。初始经向丝的数量等于初始倾角数加一。经向网的构建则通过以下迭代合并这些初始经向丝来完成：
   1. 步骤 1：在当前的经向丝集合$T_{1}, T_{2}, T_{3}, \ldots, T_{N}$中，查找每对相邻丝$T_{n}$与$T_{n+1}$的所有交点$I_{1}, I_{2}, I_{3}, \ldots, I_{N+1} $（见下6c）。
   2. 步骤 2：在这些交点中，找到距离井筒最近的交点$I_{n}$（下图6c中圈出的那个交点）。
   3. 步骤 3：在该交点处停止经向丝$T_{n}$和$T_{n+1}$的延伸，并从此交点开始生成一条新的经向丝$T_{\text {new }}$（见下图6d）。
   4. 步骤 4：更新经向丝集合：移除$T_{n}$和$T_{n+1}$，并将新生成的$T_{\text {new }}$加入集合。

   新生成的经向丝方向定义为位于$T_n$之上和$T_{n+1}$之下两根倾角对应垂线的中分线（这里n从上到下排序）。当不再出现新的交点，或线集内仅剩一条经向丝时，迭代结束（见下图6g）。这些经向丝将二维平面划分为若干区域，每个区域包含一个倾角。
2. 在第二步中，各输入倾角将在其对应区域内延伸。当延伸线达到区域边界时，便继续延伸，但此后使用下一区域的倾角（见下图 6h）。在枢纽带（hinge zone 铰部带）之外，地层几何形态与先前方法完全一致；而在枢纽带（铰部带）内部，由于导向网的合并作用，地层形态也能得到正确重建。该方法对于垂直井中包含平行褶皱的平行层构建以及水平井中的单斜构造都非常有效。但当输入倾角几乎垂直于井筒方向时，导向网会变得非常狭窄，倾角无法向井外传播，此时方法便不适用。倾角的逐渐变化也使得褶皱铰部带的几何形态更加平滑。
![图18](./assets/蛛网法.png "蛛网法")

## 项目契约

目前第一步的目标是针对单斜构造构建二维地质剖面，长远目标为针对任意构造构建二三维地质剖面。

目前给出的输入数据：
- 一份垂直井的测井数据，其中包括以下几列DEPT（垂深），DEVI（井斜角），DPAZ（地层倾角倾向），DPTR（地层倾角角度），HAZI（水平方位角），还有一个TYPE(地层构造类型)。
- 用户自定义的构造轴线，若缺省则默认由程序计算构造轴线。
初步目标的输出数据：
- 二维单斜地质剖面图。

## 技术路线



算法主要分为以下四步：
1. 数据过滤：对地层倾角进行平滑处理，过滤掉急剧变化的倾角，比如和前后倾角相差超过5度的倾角数据。
2. 分区和模型选择： 根据立体网的模式进行区域划分，针对不同区域依照其特征选取不同的地层构造模型。(测井数据的TYPE标签)
3. 确定构造轴线和剖面所在平面：见预备知识。
4. 将地层倾角投影到二维平面，再用蛛网法生成二维构造剖面：该二维平面就是上述图解法得到的投影平面，投影得到的倾角线（下图的dip）就是构造结构（例如单斜，褶皱）上某点处切平面与投影平面的交线。
![图19](./assets/蛛网法.png "蛛网法")
