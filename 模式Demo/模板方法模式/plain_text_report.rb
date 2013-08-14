# -*- coding: utf-8 -*-
b# -*- coding: utf-8 -*-
require 'Report'

class PlainTestReport < Report

  def output_head
    puts '*********#{@title}**********'
  end


  # 下面这些方法　感觉很丑陋，什么都没有做，反而要写这些空方法
  # 重构　让report基类中简单的定义默认实现，从而方便子类
  # 重构　　钩子方法，　重构后以下代码就没有了

  # def output_start
  # end

  # def output_body_start
  # end

  # def output_line line
  # end

  # def output_body_end
  # end

  # def output_end
  # end

end
