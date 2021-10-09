package com.atguigu.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 为了使各种客户端都能获取易处理的数据，自定义一个通用返回类型
 * code表示状态码，自定义成功和失败的状态码
 * msg表示成功或失败信息
 * extend中存储返回的数据
 */
public class Msg {
    //状态码
    private int code;
    //提示信息
    private String msg;
    //要返回给浏览器的信息
    private Map<String,Object> extend = new HashMap<>();

    public Msg() {
    }

    public Msg(int code, String msg, Map<String, Object> extend) {
        this.code = code;
        this.msg = msg;
        this.extend = extend;
    }

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功！");
        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败！");
        return result;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    //为了能够实现链式调用，返回msg对象
    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }
}
