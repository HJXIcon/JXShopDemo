# JXShopDemo
商品规格选择购物车demo

## 整个项目使用MVVM模式

<p>

#### 1.VC(控制器)
基本定义为,方法不外传,属性不外传,能用+号方法就用+号方法搞定
职责:事件流向的中转站,对象(view/viewModel)的创建与维护
点击事件(click action),转换事件(push present)

#### 2.V(视图View)
职责:`UI`控件的排布,动画,数据的展示(数据展示安排在这一层是为了更清晰的黑盒测试,如果安排在`VM`中,黑盒测试找到问题很麻烦(除非功力深厚或者对代码很熟悉才行))

#### 3.Model(模型)
`Model`的职责:原始数据的解析以及包装

#### 4.VM(视图模型)
职责:对原始数据`model`的包装,包装成为view可以(=号赋值)使用的数据,事件的源头以及接收事件的源头
</br><br />
就是作为一个表现视图显示自身所需数据的静态模型;但它也有收集, 解释和转换那些数据的责任. 这留给了 `view (controller)` 一个更加清晰明确的任务: 呈现由 `view-model` 提供的数据。

</p>

****
那*`MVVM`*相比*`MVC`*到底有哪些好处:

1.由于展示逻辑被抽取到了`viewModel` 中，所以 `view` 中的代码将会变得非常轻量级；</br><br />
2.由于 `viewModel` 中的代码是与 `UI` 无关的，所以它具有良好的可测试性；</br><br />
3.对于一个封装了大量业务逻辑的`model`来说，改变它可能会比较困难，并且存在一定的风险。在这种场景下，`viewModel` 可以作为 `model` 的适配器使用，从而避免对 `model` 进行较大的改动。</br><br />

### 加入购物车效果
![image](https://github.com/HJXIcon/JXShopDemo/blob/master/JXShopDemo/images/chooseGood.gif)

### 购物车效果图
![image](https://github.com/HJXIcon/JXShopDemo/blob/master/JXShopDemo/images/shopCart.gif)

### 店铺效果图
![image](https://github.com/HJXIcon/JXShopDemo/blob/master/JXShopDemo/images/storeDetail.gif)



