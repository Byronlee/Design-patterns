# -*- coding: utf-8 -*-
# 现实类

class Exsite
  
  def colour
  end

end


#目标类

class TO
  def color
  end
end


# 这就需要一个适配器的类

class FunctionAdapter < Exsite
  
  def color
    colour
  end

end


# 可以给单个实例进行修改;

bto = Exsite.new

class << bto
  def color
    colour
  end
end
