# -*- coding: utf-8 -*-
class Report

  def initialize
    @title= 'Monthly Report'
    @text = ['Things are going','really ,really well.']
  end

# 这个是模板方法的组合，只放在模板类里面，子类不重载，其他方法可能被重载
# 这个抽象的基类通过模板方法来控制高端的处理流程
  def output_report   
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  # 实用钩子方法之前

  # def output_start
  #   raise 'Called abstract method: output_start'
  # end

  # def output_head
  #   raise 'Called abstract method: output_head'
  # end

  # def output_body_start
  #   raise 'Called abstract method: output_body_start'
  # end

  # def output_body
  #   @text.each do |line|
  #     output_line line
  #   end
  # end

  # def output_line
  #   raise 'Called abstract method: output_line'
  # end

  # def output_body_end
  #   raise 'Called abstract method: output_body_end'
  # end

  # def output_end
  #   raise 'Called abstract method: output_end'
  # end


  # 实用钩子方法后
  # 在模板方法模式中，可以被具体类重载的非抽象方法被成为钩子方法
  # 钩子方法允许具体类
  # 1. 重载基础实现用来处理不通的任务
  # 2. 简单的接受默认实现
  # 基类通常定义钩子方法完全是为了让具体子类了解正在发生什么事情
  # 如：　当report类调用 output_start时，它就是告诉子类：我们已经准备好了，如果你还有什么需要处理的，就现在做！
  # 这些钩子方法通常是空的，他们的存在仅仅是为了让子类了解正在发生什么事情

   def output_start
   end

   def output_head
     output_line @title #默认实现
   end

   def output_body_start
   end

   def output_body
     @text.each do |line|
       output_line line
     end
   end

   def output_line
     raise 'Called abstract method: output_line'
   end

   def output_body_end
   end

   def output_end
   end
