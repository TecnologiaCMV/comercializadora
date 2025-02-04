﻿var tblLimitesInventario, tblFileExcel;
$(document).ready(function () {
    $('.select-multiple').select2({
        width: "100%",
        language: {
            noResults: function () {
                return "No hay resultado";
            },
            searching: function () {
                return "Buscando..";
            }
        },

    });

    $("#btnImportarArchivo").click(function (evt) {
        evt.preventDefault();
        $('#divFileExcel').html("");
        $('#excelfile').val("");
        $('#modalFileExcel').modal({ backdrop: 'static', keyboard: false, show: true });
     

    });

    $('#excelfile').change(function (evt) {
        evt.preventDefault();
        $('#divFileExcel').html("");
        ExportToTable();        
        $('#excelfile').val("");
    });

    $("#btnGuardarLimitesInventario").click(function (evt) {
        evt.preventDefault();
        var limiteInvetarios = [];
        $('#tblFileExcel tbody tr').each(function (index, fila) {
            var row_ = {
                codigoBarras: fila.children[0].innerHTML,
                descripcionAlmacen: fila.children[1].innerHTML,
                minimo: parseInt(fila.children[2].innerHTML),
                maximo: parseInt(fila.children[3].innerHTML)
            };
            limiteInvetarios.push(row_);
        });

        if (limiteInvetarios.length === 0) {
            MuestraToast('warning', "No existe información para procesar.");
            return;
        }

        swal({
            title: '',
            text: 'Estas seguro que deseas afectar los limites de inventario?',
            icon: '',
            buttons: ["Cancelar", "Aceptar"],
            dangerMode: true,
        })
            .then((willDelete) => {
                if (willDelete) {

                    var dataToPost = JSON.stringify({ limiteInvetarios: limiteInvetarios });

                    $.ajax({
                        url: rootUrl("/Productos/ImportarLimitesInventario"),
                        data: dataToPost,
                        method: 'POST',
                        dataType: 'JSON',
                        contentType: "application/json; charset=utf-8",
                        async: true,
                        beforeSend: function (xhr) {
                            ShowLoader("Afectando...");
                        },
                        success: function (data) {
                            OcultarLoader();
                            if (data.Estatus == 200) {
                                MuestraToast("success", data.Mensaje);
                                $('#modalFileExcel').modal('hide');
                                $("#frmBuscarLimitesInventario").submit();
                            }
                            else
                                MuestraToast("error", data.Mensaje);
                        },
                        error: function (xhr, status) {
                            OcultarLoader();
                            console.log('Hubo un problema al afectar los limites de inventario, contactese con el administrador del sistema');
                            console.log(xhr);
                            console.log(status);
                        }
                    });
                } else {
                    console.log("cancelar");
                }
            });
    });


    $("#frmBuscarLimitesInventario").submit();
});

//busqueda
function onBeginSubmitLimitesInventario() {
    ShowLoader("Buscando...");
}
function onSuccessResultLimitesInventario(data) {
    if (tblLimitesInventario != null)
        tblLimitesInventario.destroy();

    $('#ViewLimitesInventario').html(data);
    if ($("#tblLimitesInventario").length > 0)
        InitDataTableLimitesInventario();
    OcultarLoader();
}
function onFailureResultLimitesInventario() {
    OcultarLoader();
}

function InitDataTableLimitesInventario() {
    var NombreTabla = "tblLimitesInventario";
    tblLimitesInventario = initDataTable(NombreTabla);

    new $.fn.dataTable.Buttons(tblLimitesInventario, {
        buttons: [
            {
                extend: 'pdfHtml5',
                text: '<i class="fas fa-file-pdf" style="font-size:20px;"></i>',
                className: '',
                titleAttr: 'Exportar a PDF',
                title: "Indicador LimitesInventario",
                customize: function (doc) {
                    doc.defaultStyle.fontSize = 8;
                    doc.styles.tableHeader.fontSize = 10;
                    doc.defaultStyle.alignment = 'center';
                    // doc.content[1].table.widths = ['10%', '25%', '15%', '15%', '20%', '15%'];
                    doc.pageMargins = [30, 85, 20, 30];
                    doc.content.splice(0, 1);
                    doc['header'] = SetHeaderPDF("Indicador LimitesInventario");
                    doc['footer'] = (function (page, pages) { return setFooterPDF(page, pages) });
                },
                exportOptions: {
                    columns: [0, 1, 2, 3, 4, 5, 6, 7],
                    format: {
                        body: function (data, row, column, node) {
                            var valor = "";
                            valor = data;                          
                            valor = valor.indexOf('div') > -1 ? $(data).html() : valor; 
                            valor = valor.indexOf('input') > -1 ? $(data).val() : valor; 
                            return valor;
                        }
                    }
                },
            },
            {
                extend: 'excel',
                text: '<i class="fas fa-file-excel" style="font-size:20px;"></i>',
                className: '',
                titleAttr: 'Exportar a Excel',
                exportOptions: {
                    columns: [0, 1, 2, 3, 4, 5, 6, 7],
                    format: {
                        body: function (data, row, column, node) {
                            var valor = "";
                            valor = data;
                            valor = valor.indexOf('div') > -1 ? $(data).html() : valor;
                            valor = valor.indexOf('input') > -1 ? $(data).val() : valor;
                            return valor;
                        }
                    }
                },
            },
        ],

    });

    tblLimitesInventario.buttons(0, null).container().prependTo(
        tblLimitesInventario.table().container()
    );
}

function actualizaLimiteInventario(idLimiteInventario, idAlmacen, idProducto, maximo, minimo, campoActualizar, valorAnterior) {

    if ($("#" + campoActualizar + "_" + idLimiteInventario).val() == valorAnterior)
        return;

    if ($.trim($("#" + campoActualizar + "_" + idLimiteInventario).val()) == "") {
        $("#" + campoActualizar + "_" + idLimiteInventario).focus();
        MuestraToast("error", "El " + campoActualizar + " que desea actualizar no puede ir vacio");
        return;
    }

    if (minimo > maximo) {
        $("#" + campoActualizar + "_" + idLimiteInventario).focus();
        MuestraToast("error", "El valor minimo no puede ser mayor que el valor maximo");
        return;
    }



    swal({
        title: '',
        text: 'Estas seguro que deseas actualizar el valor ' + campoActualizar + '?',
        icon: '',
        buttons: ["Cancelar", "Aceptar"],
        dangerMode: true,
    })
        .then((willDelete) => {
            if (willDelete) {

                var limiteInvetario = new Object();
                limiteInvetario.idProducto = idProducto;
                limiteInvetario.idAlmacen = idAlmacen;
                limiteInvetario.minimo = minimo;
                limiteInvetario.maximo = maximo;


                var dataToPost = JSON.stringify({ limiteInvetario: limiteInvetario });

                $.ajax({
                    url: rootUrl("/Productos/ActualizaLimiteInventario"),
                    data: dataToPost,
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    async: true,
                    beforeSend: function (xhr) {
                        ShowLoader("Actualizando.");
                    },
                    success: function (data) {
                        if (data.Estatus == 200) {
                            MuestraToast('success', "El valor " + campoActualizar + " se ha actualizado de manera correcta");

                        } else {
                            MuestraToast("error", data.Mensaje);
                        }

                        $("#frmBuscarLimitesInventario").submit();

                        OcultarLoader();


                    },
                    error: function (xhr, status) {
                        OcultarLoader();
                        console.log('Hubo un problema al actualizar el limite de inventario, contactese con el administrador del sistema');
                        console.log(xhr);
                        console.log(status);
                    }
                });
            } else {
                $("#" + campoActualizar + "_" + idLimiteInventario).val(valorAnterior);
            }
        });
}

function ValidarFile(File) {

    var validExts = new Array(".xlsx", ".xls");
    var fileExt = File.value;
    if (fileExt !== "") {
        fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
        if (validExts.indexOf(fileExt) < 0) {
            MuestraToast("error", "Archivo inválido, los archivos validos son " + validExts.toString());
        }
        else {
            var fileUpload = $("#FileExcel").get(0);
            var files = fileUpload.files;

            // Create FormData object  
            var fileData = new FormData();

            // Looping over all files and add it to FormData object  
            for (var i = 0; i < files.length; i++) {
                fileData.append(files[i].name, files[i]);
            }

            $.ajax({
                url: rootUrl("/Productos/ImportarExcel"),
                type: "POST",
                contentType: false, // Not to set any content header  
                processData: false, // Not to process data  
                data: fileData,
                async: true,
                beforeSend: function () {
                    ShowLoader("Importando archivo...");
                },
                success: function (data) {
                    OcultarLoader();
                    $("#FileExcel").val("");
                    if (data.Estatus == 200) {
                        MuestraToast('success', "El archivo se ha importado de manera correcta");

                    } else {
                        MuestraToast("error", data.Mensaje);
                    }

                    $("#frmBuscarLimitesInventario").submit();

                },
                error: function (xhr, status, error) {
                    OcultarLoader();
                    MuestraToast("error", "Ocurrio un error al importar el archivo")
                }
            });


        }
    }
    else
        MuestraToast("error", "Seleccione un archivo")
}


/////********************** EXCEL***************************

function ExportToTable() {

    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.xlsx|.xls)$/;

    /*Checks whether the file is a valid excel file*/
    if (regex.test($("#excelfile").val().toLowerCase())) {
        var xlsxflag = false; /*Flag for checking whether excel is .xls format or .xlsx format*/
        if ($("#excelfile").val().toLowerCase().indexOf(".xlsx") > 0) {
            xlsxflag = true;
        }
        /*Checks whether the browser supports HTML5*/
        if (typeof (FileReader) != "undefined") {
            var reader = new FileReader();
            reader.onload = function (e) {
                var data = e.target.result;
                /*Converts the excel data in to object*/
                if (xlsxflag) {
                    var workbook = XLSX.read(data, { type: 'binary' });
                }
                else {
                    var workbook = XLS.read(data, { type: 'binary' });
                }
                /*Gets all the sheetnames of excel in to a variable*/
                var sheet_name_list = workbook.SheetNames;

                var cnt = 0; /*This is used for restricting the script to consider only first sheet of excel*/
                sheet_name_list.forEach(function (y) { /*Iterate through all sheets*/
                    /*Convert the cell value to Json*/
                    if (xlsxflag) {
                        var exceljson = XLSX.utils.sheet_to_json(workbook.Sheets[y]);
                    }
                    else {
                        var exceljson = XLS.utils.sheet_to_row_object_array(workbook.Sheets[y]);
                    }
                    if (exceljson.length > 0 && cnt == 0) {
                        // BindTable(exceljson, '#tblFileExcel');  
                        GenerarTabla(exceljson);
                        cnt++;
                    }
                });
                //$('#tblFileExcel').show();
            }
            if (xlsxflag) {/*If excel file is .xlsx extension than creates a Array Buffer from excel*/
                reader.readAsArrayBuffer($("#excelfile")[0].files[0]);
            }
            else {
                reader.readAsBinaryString($("#excelfile")[0].files[0]);
            }
        }
        else {
            MuestraToast("error", "¡Lo siento! Su navegador no es compatible con HTML5.");
        }
    }
    else {
        MuestraToast("error", "Por favor seleccione un archivo válido");
    }
}

function GenerarTabla(exceljson) {
    var columnSet = [];
    for (var i = 0; i < exceljson.length; i++) {
        var rowHash = exceljson[i];
        for (var key in rowHash) {
            if (rowHash.hasOwnProperty(key)) {
                if ($.inArray(key, columnSet) == -1) {/*Adding each unique column names to a variable array*/
                    columnSet.push(key);
                }
            }
        }
    }

    if (columnSet.length < 4) {
        MuestraToast("error", "El archivo no tiene el formato correcto");
        return false;
    }

    if ((columnSet[0] != "Codigo Barras") || (columnSet[1] != "Almacen") || (columnSet[2] != "Minimo") || (columnSet[3] != "Maximo")) {
        MuestraToast("error", "El archivo no tiene el formato correcto");
        return false;
    }

    var htmlTable = "";
    htmlTable += '<table class="table table-striped dataTable" id="tblFileExcel">';
    htmlTable += '<thead>';
    htmlTable += '<tr>';
    for (var colIndex = 0; colIndex < columnSet.length; colIndex++) {
        htmlTable += '<th>' + columnSet[colIndex] + '</th>';
    }
    htmlTable += '<th>Estatus</th>';
    htmlTable += '</tr>';
    htmlTable += '</thead>';
    htmlTable += '<tbody>';
    for (var i = 0; i < exceljson.length; i++) {
        var ErrorMsg = "";
        htmlTable += '<tr>';
        for (var colIndex = 0; colIndex < columnSet.length; colIndex++) {            
            var cellValue = exceljson[i][columnSet[colIndex]];
            if (cellValue == null)
                cellValue = "";
            if (cellValue == "") //validamos campos vacioes
                ErrorMsg = "El campo " + columnSet[colIndex] + " se encuentra vacio"
            if ((colIndex == 2 || colIndex == 3)) {
                htmlTable += '<td>' + parseInt(cellValue) + '</td>';
                if (!Number.isInteger(parseInt(cellValue))) //validamos que sea un entero
                    ErrorMsg = "El campo " + columnSet[colIndex] + " no es un número entero"
                else if (colIndex == 2 && (parseInt(cellValue) > exceljson[i][columnSet[3]])) //validamos que el minimo no sea mayor que el maximo
                    ErrorMsg = "El campo " + columnSet[colIndex] + " no puede ser mayor que el campo " + columnSet[3];               
            }
            else
             htmlTable += '<td>' + cellValue + '</td>';
        }
        htmlTable += '<td><div class="badge ' + (ErrorMsg === "" ? "badge-success" : "badge-danger") + ' badge-shadow">' + (ErrorMsg === "" ? "Correcto" : "Incorrecto: " + ErrorMsg) + '</div></td>';
        htmlTable += '</tr>';
    }

    htmlTable += '</tbody>';
    htmlTable += '</table>';
    $("#divFileExcel").html(htmlTable);
    if (tblFileExcel != null)
        tblFileExcel.destroy();
    if ($("#tblFileExcel").length > 0)
        InitDataTableFileExcel();
}

function InitDataTableFileExcel() {
    var NombreTabla = "tblFileExcel";
    tblFileExcel = initDataTable(NombreTabla);
}
