<?php

namespace app\admin\controller;

use app\admin\model\Admin;
use app\admin\model\AuthGroupAccess;
use app\common\controller\Backend;
use think\Db;
use think\exception\PDOException;
use think\exception\ValidateException;
use think\Session;

/**
 * 项目
 *
 * @icon fa fa-circle-o
 */
class Project extends Backend
{
    
    /**
     * Project模型对象
     * @var \app\admin\model\Project
     */
    protected $model = null;


    /**
     * 无需鉴权的方法,但需要登录
     * @var array
     */
    protected $noNeedLogin = ['getProjectList','getAdminListByGroup','getSearchProjectList','manager_list'];

    protected $noNeedRight = ['getProjectList','getAdminListByGroup','getSearchProjectList', 'getUserInfo','edit', 'indexAjax','manager_list'];

    protected $manger_input_arr = [1, 7];  // 项目经理修改允许权限

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Project;

        // DOM 设置项目经理开关
        $manger_show = false;
        if (array_intersect($this->role_arr, $this->manger_input_arr)) {
            $manger_show = true;
        }

        $this->view->assign("manger_show", $manger_show);
        $this->view->assign("statusList", $this->model->getStatusList());
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

            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $manger_where = [];

            $total = $this->model
                ->where($where)
                ->where($manger_where)
                ->order($sort, $order)
                ->count();
            $list = $this->model
                ->where($where)
                ->where($manger_where)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();

            foreach ($list as $k => $v) {
                if($v->manager){
                    $admin_info = \app\admin\model\Admin::where('id', '=', $v->manager)->find()->toArray();
                    $v->manager = $admin_info['nickname'];
                }else{
                    $v->manager = '无';
                }
            }

            $result = array("total" => $total, "rows" => $list);
            return json($result);
        }
        return $this->view->fetch();
    }

    public function indexAjax()
    {
        //如果发送的来源是Selectpage，则转发到Selectpage
        if ($this->request->request('keyField')) {
            return $this->selectpage();
        }

        list($where, $sort, $order, $offset, $limit) = $this->buildparams();
        $manger_where = [];
//        if(!empty($this->manger_where)){
//            $manger_where['id'] = $this->manger_where['pid'];
//        }

        $total = $this->model
            ->where($where)
            ->where($manger_where)
            ->order($sort, $order)
            ->count();
        $list = $this->model
            ->where($where)
            ->where($manger_where)
            ->order($sort, $order)
            ->limit($offset, $limit)
            ->select();

        foreach ($list as $k => $v) {
            if($v->manager){
                $admin_info = \app\admin\model\Admin::where('id', '=', $v->manager)->find()->toArray();
                $v->manager = $admin_info['nickname'];
            }else{
                $v->manager = '无';
            }
        }

        $result = array("total" => $total, "rows" => $list);
        return json($result);
    }

    public function getProjectList()
    {
        $where = [];
//        if(in_array($this->role_id_3,$this->role_arr)){
//            $where['manager'] = ['=',$this->auth->id];
//        }
        return $this->model->getProjectArray($where);
    }

    public function getAdminListByGroup()
    {
        //主键
        $primarykey = $this->request->request("keyField");
        //主键值
        $primaryvalue = $this->request->request("keyValue");
        $where = [];
        if ($primaryvalue !== null) {
            $where = [$primarykey => ['in', $primaryvalue]];
        }

        $result = collection(model("AuthGroupAccess")->field('aga.uid as id,a.nickname as name')->alias('aga')->join('admin a','a.id = aga.uid')->where('aga.group_id',6)->where('a.status','normal')->where($where)->order('a.id', 'desc')->select())->toArray();
        foreach ($result as $key => $val){
            $result[$key]['pid'] = 0;
        }
        return json(['list' => $result, 'total' => count($result)]);
    }

    public function getSearchProjectList()
    {
        $where = [];
        if(in_array($this->role_id_3,$this->role_arr)){
            $where['manager'] = ['=',$this->auth->id];
        }
        $row = $this->model->get();
        return $this->model->getSearchProjectArray($where);
    }

    public function getUserInfo() {
        $admin = [];
        $admin['userInfo'] = Session::get('admin');
        $role= AuthGroupAccess::where(['uid'=>$admin['userInfo']['id']])->select();
        if($role){
            $role=array_column($role,'group_id');
        }
        foreach ($role as $k => $v) {
          $role[$k] = (string)$v;
        }
        $admin['userInfo']['role']=$role;
        return json($admin);
    }

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if(!$params['manager']){
                $this->error('请选择项目经理');
            }
            if ($params) {
                $params['created_by'] = $this->auth->id;
                $result = $this->model->validate('Project.add')->save($params);
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
            $admin= Session::get('admin');
            $user_id=$params['currentUser']?:$admin['id'];
            //判断当前账号有没有修改权限
            $res=\app\admin\model\Project::CheckEditAuth($user_id,$ids);
            if(!$res){ $this->json_error([],'暂无权限');}

            if ($params) {
                $result = $row->allowField(true)->validate('Project.edit')->save($params);
                if ($result === false) {
                    $this->json_error([],$row->getError());
                }
                $this->json_success();
            }
            $this->json_error();
        }
        $maneger=Admin::where(['id'=>$row->manager])->find();
        $row->manager_name=$maneger->nickname??'';
        return  json($row);
    }


    public function manager_list()
    {
        $user_id=AuthGroupAccess::where(['group_id'=>6])->select();
        $user_list=Admin::where('id','in',array_column($user_id,'uid')?:[])->field('username,nickname,id as user_id')->select();

        $result=collection($user_list)->toArray();
        return  json(['total'=>count($result),'rows'=>$result]);

    }
}
