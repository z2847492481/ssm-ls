package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 为了使各种客户端都能获取易处理的数据，自定义一个通用返回类型
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //分页插件处理分页，pn为显示第几页，pageSize表示每页放几条数据
        PageHelper.startPage(pn,5);
        List<Employee> employeeList = employeeService.getAll();
        //连续显示5页
        PageInfo page = new PageInfo(employeeList,5);
        //链式调用
        return Msg.success().add("pageInfo",page);
    }

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn,5);
        List<Employee> employeeList = employeeService.getAll();
        //连续显示5页
        PageInfo pageInfo = new PageInfo(employeeList,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }


    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){

        if (result.hasErrors()){
            //校验失败，显示错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError error : fieldErrors) {
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
        employeeService.saveEmp(employee);
        return Msg.success();

        }
    }

    //后端校验数据之判断用户名是否可用
    @ResponseBody
    @RequestMapping("/checkName")
    public Msg checkName(@RequestParam("empName") String empName){

        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E89-\u9FFF]{2,5})";
        //不匹配则失败
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg","用户名必须是6-16位数字字母组合或者2-5位中文");
        }
        //数据库是否重名校验
        boolean b = employeeService.checkName(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String str_id : str_ids) {
                del_ids.add(Integer.parseInt(str_id));

            }
            employeeService.deleteBatch(del_ids);
        }else {
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);

        }
        return Msg.success();
    }
}
