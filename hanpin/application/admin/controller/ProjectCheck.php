<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use think\Db;
use think\exception\PDOException;
use think\exception\ValidateException;
use think\Session;

/**
 * 施工前检查管理
 *
 * @icon fa fa-circle-o
 */
class ProjectCheck extends Backend
{
    
    /**
     * ProjectCheck模型对象
     * @var \app\admin\model\ProjectCheck
     */
    protected $model = null;
    protected $noNeedRight = ['indexAjax'];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\ProjectCheck;
        $this->view->assign("sgtxgtList", $this->model->getSgtxgtList());
        $this->view->assign("sgjdbList", $this->model->getSgjdbList());
        $this->view->assign("sgzcwdList", $this->model->getSgzcwdList());
        $this->view->assign("gywdList", $this->model->getGywdList());
        $this->view->assign("sxgclList", $this->model->getSxgclList());
        $this->view->assign("clxyzbList", $this->model->getClxyzbList());
        $this->view->assign("ysfwhgclList", $this->model->getYsfwhgclList());
        $this->view->assign("wmsdqzList", $this->model->getWmsdqzList());
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
            $total = $this->model
                ->where($where)
//                ->where($this->manger_where)
                ->order($sort, $order)
                ->count();
            $list = $this->model
                ->where($where)
//                ->where($this->manger_where)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();

            foreach ($list as $k => $v) {
                if($v->pid){
                    $admin_info = \app\admin\model\Project::where('id', '=', $v->pid)->find()->toArray();
                    $v->pid = $admin_info['name'];
                }else{
                    $v->pid = '无';
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
        list($where, $sort, $order, $offset, $limit) = $this->buildparams();
        $total = $this->model
            ->where($where)
//            ->where($this->manger_where)
            ->where('pid', $pid)
            ->order($sort, $order)
            ->count();
        $list = $this->model
            ->where($where)
//            ->where($this->manger_where)
            ->where('pid', $pid)
            ->order($sort, $order)
            ->limit($offset, $limit)
            ->select();

        foreach ($list as $k => $v) {
            if($v->pid){
                $admin_info = \app\admin\model\Project::where('id', '=', $v->pid)->find()->toArray();
                $v->pid = $admin_info['name'];
            }else{
                $v->pid = '无';
            }
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
                $admin= Session::get('admin')   ;
                $user_id=$admin['id'];
                //判断当前账号有没有修改权限
                $res=\app\admin\model\Project::CheckEditAuth($user_id,$params['pid']);
                if(!$res){ $this->json_error([],'暂无权限');}

                $params = $this->preExcludeFields($params);

                if ($this->dataLimit && $this->dataLimitFieldAutoFill) {
                    $params[$this->dataLimitField] = $this->auth->id;
                }
                $result = false;
                Db::startTrans();
                try {
                    //是否采用模型验证
                    if ($this->modelValidate) {
                        $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                        $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.add' : $name) : $this->modelValidate;
                        $this->model->validateFailException(true)->validate($validate);
                    }
                    $result = $this->model->allowField(true)->save($params);
                    Db::commit();
                } catch (ValidateException $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                } catch (PDOException $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                } catch (Exception $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                }
                if ($result !== false) {
                    $this->success();
                } else {
                    $this->error(__('No rows were inserted'));
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        return $this->view->fetch();
    }

    /**
     * 编辑
     */
    public function edit($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $admin= Session::get('admin')   ;
        $user_id=$admin['id'];
        //判断当前账号有没有修改权限
        $res=\app\admin\model\Project::CheckEditAuth($user_id,$row['pid']);
        if(!$res){ $this->json_error([],'暂无权限');}


        $adminIds = $this->getDataLimitAdminIds();
        if (is_array($adminIds)) {
            if (!in_array($row[$this->dataLimitField], $adminIds)) {
                $this->error(__('You have no permission'));
            }
        }
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                $params = $this->preExcludeFields($params);
                $result = false;
                Db::startTrans();
                try {
                    //是否采用模型验证
                    if ($this->modelValidate) {
                        $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                        $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.edit' : $name) : $this->modelValidate;
                        $row->validateFailException(true)->validate($validate);
                    }
                    $result = $row->allowField(true)->save($params);
                    Db::commit();
                } catch (ValidateException $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                } catch (PDOException $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                } catch (Exception $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                }
                if ($result !== false) {
                    $this->success();
                } else {
                    $this->error(__('No rows were updated'));
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $this->view->assign("row", $row);
        return $this->view->fetch();
    }




}
