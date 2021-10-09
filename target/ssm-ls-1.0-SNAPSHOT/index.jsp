<%--
  Created by IntelliJ IDEA.
  User: 28474
  Date: 2021/10/4
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--务必要把script标签给闭起来，妈的，坑我一小时-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!--员工修改的模态框-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@atguigu.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender"  id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" ></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@atguigu.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender"  id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" ></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--表单显示数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">
    //总记录数
    var totalRecord,currentPage;
    //页面加载完成之后，直接发送ajax异步请求，查到分页数据并显示数据
    $(function () {
        //刚加载完指定跳转到第一页
        to_page(1);
    });


    //页面跳转请求，pn表示要跳转的页面号
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",//请求路径
            data:"pn="+pn,//跳转页号
            type:"get",//请求方式
            success:function (result) {
                // console.log(result);
                //构建表格
                build_emps_table(result);
                //构建分页信息
                build_page_info(result);
                //构建分页条信息
                build_page_nav(result);
            }
        });

    }
    //构建表格数据
    function build_emps_table(result) {
        //构建之前先清空，防止数据重叠
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var gender = item.gender == 'M'?"男":"女";
            var genderTd = $("<td></td>").append(gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn =$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("delete-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //将组件添加到指定位置
           $("<tr></tr>").append(checkBoxTd)
               .append(empIdTd)
               .append(empNameTd)
               .append(genderTd)
               .append(emailTd)
               .append(deptNameTd)
               .append(btnTd)
               .appendTo("#emps_table tbody");
        });
        
    }

    //解析分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页，总"
            +result.extend.pageInfo.pages+"共页，总共"
            +result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;

    }

    //构建分页条信息
    function build_page_nav(result) {
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {

        firstPageLi.click(function () {
            to_page(1);
        });
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum - 1);
        });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if (result.extend.pageInfo.hasNextPage == false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else {

        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum + 1);
        });
        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        })
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //遍历完之后
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }

    function reset_form(ele){
        $(ele)[0].reset();
        //清空样式
        $(ele).find("*").removeClass("has-error hash-success");
        //文本清空
        $(ele).find(".help-block").text("");
    }


    $("#emp_add_modal_btn").click(function () {
        //模态框弹出之前重置表单
        reset_form("#empAddModal form");
        // $()[0].reset();
        //模态框显示之前应该发送ajax请求获取全部部门名称并显示在下拉列表中
        getDepts("#empAddModal select");
        $("#empAddModal").modal({
            backdrop:"static"
        })
    });

    //查出所有的部门信息
    function getDepts(ele) {
        //清空下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele)
                })
            }
        });
    }

    //校验表单数据
    function validata_add_form(){
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E89-\u9FFF]{2,5})/;
        if (!regName.test(empName)){
          // alert("用户名要求2-5位中文或6-16位数字字母组合");
            show_validata_msg("#empName_add_input","error","用户名要求2-5位中文或6-16位数字字母组合");
          return false;
        }else {
            show_validata_msg("#empName_add_input","success","");
        }

        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)){
            // alert("邮箱格式不正确");
            show_validata_msg("#email_add_input","error","邮箱格式不正确");
            return  false;
        }else {
            show_validata_msg("#email_add_input","success","")
        }
        return true;
    }

    function show_validata_msg(ele,status,msg){
        //先清除
        $(ele).parent().remove("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);

        }else if ("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#empName_add_input").change(function () {
        //发送ajax请求检验是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkName",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code == 100){
                    show_validata_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else {
                    show_validata_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");

                }
            }
        })
    });

    $("#emp_save_btn").click(function () {
        //对数据进行校验
        if (!validata_add_form()){
            return false;
        }
        //拿到当前按钮的自定义属性判断
        if ($(this).attr("ajax-va") == "error"){
            return false;
        }
        //将模态框填写的表单数据提交保存
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"post",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                if (result.code == 100){

                //员工保存成功，关闭模态框，以及跳转到末页
                $("#empAddModal").modal("hide");
                //跳转到最后一页
                to_page(totalRecord);
                }else {
                    if (undefined != result.extend.errorFields.email){
                        //显示错误信息
                        show_validata_msg("#email_add_input","error",result.extend.errorFields.email)
                    }
                    if (undefined != result.extend.errorFields.empName){
                        show_validata_msg("#empName_add_input","error",result.extend.errorFields.empName)
                    }
                }

            }
        })
    });

    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }
    //删除
    $(document).on("click",".delete_btn",function () {
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId =  $(this).attr("delete-id");
        if (confirm("确认删除【"+empName+"】吗？")){
            //确认的话就发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    to_page(currentPage);
                }
            })
        }
    });

    $(document).on("click",".edit_btn",function () {

        //查出部门信息
        getDepts("#empUpdateModal select");
        //查出员工信息
        getEmp($(this).attr("edit-id"));
        //给按钮一个id属性
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });


    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)){
            // alert("邮箱格式不正确");
            show_validata_msg("#email_update_input","error","邮箱格式不正确");
            return  false;
        }else {
            show_validata_msg("#email_update_input","success","")
        }
        //发送ajax请求更新
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //更新成功，关闭对话框
                $("#empUpdateModal").modal("hide");
                //刷新本页数据内容
                to_page(currentPage);
            }
        });
    });

    //全选/全不选
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
      var flag =  $(".check_itme:checked").length==$(".check_item").length;
      $("#check_all").prop("checked",flag);
    });


    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
            $(this).parents("tr").find("td:eq(2)").text();
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames =  empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if (confirm("确认删除【"+empNames+"】吗？")){
            $.ajax({
               url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
