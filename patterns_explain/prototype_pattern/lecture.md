设计模式- 原型模式 
===================================
_[注] 讲解主要以Java环境为主,代码实现可带不同语言版本_

### 提纲
* 原型模式主要内容,定义
* 使用场景
* 通用模式代码(java)
* 优缺点
* 原型模式的注意事项
* Ruby中的clone
* Js版通用代码
* 问题讨论

###  原型模式主要内容,定义
* 用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象。
Prototype原型模式是一种创建型设计模式，Prototype模式允许一个对象再创建另外一个可定制的对象，根本无需知道任何如何创建的细节,工作原理是:通过将一个原型对象传给那个要发动创建的对象，这个要发动创建的对象通过请求原型对象拷贝它们自己来实施创建。
* 利用过一个原型对象来指明我们所要创建对象的类型，然后通过复制这个对象的方法来获得与该对象一模一样的对象实例。这就是原型模式的设计目的。

### 原型模式的使用场景

* 资源优化场景
  * 类初始化需要消化非常多的资源，这个资源包括数据、硬件资源等。
* 性能和安全要求的场景
  * 通过new产生一个对象需要非常繁琐的数据准备或访问权限，则可以使用原型模式。
* 一个对象多个修改者的场景
  * 一个对象需要提供给其他对象访问，而且各个调用者可能都需要修改其值时，可以考虑使用原型模式拷贝多个对象供调用者使用。
* 在实际项目中，原型模式很少单独出现，一般是和工厂方法模式一起出现，通过clone的方法创建一个对象，然后由工厂方法提供给调用者。原型模式已经与Java融为浑然一体，大家可以随手拿来使用。


### 原型模式通用源码(java)

_在Java中原型模式是如此的简单，我们来看通用源代码，如下代码清单:_

```java
public class PrototypeClass  implements Cloneable{    
    //覆写父类Object方法  
    @Override  
    public PrototypeClass clone(){  
        PrototypeClass prototypeClass = null;  
        try {  
            prototypeClass = (PrototypeClass)super.clone();  
        } catch (CloneNotSupportedException e) {  
            //异常处理  
        }  
        return prototypeClass;  
    }  
} 
```
实现一个接口，然后重写clone方法，就完成了原型模式！

```java
@Override  
public Mail clone(){
} 
```
请注意，在clone()方法上增加了一个注解@Override，没有继承一个类为什么可以覆写呢？想想看，在Java中所有类的老祖宗是谁？对嘛，Object类，每个类默认都是继承了这个类，所以这个用上覆写是非常正确的，--覆写了Object类中的clone方法！


### 优缺点

* 性能优良,原型模式是在内存二进制流的拷贝，要比直接new一个对象性能好很多，特别是要在一个循环体内产生大量的对象时，原型模式可以更好的体现其优点。
* 逃避构造函数的约束.这既是它的优点也是缺点，直接在内存中拷贝，构造函数是不会执行的（见"原型模式的注意事项"），优点就是减少了约束，缺点也是减少了约束，双刃剑，需要大家在实际应用时考虑。

### 原型模式的注意事项

* 构造函数不会被执行
  * 一个实现了Cloneable并重写了clone方法的类A,有一个无参构造或有参构造B，通过new关键字产生了一个对象S，再然后通过S.clone()方式产生了一个新的对象T，那么在对象拷贝时构造函数B是不会被执行的，我们来写一小段程序来说明这个问题，如代码所示:

```java
public class Thing implements Cloneable{  
    public Thing(){  
        System.out.println("构造函数被执行了...");  
    }  
      
    @Override  
    public Thing clone(){  
        Thing thing=null;  
        try {  
            thing = (Thing)super.clone();  
        } catch (CloneNotSupportedException e) {  
            e.printStackTrace();  
        }  
        return thing;  
    }  
} 
```
然后我们再来写一个Client类，进行对象的拷贝，如代码所示:
```java
public class Client {  
 
    public static void main(String[] args) {  
        //产生一个对象  
        Thing thing = new Thing();        
        //拷贝一个对象  
        Thing cloneThing = thing.clone();  
    }  
} 
```
运行结果如下所示:
```java
构造函数被执行了... 
```
对象拷贝时构造函数确实没有被执行，这点从原理来讲也是可以讲得通的，Object类的clone方法的原理是从内存中（具体的说就是堆内存）以二进制流的方式进行拷贝，重新分配一个内存块，那构造函数没有被执行也是非常正常的了。

* 浅拷贝和深拷贝

在解释什么是浅拷贝什么是深拷贝前，我们先来看个例子，如代码所示:

```java
public class Thing implements Cloneable{  
    //定义一个私有变量  
    private ArrayList<String> arrayList = new ArrayList<String>();  
 
    @Override  
    public Thing clone(){  
        Thing thing=null;  
        try {  
            thing = (Thing)super.clone();  
        } catch (CloneNotSupportedException e) {  
            e.printStackTrace();  
        }  
        return thing;  
    }  
    //设置HashMap的值  
    public void setValue(String value){  
        this.arrayList.add(value);  
    }  
    //取得arrayList的值  
    public ArrayList<String> getValue(){  
        return this.arrayList;  
    }  
} 
```
在Thing类中增加一个私有变量arrayLis，类型为ArrayList,然后通过setValue和getValue分别进行设置和取值，我们来看场景类是如何拷贝的，如代码所示:
```java
public class Client {  
     public static void main(String[] args) {  
        //产生一个对象  
        Thing thing = new Thing();  
        //设置一个值  
        thing.setValue("张三");         
        //拷贝一个对象  
        Thing cloneThing = thing.clone();  
        cloneThing.setValue("李四");        
        System.out.println(thing.getValue());  
    }  
} 
```
读者猜想一下运行结果应该是什么？是仅一个"张三"吗？运行结果如下所示。
```java
[张三, 李四] 
```
怎么会这样呢？怎么会有李四呢？
!是因为Java做了一个偷懒的拷贝动作，Object类提供的方法clone只是拷贝本对象，其对象内部的数组、引用对象等都不拷贝，还是指向原生对象的内部元素地址，这种拷贝就叫做浅拷贝，确实是非常浅，两个对象共享了一个私有变量，你改我改大家都能改，是一种非常不安全的方式，在实际项目中使用还是比较少的（当然，这是也是一种"危机"环境的一种救命方式）。你可能会比较奇怪，为什么在Mail那个类中就可以使用String类型，而不会产生由浅拷贝带来的问题呢？内部的数组和引用对象才不拷贝，其他的原始类型比如int,long,String(Java就希望你把String认为是基本类型，String是没有clone方法的)等都会被拷贝的。

__[注意]  使用clone方法拷贝时，满足两个条件的对象才不会被拷贝：一是类的成员变量，而不是方法内的变量；二是必须是一个对象，而不是一个原始类型__

浅拷贝是有风险的，那怎么才能深入的拷贝呢？我们修改一下程序就可以深拷贝，如代码所示:
```java
public class Thing implements Cloneable{  
    //定义一个私有变量  
    private ArrayList<String> arrayList = new ArrayList<String>();  
 
    @Override  
    public Thing clone(){  
        Thing thing=null;  
        try {  
            thing = (Thing)super.clone();  
            thing.arrayList = (ArrayList<String>)
            this.arrayList.clone();  
        } catch (CloneNotSupportedException e) {  
            e.printStackTrace();  
        }  
        return thing;  
    }  
} 
```
仅仅增加了黑体部分，对私有的类变量进行独立的拷贝。Client类没有任何改变，运行结果如下所示:
```java
[张三] 
```
该方法就实现了完全的拷贝，两个对象之间没有任何的瓜葛了，你修改你的，我修改我的，不相互影响，这种拷贝就叫做深拷贝，深拷贝还有一种实现方式就是通过自己写二进制流来操作对象，然后实现对象的深拷贝，这个大家有时间自己实现一下。

__[注意]  深拷贝和浅拷贝建议不要混合使用，特别是是在涉及到类的继承，父类有多个引用的情况就非常的复杂，建议的方案是深拷贝和浅拷贝分开实现__

__在Java中Prototype模式变成clone()方法的使用，此方法执行的是该对象的“浅表复制”，而不“深层复制”操作,java为什么如此实现clone呢？__
* 也许有以下考虑:
  * 效率和简单性，简单的copy一个对象在堆上的的内存比遍历一个对象网然后内存深copy明显效率高并且简单。
  * 不给别的类强加意义。如果A实现了Cloneable，同时有一个引用指向B，如果直接复制内存进行深copy的话，意味着B在意义上也是支持Clone的，但是这个是在使用B的A中做的，B甚至都不知道。破坏了B原有的接口。
  * 有可能破坏语义。如果A实现了Cloneable，同时有一个引用指向B，该B实现为单例模式，如果直接复制内存进行深copy的话，破坏了B的单例模式。
  * 方便且更灵活，如果A引用一个不可变对象，则内存deep copy是一种浪费。Shadow copy给了程序员更好的灵活性。

但是clone方法直接无视构造方法的权限，所以，单例模式与原型模式是冲突的，在使用时要特别注意

深拷贝与浅拷贝。Object类的clone方法只会拷贝对象中的基本的数据类型，对于数组、容器对象、引用对象等都不会拷贝，这就是浅拷贝。如果要实现深拷贝，必须将原型模式中的数组、容器对象、引用对象等另行拷贝。
幸运的是java提供的大部分的容器类都实现了Cloneable接口。所以实现深拷贝并不是特别困难。

PS：深拷贝与浅拷贝问题中，会发生深拷贝的有java中的8中基本类型以及他们的封装类型，另外还有String类型。其余的都是浅拷贝。

* clone与final两对冤家

俗话说，不是冤家不聚头，对象的clone与对象内的final关键字是有冲突的，我们举例来说明这个问题，如代所示:
```java
public class Thing implements Cloneable{  
    //定义一个私有变量  
    private final ArrayList<String> arrayList = new ArrayList<String>();  
 
    @Override  
    public Thing clone(){  
        Thing thing=null;  
        try {  
            thing = (Thing)super.clone();     
            this.arrayList = (ArrayList<String>)
            this.arrayList.clone();  
        } catch (CloneNotSupportedException e) {  
            e.printStackTrace();  
        }  
        return thing;  
    }  
} 
```
黑体部分仅仅增加了一个final关键字，然后编译器就报斜体部分错误，正常呀，final类型你还想重设值呀！完蛋了，你要实现深拷贝的梦想在final关键字的威胁下破灭了,路总是有的，我们来想想怎么修改这个方法：删除掉final关键字，这是最便捷最安全最快速的方式。你要使用clone方法就在类的成员变量上不要增加final关键字。

__[注意]  要使用clone方法，类的成员变量上不要增加final关键字__

### Ruby中的clone
  
Ruby是一门动态语言,一切都是对象! 每个对象都可以复制,因为每一个对象的祖先连中都继承了Object类,该类支持两种方式:clone,dup.
Ruby中所以复制对象支持三种方式:=,clone,dup, 先来看现象 :

ruby中的'='可以理解为指针或者引用
```ruby
>> a= [0,[1,2]]
>> b=a
>> b[0]=88
>> b[1][0]=99
>> b  
=> [88, [99, 2]]
>> a  
=> [88, [99, 2]]

# 再看:

irb(main):002:0> a = "Hooopo"  
=> "Hooopo"  
irb(main):003:0> b = a  
=> "Hooopo"  
irb(main):004:0> b.object_id  
=> 23424840  
irb(main):005:0> a.object_id  
=> 23424840  

# 原来b跟a根本就是同一个object, 只是马甲不一样罢了. 所以b = a不是复制.

# ruby中clone和dup都是浅拷贝

# 那 b = a.dup 呢?? 还是看代码:

# 例一:

irb(main):001:0> a = "Hooopo"  
=> "Hooopo"  
irb(main):002:0> b = a.dup  
=> "Hooopo"  
irb(main):003:0> a.object_id  
=> 23428740  
irb(main):004:0> b.object_id 

# 例二:

>> a= [0,[1,2]]
>> b=a.dup
>> b[0]=88
>> b[1][0]=99
>> b
=> [88, [99, 2]]
>> a
=> [0, [99, 2]]

# 情况似乎有所好转, 在修改b后, a还是有一部分被修改了.(0没有变,但原来的1变成了99).
# 所以dup有时候是复制(如在Array只有一级时), 但有时不是复制哦.

# 再来一个, b = a.clone呢? 上代码:
>> a= [0,[1,2]]
>> b=a.clone
>> b[0]=88
>> b[1][0]=99
>> b
=> [88, [99, 2]]
>> a
=> [0, [99, 2]]
```
情况几乎跟dup一模一样. 所以clone也不一定可以相信哦! 

__dup和clone 区别:__

_dup 的官方文档:_

> [dup](http://ruby-doc.org/core-2.0.0/Object.html#method-i-dup)
>
> Produces a shallow copy of obj—the instance variables of obj are copied, but not the objects they reference. dup copies the tainted state of obj. See also the discussion under Object#clone. In general, clone and dup may have different semantics in descendant classes. While clone is used to duplicate an object, including its internal state, dup typically uses the class of the descendant object to create the new instance.
>
> This method may have class-specific behavior. If so, that behavior will be documented under the #initialize_copy method of the class.

大意是 dup 会进行浅拷贝--只拷贝对象包含的实例变量，而不是实例变量所引用的对象本身。而且 dup 会拷贝对象的 [tainted](http://stackoverflow.com/questions/1736161/whats-the-purpose-of-tainting-ruby-objects) 状态。而特定类的 dup 方法可能会有额外的一些行为，具体参考该类对于 initialize_copy 方法的解释。

_clone的官方文档：_

> [clone](http://ruby-doc.org/core-2.0.0/Object.html#method-i-clone)
>
> Produces a shallow copy of obj—the instance variables of obj are copied, but not the objects they reference. Copies the frozen and tainted state of obj. See also the discussion under Object#dup.
This method may have class-specific behavior. If so, that behavior will be documented under the #initialize_copy method of the class.

大意是 clone 会进行浅拷贝--只拷贝对象包含的实例变量，而不是实例变量所引用的对象本身。而且 clone 会拷贝对象的 [tainted](http://stackoverflow.com/questions/1736161/whats-the-purpose-of-tainting-ruby-objects) 和 [frozen](http://stackoverflow.com/questions/2204945/ruby-cant-modify-frozen-string-typeerror) 状态。而特定类的 clone 方法可能会有额外的一些行为，具体参考该类对于 initialize_copy 方法的解释。

对两者的简单总结:

* 相同点：

浅拷贝(shallow copy)：只拷贝对象包含的实例变量，而不是实例变量所引用的对象本身
```ruby
class ProgramLanguage
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

ruby = ProgramLanguage.new "ruby"
ruby.name.object_id == ruby.dup.name.object_id  #=> true
ruby.name.object_id == ruby.clone.name.object_id  #=> true
```
拷贝对象的 tainted 状态
```ruby
ruby.taint
ruby.tainted?  #=> true
ruby.dup.tainted?  #=> true
ruby.clone.tainted?  #=> true
```
* 不同点：

clone 会拷贝对象的 frozen 状态
```ruby
ruby.freeze
ruby.frozen?  #=> true
ruby.dup.frozen?  #=> false
ruby.clone.frozen?  #=> true
```
clone 会拷贝对象的单例方法
```ruby
ruby = ProgramLanguauge.new "ruby"

def ruby.creator
  "Matz"
end

ruby.creator  #=> Matz
ruby.dup.creator  #=> undefined method `creator' for #<ProgramLanguage @name="ruby">
ruby.clone.creator  #=> Matz
```
Ruby中的dup和clone都是shallow复制, 只针对object的第一级属性.  难道在Ruby中没有办法复制对像吗? 也不完全是, 可以借助: Marshal.

_Marshal_
> The marshaling library converts collections of Ruby objects into a byte stream, allowing them to be stored outside the currently active script. This data may subsequently be read and the original objects reconstituted.
>
> Marshal.dump 将对象转化成  a byte stream
>
> Marshal.load 将byte stream 还原对象

就是Marshal只能序列化一般对象，数组哈希，高级一些的对象不能序列化（IO，Proc，singleton等） 

```ruby
1.9.3-p374 :003 > b = Marshal.dump("thing")
 => "\x04\bI\"\nthing\x06:\x06ET" 

# 查看例子:
>> a= [0,[1,2]]
>> b=Marshal.load(Marshal.dump(a))
>> b[0]=88
>> b[1][0]=99
>> b
=> [88, [99, 2]]
>> a= [0,[1,2]]
=> [0, [1, 2]]

# 修改b后a没有被改变!!! 似乎终于成功找到复制的办法了!!!
# 为什么要加"似乎"呢? 因为有些object是不能被Marshal.dump的.如:

>> t=Object.new
>> def t.test; puts ‘test’ end
>> Marshal.dump(t)
>> TypeError: singleton can’t be dumped
>>    from (irb):59:in `dump’
>>    from (irb):59
```
更完善的复制方案可以考虑给ruby增加一个deep clone功能, 可以参考以下链接:

[deep clone demo](http://www.artima.com/forums/flat.jsp?forum=123&thread=40913)

你也可以自实现 initialize_clone 的一些方法: 

参考[initialize_clone, initialize_dup and initialize_copy in Ruby](http://www.jonathanleighton.com/articles/2011/initialize_clone-initialize_dup-and-initialize_copy-in-ruby/)

### Js版通用代码
http://liuzhijun.iteye.com/blog/1157453



### 问题讨论
 * 如果一个原型类被继承了,如:
 ```java
   (PrototypeClass)super.clone();   执行这句话会有什么结果?
 ```
 * java实现 super.clone方法的源码?
 * 可以参考一下Cloneable接口的 源码?

