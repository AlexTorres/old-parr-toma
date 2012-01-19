<?php
    $actual_row     = 0;
    $actual_column  = 0;

	//input the export file name
	$xls->setHeader('Access_logs_'.date('Y_m_d').'.xls');
	
    $xls->BOF();


    $xls->writeLabel($actual_row, $actual_column, "USER NAME");
    $actual_column++;
    
    $xls->writeLabel($actual_row, $actual_column, "EMAIL");
    $actual_column++;
   
    $xls->writeLabel($actual_row, $actual_column, "FACEBOOK ID");
    $actual_column++;

    $xls->writeLabel($actual_row, $actual_column, "CITY");
    $actual_column++;

    $xls->writeLabel($actual_row, $actual_column, "SEX");
    $actual_column++;

    $xls->writeLabel($actual_row, $actual_column, "BIRTH DATE");
    $actual_column++;
    
    $xls->writeLabel($actual_row, $actual_column, "POST DATA");
    $actual_column++;
    
    $xls->writeLabel($actual_row, $actual_column, "CLIENT IP");
    $actual_column++;
    
    $xls->writeLabel($actual_row, $actual_column, "CREATED");

    $actual_row++;

    foreach ($logs as $log){
        $actual_column = 0;

        $xls->writeLabel($actual_row, $actual_column, $log['User']['name']);
        $actual_column++;

        $xls->writeLabel($actual_row, $actual_column, $log['User']['email']);
        $actual_column++;

        $xls->writeLabel($actual_row, $actual_column, $log['User']['facebookid']);
        $actual_column++;

        $xls->writeLabel($actual_row, $actual_column, $log['User']['current_city']);
        $actual_column++;

        $xls->writeLabel($actual_row, $actual_column, $log['User']['sex']);
        $actual_column++;
        
        $xls->writeLabel($actual_row, $actual_column, $log['User']['birth_date']);
        $actual_column++;

        $xls->writeLabel($actual_row, $actual_column, rawurldecode($log['Alog']['post_data']));
        $actual_column++;
        
        $xls->writeLabel($actual_row, $actual_column, $log['Alog']['ip']);
        $actual_column++;
        
        $xls->writeLabel($actual_row, $actual_column, $log['Alog']['created']);
        $actual_column++;

        $actual_row++;

    }

    $xls->EOF();
    exit();
?> 
