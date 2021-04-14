<?php

namespace app\admin\model;

use think\Cache;
use think\Model;
use traits\model\SoftDelete;

class ProjectRecordLog extends Model
{

    // 表名
    protected $name = 'project_record_log';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;


    public  static function updateReadStatus($type,$pid)
    {
        return self::where(['pid'=>$pid,'type'=>$type])->update(['is_read'=>1]);
    }







}
