<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class ProjectCheck extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'project_check';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'sgtxgt_text',
        'sgjdb_text',
        'sgzcwd_text',
        'gywd_text',
        'sxgcl_text',
        'clxyzb_text',
        'ysfwhgcl_text',
        'wmsdqz_text'
    ];
    

    
    public function getSgtxgtList()
    {
        return ['是' => __('是'), '否' => __('否')];
    }

    public function getSgjdbList()
    {
        return ['是' => __('是'), '否' => __('否')];
    }

    public function getSgzcwdList()
    {
        return ['是' => __('是'), '否' => __('否')];
    }

    public function getGywdList()
    {
        return ['是' => __('是'), '否' => __('否')];
    }

    public function getSxgclList()
    {
        return ['是' => __('是'), '否' => __('否')];
    }

    public function getClxyzbList()
    {
        return ['是' => __('是'), '否' => __('否')];
    }

    public function getYsfwhgclList()
    {
        return ['是' => __('是'), '否' => __('否')];
    }

    public function getWmsdqzList()
    {
        return ['是' => __('是'), '否' => __('否')];
    }


    public function getSgtxgtTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['sgtxgt']) ? $data['sgtxgt'] : '');
        $list = $this->getSgtxgtList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getSgjdbTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['sgjdb']) ? $data['sgjdb'] : '');
        $list = $this->getSgjdbList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getSgzcwdTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['sgzcwd']) ? $data['sgzcwd'] : '');
        $list = $this->getSgzcwdList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getGywdTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['gywd']) ? $data['gywd'] : '');
        $list = $this->getGywdList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getSxgclTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['sxgcl']) ? $data['sxgcl'] : '');
        $list = $this->getSxgclList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getClxyzbTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['clxyzb']) ? $data['clxyzb'] : '');
        $list = $this->getClxyzbList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getYsfwhgclTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['ysfwhgcl']) ? $data['ysfwhgcl'] : '');
        $list = $this->getYsfwhgclList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getWmsdqzTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['wmsdqz']) ? $data['wmsdqz'] : '');
        $list = $this->getWmsdqzList();
        return isset($list[$value]) ? $list[$value] : '';
    }




}
