# FPGA_piano
## **基于FPGA的数字电子琴设计**
## 介绍
    本设计主要通过FPGA编程驱动矩阵键盘电路，获取矩阵键盘键入的信息，然后通过编码将键盘输出的信息译码成对应的音节数据，最后通过PWM发生模块驱动底板上的无源蜂鸣器发出声音。要求熟悉PWM信号发生驱动模块和矩阵键盘驱动模块的应用；了解无源蜂鸣器的驱动原理及方法；最终完成简易电子琴设计实现。
## 功能分析
第一，该设计总体可以拆分成两个功能模块实现，如图所示：
  
  + Array_KeyBoard：通过驱动矩阵键盘工作获取键盘的操作信息数据。
  
  + Beeper：根据键盘按键信息驱动无源蜂鸣器发出不同的音节。
  
  第二，顶层模块Electric_Piano通过实例化两个子模块并将对应的信号连接，最终实现简易电子琴的总体设计。我们知道无源蜂鸣器是通过交流信号驱动的，FPGA可以通过输出不同频率的PWM脉冲信号控制蜂鸣器产生不同的音节输出，所以上面Beeper模块又可以拆分成两个功能模块实现其功能
  
  + tone：通过编码方式将键盘的操作信息译码成对应的PWM周期信息。
  
  + PWM：根据PWM周期信息产生对应的PWM脉冲信号。
  ![top-down设计](https://github.com/ghuaerm/FPGA_piano/blob/master/image/1.png)
  ![模块结构设计](https://github.com/ghuaerm/FPGA_piano/blob/master/image/2.png)
## 实验步骤
双击打开Quartus Prime工具软件；

+ 新建工程：File → New Project Wizard（工程命名，工程目录选择，设备型号选择，EDA工具选择）；

+ 新建文件：File → New → Verilog HDL File，键入设计代码并保存；

+ 设计综合：双击Tasks窗口页面下的Analysis & Synthesis对代码进行综合；

+ 管脚约束：Assignments → Assignment Editor，根据项目需求分配管脚；

+ 设计编译：双击Tasks窗口页面下的Compile Design对设计进行整体编译并生成配置文件；

+ 程序烧录：点击Tools → Programmer打开配置工具，Program进行下载；
观察设计运行结果。
## 系统整体实现
综合后的设计框图如图所示：
  ![RTL电路图](https://github.com/ghuaerm/FPGA_piano/blob/master/image/3.png)

  Assignments → Pin_Planener,然后根据项目需求分配引脚，引脚分配对照矩形键盘原理图和Alert开发板引脚图完成分配问题。
  ![矩形键盘原理图](https://github.com/ghuaerm/FPGA_piano/blob/master/image/5.png)
  ![Alert开发板引脚](https://github.com/ghuaerm/FPGA_piano/blob/master/image/6.png)
  引脚分配操作如下图：
  ![引脚分配操作](https://github.com/ghuaerm/FPGA_piano/blob/master/image/7.png)

  然后对设计整体编译并生成配置文件.sof文件；点击Tools → Programmer打开配置工具添加配置文件进行下载；程序到此烧录完成。按动矩阵按键听蜂鸣器发出的声音，16个按键对应16个音节。
  ![实验结果](https://github.com/ghuaerm/FPGA_piano/blob/master/image/4.png)

