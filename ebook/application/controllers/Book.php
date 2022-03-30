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
		echo json_encode($this->book_model->get_book(),JSON_UNESCAPED_UNICODE);
	}
	public function single($id)
	{
		echo json_encode($this->book_model->get_book($id),JSON_UNESCAPED_UNICODE);
	}
	public function add()
	{
		$data = array(
	                'title' => $this->input->post('title'),
	                'description' => $this->input->post('description'),
	                'file_path' => $this->input->post('file_path'),
	                'views' => 0,
	            );
		echo json_encode($this->book_model->add(),JSON_UNESCAPED_UNICODE);
	}
}