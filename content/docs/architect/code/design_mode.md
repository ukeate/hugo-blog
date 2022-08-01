---
Categories: ["设计"]
title: "Java设计模式"
date: 2018-10-09T08:48:07+08:00
---
# 六个原则
    单一职责原则(SRP, Single Responsibility Principle)
        一个类只做一件事，应该只有一个引起它修改的原因
    开闭原则(OCP, Open-Close Principle)
        对修改封闭，对扩展开放
    里氏替换原则(LSP, the Liskov Substitution Principle)
        子类可以完全替换父类。也就是继承只扩展新功能
    依赖倒置原则(DIP, the Dependency Inversion Principle)
        细节依赖于抽象,抽象不依赖于细节。抽象放在高层，并保持稳定
    接口隔离原则(ISP, the Interface Segregation Principle)
        客户端不依赖它不需要的接口。冗余依赖应该将接口拆分
    迪米特法则（最少知道原则）(LoD, Law of Demeter)
        一个类不应该知道自己操作的细节。只和朋友谈话，不和朋友的朋友谈话
# 构建型
## 工厂方法(Factory Method)
    # 简单工厂, 根据参数创建不同的类
    # 静态工厂，单例工厂
    public interface Sender{
        public void Send();
    }
    public class MySender implements Sender{
        @Override
        public void Send(){}
    }
    public SenderFactory {
        public static Sender produceStatic() {
            return new MySender();
        }
        public Sender produce(){
            return new MySender();
        }
        public Sender produce(int i){
            return new MySender();
        }
    }

    # 工厂子类继承工厂接口, 不同产品对应不同工厂
    public interface AbstractFactory {
        public MySender produce();
    }
    public class MyFactory implements AbstractFactory {
        @Override
        public MySender produce(){
            return new MySender();
        }
    }
## 抽象工厂(Abstract Factory)
    # 生产抽象产品
    public interface AbstractFactory {
        public Sender produce();
    }
    public class MyFactory implements AbstractFactory {
        @Override
        public Sender produce(){
            return new MySender();
        }
    }
## 单例(Singleton)
    确保只有一个实例
        # 大多有资源管理器的功能
        # 反射机制会使所有单例失效：私有构造方法可以被访问
    应用
        线程池
        缓存
        日志对象
        对话框
        打印机
        显卡驱动程序
    o-> 饿汉
    public class Singleton {
        public static Singleton instance = new Singleton();
        private Singleton(){}
        public static Singleton getInstance(){
            return instance;
        }
    }
    o-> 懒汉式
    public class Singleton {
        private static Singleton single=null;
        private Singleton() {}
        public synchronized  static Singleton getInstance() {
            if (single == null) {
                single = new Singleton();
            }
            return single;
        }
    }
    o-> 懒汉，双重检测(DCL)
        # 解决问题并发创建问题。在不同jvm或多核cpu上，有无序写入bug。
        # 解决bug: 1 直接创建static属性, 2 get方法修饰synchronized
    public class Singleton {
        private static volatile Singleton singleton = null;
            # volatile: t1编译singleton = new Singleton()时重排序把没初始化对象赋值给singleton时, t2判断singleton为null。
        private Singleton(){}
        public static Singleton getInstance(){
            if (singleton == null) {
                // t1,t2并发进入
                synchronized (Singleton.class) {
                    // t1释放后，t2进入
                    if (singleton == null) {
                        singleton = new Singleton();
                    }
                }
            }
            return singleton;
        }
    }
    o-> map注册
        # 学Spring，将类名注册
    public class Singleton {
        private static Map<String,Singleton> map = new HashMap<String,Singleton>();
        static{
            Singleton single = new Singleton();
            map.put(single.getClass().getName(), single);
        }
        protected Singleton(){}
        public static Singleton getInstance(String name) {
            if(name == null) {
                name = Singleton.class.getName();
            }
            if(map.get(name) == null) {
                map.put(name, (Singleton) Class.forName(name).newInstance());
            }
            return map.get(name);
        }
    }
## 建造者(Builder)
    # 提供工厂方法，建造内部复合对象
    o->
    public class Builder {
        private List<Sender> list = new ArrayList<Sender>();
        public void produceMailSender() {
            list.add(new MailSender())
        }
    }

## 原型(Prototype)
    # 复制原型来创建新对象

# 结构型
## 适配器(Adapter)
    # 用来匹配接口
    o-> 类
    public class Source(){
        public void method1(){}
    }
    public interface Targetable {
        public void method1()
        public void method2()
    }
    public class Adapter extends Source implements Targetable {
        @Override
        public void method2(){}
    }
    o-> 对象
    public class Wrapper implements Targetable {
        private Source source;
        public Wrapper(Source source){
            super();
            this.source = source;
        }
        @Override
        public void method1(){
            source.method1()
        }
        @Override
        public void method2(){}
    }
    o-> 接口
    public abstract class AbstractTarget implements Targetable {
        @Override
        public void method1(){}
    }
    public class Adapter extends AbstractTarget {
        @Override
        public method2(){}
    }
## 桥接(Bridge)
    # 分离抽象和具体(两个维度发展)分别继承，抽象聚合(桥接)具体
    public abstract class Gift {
        GiftImpl impl;
    }
    public class Flower extends GiftImpl {}
    public class WarmGift extends Gift {
        public WarmGift(GiftImpl impl) {
            this.impl = impl;
        }
    }
## 组合(Composite)
    # 树状结构
    abstract class Node{}
    class LeafNode extends Node{}
    class BranchNode extends Node{
        List<Node> nodes = new ArrayList<>();
    }

    tree(Node b, int depth) {
        b.print();
        if (b instanceof BranchNode) {
            for (Node n : ((BranchNode)b).nodes){
                tree(n, depth+1)
            }
        }
    }
## 装饰(Decorator)
    # 持有被装饰实例，实现同一接口
    public interface Sourceable {
        public void method();
    }
    public class Source implements Sourceable {
        @Override
        public void method(){}
    }
    public class Decorator implements Sourceable {
        private Sourceable source;
        public Decorator(Sourceable source) {
            super();
            this.source = source;
        }
        @Override
        public void method() {
            source.method();
        }
    }
## 门面(Facade)
    # 对外接待
## 中介者(Mediator)
    # 内部都只关联它，如mq
## 享元(Flyweight)
    # 共享元数据
## 代理
    # 静态代理，实现同装饰
    class TankTimeProxy implements Movable {
        Movable m;
        @Override
        public void move(){
            m.move();
        }
    }

    # 动态代理，Proxy调asm生成代理类
    Tank tank = new Tank();
    Movable m = (Movable)Proxy.newProxyInstance(Tank.class.getClassLoader()), 
        new Class[]{Movable.class},
        new Hander(tank)
    );
    class Handler implements InvocationHandler {
        Tank tank;
        @Override
        public Object invoke(Object proxy, Method method, Object[] args) {
            return method.invoke(tank, args);
        }
    }

    // 动态代理, CGLIB调asm，由于是继承，所以final类不能代理
    Enhancer enhancer = new Enhancer();
    enhancer.setSuperclass(Tank.class);
    enhancer.setCallback(new TimeMethodInterceptor());
    Tank tank = (Tank)enhancer.create();
    tank.move();
    class TimeMethodInterceptor implements MethodInterceptor {
        @Override
        public Object intercept(Object o, Method method, Object[] objects, MethodProxy methodProxy) {
            return methodProxy.invokeSuper(o, objects);
        }
    }

    // Spring AOP: aspect指定代理类, pointcut指定被代理方法

# 行为型
## 观察者
    # Observer, 对象变化，对观察者广播
    public interface Observer {
        public void update();
    }
    public class Observer1 implements Observer {
        @Override
        public void update(){}
    }
    public interface Subject{
        public void add(Observer observer);
        public void del(Observer observer);
        public void notifyObservers();
        public void operate()
    }
    public abstract class AbstractSubject implements Subject {
        private Vector<Observer> vector = new Vector<Observer>();
        @Override
        public void add(Observer observer) {
            vector.add(observer);
        }
        @Override
        public void del(Observer observer) {
            vector.remove(observer);
        }
        @Override
        public void notifyObservers(){
            Enumeration<Observer> enumo = vector.elements();
            while (enumo.hasMoreElements()) {
                enumo.nextElement().update();
            }
        }
    }
    public class MySubject extends AbstractSubject {
        @Override
        public void operate() {
            notifyObservers();
        }
    }
## 模板方法(TemplateMethod)
    # 钩子函数
    abstract class F {
        public void m() {
            op1();
        }
        abstract void op1();
    }
    class C1 extends F {
        @Override
        void op1(){}
    }
## 状态(State)
    # 状态便于扩展, 方法不便扩展。如果相反用switch
    public class MM {
        MMState state;
        public void smile(){
            state.smile();
        }
    }
    public abstract class MMState {
        abstract void smile();
    }
    public class MMHappyState extends MMState {
        @Override
        void smile(){}
    }

    # FSM例子，线程状态
    public class Thread_ {
        ThreadState_ state;
        void move(Action a) { state.move(a);}
    }
    abstract class ThreadState_ {
        abstract void move(Action a);
    }
    public class NewState extends ThreadState_ {
        private Thread_ t;
        @Override
        void move(Action a) {
            if ("start".equals(a.msg)) {
                t.state = new RunningState(t);
            }
        }
    }
    public class Action {
        String msg;
    }
## 迭代器(Iterator)
    public interface Iterator<E> {
        boolean hasNext();
        E next();
    }
    public interface Collection<E> {
        Iterator<E> iterator();
    }
    class List<E> implements Collection<E> {
        private class Itr<E> implements Iterator<E> {
            @Override
            public boolean hasNext(){}
            @Override
            public E next(){}
        }
        @Override
        public Iterator iterator(){
            return new Itr();
        }
    }
## 策略
    # strategy, 封装多个算法类, 更换策略，调用方式一致
    o->
    public interface ICalculator {
        public int calculate(String exp);
    }
    public class Minus extends AbstractCaculator implements ICalculator {
        @Override
        public int calculate(String exp) {
            int arrayInt[] = split(exp, "-");
            return arrayInt[0] - arrayInt[1];
        }
    }
    public class AbstractCalculator {
        public int[] split(String exp, String opt) {
            String[] array = exp.split(opt);
            int arrayInt[] = new int[2];
            arrayInt[0] = Integer.parseInt(array[0]);
            arrayInt[1] = Integer.parseInt(array[1]);
            return arrayInt;
        }
    }
    Icalculator cal = new Minus();
    cal.calculate(exp);
## 备忘录(Memento)
    # 快照
    # Java序列化, ProtoBuf库
    class C implements Serializable {
        private transient List<Object> list;
    }
    ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(new File("")));
    oos.writeObject(o1)
    oos.writeObject(o2)
    ObjectInputStream ois = new ObjectInputStream(new FileInputStream(new File("")));
    o1 = ois.readObject();
    o2 = ois.readObject();
## 命令(Command)
    # 别名Action或Transaction
    # 配合组合实现宏命令, 配合责任链实现undo，配合备忘录实现事务回滚
    abstract class Command {
        abstract void do();
        abstract void undo();
    }
    class InsertCommand extends Command {}
## 责任链(Chain of Responsibility)
    interface Filter {
        boolean doFilter(Msg m);
    }
    class HTMLFilter implements Filter {}
    class FilterChain implements Filter{
        List<Filter> filters = new ArrayList<>();
        public boolean doFilter(Msg msg){
            for (Filter f : filters) {
                if (!f.doFilter(msg)) {
                    return false;
                }
            }
            return true;
        }
        public FilterChain add(Filter f) {
            filters.add(f);
            return this;
        }
    }
    FilterChain fc = new FilterChain();
    FilterChain fc2 = new FilterChain();
    Filter f = new Filter();
    fc.add(f).add(fc2);

    # ServletFilter
    Filter1 implements Filter {
        void doFilter(req, resp, chain) {
            chain.doFilter(req, resp);
        }
    }
    FilterChain implements Filter {
        List<Filter> filters;
        int curIndex = 0;
        void doFilter(req, resp){
            curIndex++;
            if (curIndex < filters.size()) {
                filters[curIndex].doFilter(req, resp, this);
            }
        }
    }
## 访问者(Visitor)
    # 内部结构不变，访问方式扩展
    interface Visitor {
        void visitCpu(CPU cpu);
    } 
    class Visitor1 implements Visitor {
        double price = 0.0;
        @Override
        void visitCpu(CPU cpu) {
            price += cpu.getPrice() * 0.9;
        }
    }
    class Computer {
        Part cpu;
        void accept(Visitor v) {
            this.cpu.accept(v);
        }
    }
    abstract class Part {
        abstract void accept(Visitor v);
        abstract double getPrice();
    }
    class CPU extends Part {
        @Override
        void accept(Visitor v){
            v.visitCpu(this);
        }
    }

    Visitor p = new Visitor1();
    new Computer().accept(p);
    p.price;

    # Java类AST编译器Visitor, ASM
    // 打印
    class ClassPrinter extends ClassVisitor {
        @Override
        MethodVisitor visitMethod(){
            print(name + "()");
            retrun null;
        }
    }
    ClassPrinter cp = new ClassPrinter();
    ClassReader cr = new ClassReader("java.lang.Runnable");
    cr.accept(cp, 0);

    // 生成类
    ClassWriter cw = new ClassWriter(0);
    cw.visitMethod(ACC_PULIC + ACC_ABSTRACT, "compareTo", "(Ljava/lang/Object;)I", null, null).visitEnd();
    cw.visitEnd();
    MyClassLoader cl = new MyClassLoader();
    byte[] b = cw.toByteArray();
    Class c = cl.defineClass("pkg.Comparable", b, 0, b.length);

    // 代理类
    ClassReader cr = new ClassReader();
    ClassWriter cw = new ClassWriter(0);
    ClassVisitor cv = new ClassVisitor(ASM4, cw) {
        @Override
        public MethodVisitor visitMethod() {
            MethodVisitor mv = super.visitMethod(); 
            return new MethodVisitor(ASM4, mv) {
                @Override
                public void visitCode(){
                    visitMethodInsn(INVOKESTATIC, "TimeProxy", "before", "()v", false);
                    super.visitCode();
                }
            }
        }
    };
    cr.accept(cv, 0);
    cw.toByteArray();
## 解释器(Intepreter)
    # 解释出AST

# 其它补充
    元素模式
        # 抽象各模式成元素，简化表示
    actor
        # 消息通信
    reactor
        # 事件轮循，注册回调，如libevent
    proactor
        # 注册事件回调，os通知触发回调
    惰性求值
        链式定义(配方)，后自动触发(js tick调度)终止操作
    dsl测试(如jasmine.js)