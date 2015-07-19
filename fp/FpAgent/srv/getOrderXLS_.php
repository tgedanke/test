<?php
	require_once 'Excel/PHPExcel.php';

    include 'dbConnect.php';

    require_once 'Excel/PHPExcel/Writer/Excel5.php';
	


$ordnum = $_REQUEST['ordnum']; 
$query = "exec wwwExportAgOrder @ordnum={$ordnum}";
$result=mssql_query($query);




 
 
// Creating a workbook
$workbook = new PHPExcel();

// sending HTTP headers
//$workbook->send('заказ Флиппост №'.$ordnum.'.xls');

// Creating a worksheet
//$worksheet =& $workbook->addWorksheet('заказ Флиппост №'.$ordnum);

// Устанавливаем индекс активного листа
$workbook->setActiveSheetIndex(0);
// Получаем активный лист
$worksheet = $workbook->getActiveSheet();

$worksheet->setTitle('заказ Флиппост №'/*.$ordnum*/);

 //$worksheet->setCellValueByColumnAndRow(0, 1, 'Отправитель'); // Добавляем в ячейку A1 слово "Hello"

 


//формат

$worksheet->getColumnDimension('A')->setWidth(20);// устанавливает столбцу ширину
$worksheet->getColumnDimension('B')->setWidth(40);
$worksheet->getColumnDimension('C')->setWidth(20);// устанавливает столбцу ширину
$worksheet->getColumnDimension('D')->setWidth(40);
$worksheet->getRowDimension(1)->setRowHeight(20);//  устанавливает строке высоту
$worksheet->getRowDimension(13)->setRowHeight(45);
$worksheet->getStyle('A13')->getAlignment()->setWrapText(true);


function setCellStyle($sheet, $cell, $fill){
$sheet->getStyle($cell)->getBorders()->getTop()->setBorderStyle(PHPExcel_Style_Border::BORDER_MEDIUM);
$sheet->getStyle($cell)->getBorders()->getTop()->getColor()->setRGB('CCCCFF');
$sheet->getStyle($cell)->getBorders()->getLeft()->setBorderStyle(PHPExcel_Style_Border::BORDER_MEDIUM);
$sheet->getStyle($cell)->getBorders()->getLeft()->getColor()->setRGB('CCCCFF');
$sheet->getStyle($cell)->getBorders()->getRight()->setBorderStyle(PHPExcel_Style_Border::BORDER_MEDIUM);
$sheet->getStyle($cell)->getBorders()->getRight()->getColor()->setRGB('CCCCFF');
$sheet->getStyle($cell)->getBorders()->getBottom()->setBorderStyle(PHPExcel_Style_Border::BORDER_MEDIUM);
$sheet->getStyle($cell)->getBorders()->getBottom()->getColor()->setRGB('CCCCFF');
if ($fill==1){
$sheet->getStyle($cell)->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
$sheet->getStyle($cell)->getFill()->getStartColor()->setRGB('0066CC');
}
}
setCellStyle($worksheet, 'A2', 1);
setCellStyle($worksheet, 'B2', 1);
setCellStyle($worksheet, 'C2', 1);
setCellStyle($worksheet, 'D2', 1);

setCellStyle($worksheet, 'A3', 1);
setCellStyle($worksheet, 'A4', 1);
setCellStyle($worksheet, 'A5', 1);
setCellStyle($worksheet, 'A6', 1);
setCellStyle($worksheet, 'A7', 1);
setCellStyle($worksheet, 'A8', 1);
setCellStyle($worksheet, 'A9', 1);
setCellStyle($worksheet, 'A10', 1);

setCellStyle($worksheet, 'C3', 1);
setCellStyle($worksheet, 'C4', 1);
setCellStyle($worksheet, 'C5', 1);
setCellStyle($worksheet, 'C6', 1);
setCellStyle($worksheet, 'C7', 1);
setCellStyle($worksheet, 'C8', 1);
setCellStyle($worksheet, 'C9', 1);
setCellStyle($worksheet, 'C10', 1);

setCellStyle($worksheet, 'A12', 1);
setCellStyle($worksheet, 'B12', 1);
setCellStyle($worksheet, 'C12', 1);
setCellStyle($worksheet, 'D12', 1);

setCellStyle($worksheet, 'A15', 1);
setCellStyle($worksheet, 'B15', 1);
setCellStyle($worksheet, 'C15', 1);
setCellStyle($worksheet, 'D15', 1);

setCellStyle($worksheet, 'A16', 1);
setCellStyle($worksheet, 'B16', 1);
setCellStyle($worksheet, 'C16', 1);
setCellStyle($worksheet, 'D16', 1);

setCellStyle($worksheet, 'A19', 1);
setCellStyle($worksheet, 'B19', 1);
setCellStyle($worksheet, 'C19', 1);

setCellStyle($worksheet, 'A20', 1);
setCellStyle($worksheet, 'B20', 1);
setCellStyle($worksheet, 'C20', 1);

setCellStyle($worksheet, 'A23', 1);
setCellStyle($worksheet, 'B23', 1);
setCellStyle($worksheet, 'C23', 1);

setCellStyle($worksheet, 'A24', 1);
setCellStyle($worksheet, 'B24', 1);
setCellStyle($worksheet, 'C24', 1);

setCellStyle($worksheet, 'A27', 1);
setCellStyle($worksheet, 'B27', 1);
setCellStyle($worksheet, 'C27', 1);
setCellStyle($worksheet, 'D27', 1);

setCellStyle($worksheet, 'A28', 1);
setCellStyle($worksheet, 'B28', 1);
setCellStyle($worksheet, 'C28', 1);
setCellStyle($worksheet, 'D28', 1);

setCellStyle($worksheet, 'B3', 0);
setCellStyle($worksheet, 'B4', 0);
setCellStyle($worksheet, 'B5', 0);
setCellStyle($worksheet, 'B6', 0);
setCellStyle($worksheet, 'B7', 0);
setCellStyle($worksheet, 'B8', 0);
setCellStyle($worksheet, 'B9', 0);
setCellStyle($worksheet, 'B10', 0);

setCellStyle($worksheet, 'D3', 0);
setCellStyle($worksheet, 'D4', 0);
setCellStyle($worksheet, 'D5', 0);
setCellStyle($worksheet, 'D6', 0);
setCellStyle($worksheet, 'D7', 0);
setCellStyle($worksheet, 'D8', 0);
setCellStyle($worksheet, 'D9', 0);
setCellStyle($worksheet, 'D10', 0);

setCellStyle($worksheet, 'A13', 0);
setCellStyle($worksheet, 'B13', 0);
setCellStyle($worksheet, 'C13', 0);
setCellStyle($worksheet, 'D13', 0);

setCellStyle($worksheet, 'A17', 0);
setCellStyle($worksheet, 'B17', 0);
setCellStyle($worksheet, 'C17', 0);
setCellStyle($worksheet, 'D17', 0);

setCellStyle($worksheet, 'A21', 0);
setCellStyle($worksheet, 'B21', 0);
setCellStyle($worksheet, 'C21', 0);

setCellStyle($worksheet, 'A25', 0);
setCellStyle($worksheet, 'B25', 0);
setCellStyle($worksheet, 'C25', 0);

setCellStyle($worksheet, 'A29', 0);
setCellStyle($worksheet, 'B29', 0);
setCellStyle($worksheet, 'C29', 0);
setCellStyle($worksheet, 'D29', 0);
/*$format_title =& $workbook->addFormat();
$format_title->setBold();
$format_title->setColor('white'); 
$format_title->setFgColor(23+7);
$format_title->setAlign('center'); 
$format_title->setBorder(1);
$format_title->setBorderColor(17+7);

$format_data =& $workbook->addFormat();
$format_data->setBorder(1);
$format_data->setBorderColor(17+7);

$format_default =& $workbook->addFormat();
$format_default->setBorder(1);
$format_default->setBorderColor(17+7);
$format_default->setTextWrap(1);

$format_page =& $workbook->addFormat();
$format_page->setBold();
$format_page->setAlign('center');

$worksheet->setColumn ( 0 , 0 , 20 );
$worksheet->setColumn ( 1 , 1 , 40 );
$worksheet->setColumn ( 2 , 2 , 20 );
$worksheet->setColumn ( 3 , 3 , 40 );

$worksheet->setRow ( 0, 20);
$worksheet->setRow ( 12, 45);*/

//пишем заголовки

$row = mssql_fetch_array($result, MSSQL_ASSOC);



$worksheet->mergeCells('A1:D1');
$worksheet->setCellValueByColumnAndRow(0, 1, 'Ангентский заказ №'.$ordnum);

$worksheet->mergeCells('A2:B2');
$worksheet->setCellValueByColumnAndRow(0, 2, 'Отправитель');//y,x,value
//$worksheet->setCellValueByColumnAndRow(1, 2, null);

$worksheet->setCellValueByColumnAndRow(0, 3, 'ORG');
$worksheet->setCellValueByColumnAndRow(1, 3, $row['org']);


$worksheet->setCellValueByColumnAndRow(0, 4, 'Город');
$worksheet->setCellValueByColumnAndRow(1, 4, iconv("windows-1251", "UTF-8", $row['orgcity']));

$worksheet->setCellValueByColumnAndRow(0, 5, 'Отправитель');
$worksheet->setCellValueByColumnAndRow(1, 5, iconv("windows-1251", "UTF-8", $row['cname']));

$worksheet->setCellValueByColumnAndRow(0, 6, 'Адрес');
$worksheet->setCellValueByColumnAndRow(1, 6, iconv("windows-1251", "UTF-8", $row['address']));

$worksheet->setCellValueByColumnAndRow(0, 7, 'Контакт');
$worksheet->setCellValueByColumnAndRow(1, 7, iconv("windows-1251", "UTF-8", $row['contname']));

$worksheet->setCellValueByColumnAndRow(0, 8, 'Телефон');
$worksheet->setCellValueByColumnAndRow(1, 8, iconv("windows-1251", "UTF-8", $row['contphone']));

$worksheet->setCellValueByColumnAndRow(0, 9, 'E-Mail');
$worksheet->setCellValueByColumnAndRow(1, 9, iconv("windows-1251", "UTF-8", $row['contmail']));

$worksheet->setCellValueByColumnAndRow(0, 10, 'Факс');
$worksheet->setCellValueByColumnAndRow(1, 10, iconv("windows-1251", "UTF-8", $row['contfax']));

$worksheet->mergeCells('A12:B12');
$worksheet->setCellValueByColumnAndRow(0, 12, 'Примечание');


$worksheet->mergeCells('A13:B13');
$worksheet->setCellValueByColumnAndRow(0, 13, iconv("windows-1251", "UTF-8", $row['orgrems']));


$worksheet->mergeCells('C2:D2');
$worksheet->setCellValueByColumnAndRow(2, 2, 'Получатель');


$worksheet->setCellValueByColumnAndRow(2, 3, 'DEST');
$worksheet->setCellValueByColumnAndRow(3, 3, $row['dest']);

$worksheet->setCellValueByColumnAndRow(2, 4, 'Город');
$worksheet->setCellValueByColumnAndRow(3, 4, iconv("windows-1251", "UTF-8", $row['destcity']));

$worksheet->setCellValueByColumnAndRow(2, 5, 'Отправитель');
$worksheet->setCellValueByColumnAndRow(3, 5, iconv("windows-1251", "UTF-8", $row['dname']));

$worksheet->setCellValueByColumnAndRow(2, 6, 'Адрес');
$worksheet->setCellValueByColumnAndRow(3, 6, iconv("windows-1251", "UTF-8", $row['dadr']));

$worksheet->setCellValueByColumnAndRow(2, 7, 'Контакт');
$worksheet->setCellValueByColumnAndRow(3, 7, iconv("windows-1251", "UTF-8", $row['dcontname']));

$worksheet->setCellValueByColumnAndRow(2, 8, 'Телефон');
$worksheet->setCellValueByColumnAndRow(3, 8, $row['dcontphone']);

$worksheet->setCellValueByColumnAndRow(2, 9, 'E-Mail');
$worksheet->setCellValueByColumnAndRow(3, 9, $row['dcontmail']);

$worksheet->setCellValueByColumnAndRow(2, 10, 'Факс');
$worksheet->setCellValueByColumnAndRow(3, 10, $row['dcontfax']);

$worksheet->mergeCells('C12:D12');
$worksheet->setCellValueByColumnAndRow(2, 12, 'Примечание');


$worksheet->mergeCells('C13:D13');
$worksheet->setCellValueByColumnAndRow(12, 2, iconv("windows-1251", "UTF-8", $row['destrems']));


$worksheet->mergeCells('A15:D15');
$worksheet->setCellValueByColumnAndRow(0, 15, 'Информация о плательщике');


$worksheet->setCellValueByColumnAndRow(0, 16, 'Кто платит');
$worksheet->setCellValueByColumnAndRow(0, 17, iconv("windows-1251", "UTF-8", $row['payr']));

$worksheet->setCellValueByColumnAndRow(1, 16, 'Вид оплаты');
$worksheet->setCellValueByColumnAndRow(1, 17, iconv("windows-1251", "UTF-8", $row['paytype']));

$worksheet->mergeCells('C16:D16');
$worksheet->setCellValueByColumnAndRow(2, 16, 'Плательщик');

$worksheet->mergeCells('C17:D17');
$worksheet->setCellValueByColumnAndRow(2, 17, iconv("windows-1251", "UTF-8", $row['pname']));


$worksheet->mergeCells('A19:C19');
$worksheet->setCellValueByColumnAndRow(0, 19, 'Информация о заказе');



$worksheet->setCellValueByColumnAndRow(0, 20, 'Статус');
$worksheet->setCellValueByColumnAndRow(0, 21, iconv("windows-1251", "UTF-8", $row['status']));

$worksheet->setCellValueByColumnAndRow(1, 20, '№ накладной');
$worksheet->setCellValueByColumnAndRow(1, 21, $row['wb_no']);

$worksheet->setCellValueByColumnAndRow(2, 20, 'Заказ принят');
$worksheet->setCellValueByColumnAndRow(2, 21, $row['datein']);

$worksheet->mergeCells('A23:C23');
$worksheet->setCellValueByColumnAndRow(0, 23, 'Дата приезда');

$worksheet->setCellValueByColumnAndRow(0, 24, 'Дата');
$worksheet->setCellValueByColumnAndRow(0, 25, $row['courdate']);

$worksheet->setCellValueByColumnAndRow(1, 24, 'Время с');
$worksheet->setCellValueByColumnAndRow(1, 25, $row['courtimef']);

$worksheet->setCellValueByColumnAndRow(2, 24, 'Время по');
$worksheet->setCellValueByColumnAndRow(2, 25, $row['courtimet']);

$worksheet->mergeCells('A27:D27');
$worksheet->setCellValueByColumnAndRow(0, 27, 'Информация о грузе');

$worksheet->setCellValueByColumnAndRow(0, 28, 'Тип груза');
$worksheet->setCellValueByColumnAndRow(0, 29, iconv("windows-1251", "UTF-8", $row['type']));

$worksheet->setCellValueByColumnAndRow(1, 28, 'Кол-во');
$worksheet->setCellValueByColumnAndRow(1, 29, $row['packs']);

$worksheet->setCellValueByColumnAndRow(2, 28, 'Вес');
$worksheet->setCellValueByColumnAndRow(2, 29, $row['wt']);

$worksheet->setCellValueByColumnAndRow(3, 28, 'объемный вес');
$worksheet->setCellValueByColumnAndRow(3, 29, $row['volwt']);

//Отдаем на скачивание
header("Content-Type:application/vnd.ms-excel");
header("Content-Disposition:attachment;filename='Отчет.xlsx'");
 
$objWriter = PHPExcel_IOFactory::createWriter($workbook, 'Excel2007');
$objWriter->save('php://output');
?>