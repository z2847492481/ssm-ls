package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import org.springframework.transaction.jta.SpringJtaSynchronizationAdapter;

import java.util.UUID;

/**
 * 测试dao层的工作：
 */
@SpringJUnitConfig(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
//        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
//        DepartmentMapper deptMapper = context.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);

        //插入几个部门
//        departmentMapper.insert(new Department(null,"开发部"));
//        departmentMapper.insert(new Department(null,"测试部"));

//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1));
//        for (){
//            employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1));
//        }

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);


        Employee employee = mapper.selectByPrimaryKey(1);
        System.out.println(employee);
    }
}
