<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Book extends CI_Controller {
        public function __construct()
        {
                parent::__construct();
                $this->load->model('book_model');
        }
	public function index()
	{
		echo json_encode($this->book_model->get_page(),JSON_UNESCAPED_UNICODE);
	}
	public function single($id)
	{
		echo json_encode($this->book_model->get_page($id),JSON_UNESCAPED_UNICODE);
	}
}
