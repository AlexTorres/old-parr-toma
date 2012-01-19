<?php
    $actual_row     = 0;
    $actual_column  = 0;

	//input the export file name
	$xls->setHeader('Error_logs_'.date('Y_m_d').'.xls');
	
    $xls->BOF();


    $xls->writeLabel($actual_row, $actual_column, "REASON");
    $actual_column++;
    
    $xls->writeLabel($actual_row, $actual_column, "POST DATA");
    $actual_column++;
    
    $xls->writeLabel($actual_row, $actual_column, "CLIENT IP");
    $actual_column++;
    
    $xls->writeLabel($actual_row, $actual_column, "CREATED");

    $actual_row++;

    foreach ($logs as $log){
        $actual_column = 0;

        $xls->writeLabel($actual_row, $actual_column, $log['Elog']['reason']);
        $actual_column++;
        
        $xls->writeLabel($actual_row, $actual_column, rawurldecode($log['Elog']['post_data']));
        $actual_column++;
        
        $xls->writeLabel($actual_row, $actual_column, $log['Elog']['ip']);
        $actual_column++;
        
        $xls->writeLabel($actual_row, $actual_column, $log['Elog']['created']);
        $actual_column++;

        $actual_row++;

    }

    $xls->EOF();
    exit();
?> 
