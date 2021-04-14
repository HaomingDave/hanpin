<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class MaterialStage extends Model
{

    // 表名
    protected $name = 'material_stage';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;


//    public function setTime1Attr($value,$row)
//    {
//        if(!$value  && $row['price1']){
//            return date('Y-m-d');
//        }else{
//            return $value;
//        }
//
//    }
//
//
//    public function setTime2Attr($value,$row)
//    {
//        if(!$value  && $row['price2']){
//            return date('Y-m-d');
//        }else{
//            return $value;
//        }
//
//    }
//
//    public function setTime3Attr($value,$row)
//    {
//        if(!$value  && $row['price3']){
//            return date('Y-m-d');
//        }else{
//            return $value;
//        }
//
//    }
//
//    public function setTime4Attr($value,$row)
//    {
//        if(!$value  && $row['price4']){
//            return date('Y-m-d');
//        }else{
//            return $value;
//        }
//
//    }
//
//    public function setTime5Attr($value,$row)
//    {
//        if(!$value  && $row['price1']){
//            return date('Y-m-d');
//        }else{
//            return $value;
//        }
//
//    }


}
