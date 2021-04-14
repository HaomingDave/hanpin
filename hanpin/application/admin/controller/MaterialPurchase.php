<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use think\Session;

/**
 * 材料采购
 *
 * @icon fa fa-circle-o
 */
class MaterialPurchase extends Backend
{

    /**
     * MaterialPurchase模型对象
     * @var \app\admin\model\MaterialPurchase
     */
    protected $model = null;

    protected $goods_input_arr = [1, 6];  // 修改允许权限

    /**
     * 无需鉴权的方法,但需要登录
     * @var array
     */
    protected $noNeedRight = ['getTypeList', 'indexAjax'];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MaterialPurchase;
        $this->view->assign("fhrqrList", $this->model->getfhrqrList());
    }

    /**
     * 查看
     */
    public function index($ids = null)
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }

            $where2 = [];
            if ($ids) {
                $where2['ma_id'] = ['=', $ids];
            }

            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $total = $this->model
                ->where($where)
                ->where($where2)
                ->order($sort, $order)
                ->count();
            $list = $this->model
                ->where($where)
                ->where($where2)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();
            foreach ($list as $k => $v) {
                $v->mp_type_cn = config('site.project_type')[$v->mp_type_cn];
                $ghs = \app\admin\model\Supplier::where('id', '=', $v->mp_ghs_id)->find()->toArray();

                $v->ghs_name = '';
                $v->ghs_tel = '';
                if (isset($ghs) && !empty($ghs)) {
                    $v->ghs_name = $ghs['name'];
                    $v->ghs_tel = $ghs['mobile'];
                }

                if ($v->mp_fhrqr == 'Y') {
                    $v->mp_fhrqr = '<span class="green">是</span>';
                } else {
                    $v->mp_fhrqr = '<span class="red">否</span>';
                }

                if ($v->mp_cwqr == 'Y') {
                    $v->mp_cwqr = '<span class="green">是</span>';
                } else {
                    $v->mp_cwqr = '<span class="red">否</span>';
                }

//                $material = \app\admin\model\Material::where('id', '=', $v->mp_cl_id)->find()->toArray();
//
//                $v->material_name = '';
//                $v->material_model = '';
//                $v->material_specifications = '';
//                $v->material_brand = '';
//                if (isset($material) && !empty($material)) {
//                    $v->material_name = $material['name'];
//                    $v->material_model = $material['model'];
//                    $v->material_specifications = $material['specifications'];
//                    $v->material_brand = $material['brand'];
//                }

//                if ($v->mp_cw_budget_quantity > 0) {
//                    $v->mp_budget_quantity = '<span class="red">' . $v->mp_cw_budget_quantity . '</span>';
//                }
//
//                if ($v->mp_cw_purchased_quantity > 0) {
//                    $v->mp_purchased_quantity = '<span class="red">' . $v->mp_cw_purchased_quantity . '</span>';
//                }
//
//                if ($v->mp_cw_sq_quantity > 0) {
//                    $v->mp_sq_quantity = '<span class="red">' . $v->mp_cw_sq_quantity . '</span>';
//                }
//
//                if ($v->mp_cw_unit > 0) {
//                    $v->mp_unit = '<span class="red">' . $v->mp_cw_unit . '</span>';
//                }
//
//                if ($v->mp_cw_total > 0) {
//                    $v->mp_total = '<span class="red">' . $v->mp_cw_total . '</span>';
//                }

            }

            $result = array("total" => $total, "rows" => $list);
            return json($result);
        }
        return $this->view->fetch();
    }

    public function indexAjax($ids = null)
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        //如果发送的来源是Selectpage，则转发到Selectpage
        if ($this->request->request('keyField')) {
            return $this->selectpage();
        }

        $where2 = [];
        if ($ids) {
            $where2['ma_id'] = ['=', $ids];
        }

        list($where, $sort, $order, $offset, $limit) = $this->buildparams();
        $total = $this->model
            ->where($where)
            ->where($where2)
            ->order($sort, $order)
            ->count();
        $list = $this->model
            ->where($where)
            ->where($where2)
            ->order($sort, $order)
            ->limit($offset, $limit)
            ->select();
        foreach ($list as $k => $v) {
//            $v->mp_type_cn = config('site.project_type')[$v->mp_type_cn];
//            $ghs = \app\admin\model\Supplier::where('id', '=', $v->mp_ghs_id)->find()->toArray();
//
//            $v->ghs_name = '';
//            $v->ghs_tel = '';
//            if (isset($ghs) && !empty($ghs)) {
//                $v->ghs_name = $ghs['name'];
//                $v->ghs_tel = $ghs['mobile'];
//            }

            if ($v->mp_fhrqr == 'Y') {
                $v->mp_fhrqr = '<span class="green">是</span>';
            } else {
                $v->mp_fhrqr = '<span class="red">否</span>';
            }

            if ($v->mp_cwqr == 'Y') {
                $v->mp_cwqr = '<span class="green">是</span>';
            } else {
                $v->mp_cwqr = '<span class="red">否</span>';
            }

//                $material = \app\admin\model\Material::where('id', '=', $v->mp_cl_id)->find()->toArray();
//
//                $v->material_name = '';
//                $v->material_model = '';
//                $v->material_specifications = '';
//                $v->material_brand = '';
//                if (isset($material) && !empty($material)) {
//                    $v->material_name = $material['name'];
//                    $v->material_model = $material['model'];
//                    $v->material_specifications = $material['specifications'];
//                    $v->material_brand = $material['brand'];
//                }

//            if ($v->mp_cw_budget_quantity > 0) {
//                $v->mp_budget_quantity = '<span class="red">' . $v->mp_cw_budget_quantity . '</span>';
//            }
//
//            if ($v->mp_cw_purchased_quantity > 0) {
//                $v->mp_purchased_quantity = '<span class="red">' . $v->mp_cw_purchased_quantity . '</span>';
//            }
//
//            if ($v->mp_cw_sq_quantity > 0) {
//                $v->mp_sq_quantity = '<span class="red">' . $v->mp_cw_sq_quantity . '</span>';
//            }
//
//            if ($v->mp_cw_unit > 0) {
//                $v->mp_unit = '<span class="red">' . $v->mp_cw_unit . '</span>';
//            }
//
//            if ($v->mp_cw_total > 0) {
//                $v->mp_total = '<span class="red">' . $v->mp_cw_total . '</span>';
//            }

        }

        $result = array("total" => $total, "rows" => $list);
        return json($result);

        return $this->view->fetch();
    }
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */

    public function getTypeList()
    {
        //主键值
        $primaryvalue = $this->request->request("keyValue");

        $typeList = config('site.project_type');
        $result = [];
        if($primaryvalue !== null){
            $result[0]['id'] = $primaryvalue;
            $result[0]['name'] = $typeList[$primaryvalue];
        }else{
            $i = 0;
            foreach ($typeList as $k => &$v) {
                $result[$i]['id'] = $k;
                $result[$i]['name'] = $v;
                $i++;
            }
        }
        return json(['list' => $result, 'total' => count($result)]);
    }

    /**
     * 添加
     */
    public function add()
    {
        $mid = $this->request->get("mid");
        if (empty($mid)) {
            $this->error('采购单ID不能为空');
        }

        $materialApproval = \app\admin\model\MaterialApproval::where(array('id' => $mid, 'status' => 'normal'))->find();
        if (empty($materialApproval)) {
            $this->error('采购单不存在');
        }

        if ($materialApproval->audit == 1) {
            $this->error('采购单已审核通过 不允许再添加采购记录');
        }

        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");

//            $admin= Session::get('admin');
//            $user_id=$admin['id'];
//            //判断当前账号有没有修改权限
//            $res=\app\admin\model\Project::CheckEditAuth($user_id,$params['pid']);
//            if(!$res){ $this->json_error([],'暂无权限');}


            if ($params) {
                $params['ma_id'] = $mid;
                $result = $this->model->validate('MaterialPurchase.add')->save($params);
                if ($result === false) {
                    $this->error($this->model->getError());
                }
                $this->success();
            }
            $this->error();
        }
        $this->view->assign("mid", $mid);
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
        $material_approval = \app\admin\model\MaterialApproval::where('id', '=', intval($row->ma_id))->find();
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                if (in_array($this->role_id_2, $this->role_arr)) {
                    if ($material_approval && $material_approval->audit != 1) {
                        $this->error('该采购单还未审核通过, 您无权限修改');
                    }

                    $params['mp_cw_budget_quantity'] = $params['mp_budget_quantity'];
                    $params['mp_cw_purchased_quantity'] = $params['mp_purchased_quantity'];
                    $params['mp_cw_sq_quantity'] = $params['mp_sq_quantity'];
                    $params['mp_cw_unit'] = $params['mp_unit'];
                    $params['mp_cw_total'] = $params['mp_total'];
                    $params['mp_cwqr_time'] = time();
                    $params['mp_cwqr_id'] = $this->auth->id;
                } else {
                    unset($params['mp_cwqr']);
                }

                $result = $row->allowField(true)->validate('MaterialPurchase.edit')->save($params);
                if ($result === false) {
                    $this->error($row->getError());
                }
                $this->success();
            }

            $this->error();
        }
        $this->view->assign("row", $row);

        // DOM input置灰
        $input_disabled = true;

        // DOM 发货收货开关
        $goods_disabled = true;

        // DOM 财务确认按钮开关
        $cwqr_buttons_show = false;

        if (array_intersect($this->role_arr, $this->input_arr)) {
            if ($material_approval && $material_approval->audit == 1) {
                $input_disabled = true;
            } else {
                $input_disabled = false;
            }
        }

        // 权限控制
        if ($material_approval && $material_approval->audit == 1 && in_array($this->role_id_2, $this->role_arr)) {
            $cwqr_buttons_show = true;
            $input_disabled = false;
        }


        if ($material_approval && $material_approval->audit == 1 && array_intersect($this->role_arr, $this->goods_input_arr)) {
            $goods_disabled = false;
        }

        $this->view->assign("input_disabled", $input_disabled);
        $this->view->assign("cwqr_buttons_show", $cwqr_buttons_show);
        $this->view->assign("goods_disabled", $goods_disabled);
        return $this->view->fetch();
    }
}
