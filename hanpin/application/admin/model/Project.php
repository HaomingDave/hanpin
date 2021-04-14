<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class Project extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'project';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'start_time_text',
        'end_time_text',
        'status_text'
    ];
    

    
    public function getStatusList()
    {
        return ['normal' => __('Normal'), 'hidden' => __('Hidden')];
    }


    public function getStartTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['start_time']) ? $data['start_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getEndTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['end_time']) ? $data['end_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    protected function setStartTimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setEndTimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    /**
     * 项目列表
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function getProjectArray($where)
    {
        $list = collection(self::field('id,name')->where(function ($query) {
                $query->where('status', '=', 'normal');
            })->where($where)->order('order', 'desc')->select())->toArray();
        return json(['list' => $list, 'total' => count($list)]);
    }

    public function getSearchProjectArray($where)
    {

        $list = collection(self::field('id, name, start_time, manager')->where(function ($query) {
            $query->where('status', '=', 'normal');
        })->where($where)->order('order', 'desc')->select())->toArray();
        $json = json($list);

        return $json;
    }

    public static function CheckEditAuth($uid,$projectid)
    {
        $data=self::where(['id'=>$projectid])->find();
        if($data['manager']==$uid){return true;}
        $auth_group=AuthGroupAccess::where(['uid'=>$uid,'group_id'=>7])->find();
        if($auth_group){ return true;}
        return false;
    }

}
