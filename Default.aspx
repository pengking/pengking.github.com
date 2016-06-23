<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="testJQuery._Default"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <script type="text/javascript" src="jq/jquery.min.js"></script>
    <script type="text/javascript" src="jq/jquery.js"></script>
    <script type="text/javascript">
        var test = ["hello", "world", "test", "jquery"];
        function test_foreach() {
            $.each(test, function(i,n) {
                if(i%2 == 0)
                  alert(n);
          });
          $("#test").append($("input").map(function() {
              return $(this).val();
          }).get().join(", "));
        }
       // window.onload = test_foreach;
        //use button to get value from server
        $(function() {
            $("#btn").click(function() {
                $.ajax({
                    type: "post", //要用post方式                 
                    url: "Default.aspx/SayHello", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(data) {
                    alert(data); //返回的数据用data.d获取内容
                    },
                    error: function(err) {
                        alert(err);
                    }
                });
            });
        });
        $(function() {
        $("#testother").click(function() {
                $.ajax({
                    type: "get", //要用post方式
                    //url: "Default.aspx?type=test&body=test", //方法所在页面和方法名
                    url: "Default.aspx", //方法所在页面和方法名
                   // contentType: "application/json; charset=utf-8",
                   // dataType: "json",
                    data: {type:"test",body:"testbody"},
                    success: function(data) {
                        alert(data); //返回的数据用data.d获取内容
                    },
                    error: function(err) {
                        alert("error");
                    }
                });
            });
        });
        //use button to post value to server
        //
        $(function() {
            $("#Senddata").click(function() {
                var myCars = new Array();
                myCars[0] = "Saab";
                myCars[1] = "Volvo";
                myCars[2] = "BMW";

                $.ajax({
                    type: "POST",
                    url: "Default.aspx/Concat",
                    data: JSON.stringify({ arr: myCars }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) {
                        alert(response.d);
                        alert(myCars);
                    },
                    failure: function() {
                        alert("fail");
                    }
                });
            });
        });
        /*
        $(document).ready(function() {
            var myCars = new Array();
            myCars[0] = "Saab";
            myCars[1] = "Volvo";
            myCars[2] = "BMW";

            $.ajax({
                type: "POST",
                url: "Default.aspx/Concat",
                data: JSON.stringify({ arr: myCars }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    alert(response.d);
                },
                failure: function() {
                    alert("fail");
                }
            });
        });
        */
        //transfer an array to asp.net list
        //post data to server(array)
        //get data from server(array)


        function TestFunc() {
            var d = {
                "q": "queryCondition",
                "user":
            {
                "Id": 1,
                "Name": '张三',
                "Age": 18
            }
            };

            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "Default.aspx/Insert",
                dataType: "json",
                data: JSON.stringify(d),   //这里需将d转换为字符串
                success: function(result) {

                    //var date = eval('new ' + eval(result.d.ProductDate).source)  //从C#的DateTime类型转换为js的date类型
                    //获取返回实体类的值
                    var id = result.d.id;
                    var name = result.d.name;
                    var age = result.d.age;
                    alert("the recv data is id" + id + ",name is " + name + ",age is " + age);
                },
                error: function(error) {
                    alert(error.responseText);
                }
            });
        }
        //var te = { "test" };

        function transtoarray() {
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "Default.aspx/BackList",
                dataType: "json",
                data:'{"tests":"test"}',
                success: handleSuccess,
                error: function(error) {
                    alert(error.responseText);
                }
            });
        }

        function testMuchInput() {
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "Default.aspx/HelloTest",
                dataType: "json",
                //data: '{"tests":"test"}',
                data: '{"smart":"smart","guid":"12","type":"intt","body":"nothing"}',
                success: function(data) {
                    for (var test in data.d)
                        //alert(test);
                    alert(data.d[test]);
                },
                error: function(error) {
                    // alert(error.responseText);
                    alert("error happen");
                }
            });
        }
        function handleSuccess(result) { 
        //this is the old part use to test string
          // Array transResult = new Array();
            //transResult = result.d.toString().split(";");
            
            //this is my new add use to test array
            transResult = result.d;
            alert(transResult);
            for(var test in result.d)
                alert(result.d[test].Id);
            //alert(result.d);
        }
        $("#RecvData").click(testMuchInput());
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <p> hello world</p>
    <input type="text" value = "test first">
    <input type= "text" value = "ajax not learning" />
    <input type=text value ="test value" />
    <p id="test"></p>
    </div>
    
    <div>
    <asp:Button ID="btn" runat="server" Text="验证用户" />
    </div>
    
    <div>
    <asp:Button ID="Senddata" runat="server" Text="send data" />
    </div>
    
    <div>
    <asp:Button ID="RecvData" runat="server" Text="Recv data" />
    </div>
    <input type="button" id="testother" value = "test other" />
    </form>
</body>
</html>
