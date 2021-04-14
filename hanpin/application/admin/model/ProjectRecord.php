<?php

namespace app\admin\model;

use think\Cache;
use think\Model;
use traits\model\SoftDelete;

class ProjectRecord extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'project_record';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [

    ];


    protected static function init()
    {
        self::afterInsert(function ($row) {
            $type=0;
            if($row->images){$type=1;}
            if($row->zcxm){$type=2;}
            if($row->zjjh){$type=3;}
            if($row->sgjdkz){$type=4;}
              (new ProjectRecordLog)->save([
                  'project_record_id'=>$row->id,
                  'type'=>$type,
                  'pid'=>$row->pid,
              ]);
        });

    }
    







}
