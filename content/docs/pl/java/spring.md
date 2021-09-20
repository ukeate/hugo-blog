---
Categories: ["语言"]
title: "Spring"
date: 2018-10-09T08:48:07+08:00
---

# NamedContextFactory
    class Spec1 implements NamedContextFactory.Specification {
        @Override
        public String getName(){}
        @Override
        public Class<?>[] getConfiguration(){}
    }
    public class MyFactory extends NamedContextFactory<Specification1> {
        public MyFactory(Class<?> clazz) {
            super(clazz, "my", "my.name")
        }
    }
    @Configuration
    public class Config0 {
        @Bean
        Bean0 getBean(){
            return new Bean0()
        }
    }
    
    parent = new AnnotationConfigApplicationContext()
    parent.register(Config0.class)
    parent.refresh()
    factory = new MyFactory(Config00.class)
    factory.setApplicationContext(parent) 

    spec1 = new Spec1("1", new Class[]{Config1.class})
    factory.setConfigurations(List.of(spec1))
    factory.getInstance("1", Bean0.class)   // 子域共享
    factory.getInstance("1", Bean00.class)  // 子域复制
    factory.getInstance("1", Bean1.class)