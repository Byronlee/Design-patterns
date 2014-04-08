# -*- coding: utf-8 -*-
# 所有任务的基类 即组件：component
class Task
  #attr_reader :name

  # 重构２　给各个层次指明方向
  attr_reader :name,:parent

  def initialize name
    @name = name
    @parent= nil
  end
  
  def get_time_required
    0.0
  end
end

#叶子类　　
class AddDryIngredientstask < Task
  def initialize
    super("add dry ingredients")
  end

  def get_time_required
    1.0
  end
end

class MixTask < Task
  def initialize
    super("Mix that batter up")
  end

  def get_time_required
    3.0   # 搅拌需要３分钟
  end
end

# 高端组合类，composite 也需要继承基类,
# 所有的高端类也应该有个高端的基类，然后这个高端的基类继承composite
# 所有高端类继承这个高端的基类

# 高端基类
# 其实高端基类就是可以用一些运算符号来表示添加和删除更加形象　重构１
class CompositeTask < Task
  def initialize name
    super("name")
    @sub_tasks =[]
  end

  # def add_sub_task task
  #   @sub_tasks << task
  # end

  # 重构１   其实为了这些方便，可以直接把comosite这个类继承数组类，它就有了，数组相关的方便操作
  def << task
    @sub_tasks << task
    #重构２　给各个层次指明方向　
    task.parent = self
  end
  
  def [] index
    @sub_tasks[index]
  end

  def []= index,new_value
    @sub_tasks[index] = new_value
  end



  def remove_sub_task task
    @sub_tasks.delete task
    #重构２　给各个层次指明方向　
    task.parent = nil
  end

  def get_time_required
    @sub_tasks.inject(0){|time,task| time += task.get_time_required}
  end
end


# 高端类继承高端基类
class MakeBatterTask < CompositeTask
  def initialize 
    super(" make batter")
    add_sub_task AddDryIngredientstask.new
    add_sub_task AddLiquiTask.new
    add_sub_task MixTask.new
  end
  

end





# usage:
composite = CompositeTask.new "example"
composite << MixTask.new



















