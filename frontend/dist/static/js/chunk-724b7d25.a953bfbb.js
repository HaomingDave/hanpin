(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-724b7d25"],{"0eab":function(t,e,a){"use strict";a.r(e);var i=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"app-container"},[a("span",{staticStyle:{"margin-bottom":"20px"}},[t._v("材料条目:")]),t._v(" "),"未提交"==t.applicationStatus&&-1!==t.userInfo.role.indexOf("6")&&t.userInfo.id===t.originalManager?a("el-button",{staticStyle:{float:"right"},attrs:{type:"primary",size:"mini"},on:{click:t.add}},[t._v("添加条目")]):t._e(),t._v(" "),a("el-table",{directives:[{name:"loading",rawName:"v-loading",value:t.loading,expression:"loading"}],key:t.tableKey,attrs:{data:t.list,border:"",fit:"","highlight-current-row":""}},[a("el-table-column",{attrs:{label:"编号",width:"50px",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.id))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"供货商",width:"150px",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_ghs_name))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"供货商电话",width:"150px",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_ghs_tel))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"添加日期",width:"160px",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.createtime_text))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"材料名称",width:"160px",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_cl_name))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"材料规格","min-width":"150px",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_cl_specifications))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"材料单价",width:"150px",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_unit))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"材料品牌",width:"150px",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_cl_brand))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"材料型号",width:"150px",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_cl_model))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"预算数量",align:"center",width:"150"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_budget_quantity))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"已购数量","class-name":"status-col",width:"150",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_purchased_quantity))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"申请数量","class-name":"status-col",width:"150",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_sq_quantity))])]}}])}),t._v(" "),a("el-table-column",{attrs:{label:"材料合计价","class-name":"status-col",width:"150",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;return[a("span",[t._v(t._s(i.mp_total))])]}}])}),t._v(" "),"未提交"==t.applicationStatus&&-1!==t.userInfo.role.indexOf("6")&&t.userInfo.id===t.originalManager?a("el-table-column",{attrs:{label:"操作",align:"center",width:"230",fixed:"right","class-name":"small-padding fixed-width"},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.row;e.$index;return[a("el-button",{attrs:{type:"primary",size:"mini"},on:{click:function(e){return t.handleUpdate(i)}}},[t._v("\n          编辑\n        ")]),t._v(" "),a("el-button",{attrs:{type:"danger",size:"mini"},on:{click:function(e){return t.handleDelete(i)}}},[t._v("\n          删除\n        ")])]}}],null,!1,855430908)}):t._e()],1),t._v(" "),a("div",{staticStyle:{"margin-bottom":"15px"}},[t._v("申请状态："+t._s(t.applicationStatus))]),t._v(" "),a("div",{staticClass:"remark-wrapper"},[a("div",{staticClass:"remark-title"},[t._v("\n      审核意见：\n    ")]),t._v(" "),a("div",{staticClass:"remark"},[t._v("\n      "+t._s(t.auditRemark)+"\n    ")])]),t._v(" "),a("div",{staticClass:"remark-wrapper"},[a("div",{staticClass:"remark-title"},[t._v("\n      复核意见：\n    ")]),t._v(" "),a("div",{staticClass:"remark"},[t._v("\n      "+t._s(t.reauditRemark)+"\n    ")])]),t._v(" "),a("div",{staticClass:"foot"},[t.canSubmit&&"未提交"==t.applicationStatus&&t.userInfo.id===t.originalManager?a("el-button",{attrs:{type:"primary",size:"mini",loading:t.addLoading},on:{click:t.submit}},[t._v("提交申请")]):t._e(),t._v(" "),t.canAudit&&"复核已通过"!=t.applicationStatus&&"复核未通过"!=t.applicationStatus?a("el-button",{attrs:{type:"primary",size:"mini",loading:t.addLoading},on:{click:t.audit}},[t._v("审核")]):t._e(),t._v(" "),t.canReaudit&&"审核通过"==t.applicationStatus?a("el-button",{attrs:{type:"primary",size:"mini",loading:t.addLoading},on:{click:t.reaudit}},[t._v("复核")]):t._e(),t._v(" "),a("el-button",{attrs:{size:"mini"},on:{click:t.cancel}},[t._v("返回")])],1),t._v(" "),a("concentDialog",{ref:"concentDialog",attrs:{visible:t.submitVisible,form:t.form,"purchase-item-change-type":t.purchaseItemChangeType,"item-id":t.purchaseItemId,title:t.title},on:{"update:visible":function(e){t.submitVisible=e},"update:form":function(e){t.form=e},success:t.success}}),t._v(" "),a("auditDialog",{ref:"auditDialog",attrs:{visible:t.auditVisible,title:"审核"},on:{"update:visible":function(e){t.auditVisible=e}}}),t._v(" "),a("reauditDialog",{ref:"reauditDialog",attrs:{visible:t.reauditVisible,title:"复核"},on:{"update:visible":function(e){t.reauditVisible=e}}})],1)},n=[],l=a("db72"),s=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("el-dialog",{attrs:{title:t.title,visible:t.visible,width:"600px"},on:{close:t.close}},[a("el-form",{ref:"form",staticClass:"demo-form",attrs:{model:t.form,rules:t.rules,"label-width":"100px"}},[a("el-form-item",{attrs:{label:"供货商",prop:"ghs_name"}},[a("el-autocomplete",{staticClass:"inline-input",attrs:{"fetch-suggestions":t.querySearch,placeholder:"请输入内容",size:"mini"},on:{select:t.handleSelect},model:{value:t.form.mp_ghs_name,callback:function(e){t.$set(t.form,"mp_ghs_name",e)},expression:"form.mp_ghs_name"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"供货商电话",prop:"ghs_tel"}},[a("el-autocomplete",{staticClass:"inline-input",attrs:{"fetch-suggestions":t.queryGhsTel,placeholder:"请输入内容",size:"mini"},on:{select:t.handleSelect},model:{value:t.form.mp_ghs_tel,callback:function(e){t.$set(t.form,"mp_ghs_tel",e)},expression:"form.mp_ghs_tel"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"材料名称",prop:"mp_cl_name"}},[a("el-autocomplete",{staticClass:"inline-input",attrs:{"fetch-suggestions":t.queryClName,placeholder:"请输入内容",size:"mini"},on:{select:t.handleSelect},model:{value:t.form.mp_cl_name,callback:function(e){t.$set(t.form,"mp_cl_name",e)},expression:"form.mp_cl_name"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"材料规格",prop:"mp_cl_specifications"}},[a("el-autocomplete",{staticClass:"inline-input",attrs:{"fetch-suggestions":t.queryClSpeci,placeholder:"请输入内容",size:"mini"},on:{select:t.handleSelect},model:{value:t.form.mp_cl_specifications,callback:function(e){t.$set(t.form,"mp_cl_specifications",e)},expression:"form.mp_cl_specifications"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"材料单价",prop:"materialPrice"}},[a("el-input",{attrs:{size:"mini"},model:{value:t.form.mp_unit,callback:function(e){t.$set(t.form,"mp_unit",e)},expression:"form.mp_unit"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"材料品牌",prop:"region"}},[a("el-input",{attrs:{size:"mini"},model:{value:t.form.mp_cl_brand,callback:function(e){t.$set(t.form,"mp_cl_brand",e)},expression:"form.mp_cl_brand"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"材料型号",prop:"region"}},[a("el-input",{attrs:{size:"mini"},model:{value:t.form.mp_cl_model,callback:function(e){t.$set(t.form,"mp_cl_model",e)},expression:"form.mp_cl_model"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"预算数量",prop:"region"}},[a("el-input",{attrs:{size:"mini"},model:{value:t.form.mp_budget_quantity,callback:function(e){t.$set(t.form,"mp_budget_quantity",e)},expression:"form.mp_budget_quantity"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"已购数量",prop:"region"}},[a("el-input",{attrs:{size:"mini"},model:{value:t.form.mp_purchased_quantity,callback:function(e){t.$set(t.form,"mp_purchased_quantity",e)},expression:"form.mp_purchased_quantity"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"申请数量",prop:"region"}},[a("el-input",{attrs:{size:"mini"},model:{value:t.form.mp_sq_quantity,callback:function(e){t.$set(t.form,"mp_sq_quantity",e)},expression:"form.mp_sq_quantity"}})],1),t._v(" "),a("el-form-item",{attrs:{label:"材料合计价",prop:"region"}},[a("el-input",{attrs:{size:"mini"},model:{value:t.form.mp_total,callback:function(e){t.$set(t.form,"mp_total",e)},expression:"form.mp_total"}})],1)],1),t._v(" "),a("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[a("el-button",{attrs:{size:"mini"},on:{click:t.cancel}},[t._v("取 消")]),t._v(" "),a("el-button",{attrs:{type:"primary",loading:t.loading,size:"mini"},on:{click:t.submit}},[t._v("确 定")])],1)],1)},o=[],r=a("4328"),u=a.n(r),c=a("ad8f"),p=a("2f62"),m={props:{visible:{type:Boolean,default:!1},form:{type:Object,default:function(){}},title:{type:String,default:""},purchaseItemChangeType:{type:String,default:""},itemId:{type:String,default:""}},data:function(){return{tableKey:0,loading:!1,submitData:{},rules:{}}},computed:Object(l["a"])({},Object(p["b"])(["mpGhsName","mpGhsTel","mpClName","mpClSpecifications"])),methods:Object(l["a"])({},Object(p["c"])("user",["SET_MPGHSNAME","SET_MPGHSTEL","SET_MPCLNAME","SET_MPCLSPECIFICACTIONS"]),{submit:function(){var t=this;this.loading=!0,"add"===this.purchaseItemChangeType?(this.submitData=u.a.stringify({row:this.form,ma_id:this.$route.query.applicationId}),Object(c["d"])({mid:this.$route.query.applicationId},this.submitData).then((function(e){t.clear()}))):"update"===this.purchaseItemChangeType&&(this.submitData=u.a.stringify({row:this.form,ma_id:this.$route.query.applicationId}),Object(c["n"])({},this.submitData,this.itemId).then((function(e){t.clear()})))},clear:function(){var t={value:this.form.mp_ghs_name},e={value:this.form.mp_ghs_tel},a={value:this.form.mp_cl_name},i={value:this.form.mp_cl_specifications};this.loading=!1,this.SET_MPGHSNAME(t),this.SET_MPGHSTEL(e),this.SET_MPCLNAME(a),this.SET_MPCLSPECIFICACTIONS(i),this.$emit("success"),this.$emit("update:visible",!1)},cancel:function(){this.loading=!1,this.$emit("update:visible",!1)},close:function(){this.$emit("update:visible",!1)},querySearch:function(t,e){e(this.mpGhsName)},queryGhsTel:function(t,e){e(this.mpGhsTel)},queryClName:function(t,e){e(this.mpClName)},queryClSpeci:function(t,e){e(this.mpClSpecifications)},handleSelect:function(){}})},d=m,f=(a("c074"),a("2877")),_=Object(f["a"])(d,s,o,!1,null,"d38f3b82",null),h=_.exports,b=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("el-dialog",{attrs:{title:t.title,visible:t.visible,width:"600px"},on:{close:t.close}},[a("el-form",{ref:"form",staticClass:"demo-form",attrs:{model:t.form,rules:t.rules,"label-width":"100px"}},[a("el-form-item",{attrs:{label:"审核结果",prop:"ghs_name"}},[a("el-select",{attrs:{placeholder:"请选择"},model:{value:t.auditOptionValue,callback:function(e){t.auditOptionValue=e},expression:"auditOptionValue"}},t._l(t.auditOptions,(function(t){return a("el-option",{key:t.value,attrs:{label:t.label,value:t.value}})})),1)],1),t._v(" "),a("el-form-item",{attrs:{label:"审核结果",prop:"ghs_name"}},[a("el-input",{attrs:{type:"textarea",rows:3,placeholder:"请输入审核意见"},model:{value:t.auditMark,callback:function(e){t.auditMark=e},expression:"auditMark"}})],1)],1),t._v(" "),a("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[a("el-button",{attrs:{size:"mini"},on:{click:t.cancel}},[t._v("取 消")]),t._v(" "),a("el-button",{attrs:{type:"primary",loading:t.loading,size:"mini"},on:{click:t.submit}},[t._v("确 定")])],1)],1)},v=[],g={props:{visible:{type:Boolean,default:!1},title:{type:String,default:""},itemId:{type:String,default:""}},data:function(){return{loading:!1,submitData:{},rules:{},auditOptions:[{label:"通过",value:1},{label:"不通过",value:3}],auditOptionValue:1,auditMark:""}},methods:{submit:function(){var t=this;this.loading=!0,this.submitData={row:{audit:this.auditOptionValue,audit_remark:this.auditMark},id:this.$route.query.applicationId},Object(c["e"])({id:this.$route.query.applicationId},this.submitData).then((function(e){t.loading=!1,window.location.reload()}))},cancel:function(){this.loading=!1,this.$emit("update:visible",!1)},close:function(){this.$emit("update:visible",!1)}}},y=g,S=(a("69b6"),Object(f["a"])(y,b,v,!1,null,"8a83358a",null)),k=S.exports,w=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("el-dialog",{attrs:{title:t.title,visible:t.visible,width:"600px"},on:{close:t.close}},[a("el-form",{ref:"form",staticClass:"demo-form",attrs:{model:t.form,rules:t.rules,"label-width":"100px"}},[a("el-form-item",{attrs:{label:"复核结果",prop:"ghs_name"}},[a("el-select",{attrs:{placeholder:"请选择"},model:{value:t.auditOptionValue,callback:function(e){t.auditOptionValue=e},expression:"auditOptionValue"}},t._l(t.auditOptions,(function(t){return a("el-option",{key:t.value,attrs:{label:t.label,value:t.value}})})),1)],1),t._v(" "),a("el-form-item",{attrs:{label:"复核结果",prop:"ghs_name"}},[a("el-input",{attrs:{type:"textarea",rows:3,placeholder:"请输入复核意见"},model:{value:t.auditMark,callback:function(e){t.auditMark=e},expression:"auditMark"}})],1)],1),t._v(" "),a("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[a("el-button",{attrs:{size:"mini"},on:{click:t.cancel}},[t._v("取 消")]),t._v(" "),a("el-button",{attrs:{type:"primary",loading:t.loading,size:"mini"},on:{click:t.submit}},[t._v("确 定")])],1)],1)},I=[],x={props:{visible:{type:Boolean,default:!1},title:{type:String,default:""},itemId:{type:String,default:""}},data:function(){return{loading:!1,submitData:{},rules:{},auditOptions:[{label:"通过",value:4},{label:"不通过",value:5}],auditOptionValue:4,auditMark:""}},methods:{submit:function(){var t=this;this.loading=!0,this.submitData={row:{audit:this.auditOptionValue,reaudit_remark:this.auditMark},id:this.$route.query.applicationId},Object(c["e"])({id:this.$route.query.applicationId,type:2},this.submitData).then((function(e){t.loading=!1,window.location.reload()}))},cancel:function(){this.loading=!1,this.$emit("update:visible",!1)},close:function(){this.$emit("update:visible",!1)}}},O=x,C=(a("fa87"),Object(f["a"])(O,w,I,!1,null,"3d418c64",null)),q=C.exports,$={components:{concentDialog:h,auditDialog:k,reauditDialog:q},data:function(){return{tableKey:0,loading:!1,addLoading:!1,list:[],submitVisible:!1,auditVisible:!1,reauditVisible:!1,title:"新增购买条目",purchaseItemChangeType:"",purchaseItemId:"",applicationStatus:"",auditRemark:"",reauditRemark:"",form:{mp_ghs_name:"",mp_ghs_tel:"",mp_cl_name:"",mp_cl_specifications:"",mp_unit:"",mp_cl_brand:"",mp_cl_model:"",mp_budget_quantity:0,mp_purchased_quantity:0,mp_sq_quantity:0,mp_total:0},editApprovalForm:{audit:2},canAudit:!1,canSubmit:!1,canReaudit:!1,canDoubleCheck:!1,originalManager:""}},computed:Object(l["a"])({},Object(p["b"])(["userInfo"])),created:function(){this.fetchData(),console.log(this.userInfo),this.authorizeRole()},methods:Object(l["a"])({},Object(p["c"])("user",["SET_USERINFO"]),{authorizeRole:function(){var t=this;this.userInfo?"shenhe001"===this.userInfo.username?(this.canAudit=!0,this.canSubmit=!1,this.canReaudit=!1):-1!==this.userInfo.role.indexOf("6")?(this.canAudit=!1,this.canSubmit=!0,this.canReaudit=!1):-1!==this.userInfo.role.indexOf("8")&&(this.canAudit=!1,this.canSubmit=!1,this.canReaudit=!0):Object(c["z"])({}).then((function(e){t.userInfo=e.data.userInfo,t.SET_USERINFO(t.userInfo),"shenhe001"===t.userInfo.username?(t.canAudit=!0,t.canSubmit=!1,t.canReaudit=!1):-1!==t.userInfo.role.indexOf("6")?(t.canAudit=!1,t.canSubmit=!0,t.canReaudit=!1):-1!==t.userInfo.role.indexOf("8")&&(t.canAudit=!1,t.canSubmit=!1,t.canReaudit=!0)}))},fetchData:function(){var t=this;this.loading=!0,Object(c["x"])({},this.$route.query.applicationId).then((function(e){t.list=e.data.rows,t.loading=!1})),Object(c["o"])({},this.$route.query.applicationId).then((function(e){t.applicationStatus=e.data.audit,t.auditRemark=e.data.audit_remark,t.reauditRemark=e.data.reaudit_remark,1==t.applicationStatus?t.applicationStatus="审核通过":2==t.applicationStatus?t.applicationStatus="待审核":3==t.applicationStatus?t.applicationStatus="审核未通过":4==t.applicationStatus?t.applicationStatus="复核已通过":5==t.applicationStatus?t.applicationStatus="复核未通过":6==t.applicationStatus&&(t.applicationStatus="未提交")})),Object(c["w"])({},this.$route.query.projectId).then((function(e){t.originalManager=e.data.manager}))},add:function(){this.submitVisible=!0,this.purchaseItemChangeType="add"},handleUpdate:function(t){for(var e in this.purchaseItemChangeType="update",this.purchaseItemId=t.id,this.submitVisible=!0,this.form)this.form[e]=t[e]},handleDelete:function(t){var e=this;this.loading=!0,Object(c["h"])({},t.id).then((function(t){e.loading=!1,e.fetchData()}))},submit:function(){var t=this;this.addLoading=!0,Object(c["j"])({},this.editApprovalForm,this.$route.query.applicationId).then((function(e){console.log(e),t.addLoading=!1,window.location.reload()}))},audit:function(){this.auditVisible=!0},reaudit:function(){this.reauditVisible=!0},cancel:function(){this.clean(),this.$router.go(-1)},clean:function(){this.list=[]},success:function(){this.fetchData(),this.form={mp_ghs_name:"",mp_ghs_tel:"",mp_cl_name:"",mp_cl_specifications:"",mp_unit:"",mp_cl_brand:"",mp_cl_model:"",mp_budget_quantity:0,mp_purchased_quantity:0,mp_sq_quantity:0,mp_total:0}}})},z=$,D=(a("acea"),Object(f["a"])(z,i,n,!1,null,"006d79e6",null));e["default"]=D.exports},"558e":function(t,e,a){},"69b6":function(t,e,a){"use strict";var i=a("558e"),n=a.n(i);n.a},"931d":function(t,e,a){},acea:function(t,e,a){"use strict";var i=a("931d"),n=a.n(i);n.a},b9a1:function(t,e,a){},c074:function(t,e,a){"use strict";var i=a("b9a1"),n=a.n(i);n.a},d36f:function(t,e,a){},fa87:function(t,e,a){"use strict";var i=a("d36f"),n=a.n(i);n.a}}]);