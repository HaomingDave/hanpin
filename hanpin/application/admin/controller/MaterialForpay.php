<?php

namespace app\admin\controller;

use app\admin\model\MaterialApprovalLog;
use app\admin\model\MaterialStage;
use app\common\controller\Backend;
use app\admin\controller\Project;

/**
 * 材料付款单
 *
 * @icon fa fa-circle-o
 */
class MaterialForpay extends Backend
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
    protected $noNeedRight = ['*'];
    protected $noNeedLogin = ['*'];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MaterialForpay;

    }


    /**
     * 查看
     */
    public function index()
    {
            //财务
            $request=$this->request->request();
            if(!$request['pid'] ||!$request['username'])
            {
                $this->json_error('参数有误');
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
//            $total = $this->model->alias('a')
//                ->join("material_approval b",'a.ma_id=b.id')
//                ->where(['b.audit'=>4,'b.pid'=>$request['pid']])
//                ->where($where)
//                ->where($this->manger_where)
//                ->order('a.id', $order)
//                ->field('a.mp_cl_name,a.id,b.audit,b.pid')
//                ->group('ma_id')
//                ->count();
//
//
//
//            $list = $this->model->alias('a')
//                ->join("material_approval b",'a.ma_id=b.id')
//                ->where(['b.audit'=>4,'b.pid'=>$request['pid']])
//                ->where($where)
//                ->where($this->manger_where)
//                ->order('a.id', $order)
//                ->field('a.*,b.audit,b.pid')
//                ->group('ma_id')
//                ->limit($offset, $limit)
//                ->select();

        $materialApprovalModel= new \app\admin\model\MaterialApproval();
        $total = $materialApprovalModel->alias('a')
                ->where(['audit'=>4,'pid'=>$request['pid']])
                ->where($this->manger_where)
                ->order('id', $order)
                ->count();
        $list = $materialApprovalModel
            ->where(['audit'=>4,'pid'=>$request['pid']])
            ->where($this->manger_where)
            ->order('id', $order)
            ->field('*')
            ->limit($offset, $limit)
            ->select();
        $all_wait_pay=0;
        $all_paid=0;

        foreach($list as &$v){
                $stage_lists=(new MaterialStage())->where(['maid'=>$v->id])->find();

                //申请单的材料列表
                $pay_list=(new \app\admin\model\MaterialPurchase())
                            ->where(['ma_id'=>$v->id])
                            ->select();
                $pay_data_list= collection($pay_list)->toArray();

                $v->mp_ghs_id=$pay_data_list[0]['mp_ghs_id']??'';
                $v->mp_ghs_name=$pay_data_list[0]['mp_ghs_name']??'';
                $v->mp_ghs_tel=$pay_data_list[0]['mp_ghs_tel']??'';
                $v->mp_cl_id=$pay_data_list[0]['mp_cl_id']??'';
                $v->mp_cl_name=$pay_data_list[0]['mp_cl_name']??'';
                $v->mp_cl_model=$pay_data_list[0]['mp_cl_model']??'';
                $v->mp_cl_specifications=$pay_data_list[0]['mp_cl_specifications']??'';
                $v->mp_cl_brand=$pay_data_list[0]['mp_cl_brand']??'';

                $mp_cw_total=0;
                foreach($pay_data_list as $vv){
                    $mp_cw_total+=$vv['mp_cw_total'];
                }
                $v->mp_all_money=$mp_cw_total;
                if(!$stage_lists){
                    $v->mp_paid=0;
                    $v->mp_is_paidout=false;
                    $v->mp_to_pay=$mp_cw_total;
                }else{
                    $over_pay=($stage_lists->price1*100)+($stage_lists->price2*100)+($stage_lists->price3*100)+($stage_lists->price4*100)+($stage_lists->price5*100);
                    $v->mp_paid=$over_pay/100;
                    $v->mp_to_pay=($mp_cw_total*100-$over_pay)/100;

                    if($v->mp_to_pay==$v->mp_paid){
                        $v->mp_is_paidout=true;
                    }else{
                        $v->mp_is_paidout=false;
                    }
                }

                 $all_wait_pay+=$v->mp_to_pay;
                 $all_paid+=$v->mp_paid;


            }
            if (in_array($this->role_id_2,$this->role_arr)){
                MaterialApprovalLog::where(['pid'=>$request['pid'],'audit'=>4])->update(['is_read'=>1]);
            }

            $result = array("total" => $total, "rows" => $list,'all_wait_pay'=>$all_wait_pay,'all_paid'=>$all_paid);
            return json($result);
    }

    public function info()
    {
        $ma_id=$this->request->request('maid');
        $row = MaterialStage::where(['maid' => $ma_id])->find();
        $this->json_success($row?:[]);
    }

    /**
     *新增或编辑付款单
     */
    public function edit($ids=null)
    {
        $params=$this->request->request('row/a');
        if(!$params['pid'] || !$params['maid']){
            $this->json_error([],'参数有误');
        }

        $row =  MaterialStage::where(['maid' => $params['maid']])->find();
        $all_pay=($params['price1']?:0)+($params['price2']?:0)+($params['price3']?:0)+($params['price4']?:0)+($params['price5']?:0);
        //获取所以已审核通过的付款单
        $fukuan_list=\app\admin\model\MaterialPurchase::where(['ma_id'=>$params['maid']])->select();
        $need_pay=0;
        foreach($fukuan_list as $key=>$val){
            $need_pay+=$val['mp_cw_total'];
        }

        if($all_pay*100 > ($need_pay*100)){
            $this->json_error([],'超出待付款金额');
        }

        if (!$row){
            $model= new MaterialStage();
            if($params['price1']){
                $params['time1']=date('Y-m-d');
            }
            if($params['price2']){
                $params['time2']=date('Y-m-d');
            }
            if($params['price3']){
                $params['time3']=date('Y-m-d');
            }
            if($params['price4']){
                $params['time4']=date('Y-m-d');
            }
            if($params['price5']){
                $params['time5']=date('Y-m-d');
            }

            //执行新增
            $result =$model->allowField(true)->save($params);
            if(!$result){
                $this->json_error('新增失败');
            }
        }else{
            if(!$row->time1){
                if($params['price1']){
                    $params['time1']=date('Y-m-d');
                }
            }

            if(!$row->time2) {

                if ($params['price2']) {
                    $params['time2'] = date('Y-m-d');
                }
            }
            if(!$row->time3) {

                if ($params['price3']) {
                    $params['time3'] = date('Y-m-d');
                }
            }
            if(!$row->time4) {

                if ($params['price4'] ) {
                    $params['time4'] = date('Y-m-d');
                }
            }
            if(!$row->time5){

                if($params['price5']){
                $params['time5']=date('Y-m-d');
             }

            }

            $result = $row->allowField(true)->validate('MaterialApproval.edit')->save($params);
            if(!$result){
                $this->json_error([],'修改失败');
            }
        }
        $this->json_success([],'操作成功');


    }



}
