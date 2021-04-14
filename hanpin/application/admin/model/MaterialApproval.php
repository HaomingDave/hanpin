<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class MaterialApproval extends Model
{

    use SoftDelete;

    // 表名
    protected $name = 'material_approval';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'audit_time_text',
        'status_text',
        'reaudit_time_text',
        'createtime_text',
        'applicant_time_text'
    ];

    //修改
    protected static function init()
    {
        self::afterUpdate(function ($row) {
            if($row->audit==1 || $row->audit==2){
                (new MaterialApprovalLog)->insert([
                   'audit'=>$row->audit,
                    'pid'=>$row->pid,
                    'material_approval_id'=>$row->id
                ]);
            }



        });

    }


    public function getStatusList()
    {
        return ['normal' => __('Normal'), 'hidden' => __('Hidden')];
    }

    public function getAuditList()
    {
        return ['1' => '审核成功', '3' => '审核不通过'];
    }


    public function getAuditTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['audit_time']) ? $data['audit_time'] : '');
        return is_numeric($value) && $value != 0 ? date("Y-m-d H:i:s", $value) : '无';
    }

    public function getCreatetimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['createtime']) ? $data['createtime'] : '');
        return is_numeric($value) && $value != 0 ? date("Y-m-d H:i:s", $value) : '无';
    }

    public function getReauditTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['reaudit_time']) ? $data['reaudit_time'] : '');
        return is_numeric($value) && $value != 0 ? date("Y-m-d H:i:s", $value) : '无';
    }

    public function getApplicantTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['applicant_time']) ? $data['applicant_time'] : '');
        return is_numeric($value) && $value != 0 ? date("Y-m-d H:i:s", $value) : '无';
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    protected function setAuditTimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }


}
