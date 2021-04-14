<?php

namespace app\admin\controller;

use app\admin\model\MaterialApprovalLog;
use app\admin\model\MaterialPurchase;
use app\common\controller\Backend;
use app\admin\controller\Project;
use think\Session;

/**
 * 材料审批管理
 *
 * @icon fa fa-circle-o
 */
class MaterialApproval extends Backend
{
    
    /**
     * MaterialApproval模型对象
     * @var \app\admin\model\MaterialApproval
     */
    protected $model = null;

    /**
     * 无需鉴权的方法,但需要登录
     * @var array
     */
    protected $noNeedRight = ['auditTpl','audit', 'indexAjax'];
//    protected $noNeedLogin = ['*'];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MaterialApproval;
        $this->view->assign("statusList", $this->model->getStatusList());
        $this->view->assign("auditList", $this->model->getAuditList());
    }
    
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */

    /**
     * 查看
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }

            $caiwu_where = [];
            // 财务查看权限
            if (in_array($this->role_id_2,$this->role_arr)){
                $caiwu_where['audit'] = ['=',1];
            }

            list($where, $sort, $order, $offset, $limit) = $this->buildparams();

            $total = $this->model
                ->where($where)
//                ->where($this->manger_where)
                ->where($caiwu_where)
                ->order($sort, $order)
                ->count();
            $list = $this->model
                ->where($where)
//                ->where($this->manger_where)
                ->where($caiwu_where)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();

            foreach ($list as $k => $v) {
                if($v->audit_admin_id){
                    $admin_info = \app\admin\model\Admin::where('id', '=', $v->audit_admin_id)->find()->toArray();
                    $v->audit_admin_id = $admin_info['nickname'];
                }else{
                    $v->audit_admin_id = '无';
                }

                if($v->pid){
                    $project_info = \app\admin\model\Project::where('id', '=', $v->pid)->find()->toArray();
                    $v->pid = $project_info['name'];
                }else{
                    $v->pid = '无';
                }

                if($v->applicant_admin_id){
                    $admin_info = \app\admin\model\Admin::where('id', '=', $v->applicant_admin_id)->find()->toArray();
                    $v->applicant_admin_id = $admin_info['nickname'];
                }else{
                    $v->applicant_admin_id = '无';
                }

                if($v->audit == 1){
                    $v->audit = '<span class="green">审核通过</span>';
                }elseif($v->audit == 2){
                    $v->audit = '<span style="color:grey">待审核</span>';
                }else{
                    $v->audit = '<span class="red">审核未通过</span>';
                }
            }

            $result = array("total" => $total, "rows" => $list);
            return json($result);
        }
        return $this->view->fetch();
    }

    public function indexAjax($pid)
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);

        //如果发送的来源是Selectpage，则转发到Selectpage
        if ($this->request->request('keyField')) {
            return $this->selectpage();
        }

        $caiwu_where = [];
        // 财务查看权限
        if (in_array($this->role_id_2,$this->role_arr)){
            $caiwu_where['audit'] = ['in',[1,4,5]];
        }
        //项目经理权限
        if (in_array($this->role_id_1,$this->role_arr)){
            $caiwu_where['audit'] = ['in',[1,2,3,4,5]];
        }

        list($where, $sort, $order, $offset, $limit) = $this->buildparams();

        $total = $this->model
            ->where($where)
            ->where('pid', $pid)
//            ->where($this->manger_where)
            ->where($caiwu_where)
            ->order($sort, $order)
            ->count();
        $list = $this->model
            ->where($where)
            ->where('pid', $pid)
//            ->where($this->manger_where)
            ->where($caiwu_where)
            ->order($sort, $order)
            ->limit($offset, $limit)
            ->select();
        foreach ($list as $k => $v) {
            if($v->audit_admin_id){
                $admin_info = \app\admin\model\Admin::where('id', '=', $v->audit_admin_id)->find()->toArray();
                $v->audit_admin_id = $admin_info['nickname'];
            }else{
                $v->audit_admin_id = '无';
            }

            if($v->pid){
                $project_info = \app\admin\model\Project::where('id', '=', $v->pid)->fetchSql()->find();
                $v->pid = $project_info['name']??"";
            }else{
                $v->pid = '无';
            }

            if($v->applicant_admin_id){
                $admin_info = \app\admin\model\Admin::where('id', '=', $v->applicant_admin_id)->find()->toArray();
                $v->applicant_admin_id = $admin_info['nickname'];
            }else{
                $v->applicant_admin_id = '无';
            }
            $v->applicant_time = date("Y-m-d H:i", $v->applicant_time);
            if($v->audit == 1){
                $v->audit = '审核通过';
            }elseif($v->audit == 2){
                $v->audit = '待审核';
            }elseif($v->audit == 3){
                $v->audit = '审核未通过';
            }elseif($v->audit == 4){
                $v->audit = '复核通过';
            }elseif($v->audit == 5){
                $v->audit = '复核未通过';
            }elseif($v->audit == 6){
                $v->audit = '未提交';
            }
        }

        if (in_array($this->role_id_1,$this->role_arr)){
            MaterialApprovalLog::where(['pid'=>$pid,'audit'=>2])->update(['is_read'=>1]);
        }





        $result = array("total" => $total, "rows" => $list);
        return json($result);
    }

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
//                $where['numer'] = ['=', $params['numer']];
//                if ($this->model->where($where)->find()) {
//                    $this->error('该编号已存在,请重新输入');
//                }
                $admin= Session::get('admin');
                $user_id=$admin['id'];
                //判断当前账号有没有修改权限
                $res=\app\admin\model\Project::CheckEditAuth($user_id,$params['pid']);
                if(!$res){ $this->json_error([],'暂无权限');}



                $params['applicant_admin_id'] = $this->auth->id;
                $params['applicant'] = $this->auth->nickname;
                $params['applicant_time'] = time();

                $result = $this->model->validate('MaterialApproval.add')->save($params);
                if ($result === false) {
                    $this->error($this->model->getError());
                }

                $this->success();
            }
            $this->error();
        }

        return $this->view->fetch();
    }

    /**
     * 编辑
     */
    public function edit($ids = NULL)
    {
        $row = $this->model->get(['id' => $ids]);
        if (!$row)
            $this->error(__('No Results were found'));
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
//                $where['numer'] = ['=', $params['numer']];
//                $where['id'] = ['<>', $row->id];
//                if ($this->model->where($where)->find()) {
//                    $this->error('该编号已存在,请重新输入');
//                }
                $params['applicant_time'] = time();
                $result = $row->allowField(true)->validate('MaterialApproval.edit')->save($params);
                if ($result === false) {
                    $this->error($row->getError());
                }
                $this->success();
            }

            $this->error();
        }
        $this->view->assign("row", $row);

        // DOM 审核按钮显示开关
        $audit_buttons_show = false;
        $buttons_show = true;

        if (in_array($this->role_id_1,$this->role_arr)){
            $audit_buttons_show = true;
        }

        if (in_array($this->role_id_2,$this->role_arr)){
            $buttons_show = false;
        }

        $this->assignconfig('ids', $ids);
        $this->view->assign("audit_buttons_show", $audit_buttons_show);
        $this->view->assign("buttons_show", $buttons_show);
//        return $this->view->fetch();
        return json($row);
    }

    /**
     * 审核
     */
    public function audit()
    {
        $type = $this->request->request("type",'1');
        if (!in_array($this->role_id_1,$this->role_arr) && !in_array($this->role_id_2,$this->role_arr)){
            $this->error('很抱歉,您没有审核权限');
        }

        $id = $this->request->get("id");
        $row = $this->model->get(['id' => $id]);
        if (!$row)
            $this->error(__('No Results were found'));

            $params = $this->request->request("row/a");
            if ($params) {
                $updateDate['audit'] = $params['audit'];
                if ($type == 2) {
                    $updateDate['reaudit_remark'] = $params['reaudit_remark'];
                    $updateDate['reaudit_time'] = time();
                } else {
                    $updateDate['audit_remark'] = $params['audit_remark'];
                    $updateDate['audit_time'] = time();
                }

                $updateDate['audit_admin_id'] = $this->auth->id;
                $result = $row->allowField(true)->validate('MaterialApproval.edit')->save($updateDate);

                if($params['audit']==4){
                    $lists=(new MaterialPurchase)->where(['ma_id'=>$id])->select();
                    if($lists){
                        foreach($lists as $v){
//                            $mater=(new MaterialPurchase)->where(['id'=>$v->id])->find();
                            $update['mp_cw_budget_quantity']    =$v->mp_budget_quantity;
                            $update['mp_cw_purchased_quantity'] =$v->mp_purchased_quantity;
                            $update['mp_cw_sq_quantity']        =$v->mp_sq_quantity;
                            $update['mp_cw_unit']               =$v->mp_unit;
                            $update['mp_cwqr']                  ='Y';
                            $update['mp_cwqr_time']             =time();
                            $update['mp_cw_total']              = $v->mp_total;

                            (new MaterialPurchase)->where(['id'=>$v->id])->update($update);
                            unset($update);
                        }
                    }

                }
                if ($result === false) {
                    $this->json_error($row->getError());
                }
                $this->json_success();
            }
            $this->json_error();

    }



}
