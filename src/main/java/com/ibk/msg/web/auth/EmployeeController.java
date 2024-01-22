package com.ibk.msg.web.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;


    @GetMapping("/employee")
    @ResponseBody
    public Object findByPagination(EmployeeInfoSearchCondition searchCondition) throws Exception {
        return employeeService.findByPagination(searchCondition);
    }
    
    @GetMapping("/search/bocode")
    @ResponseBody
    public Object findBocodeByPagination(EmployeeInfoSearchCondition searchCondition) throws Exception {
        return employeeService.findBocodeByPagination(searchCondition);
    }
}
