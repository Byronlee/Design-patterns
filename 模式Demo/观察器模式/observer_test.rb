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
  
