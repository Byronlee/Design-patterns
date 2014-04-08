# -*- coding: utf-8 -*-
# 重构1:
# 在策略环境中共享数据 
# 重构２:
# 这是个非ruby方案，因为实质上这个类什么都没有做，它仅仅定义一个子类接口，虽然能正常工作，这个实现也没有任何问题，但是违背了鸭子类型的精神．
# 根据鸭子类型的精神，两个策略类都共享了一个相同的接口　output_report　所以没有必要创建一个什么都不做的超类
# 鸭子类型只关心实用对象有没有这个方法
# 重构３：
# 实用代码块来　包装策略，而不用为每一个策略创建一个类

# 策略的同根类　
# class Formatter
#   def output_report title,text
#     raise 'Abstract method called'
#   end
# end




# #不同的策路类
# # class HtmlReportFormatter < Formatter
# class HtmlReportFormatter # 重构2
#   # def output_report title,text
#   #   puts '<html>'
#   #   puts '<head>'
#   #   puts "<title>#{title}</title>"
#   #   puts '</head>'
#   #   puts '<body>'
#   #   text.each do | line |
#   #     puts "<p>#{line}</p>"
#   #   end
#   #   puts '</body>'
#   #   puts '</html>'
#   # end

#   # 在策略环境中共享数据 重构一
#   def output_report context
#     puts '<html>'
#     puts '<head>'
#     puts "<title>#{context.title}</title>"
#     puts '</head>'
#     puts '<body>'
#     context.text.each do | line |
#       puts "<p>#{line}</p>"
#     end
#     puts '</body>'
#     puts '</html>'
#   end

# end

# # class PlainTextFormatter < Formatter
# class PlainTextFormatter  # 重构2
#   # def output_report title,text
#   #   puts '*********#{title}**********'
#   #   text.each do | line |
#   #     puts line
#   #   end
#   # end

#   # 在策略环境中共享数据 重构一
#   def output_report context
#     puts '*********#{context.title}**********'
#     context.text.each do | line |
#       puts line
#     end
#   end
# end


# # 主类

# class Report
#   attr_reader :title,:text
#   attr_accessor :formatter

#   def initialize formatter
#     @title= 'Monthly Report'
#     @text = ['Things are going','really ,really well.']
#     @formatter = formatter
#   end

#   # def output_report
#   #   @formatter.output_report @title,@text
#   # end
# 　
#   # 在策略环境中共享数据 重构一
#   def output_report
#     @formatter.output_report self
#   end
# end



# # usage:

# report = Report.new HtmlReportFormatter.new
# report.output_report


# report.formatter =  PlainTestFormatter.new
# report.output_report




# 说明：
# 虽然重构一简化了数据的流动，但是它同时增加了环境和策略之间的耦合


# 重构３

 class Report
   attr_reader :title,:text
   attr_accessor :formatter

   def initialize &formatter
     @title= 'Monthly Report'
     @text = ['Things are going','really ,really well.']
     @formatter = formatter
   end
   
   def output_report
     @formatter.call self
   end
 end

# 代码块
HTMLREPORT = lambda do | context|
   puts '<html>'
   puts '<head>'
   puts "<title>#{context.title}</title>"
   puts '</head>'
   puts '<body>'
   context.text.each do | line |
     puts "<p>#{line}</p>"
   end
   puts '</body>'
   puts '</html>'
 end

#usage:
# 法一
report = Report.new &HTMLREPORT
report.output_report

# 法二
report = Report.new do | context|
   puts '*********#{context.title}**********'
   context.text.each do | line |
     puts line
   end
 end
