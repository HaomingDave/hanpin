<?php

namespace app\admin\controller;

use app\admin\model\ProjectRecordLog;
use app\common\controller\Backend;
use think\Db;
use think\Exception;
use think\exception\PDOException;
use think\exception\ValidateException;
use think\Session;

/**
 * 项目记录
 *
 * @icon fa fa-circle-o
 */
class ProjectRecord extends Backend
{

    /**
     * ProjectRecord模型对象
     * @var \app\admin\model\ProjectRecord
     */
    protected $model = null;
    protected $noNeedRight = ['getProjectRecordFile', 'getProjectRecordImg','getAdminListByGroup','getSearchProjectList', 'edit', 'getUserInfo', 'indexAjax'];
    protected $noNeedLogin=["*"];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\ProjectRecord;

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
                ->where($this->manger_where)
                ->order($sort, $order)
                ->count();
            $list = $this->model
                ->where($where)
                ->where($this->manger_where)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();
            foreach ($list as $k => $v) {
                if ($v->pid) {
                    $project_info = \app\admin\model\Project::where('id', '=', $v->pid)->find()->toArray();
                    $v->pid = $project_info['name'];
                } else {
                    $v->pid = '无';
                }

                if ($v->zcxm) {
                    $v->zcxm = '<a href="' . $v->zcxm . '">下载链接</a>';
                } else {
                    $v->zcxm = '无';
                }

                if ($v->zjjh) {
                    $v->zjjh = '<a href="' . $v->zjjh . '">下载链接</a>';
                } else {
                    $v->zjjh = '无';
                }

                if ($v->xmjdb) {
                    $v->xmjdb = '<a href="' . $v->xmjdb . '">下载链接</a>';
                } else {
                    $v->xmjdb = '无';
                }

                if ($v->sgjdkz) {
                    $v->sgjdkz = '<a href="' . $v->sgjdkz . '">下载链接</a>';
                } else {
                    $v->sgjdkz = '无';
                }
            }

            $result = array("total" => $total, "rows" => $list);
            return json($result);
        }
        return $this->view->fetch();
    }

    public function getProjectRecordImg($id)
    {
        list($where, $sort, $order, $offset, $limit) = $this->buildparams();
        $total = $this->model
            ->where($where)
            ->where('images', '<>', '')
//            ->where($this->manger_where)
            ->where('pid',$id)
            ->group('FROM_UNIXTIME(createtime,\'%Y-%m-%d\')')
            ->count();
        $res = $this->model
            ->where($where)
//            ->where($this->manger_where)
            ->where('images', '<>', '')
            ->where('pid',$id)
            ->group('FROM_UNIXTIME(createtime,\'%Y-%m-%d\')')
            ->order('createtime', 'desc')
            ->limit($offset, 5)
            ->select();



        $res=collection($res)->toArray();
        $date_arr=$new_arr=[];

        if ($res) {
            foreach ($res as $key => $val) {
                $date_arr[] =date('Y-m-d', $val['createtime']);
            }
            foreach($date_arr as  $kk=>$vv){


                $res2 = $this->model
                    ->where('images', '<>', '')
                    ->where('pid',$id)
                    ->whereBetween('createtime',[strtotime($vv),strtotime($vv)+60*60*24])
                    ->select();

                if($res2){
                    $imgarr=[];
                    foreach($res2 as $vvv){
                        $imgarr=array_merge($imgarr,explode(',',$vvv['images']));
                    }

                }

                $new_arr[$kk]['date']=$vv;
                $new_arr[$kk]['imgs']=$imgarr;
            }

        }




//        if (!empty($date_arr)) {
//            $list = Db::query('select createtime,images from fa_project_record  where images!='' and  and where FROM_UNIXTIME(createtime,\'%Y%m%d\') in (' . implode(',', $date_arr) . ') order by createtime desc');
//        }


//        if (!empty($list)) {
//            foreach ($list as $k => $v) {
//                if ($v['images']) {
//                    if (strstr($v['images'], ',')) {
//                        $images = explode(',', $v['images']);
//                        foreach ($images as $val) {
//                            $pic_list[date('Ymd', $v['createtime'])][] = $val;
//                        }
//                    } else {
//                        $pic_list[date('Ymd', $v['createtime'])][] = $v['images'];
//                    }
//                }
//            }
//
//            $i = 0;
//            foreach ($pic_list as $key => $val) {
//                $pic_list2[$i]['date'] = $key;
//                $pic_list2[$i]['imgs'] = $pic_list[$key];
//                $i++;
//            }
//        }



        if (in_array($this->role_id_1,$this->role_arr)) {
            ProjectRecordLog::updateReadStatus(1, $id);
        }

        $result = array("total" => $total, "rows" => $new_arr);
        return json($result);
    }





    // 文件记录历史
    public function getProjectRecordFile($id)
    {
        $type = $this->request->request("type",'1');
        list($where, $sort, $order, $offset, $limit) = $this->buildparams();

        switch ($type){
            case 1:
                $total = $this->model
                    ->where($where)
//                    ->where($this->manger_where)
                    ->where('pid',$id)
                    ->where('zcxm', '<>', '')
                    ->order('createtime','desc')
                    ->count();
                $list = $this->model
                    ->where($where)
//                    ->where($this->manger_where)
                    ->where('pid',$id)
                    ->where('zcxm', '<>', '')
                    ->order('createtime','desc')
                    ->limit($offset, $limit)
                    ->select();
                foreach ($list as $key => $val) {
                    $val->createtime = date("Y-m-d H:i",$val->createtime);
                }
                $result = array("total" => $total, "rows" => $list);
                if (in_array($this->role_id_1,$this->role_arr)) {
                    ProjectRecordLog::updateReadStatus(2, $id);
                }
                return json($result);
            case 2:
                $total = $this->model
                    ->where($where)
//                    ->where($this->manger_where)
                    ->where('pid',$id)
                    ->where('zjjh', '<>', '')
                    ->order('createtime','desc')
                    ->count();
                $list = $this->model
                    ->where($where)
//                    ->where($this->manger_where)
                    ->where('pid',$id)
                    ->where('zjjh', '<>', '')
                    ->order('createtime','desc')
                    ->limit($offset, $limit)
                    ->select();
                foreach ($list as $key => $val) {
                    $val->createtime = date("Y-m-d H:i",$val->createtime);
                }
                $result = array("total" => $total, "rows" => $list);
                if (in_array($this->role_id_1,$this->role_arr)) {
                    ProjectRecordLog::updateReadStatus(3, $id);
                }
                return json($result);
            case 3:
                $total = $this->model
                    ->where($where)
//                    ->where($this->manger_where)
                    ->where('pid',$id)
                    ->where('sgjdkz', '<>', '')
                    ->order('createtime','desc')
                    ->count();
                $list = $this->model
                    ->where($where)
//                    ->where($this->manger_where)
                    ->where('pid',$id)
                    ->where('sgjdkz', '<>', '')
                    ->order('createtime','desc')
                    ->limit($offset, $limit)
                    ->select();
                foreach ($list as $key => $val) {
                    $val->createtime = date("Y-m-d H:i",$val->createtime);
                }
                $result = array("total" => $total, "rows" => $list);
                // 审核查看权限
                if (in_array($this->role_id_1,$this->role_arr)){
                    ProjectRecordLog::updateReadStatus(4,$id);
                }
                return json($result);

        }
    }
    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                $params = $this->preExcludeFields($params);

//                $res=\app\admin\model\Project::CheckEditAuth($this->auth->id,$params['pid']);
//                if($res){ $this->json_error('暂无权限');}

                $admin= Session::get('admin')   ;
                $user_id=$admin['id'];
                //判断当前账号有没有修改权限
                $res=\app\admin\model\Project::CheckEditAuth($user_id,$params['pid']);
                if(!$res){ $this->json_error([],'暂无权限');}


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



}
