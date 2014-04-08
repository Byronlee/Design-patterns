# -*- coding: utf-8 -*-
#命令基类

class Command
  attr_reader :description

  def initialize description
    @description = description
  end
  def execute
  end

# 创建文件命令
class CreateFile < Command
  def initialize path,contents
    super("create file :#{path}")
    @path = path
    @contents = contents
  end
  
  def execute
    f= File.open(@path,"w")
    f.write @contents
    f.close
  end


  # 添加撤销命令
  def unexecute
    File.delete @path
  end

end

# 删除文件命令
class DeleteFile < Command
  def initialize path
    super("dalete file :#{path}")
    @path = path
  end
  
  # def execute    
  #   File.delete @path
  # end
  
  # 添加撤销命令
   def execute    
     if File.exists? @path
       @contents = File.read @path
     end
     File.delete @path
   end
   
  def unexecute
    if @contents
      f = File.open @path ,"w"
      f.write @contents
      F.colse
    end
  end
end

#　复制命令
class CopyFile < Command
  def initialize source,target
    super(" copy file: #{source} to #{target}")
    @source = source
    @target target
  end

  def execute
    FileUtils.copy @source ,@target
  end

  def unexecute
    # 实现机制给上面相同
  end

end

# 用个命令组合来收集这些命令，就可以跟踪做了那些事情
class CompositeCommand < Command
  def initialize
    @commands =[]
  end


  def add_command cmd
    @commands << cmd
  end

  def delete_command cmd
    @commands.delete cmd
  end

  def execute
    @commands.each {|cmd| cmd.execute}
    # 其实也可以用代码块来表示命令，就不需要建立那么命令类了
    # @commands.each{ |cmd| cmd.call if cmd}
  end

  # 添加撤销机制
  def unexecute
    @commands.reverse.each { |cmd| cmd.unexecute}
  end

  def description
    description =''
    @commands.each do | cmd |
      description += cmd.description+"/n"
    end
  end
end


#usage :
cmds = CompositeCommand.new
cmds.add_command CreateFile.new('file1.txt',"hello,world\n")
cmds.add_command CopyFile.new('file1.txt',"feil2.txt")
cmds.add_command DeleteFile.new('file1.txt')

cmds.execute

cmds.description
