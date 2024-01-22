package com.ibk.msg.web.accessmanage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
@RequestMapping("/access")
public class AccessManageController {

  @Autowired
  private AccessManageService service;


  @GetMapping("/users.ibk")
  public String viewJsp(){
    return "jsp/accessmanage";
  }

  @GetMapping("/users")
  @ResponseBody
  public Object findUsers(AccessManageSearchCondition searchCondition) {
    return service.findUsers(searchCondition);
  }

  @GetMapping("/users/{empNo}")
  public Object findUsers(@PathVariable String empNo) {
    return service.findDetail(empNo);
  }

  @PostMapping("/users")
  @ResponseStatus(HttpStatus.CREATED)
  public Object createUser(@RequestBody AccessUser user) {
    return service.createUser(user);
  }

  @PutMapping("/users/{empNo}")
  public Object modifyUser(@RequestBody AccessUser user, @PathVariable String empNo) {
    user.setEmpNo(empNo);
    return service.modifyUser(user);
  }

  @DeleteMapping("/users")
  public void removeUser(String[] empNos) {
    service.removeUser(empNos);
  }

}
