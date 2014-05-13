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
* 问题讨论



### 问题的产生 

  一个软件系统里面包含了各种对象，就像一片欣欣向荣的森林充满了各种生物一样。在一片森林中，各种生物彼此依赖和约束，形成一个个生物链。一种生物的状态变化会造成其他一些生物的相应行动，每一个生物都处于别的生物的互动之中。

　同样，一个软件系统常常要求在某一个对象的状态发生变化的时候，某些其他的对象做出相应的改变。做到这一点的设计方案有很多，但是为了使系统能够易于复用，应该选择低耦合度的设计方案。减少对象之间的耦合有利于系统的复用，但是同时设计师需要使这些低耦合度的对象之间能够维持行动的协调一致，保证高度的协作。观察者模式是满足这一要求的各种设计方案中最重要的一种。

### 观察者模式主要内容,定义

  __观察者模式是对象的行为模式，又叫发布-订阅(Publish/Subscribe)模式、模型-视图(Model/View)模式、源-监听器(Source/Listener)模式或从属者(Dependents)模式。__

　__观察者模式定义了一种一对多的依赖关系，让多个观察者对象同时监听某一个主题对象。这个主题对象在状态上发生变化时，会通知所有观察者对象，使它们能够自动更新自己。__

### 模式UML结构

![观察者模式UML结构图](https://github.com/Byronlee/byronlee.github.io/blob/master/images/guanchazhe_uml.png?raw=true)

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

__场景：__ 与推模型场景一样

__两种模式代码大部分相似,类图一样. 我们这里只罗列每个角色中不同部分的代码__

抽象主题角色类 不同部分: __拉模型的抽象主题类主要的改变是nodifyObservers()方法。在循环通知观察者的时候，也就是循环调用观察者的update()方法的时候，传入的参数不同了。__
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
具体主题角色类 不同部分: __跟推模型相比，有一点变化，就是调用通知观察者的方法的时候，不需要传入参数了。__
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
抽象观察者角色类:__拉模型通常都是把主题对象当做参数传递。__

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


### 问题讨论
* callback vs observer ?
  * 回调是短暂的:他强调一次性！把它变成一个函数被调用一次。通常我们在API中使用这个回调。如果你的功能和你需要做的事情有着紧密耦合的关系。通常情况下,你只能传递一个回调。比如：运行一个线程,该线程终止时调用的回调。 　　 
  * 观测者强调重复性和松耦合性。观察者的生命更长,在任何时候它可以连接/分离。可以有许多观察家对同样的事情,他们可以有不同的寿命。比如：UI中显示值根据用户的输入从一个值变到另一个值。
* ActiveRecord中的Observer： [ActiveRecord::Observer](http://api.rubyonrails.org/v3.2.13/classes/ActiveRecord/Observer.html)
* ActiveRecord中的Callback： [ActiveRecord::Callbacks](http://api.rubyonrails.org/v3.2.13/classes/ActiveRecord/Callbacks.html)


