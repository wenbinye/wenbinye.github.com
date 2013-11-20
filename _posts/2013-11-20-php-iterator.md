---
layout: post
title: PHP Iterator 示例
tags: 
- php
---

一个简单的例子说明 Iterator 各方法：

    class MyIterator implements Iterator
    {
        public $data = array(1, 2);
        private $pos;
        
        function rewind()
        {
            error_log("method ".__FUNCTION__." called");
            $this->pos = 0;
        }
        
        function current()
        {
            error_log("method ".__FUNCTION__." called");
            return $this->data[$this->pos];
        }
        
        function key()
        {
            error_log("method ".__FUNCTION__." called");
            return $this->pos;
        }
        
        function next()
        {
            error_log("method ".__FUNCTION__." called");
            $this->pos++;
        }
        
        function valid()
        {
            error_log("method ".__FUNCTION__." called");
            return isset($this->data[$this->pos]);
        }
    }
    
    $it = new MyIterator;
    foreach ( $it as $key => $val ) {
        echo "key = $key, val=$val \n";
    }

代码输出：

    method rewind called
    method valid called
    method current called
    method key called
    key = 0, val=1 
    method next called
    method valid called
    method current called
    method key called
    key = 1, val=2 
    method next called
    method valid called

总结：
- rewind 用于初始化迭代器
- valid 在 rewind 和 next 之后调用，current 之前调用
- current 用于获取当前值
- key 用于获取当前 key
- next 用于获取下个值
