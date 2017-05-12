# JXShopDemo
商品规格选择购物车demo

## 整个项目使用MVVM模式

<p>

#### 1.VC(控制器)
基本定义为,方法不外传,属性不外传,能用+号方法就用+号方法搞定
职责:事件流向的中转站,对象(view/viewModel)的创建与维护
点击事件(click action),转换事件(push present)

#### 2.V(视图View)
职责:UI控件的排布,动画,数据的展示(数据展示安排在这一层是为了更清晰的黑盒测试,如果安排在VM中,黑盒测试找到问题很麻烦(除非功力深厚或者对代码很熟悉才行))

#### 3.Model(模型)
Model的职责:原始数据的解析以及包装

#### 4.VM(视图模型)
职责:对原始数据model的包装,包装成为view可以(=号赋值)使用的数据,事件的源头以及接收事件的源头

</p>

### 加入购物车效果
![image](https://github.com/HJXIcon/JXShopDemo/blob/master/JXShopDemo/images/chooseGood.gif)
