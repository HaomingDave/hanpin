define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'material_approval/index' + location.search,
                    add_url: 'material_approval/add',
                    edit_url: 'material_approval/edit',
                    del_url: 'material_approval/del',
                    multi_url: 'material_approval/multi',
                    table: 'material_approval',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'order desc,id',
                escape:false,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id'),operate: false},
                        {field: 'name', title: __('Name'),operate: 'LIKE %...%', placeholder: '模糊搜索，*表示任意字符'},
                        {field: 'numer', title: __('Numer'),operate: 'LIKE %...%', placeholder: '模糊搜索，*表示任意字符'},
                        {field: 'pid', title: '项目名',searchList: $.getJSON("project/getSearchProjectList")},
                        {field: 'audit', title: '审核状态', searchList: {"1":'审核成功',"2":'待审核',"3":'审核未通过'}},
                        {field: 'audit_admin_id', title: __('Audit_admin_id'),operate: false},
                        {
                            field: 'audit_time',
                            title: __('Audit_time'),
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime,
                            operate: false
                        },
                        {field: 'applicant_admin_id', title: '申请人'},
                        {
                            field: 'applicant_time',
                            title: '申请时间',
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime,
                            operate: false
                        },
                        {field: 'order', title: __('Order'),operate: false},
                        {
                            field: 'status',
                            title: __('Status'),
                            searchList: {"normal": __('Normal'), "hidden": __('Hidden')},
                            formatter: Table.api.formatter.status,
                            operate: false
                        },
                        {
                            field: 'createtime',
                            title: __('Createtime'),
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime
                        },
                        {
                            field: 'operate',
                            title: __('Operate'),
                            table: table,
                            events: Table.api.events.operate,
                            buttons: [
                                {
                                    name: 'edit',
                                    text: '采购单管理',
                                    classname: 'btn btn-xs btn-success btn-addtabs',
                                    icon: 'fa fa-pencil',
                                    url: 'material_approval/edit',
                                },
                            ],
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        recyclebin: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    'dragsort_url': ''
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: 'material_approval/recyclebin' + location.search,
                pk: 'id',
                sortName: 'order desc,id',
                escape:false,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'name', title: __('Name'), align: 'left'},
                        {
                            field: 'deletetime',
                            title: __('Deletetime'),
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime
                        },
                        {
                            field: 'operate',
                            width: '130px',
                            title: __('Operate'),
                            table: table,
                            events: Table.api.events.operate,
                            buttons: [
                                {
                                    name: 'Restore',
                                    text: __('Restore'),
                                    classname: 'btn btn-xs btn-info btn-ajax btn-restoreit',
                                    icon: 'fa fa-rotate-left',
                                    url: 'material_approval/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'material_approval/destroy',
                                    refresh: true
                                }
                            ],
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'material_purchase/index/ids/'+Config.ids+'/' + location.search,
                    add_url: 'material_purchase/add',
                    edit_url: 'material_purchase/edit',
                    del_url: 'material_purchase/del',
                    table: 'material_purchase',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'order desc,id',
                showColumns: false,
                showToggle: false,
                showExport: false,
                showSearch: false,
                search: false,
                pagination:false,
                showPaginationSwitch:false,
                escape:false,
                columns: [
                    [
                        {field: 'mp_type_cn', title: '类别'},
                        {field: 'ghs_name', title: '供货商',searchList: $.getJSON("supplier/getSupplierList")},
                        {field: 'ghs_tel', title: '供货商电话'},
                        {field: 'mp_cl_name', title: '材料名称'},
                        {field: 'mp_cl_specifications', title: '材料规格'},
                        {field: 'mp_unit', title: '材料单价'},
                        {field: 'mp_cl_brand', title: '材料品牌'},
                        {field: 'mp_cl_model', title: '材料型号'},
                        {field: 'mp_budget_quantity', title: '预算数量'},
                        {field: 'mp_purchased_quantity', title: '已购数量'},
                        {field: 'mp_sq_quantity', title: '申请数量'},
                        {field: 'mp_total', title: '材料合计价'},
                        {field: 'mp_shr', title: '收货人'},
                        {
                            field: 'mp_sh_time',
                            title: '收货日期',
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime
                        },
                        {field: 'mp_fhrqr', title: '发货人确认'},
                        {field: 'mp_cwqr', title: '财务确认'},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
            Form.api.bindevent($("form[role=form]"), function(){
                top.window.$("ul.nav-addtabs #tab_141").trigger("click");
            })


        },
        audit: function () {
            Form.api.bindevent($("#audit-form"), function(data, ret){
                Fast.api.close(data);//这里是重点
                Toastr.success("成功");//这个可有可无
            }, function(data, ret){
                Toastr.success("失败");
            });
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});