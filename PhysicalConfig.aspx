<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PhysicalConfig.aspx.cs" Inherits="ZJG_Admin.Module.ConfigManage.PhysicalConfig" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <meta name="renderer" content="webkit">
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
     <link href="../../layui/css/layui.css" rel="stylesheet" />
     <script src="../../js/jquery.js"></script>
    


    
    <script src="../../layui/layui.js"></script>
    <script type="text/javascript">
        var tableIns;

        $(function () {
            Refresh();
        })

        function but_Add() {
            //弹出iframe层
            layer.open({
                type: 2,
                title: '新增物品',
                offset: 't',
                shadeClose: true,
                shade: 0.8,
                resize :false,
                area: ['500px', '500px'],
                content: ['PhysicalConfigAdd.aspx', 'no']//iframe的url
              
            });
        }

        //删除按钮
        function but_Delete() {
            var checkbox = tableIns.checkStatus('Tb');
            var IDCount='';
            if (checkbox.data.length == 0)
            {
                layer.msg('请至少选择一行');
            }
            else {
                for (var i = 0; i < checkbox.data.length; i++) {
                    IDCount += checkbox.data[i].ID + ',';
                }
                alert(IDCount)
                    $.ajax({
                        async: false,    //表示请求是否异步处理
                        type: "post",    //请求类型
                        url: "PhysicalConfigDeleAJAX.ashx",//请求的 URL地址
                        data: {
                            IDCount: IDCount
                        },
                        dataType: "text",//返回的数据类型
                        success: function (data) {
                            if (data == "true")
                            {
                                Refresh();
                            }
                            else if (data == "false")
                            {
                                layer.msg('删除失败');
                            }
                        },
                        error: function (data) {
                            layer.msg('删除失败');
                        }
                    });
                
            }
        }

        //刷新按钮
        function but_Refresh() {
            Refresh();
        }
        
        //表格重载方法
        function Refresh() {
            layui.use('table', function () {
                tableIns = layui.table;
                tableIns.render({
                    elem: '#test'
                  , url: 'PhysicalConfig.ashx'
                  , response: {
                      statusName: 'code' //规定数据状态的字段名称，默认：code
                        , statusCode: 0 //规定成功的状态码，默认：0
                        , msgName: 'msg' //规定状态信息的字段名称，默认：msg
                        , countName: 'count' //规定数据总数的字段名称，默认：count
                        , dataName: 'data' //规定数据列表的字段名称，默认：data
                  }
                 , cols: [[
                     { type: 'checkbox' }
                    , { field: 'ID', width: '7.2%', title: 'ID', sort: true, align: 'center' }
                    , { field: 'GoodsName', width: '15%', title: '物品名称', align: 'center' }
                    , { field: 'PicturePath', width: '15%', title: '图片路径', align: 'center' }
                    , { field: 'AddTime', width: '15%', title: '添加时间', sort: true, align: 'center' }
                    , { field: 'NeedWalletMoney', width: '15%', title: '所需金币', sort: true, align: 'center' }
                    , { field: 'CustomerServiceWeChat', width: '15%', title: '客服微信', align: 'center' }
                    , { field: 'Remarks', width: '15.5%', title: '文字说明', align: 'center' }
                 ]]

                    , id: 'Tb'
                    , page: true
                });
            });
            //tableIns.reload({
            //    url: 'PhysicalConfig.ashx',
            //    page: {
            //        curr: 1
            //    }
            //});
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <div style="width:100%;">
             <button  type="button" class="layui-btn" style="width:33.3%; height:50px;font-size:large;" onclick="but_Add()">点击新增</button>
             <button  type="button" class="layui-btn layui-btn-danger" style="width:33.3%;height:50px;margin-left:0%;font-size:large;" onclick="but_Delete()">点击删除</button>
             <button  type="button" class="layui-btn" style="width:33.3%;height:50px;margin-left:67%;margin-top:-69px; font-size:large;" onclick="but_Refresh()">点击刷新</button>
        </div>

   
    <div style="width:100%; margin-top:-35px">
      <table  id="test"  class="layui-table" lay-filter="Tb" > </table>
    </div>
    </form>

</body>
</html>
