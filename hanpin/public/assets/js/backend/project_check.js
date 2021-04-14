define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'project_check/index' + location.search,
                    add_url: 'project_check/add',
                    edit_url: 'project_check/edit',
                    del_url: 'project_check/del',
                    multi_url: 'project_check/multi',
                    table: 'project_check',
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
                        {field: 'pid', title: __('Pid'),searchList: $.getJSON("project/getSearchProjectList")},
                        {field: 'sgtxgt', title: __('Sgtxgt'), searchList: {"是":__('是'),"否":__('否')}, formatter: Table.api.formatter.normal,operate: false},
                        {field: 'sgjdb', title: __('Sgjdb'), searchList: {"是":__('是'),"否":__('否')}, formatter: Table.api.formatter.normal,operate: false},
                        {field: 'sgzcwd', title: __('Sgzcwd'), searchList: {"是":__('是'),"否":__('否')}, formatter: Table.api.formatter.normal,operate: false},
                        {field: 'gywd', title: __('Gywd'), searchList: {"是":__('是'),"否":__('否')}, formatter: Table.api.formatter.normal,operate: false},
                        {field: 'sxgcl', title: __('Sxgcl'), searchList: {"是":__('是'),"否":__('否')}, formatter: Table.api.formatter.normal,operate: false},
                        {field: 'clxyzb', title: __('Clxyzb'), searchList: {"是":__('是'),"否":__('否')}, formatter: Table.api.formatter.normal,operate: false},
                        {field: 'ysfwhgcl', title: __('Ysfwhgcl'), searchList: {"是":__('是'),"否":__('否')}, formatter: Table.api.formatter.normal,operate: false},
                        {field: 'wmsdqz', title: __('Wmsdqz'), searchList: {"是":__('是'),"否":__('否')}, formatter: Table.api.formatter.normal,operate: false},
                        {field: 'order', title: __('Order'),operate: false},
                        {field: 'createtime', title: __('Createtime'),formatter: Table.api.formatter.datetime,operate: false},
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
                url: 'project_check/recyclebin' + location.search,
                pk: 'id',
                sortName: 'id',
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
                                    url: 'project_check/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'project_check/destroy',
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