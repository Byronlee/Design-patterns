设计模式- 组合模式
===================================
_[注] 讲解主要以Java环境为主,代码实现可带不同语言版本_

### 提纲
* 问题的产生
* 组合模式主要内容,定义
* 组合模式的分类
* 模式UML结构
* 使用场景
* 模式实现
* 优缺点
* 注意事项

### 问题的产生

  我们可以使用简单的对象组合成复杂的对象，而这个复杂对象有可以组合成更大的对象。我们可以把简单这些对象定义成类，然后定义一些容器类来存储这些简单对象。客户端代码必须区别对象简单对象和容器对象，而实际上大多数情况下用户认为它们是一样的。对这些类区别使用，使得程序更加复杂。递归使用的时候跟麻烦，而我们如何使用递归组合，使得用户不必对这些类进行区别呢？

  组合模式提供了一种解决方案，使得用户对单个对象和组合对象的使用具有一致性。

### 组合模式主要内容,定义

 组合模式：将对象组合成树形结构以表示“部分-整体”的层次结构。Composite使得用户对单个对象和组合对象的使用具有一致性。

 有时候又叫做部分-整体模式，它使我们树型结构的问题中，模糊了简单元素和复杂元素的概念，客户程序可以向处理简单元素一样来处理复杂元素,从而使得客户程序与复杂元素的内部结构解耦。

 组合模式让你可以优化处理递归或分级数据结构。有许多关于分级数据结构的例子，使得组合模式非常有用武之地。关于分级数据结构的一个普遍性的例子是你每次使用电脑时所遇到的:文件系统。文件系统由目录和文件组成。每个目录都可以装内容。目录的内容可以是文件，也可以是目录。按照这种方式，计算机的文件系统就是以递归结构来组织的。如果你想要描述这样的数据结构，那么你可以使用组合模式Composite。

### 组合模式的分类

* 将管理子元素的方法定义在Composite(合成)类中 ,即所谓的__安全式__。
* 将管理子元素的方法定义在Component(元件)接口中，这样Leaf类就需要对这些方法空实现。即所谓的__透明式__。

### 模式UML结构

* 组合模式: __透明式__
![组合模式透明式UML](http://hi.csdn.net/attachment/201009/25/0_1285454118ygRO.gif)

* 组合模式: __安全式__
![组合模式透明式UML](http://hi.csdn.net/attachment/201009/25/0_1285454124wIV0.gif)

从类图中可以看出合成模式涉及3个角色：

* 抽象构件角色(Component)：这是一个抽象角色，他给参加组合的对象规定一个接口，这个角色给出共有的接口及其默认行为。
* 树叶构件角色(Leaf)：代表参加组合的树叶对象。一个树叶没有下级的子对象。定义出参加原始对象的行为。
* 树枝构件角色(Composite)：代表参加组合的有子对象的对象，并给出树枝构件对象的行为。

他们最主要的特点区别：

* 透明方式：就是在Component里面声明所有的用来管理子对象的方法，包括add()、remove()以及getChild()方法，这样做的好处是所有的构件类都有相同的接口。在客户端看来，树叶类对象与合成类对象的区别起码在接口层次上消失了，客户端可以同等的对待所有的对象。这就是透明形式的组合模式。
  * __[缺点]__这个选择的缺点是不够安全的，因为树叶类对象和合成类对象在本质上是有区别的，树叶类对象不可能有一层的对象，因此add()、remove（）以及getChild()方法没有意义，但是在编译时期不会出错，而只会在运行时期才会出错。
       
* 安全方式：是在Composite类里面声明所有的用来管理子类对象的方法。这样的做法是安全的做法，因为树叶类型的对象根本就没有管理子对象的方法。因此，如果客户端对树叶对象使用这些方法时会在编译时期出错。编译不通过，就不会出现运行时出错。
  * __[缺点]__这个选择的缺点是不够透明，因为树叶类和合成类将具有不同的接口。

### 使用场景

* 你想表示对象的部分-整体层次结构
* 你希望用户忽略组合对象与单个对象的不同，用户将统一地使用组合结构中的所有对象。

### 模式实现

__场景：__ 雇员,员工,和leader,之间的关系。
我们这里具的例子属于安全式组合,给出的组合模式抽象角色里，并没有管理子节点的方法，而是在树枝构建角色，这种模式使得叶子构建角色和树枝构建角色有区分，客户端要分别对待树叶构建角色和树枝构建角色，好处是客户端对叶子节点不会调用管理的方法，当调用时，在编译时就会报错. 透明式大同小异,就不举例了.

UML图如下:
![UML图](http://dl2.iteye.com/upload/attachment/0087/2152/00a078fa-9f4c-322e-bd0d-96bccfd24d02.png)

员工和领导的统一接口 
```java
package composite;  
/** 
 *  
 *作者：Byronlee
 *描述：员工和领导的统一接口 
 */  
public interface Worker {  
      
    public void doSomething();  
  
}  
```
普通员工类 
```java
package composite;  
/** 
 *  
 *作者：Byronlee
 *描述：普通员工类 
 */  
public class Employe implements Worker {  
  
    private String name;  
      
    public Employe(String name) {  
        super();  
        this.name = name;  
    }  
    @Override  
    public void doSomething() {  
        System.out.println(toString());  
    }  
  
  
    @Override  
    public String toString() {  
        // TODO Auto-generated method stub  
        return "我叫"+getName()+",就一普通员工!";  
    }  
  
    public String getName() {  
        return name;  
    }  
  
    public void setName(String name) {  
        this.name = name;  
    }     
  
}  
``` 
领导类 
```java
package composite;  
  
import java.util.Iterator;  
import java.util.List;  
import java.util.concurrent.CopyOnWriteArrayList;  
  
/** 
 *  
 *作者：Byronlee
 *描述：领导类 
 */  
public class Leader implements Worker {  
    private List<Worker> workers = new CopyOnWriteArrayList<Worker>();    
    private String name;  
      
    public Leader(String name) {  
        super();  
        this.name = name;  
    }  
    public void add(Worker worker){  
        workers.add(worker);  
    }  
      
    public void remove(Worker worker){  
        workers.remove(worker);  
    }  
      
    public Worker getChild(int i){  
        return workers.get(i);  
    }  
    @Override  
    public void doSomething() {  
        System.out.println(toString());  
        Iterator<Worker> it = workers.iterator();  
        while(it.hasNext()){  
            it.next().doSomething();  
        }  
              
    }  
  
      
    @Override  
    public String toString() {  
        // TODO Auto-generated method stub  
        return "我叫"+getName()+", 我是一个领导,有 "+workers.size()+"下属。";  
    }  
    public String getName() {  
        return name;  
    }  
  
    public void setName(String name) {  
        this.name = name;  
    }  
  
}  
``` 
测试类 
```java
package composite;  
/** 
 *  
 *作者：Byronlee
 *描述：测试类 
 */  
public class Client {  
  
    public static void main(String[] args) {  
        Leader leader1 = new Leader("张三");  
        Leader leader2 = new Leader("李四");  
        Employe employe1 = new Employe("王五");  
        Employe employe2 = new Employe("赵六");  
        Employe employe3 = new Employe("陈七");  
        Employe employe4 = new Employe("徐八");  
        leader1.add(leader2);  
        leader1.add(employe1);  
        leader1.add(employe2);  
        leader2.add(employe3);  
        leader2.add(employe4);  
        leader1.doSomething();  
          
    }  

运行结果如下：
我叫张三, 我是一个领导,有 3个直接下属。
我叫李四, 我是一个领导,有 2个直接下属。
我叫陈七,就一普通员工!
我叫徐八,就一普通员工!
我叫王五,就一普通员工!
我叫赵六,就一普通员工!
```

上面员工关系的的树形结构如下：
![员工关系的的树形结构](http://dl2.iteye.com/upload/attachment/0087/2154/20ef23a1-567a-34ac-a1b4-8d73f3e6b2ef.png)

### 优缺点

* 优点
  * 使得用户对单个对象和组合对象的使用具有一致性。
* 缺点
  * 使用合成模式后，控制树枝构件的类型就不太容易。
  * 用继承的方法增加新的行为很困难。
  
### 注意事项

* 透明式组合是将管理子元素的方法定义在Component(元件)接口中
* 安全式组合是将管理子元素的方法定义在Composite(合成)类中