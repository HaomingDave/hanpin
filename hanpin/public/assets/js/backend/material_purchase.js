define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'material_purchase/index' + location.search,
                    add_url: 'material_purchase/add',
                    edit_url: 'material_purchase/edit',
                    del_url: 'material_purchase/del',
                    multi_url: 'material_purchase/multi',
                    table: 'material_purchase',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'order desc,id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id'),operate: false},
                        {field: 'mp_type_cn', title: __('Mp_type_cn'),operate: false},
                        {field: 'mp_ghs_id', title: __('Mp_ghs_id'),searchList: $.getJSON("supplier/getSupplierList")},
                        {field: 'mp_cl_name', title: '材料名称',operate: 'LIKE %...%', placeholder: '模糊搜索，*表示任意字符'},
                        {field: 'mp_budget_quantity', title: __('Mp_budget_quantity'),operate: false},
                        {field: 'mp_purchased_quantity', title: __('Mp_purchased_quantity'),operate: false},
                        {field: 'mp_sq_quantity', title: __('Mp_sq_quantity'),operate: false},
                        {field: 'mp_unit', title: __('Mp_unit'),operate: false},
                        {field: 'mp_total', title: __('Mp_total'),operate: false},
                        {field: 'mp_fhrqr', title: __('Mp_fhrqr'), searchList: {"Y":'是',"N":'否'}, formatter: Table.api.formatter.status},
                        {field: 'mp_fh_time', title: __('Mp_fh_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'mp_cwqr', title: __('Mp_cwqr'),operate: false},
                        {field: 'mp_cwqr_time', title: __('Mp_cwqr_time'), operate: false},
                        {field: 'mp_ysje', title: __('Mp_ysje'), operate:false},
                        {field: 'mp_dfje', title: __('Mp_dfje'), operate:false},
                        {field: 'mp_yfje', title: __('Mp_yfje'), operate:false},
                        {field: 'order', title: __('Order'), operate:false},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
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
                url: 'material_purchase/recyclebin' + location.search,
                pk: 'id',
                sortName: 'order desc,id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
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
                                    url: 'material_purchase/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'material_purchase/destroy',
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
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});