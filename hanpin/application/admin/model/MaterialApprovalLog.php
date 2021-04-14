<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class MaterialApprovalLog extends Model
{


    // 表名
    protected $name = 'material_approval_log';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;


}
