<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;
use think\Cache;

class Material extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'material';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'status_text'
    ];
    

    
    public function getStatusList()
    {
        return ['normal' => __('Normal'), 'hidden' => __('Hidden')];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    /**
     * 材料列表
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function getMaterialArray()
    {
        $json = Cache::get("materialList");
        if ($json === false) {
            $list = collection(self::field('id,name')->where(function ($query) {
                $query->where('status', '=', 'normal');
            })->order('order', 'desc')->select())->toArray();
            $json = json($list);
            Cache::set("materialList", $list, 6000);
        }
        return $json;
    }


}
