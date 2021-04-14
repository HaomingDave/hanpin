<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class MaterialPurchase extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'material_purchase';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'mp_applicant_time_text',
        'mp_audit_time_text',
        'mp_fh_time_text',
        'mp_sh_time_text',
        'mp_cwqr_time_text',
        'createtime_text',
    ];


    public function getMpApplicantTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['mp_applicant_time']) ? $data['mp_applicant_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getMpAuditTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['mp_audit_time']) ? $data['mp_audit_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getMpFhTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['mp_fh_time']) ? $data['mp_fh_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    public function getMpShTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['mp_sh_time']) ? $data['mp_sh_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }
    public function getCreatetimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['createtime']) ? $data['createtime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    public function getMpCwqrTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['mp_cwqr_time']) ? $data['mp_cwqr_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setMpApplicantTimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setMpAuditTimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setMpFhTimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setMpShTimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setMpCwqrTimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    public function getfhrqrList()
    {
        return ['Y' => '是', 'N' => '否'];
    }


}
