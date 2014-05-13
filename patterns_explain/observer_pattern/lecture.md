设计模式- 观察者模式
===================================
_[注] 讲解主要以Java环境为主,代码实现可带不同语言版本_

### 提纲
* 问题的产生
* 观察者模式主要内容,定义
* 模式UML结构
* 使用场景
* 用户自定义观察者模式通用模式代码(java)
* 模式分类(推模型和拉模型)
* 模式实现(推模型)
* 模式实现(拉模型)
* 推拉两种模式的比较
* 优缺点
* 模式总结
* JAVA提供的对观察者模式的支持
* 怎样使用JAVA对观察者模式的支持
* Ruby中的观察者
* Ruby提供的观察者模式库
* Js中的观察者

### 问题的产生

  一个软件系统里面包含了各种对象，就像一片欣欣向荣的森林充满了各种生物一样。在一片森林中，各种生物彼此依赖和约束，形成一个个生物链。一种生物的状态变化会造成其他一些生物的相应行动，每一个生物都处于别的生物的互动之中。

　同样，一个软件系统常常要求在某一个对象的状态发生变化的时候，某些其他的对象做出相应的改变。做到这一点的设计方案有很多，但是为了使系统能够易于复用，应该选择低耦合度的设计方案。减少对象之间的耦合有利于系统的复用，但是同时设计师需要使这些低耦合度的对象之间能够维持行动的协调一致，保证高度的协作。观察者模式是满足这一要求的各种设计方案中最重要的一种。

### 观察者模式主要内容,定义

  __观察者模式是对象的行为模式，又叫发布-订阅(Publish/Subscribe)模式、模型-视图(Model/View)模式、源-监听器(Source/Listener)模式或从属者(Dependents)模式。__

　__观察者模式定义了一种一对多的依赖关系，让多个观察者对象同时监听某一个主题对象。这个主题对象在状态上发生变化时，会通知所有观察者对象，使它们能够自动更新自己。__

### 模式UML结构

![观察者模式UML结构图](data:image/png;base64,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YgsrdrVusXQ9bCurtbywCxZLdyyWPgTFdQ56nQlSGr3jJE3TrBGGauUmSGxhxa5WTyKBGCUsRJNQNyQDQ0SfflJmsXQWSxcorjORpzHxO9u2DUOTBjfqdxdvmJWbILGFFbvaM/3hWAgci6UTt8I6VyzYOOUafMy/6K/mPU1ObFwPKzdBYgsrdvVAuYUdi6WbwpBdkUHYg2QNrNjVY4krMQTtyjofP358IvP48ccf926CGT5+/Li3ac+C4koOCu2KPAivr6+fPn3697//vXdDyJJQXMlBoV2RR+Dr168vLy9vb2+fPn36z3/+s3dzyGJQXMlBoV2RR+Cnn37Cgr3//ve/nz59ent727tFZBkorkdEakE/8oJX2hU5PX/88ccvv/wi//7666+//fbbju0hC7KkuOqSUstG/I8lfEACxeljURpd73bwauR6kev86lfrMfbjr12gl+JKzs23b99eXl6+ffsmW97e3p6fn//666/9GkUWY0lxbZpGCigu6HJ1XRcufke6CedcURQTJeFQfsd9rwQ3VZXaGJ3UyV2yme/XnOEfX1g8haSG4krOzS+//PLHH394G798+fL58+c9mkMWZjFxxTr9qqqQd+l9FTbmFx/WzuiEb+flRESWhiMn7w3lajAx8kGguBLyPuq6/umnnwbf+vnnn//888+N20MWZzFxTdM0iqJYAXcHfhjKgOujBnV0rFh6KNVzBBI5F/Uh8HHl2MEa5qGShY0X53KOSIf125umGUxnMTjQitSPVz8FZ5ufBnmQmT++7ElxJeQdvL29vby8fP36dfDdb9++PT8///333xu3iizLksPCuo4pXiDNL8RMlxBHFTloyXSx9L7vvbJ0g3v2fS+Zh1EtoO/7sGYq/s3zHIdXVSXygNp2yGOsk5hD77VO40vBQUeKYDejWLrMpKLxkEzk5JPPGnxi8AqtT1AUxdX060gwi2eFqqpEtvHaG3UY/PHxUzRNo7/yGlBcyVl5fX19fX2d2OH333/nslfrrCuuTlWwEbfMcyini6WDMOV6uCdEC+eHYHviKg2AtGOjCCHUAhvlhR6S1Xn24zgWWZLngLBYuhYq7YBC3aXZ01+/aZplHURJ765d0omaQt6PrwWVnishtyILW6d347JX6yw55wrXB56WiISuhyXapiVkKXGVU4lu6WqyTmmtPlYLcJIkKLajT9g0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)

观察者模式所涉及的角色有：

*  __抽象主题(Subject)角色__： 抽象主题角色把所有对观察者对象的引用保存在一个聚集（比如ArrayList对象）里，每个主题都可以有任何数量的观察者。抽象主题提供一个接口，可以增加和删除观察者对象，抽象主题角色又叫做抽象被观察者(Observable)角色。
* __具体主题(ConcreteSubject)角色__： 将有关状态存入具体观察者对象；在具体主题的内部状态改变时，给所有登记过的观察者发出通知。具体主题角色又叫做具体被观察者(Concrete Observable)角色。
* __抽象观察者(Observer)角色__： 为所有的具体观察者定义一个接口，在得到主题的通知时更新自己，这个接口叫做更新接口。
* __具体观察者(ConcreteObserver)角色__： 存储与主题的状态自恰的状态。具体观察者角色实现抽象观察者角色所要求的更新接口，以便使本身的状态与主题的状态相协调。如果需要，__具体观察者角色可以保持一个指向具体主题对象的引用__。

### 使用场景

* 如果一个系统多个的对象对某些特定的对象的状态或者属性等的改变感兴趣,就可以采取该模式

### 用户自定义观察者模式通用模式代码(java)

常见抽象Subject类：

```java
 public abstract Subject {
  //向该主题中注册或添加新的观察者
  void registerObserver(Observer obs);
  //从该主题中删除移调某一个观察者
  void removeeObserver(Observer obs);
  //通知该主题下面注册的观察者
  void notifyObservers();
}
```
Observer接口:

```java
public interface Observer {
  //接受主题变化传递的消息
  void update(Object obj);
}
```
### 模式分类(推模型和拉模型)

在观察者模式中，又分为推模型和拉模型两种方式。

* 推模型
  * 主题对象向观察者推送主题的详细信息，不管观察者是否需要，推送的信息通常是主题对象的全部或部分数据。
* 拉模型
  * 主题对象在通知观察者的时候，只传递少量信息。如果观察者需要更具体的信息，由观察者主动到主题对象中获取，相当于是观察者从主题对象中拉数据。一般这种模型的实现中，会把主题对象自身通过update()方法传递给观察者，这样在观察者需要获取数据的时候，就可以通过这个引用来获取了。

### 模式实现(推模型)

__场景：__ 假如我们有一个主题,它有一个观察者,当这个主题的状态改变后,通知它的观察者：

抽象主题角色类
```java
public abstract class Subject {
    /**
     * 用来保存注册的观察者对象
     */
    private    List<Observer> list = new ArrayList<Observer>();
    /**
     * 注册观察者对象
     * @param observer    观察者对象
     */
    public void attach(Observer observer){
        
        list.add(observer);
        System.out.println("Attached an observer");
    }
    /**
     * 删除观察者对象
     * @param observer    观察者对象
     */
    public void detach(Observer observer){
        
        list.remove(observer);
    }
    /**
     * 通知所有注册的观察者对象
     */
    public void nodifyObservers(String newState){
        
        for(Observer observer : list){
            observer.update(newState);
        }
    }
}
```
具体主题角色类
```java
public class ConcreteSubject extends Subject{
    
    private String state;
    
    public String getState() {
        return state;
    }

    public void change(String newState){
        state = newState;
        System.out.println("主题状态为：" + state);
        //状态发生改变，通知各个观察者
        this.nodifyObservers(state);
    }
}
```
抽象观察者角色类
```java
public interface Observer {
    /**
     * 更新接口
     * @param state    更新的状态
     */
    public void update(String state);
}
```
具体观察者角色类
```java
public class ConcreteObserver implements Observer {
    //观察者的状态
    private String observerState;
    
    @Override
    public void update(String state) {
        /**
         * 更新观察者的状态，使其与目标的状态保持一致
         */
        observerState = state;
        System.out.println("状态为："+observerState);
    }

}
```
最后是客户端程序：Client.java
```java
public class Client {

    public static void main(String[] args) {
        //创建主题对象
        ConcreteSubject subject = new ConcreteSubject();
        //创建观察者对象
        Observer observer = new ConcreteObserver();
        //将观察者对象登记到主题对象上
        subject.attach(observer);
        //改变主题对象的状态
        subject.change("new state");
    }

}
```
运行结果:
```java
Attached an observer
主题状态为:  new state
观察者状态为: new state
```
### 模式实现(拉模型)

__场景：__ 与推模型场景一样__

__ 两种模式代码大部分相似,类图一样. 我们这里只罗列每个角色中不同部分的代码__

抽象主题角色类 不同部分
__拉模型的抽象主题类主要的改变是nodifyObservers()方法。在循环通知观察者的时候，也就是循环调用观察者的update()方法的时候，传入的参数不同了。__
```java
public abstract class Subject {
    .
    .
    .
    相同部分代码....
    .
    .
    .
   /**
     * 通知所有注册的观察者对象
     */
    public void nodifyObservers(){
        
        for(Observer observer : list){
            observer.update(this);
        }
    }
}
```
具体主题角色类 不同部分
__　跟推模型相比，有一点变化，就是调用通知观察者的方法的时候，不需要传入参数了。__
```java
public class ConcreteSubject extends Subject{
    .
    .
    .
    相同部分代码....
    .
    .
    .
    public void change(String newState){
        state = newState;
        System.out.println("主题状态为：" + state);
        //状态发生改变，通知各个观察者
        this.nodifyObservers();
    }
}
```
抽象观察者角色类
__拉模型通常都是把主题对象当做参数传递。__

```java
public interface Observer {
   /**
     * 更新接口
     * @param subject 传入主题对象，方面获取相应的主题对象的状态
     */
    public void update(Subject subject);
}
```
具体观察者角色类
```java
public class ConcreteObserver implements Observer {
    //观察者的状态
    private String observerState;
    
    @Override
    public void update(Subject subject) {
        /**
         * 更新观察者的状态，使其与目标的状态保持一致
         */
        observerState = ((ConcreteSubject)subject).getState();
        System.out.println("观察者状态为："+observerState);
    }

}
```
最后是客户端程序不变,运行结果也不变.

### 推拉两种模式的比较

* 推模型是假定主题对象知道观察者需要的数据；
* 拉模型是主题对象不知道观察者具体需要什么数据，没有办法的情况下，干脆把自身传递给观察者，让观察者自己去按需要取值。
* 推模型可能会使得观察者对象难以复用，因为观察者的update()方法是按需要定义的参数，可能无法兼顾没有考虑到的使用情况。这就意味着出现新情况的时候，就可能提供新的update()方法，或者是干脆重新实现观察者；
* 拉模型就不会造成这样的情况，因为拉模型下，update()方法的参数是主题对象本身，这基本上是主题对象能传递的最大数据集合了，基本上可以适应各种情况的需要。

### 优缺点
  待定，目前没发现

### 模式总结

观察者模式的核心是先分清角色、定位好观察者和被观察者、他们是多对一的关系。

实现的关键是要建立观察者和被观察者之间的联系、比如在被观察者类中有个集合是用于存放观察者的、当被检测的东西发生改变的时候就要通知所有观察者。在被观察者中要提供一些对所有观察者管理的一些方法.目的是添加或者删除一些观察者.这样才能让被观察者及时的通知观察者关系的状态已经改变、并且调用观察者通用的方法将变化传递过去。

### JAVA提供的对观察者模式的支持

在JAVA语言的java.util库里面，提供了一个Observable类以及一个Observer接口，构成JAVA语言对观察者模式的支持。

* __Observer接口__
  * 这个接口只定义了一个方法，即update()方法，当被观察者对象的状态发生变化时，被观察者对象的notifyObservers()方法就会调用这一方法。
```java
public interface Observer {

    void update(Observable o, Object arg);
}
```
* __Observable类__
  * 被观察者类都是java.util.Observable类的子类。java.util.Observable提供公开的方法支持观察者对象，
  * 这些方法中有两个对Observable的子类非常重要：一个是setChanged()，另一个是notifyObservers()。
  * 第一方法setChanged()被调用之后会设置一个内部标记变量，代表被观察者对象的状态发生了变化。
  * 第二个是notifyObservers()，这个方法被调用时，会调用所有登记过的观察者对象的update()方法，使这些观察者对象可以更新自己。
```java
public class Observable {
    private boolean changed = false;
    private Vector obs;
   
    /** Construct an Observable with zero Observers. */

    public Observable() {
    obs = new Vector();
    }

    /**
     * 将一个观察者添加到观察者聚集上面
     */
    public synchronized void addObserver(Observer o) {
        if (o == null)
            throw new NullPointerException();
    if (!obs.contains(o)) {
        obs.addElement(o);
    }
    }

    /**
     * 将一个观察者从观察者聚集上删除
     */
    public synchronized void deleteObserver(Observer o) {
        obs.removeElement(o);
    }

    public void notifyObservers() {
    notifyObservers(null);
    }

    /**
     * 如果本对象有变化（那时hasChanged 方法会返回true）
     * 调用本方法通知所有登记的观察者，即调用它们的update()方法
     * 传入this和arg作为参数
     */
    public void notifyObservers(Object arg) {

        Object[] arrLocal;

    synchronized (this) {

        if (!changed)
                return;
            arrLocal = obs.toArray();
            clearChanged();
        }

        for (int i = arrLocal.length-1; i>=0; i--)
            ((Observer)arrLocal[i]).update(this, arg);
    }

    /**
     * 将观察者聚集清空
     */
    public synchronized void deleteObservers() {
    obs.removeAllElements();
    }

    /**
     * 将“已变化”设置为true
     */
    protected synchronized void setChanged() {
    changed = true;
    }

    /**
     * 将“已变化”重置为false
     */
    protected synchronized void clearChanged() {
    changed = false;
    }

    /**
     * 检测本对象是否已变化
     */
    public synchronized boolean hasChanged() {
    return changed;
    }

    /**
     * Returns the number of observers of this <tt>Observable</tt> object.
     *
     * @return  the number of observers of this object.
     */
    public synchronized int countObservers() {
    return obs.size();
    }
}
```
这个类代表一个被观察者对象，有时称之为主题对象。一个被观察者对象可以有数个观察者对象，每个观察者对象都是实现Observer接口的对象。在被观察者发生变化时，会调用Observable的notifyObservers()方法，此方法调用所有的具体观察者的update()方法，从而使所有的观察者都被通知更新自己。

### 怎样使用JAVA对观察者模式的支持

这里给出一个非常简单的例子，说明怎样使用JAVA所提供的对观察者模式的支持。在这个例子中，被观察对象叫做Watched；而观察者对象叫做Watcher。Watched对象继承自java.util.Observable类；而Watcher对象实现了java.util.Observer接口。另外有一个Test类扮演客户端角色。

被观察者Watched类源代码
```java
public class Watched extends Observable{
    
    private String data = "";
    
    public String getData() {
        return data;
    }

    public void setData(String data) {
        
        if(!this.data.equals(data)){
            this.data = data;
            setChanged();
        }
        notifyObservers();
    }
    
    
}
```
观察者类源代码
```java
public class Watcher implements Observer{
    
    public Watcher(Observable o){
        o.addObserver(this);
    }
    
    @Override
    public void update(Observable o, Object arg) {
        
        System.out.println("状态发生改变：" + ((Watched)o).getData());
    }

}
```
测试类源代码
```java
public class Test {

    public static void main(String[] args) {
        
        //创建被观察者对象
        Watched watched = new Watched();
        //创建观察者对象，并将被观察者对象登记
        Observer watcher = new Watcher(watched);
        //给被观察者状态赋值
        watched.setData("start");
        watched.setData("run");
        watched.setData("stop");

    }

}

运行结果：

状态发生改变： start
状态发生改变: run
状态发生改变: stop
```
Test对象首先创建了Watched和Watcher对象。在创建Watcher对象时，将Watched对象作为参数传入；然后Test对象调用Watched对象的setData()方法，触发Watched对象的内部状态变化；Watched对象进而通知实现登记过的Watcher对象，也就是调用它的update()方法。

### Ruby中的观察者

Ruby中的观察者与java中的基本上没有任何差别，UML图一样，Ruby本身也提供了observer库，只不过在一些实现细节，可以使用Ruby的一些特有元编程特性

下面看一个自实现的一个Ruby观察者模式，其中演变重构过3次，该例来自于《Ruby设计模式》中的观察者模式篇章

```ruby
# -*- coding: utf-8 -*-
#　员工类
# class Employee
#   attr_reader :name, :title
#   attr_reader :salary

#   def initialize name,title,salary
#     @name = name
#     @title = title
#     @salary = salary
#     @observers = []
#   end

#   # 由于我们要通知员工工资单关于员工工资的调整，所以不能对salary字段实用arrr_accessor,而必须手动的设定salary=　方法
#   def salary= new_salay
#     @salary = new_salay
#     notify_observers
#   end

#   def notify_observers
#     @observers.each do | observer |
#       observer.update self
#     end
#   end

#   def add_observer observer
#     @observers << observer
#   end

#   def delete_observer observer
#     @observers.delete observer
#   end
# end

# # 两个个观察者类
# class　Payroll
#   def update changed_employee
#     puts "changed_employee name #{changed_employee.name}"
#     puts "his salary now is #{changed_employee.salary}"
#   end
# end

# class　TaxMan
#   def update changed_employee
#     puts "#{changed_employee.name} a new tex bill"
#   end
# end


# usage:
 fred = Employee.new('Fred','Opearater',3000.0)
 playroll = Playroll.new
 fred.add_observer playroll

 fred.salary = 3500.0

 fred.add_observer Taxman.new
 fred.salary = 8000.0

# 重构 1：
# 提取可被观察能力支持的代码，将实现观察者的代码提出来作为subjectobserver，不能做为一个基类，被继承，因为，ruby只允许继承一个基类，采用基类，就阻止了
#　了任何使用其他基类的可能性，那么employer就很难扩展，　所以把观察者部分重构一个模组

module SubjectObserver
  def initialize
    @observers = []
  end

  # def add_observer observer
  #   @observers << observer
  # end

  # def delete_observer observer
  #   @observers.delete observer
  # end

  # def notify_observers
  #   @observers.each do | observer |
  #     observer.update self
  #   end
  # end


  #　重构２　使用代码快作为观察器
  def add_observer &observer
    @observers << observer
  end

  def delete_observer &observer
    @observers.delete observer
  end

  def notify_observers
    @observers.each do | observer |
      observer.call self
    end
  end
end


class Employee
  include SubjectObserver

  attr_reader :name ,:address
  attr_reader :salary

  def initialize name,title,salary
    super()
    @name = name
    @title = title
    @salary = salary
  end


  def salary= new_salay
    @old_salary = @salary
    @salary= new_salay
    # notify_observers
    #　重构3
    # 添加稳定状态，满足一定调节才通知
     notify_observers self if @old_salary!= @salary
  end
end



# usage:
 fred = Employee.new 'Fred','opreaer',30000

 fred.add_observer do |changed_employee|
   # your block ..
 end
```


### Ruby提供的观察者模式库

Ruby本身对Observer就有很好的支持，使用Ruby提供的Observer库，也很方便，直接include Observable模块就好了

>
> __[Observable](http://ruby-doc.org/stdlib-2.0.0/libdoc/observer/rdoc/Observable.html)__
>
> The Observer pattern (also known as publish/subscribe) provides a simple mechanism for one object to inform a set of interested third-party objects when its state changes.
>
> __Mechanism__
>
> The notifying class mixes in the Observable module, which provides the methods for managing the associated observer objects.
> The observers must implement a method called update to receive notifications.
> The observable object must:
> *  assert that it has #changed
> *  call #notify_observers

Ruby Observer模块提供了一下几个方法：

* #add_observer
* #changed
* #changed?
* #count_observers
* #delete_observer
* #delete_observers
* #notify_observers

下面看一个官方给出的Observer使用例子：

__场景__: 一个时钟(Ticker),当它运行时，持续接受股票价格(stock Price)从它的@symbol. 一个报警器负责产生一个对price的观察者，这里演示了两个报警器，(a WarnLow and a WarnHigh), 当price够低，或者超过它的极限是就报警

```ruby
require "observer"

class Ticker          ### Periodically fetch a stock price.
  include Observable

  def initialize(symbol)
    @symbol = symbol
  end

  def run
    lastPrice = nil
    loop do
      price = Price.fetch(@symbol)
      print "Current price: #{price}\n"
      if price != lastPrice
        changed                 # notify observers
        lastPrice = price
        notify_observers(Time.now, price)
      end
      sleep 1
    end
  end
end

class Price           ### A mock class to fetch a stock price (60 - 140).
  def Price.fetch(symbol)
    60 + rand(80)
  end
end

class Warner          ### An abstract observer of Ticker objects.
  def initialize(ticker, limit)
    @limit = limit
    ticker.add_observer(self)
  end
end

class WarnLow < Warner
  def update(time, price)       # callback for observer
    if price < @limit
      print "--- #{time.to_s}: Price below #@limit: #{price}\n"
    end
  end
end

class WarnHigh < Warner
  def update(time, price)       # callback for observer
    if price > @limit
      print "+++ #{time.to_s}: Price above #@limit: #{price}\n"
    end
  end
end

ticker = Ticker.new("MSFT")
WarnLow.new(ticker, 80)
WarnHigh.new(ticker, 120)
ticker.run
```
运行结果：
```ruby
Current price: 83
Current price: 75
--- Sun Jun 09 00:10:25 CDT 2002: Price below 80: 75
Current price: 90
Current price: 134
+++ Sun Jun 09 00:10:25 CDT 2002: Price above 120: 134
Current price: 134
Current price: 112
Current price: 79
--- Sun Jun 09 00:10:25 CDT 2002: Price below 80: 79
```
### JS中的观察者

众所周知Js中使用最多的还是回调函数，但是他们之间存在很大的联系，他们的区别和特点我们在之后篇章讲解，下面来看一个Js实现的观察者模式

```js
//被观察者
function Subject() {
    var _this = this;
    this.observers = [];
    this.addObserver = function(obj) {
        _this.observers.push(obj);
    }
    this.deleteObserver = function(obj) {
        var length = _this.observers.length;
        for(var i = 0; i < length; i++) {
            if(_this.observers[i] === obj) {
                _this.observers.splice(i, 1);
            }
        }
    }
    this.notifyObservers = function() {
        var length = _this.observers.length;
        console.log(length)
        for(var i = 0; i < length; i++) {
            _this.observers[i].update();
        }
    }
}
//观察者
function Observer() {
    this.update = function() {
        alert(1)
    }
}
var sub = new Subject();
var obs = new Observer();
sub.addObserver(obs);
sub.notifyObservers();
var sub = new Subject();

```