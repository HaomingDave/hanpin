<?php

namespace app\admin\controller;

use app\admin\model\Admin;
use app\admin\model\AdminLog;
use app\admin\model\AuthGroupAccess;
use app\admin\model\MaterialApprovalLog;
use app\admin\model\ProjectRecordLog;
use app\common\controller\Backend;
use think\Config;
use think\Hook;
use think\Request;
use think\Validate;


class newMsg extends Backend
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];
    protected $layout = '';



    public function index()
    {
        $pid=$this->request->request('pid',0);
        $username=$this->request->request('username','');
        if(!$pid || !$username){
            $this->json_error([],'参数有误');
        }
        $return_key=[
            'hasNewPics'=>false, //图片记录
            'hasNewZcxm'=>false, //自查记录
            'hasNewZjjh'=>false,  //计划安排
            'hasNewSgjdkz'=>false, //施工节点控制
            'hasNewUnAudit'=>false, //未审核
        ];

        //判断用户身份
        $userinfo=Admin::where(['username'=>$username])->find();
        if(!$userinfo){
            $this->json_success($return_key);
        }

        $auth=AuthGroupAccess::where(['uid'=>$userinfo['id']])->column('group_id');
        if(!$auth || !in_array(7,$auth)){
            $this->json_success($return_key);
        }

        $is_have=ProjectRecordLog::where(['pid'=>$pid,'is_read'=>0])
            ->group('type')->select();
        $is_have=collection($is_have)->toArray();

        if($is_have){
            $val_lists=array_column($is_have,'type');
            foreach($val_lists as $v) {
                switch ($v) {
                    case 1:
                        $return_key['hasNewPics'] = true;
                        break;
                    case 2:
                        $return_key['hasNewZcxm'] = true;
                        break;
                    case 3:
                        $return_key['hasNewZjjh'] = true;
                        break;
                    case 4:
                        $return_key['hasNewSgjdkz'] = true;
                        break;

                }
            }
        }
        //审核人
        if(in_array(7,$auth)){
            //查看审核日志表
           $res= MaterialApprovalLog::where(['pid'=>$pid,'is_read'=>0,'audit'=>2])->find();
            if($res){
                $return_key['hasNewUnAudit']=true;
            }
        }
        if(in_array(8,$auth)){
            //查看待复核
           $res= MaterialApprovalLog::where(['pid'=>$pid,'is_read'=>0,'audit'=>1])->select();
            if($res){
                $return_key['hasNewUnAudit']=true;
            }
        }

        $this->json_success($return_key);



    }


}
