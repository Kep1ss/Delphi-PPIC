program adw;

uses
  Vcl.Forms,
  uMainMenu in 'MainMenu\uMainMenu.pas' {FMainMenu},
  uDataCategoryProduct in 'Category Product\uDataCategoryProduct.pas' {FDataCategoryProduct},
  uComCtrl in 'helper\uComCtrl.pas',
  uctrlFrm in 'helper\uctrlFrm.pas',
  uEngine in 'helper\uEngine.pas',
  uOvEdit in 'helper\uOvEdit.pas',
  uDataComponent in 'Component\uDataComponent.pas' {FDataComponent},
  uDeffAccnt in 'helper\uDeffAccnt.pas',
  uEditJadwalDivisi in 'GantChart\uEditJadwalDivisi.pas' {FEditJadwalDivisi},
  uDataJobs in 'Jobs\uDataJobs.pas' {FDataPekerjaan},
  uInputComponent in 'Component\uInputComponent.pas' {FinputComponent},
  uDataPOMonitoring in 'PoMonitoring\uDataPOMonitoring.pas' {FDataPOMonitoring},
  uInputMaterial in 'Material\uInputMaterial.pas' {FinputMaterial},
  uInputPackingContainer in 'PoMonitoring\uInputPackingContainer.pas' {FinputPackingContainer},
  uSettingComponentProduct in 'Product\uSettingComponentProduct.pas' {FSettingComponentProduct},
  uDataDivisiPengerjaan in 'Divisi\uDataDivisiPengerjaan.pas' {FDataDivisiPengerjaan},
  uDataBarang in 'Product\uDataBarang.pas' {FDataBarang},
  uDataWOWip in 'LoV\uDataWOWip.pas' {FDataWOWip},
  uDaftarBarangCosting in 'LoV\uDaftarBarangCosting.pas' {FDaftarBarangCosting},
  uMarCon in 'connection\uMarCon.pas' {MariaCon: TDataModule},
  uDataTableCostingProduk in 'Bom\uDataTableCostingProduk.pas' {FDataTableCostingProduct},
  uListOfDiviComponent in 'LoV\uListOfDiviComponent.pas' {FDaftarDivisiComponent},
  uDataInspect in 'Hasil Kerja\uDataInspect.pas' {FDataInspect},
  uGenerateJobOrders in 'Job Order\uGenerateJobOrders.pas' {FGenerateJobOrders},
  uDataMaterial in 'Material\uDataMaterial.pas' {FDataMaterial},
  uInputWIP in 'Wip\uInputWIP.pas' {FinputProgress},
  uListSOJadwal in 'LoV\uListSOJadwal.pas' {FDataSoJadwal},
  uInputBom in 'Bom\uInputBom.pas' {FinputBom},
  uGanttChatParameters in 'GantChart\uGanttChatParameters.pas' {FGanttChartParameters},
  uDaftarRencanaKerja in 'LoV\uDaftarRencanaKerja.pas' {FDaftarRencanaKerja},
  uJadwalDivisi in 'GantChart\uJadwalDivisi.pas' {FJadwalDivisi},
  uDataWIP in 'Wip\uDataWIP.pas' {FDataWIP},
  uSettingConnection in 'helper\uSettingConnection.pas' {FSettingConnection},
  pData in 'GantChart\pData.pas' {FramePData: TFrame},
  uInputProduct in 'Product\uInputProduct.pas' {FinputBarang},
  uListofSoGant in 'LoV\uListofSoGant.pas' {FDaftarSOGant},
  uListOfItemJadwal in 'LoV\uListOfItemJadwal.pas' {FlistItemJadwal},
  uInputJadwalDivisi in 'GantChart\uInputJadwalDivisi.pas' {FinputJadwalDivisi},
  uListOfComponent in 'LoV\uListOfComponent.pas' {FDaftarComponent},
  uSettingProsesProduksi in 'Product\uSettingProsesProduksi.pas' {FSettingProsesProduksi},
  uListofMaterial in 'LoV\uListofMaterial.pas' {FDaftarMaterial},
  uDataBom in 'Bom\uDataBom.pas' {FDataBOM},
  uDaftarBarangSO in 'LoV\uDaftarBarangSO.pas' {FDaftarBarangSO},
  uFrameDataCosting in 'Costing\uFrameDataCosting.pas' {FrameDataCosting: TFrame},
  uInputHasilBeritaAcara in 'Hasil Kerja\uInputHasilBeritaAcara.pas' {FInputHasilBeritaAcara},
  uListOfProduct in 'LoV\uListOfProduct.pas' {FDaftarBarang},
  uDataCategoryRakit in 'Item Category\uDataCategoryRakit.pas' {FDataCategoryRakit},
  uInputKategoriRakit in 'Item Category\uInputKategoriRakit.pas' {FinputKategoriRakit},
  uDataUser in 'Users\uDataUser.pas' {FDataUser},
  uInputGroupBuyer in 'Item Category\uInputGroupBuyer.pas' {FinputGroupBuyer},
  uListofSO in 'LoV\uListofSO.pas' {FDaftarSO},
  uLapCompare in 'Laporan\uLapCompare.pas' {FLapRencanavsHasil},
  uInputRencanaKerja in 'Rencana Kerja\uInputRencanaKerja.pas' {FinputRencanaKerja},
  uDaftarSalesOrderInspect in 'LoV\uDaftarSalesOrderInspect.pas' {FDaftarSalesOrderInspect},
  uDataRencanaKerja in 'Rencana Kerja\uDataRencanaKerja.pas' {FDataRencanaKerja},
  uLapRencanaKerja in 'Laporan\uLapRencanaKerja.pas' {FLapRencanaKerja},
  uLapHasilKerja in 'Laporan\uLapHasilKerja.pas' {FLapHasilKerja},
  uPilihPeriode in 'LoV\uPilihPeriode.pas' {FPilihPeriode},
  uDataSO in 'Data Sales Order\uDataSO.pas' {FDataSO},
  uProcessInspect in 'Hasil Kerja\uProcessInspect.pas' {FProsesInspect},
  uDataMutasiBarang in 'Mutasi Barang\uDataMutasiBarang.pas' {FDataMutasiBarang},
  uInputMutasiBarang in 'Mutasi Barang\uInputMutasiBarang.pas' {FInputMutasiBarang},
  uDaftarBarangJobOrder in 'LoV\uDaftarBarangJobOrder.pas' {FDaftarBarangJobOrder},
  uListofPekerjaan in 'LoV\uListofPekerjaan.pas' {FDaftarPekerjaan},
  oGlowButton in 'helper\oGlowButton.pas',
  uLoading in 'uLoading.pas' {Floading},
  uInpuDivisiPengerjaan in 'Divisi\uInpuDivisiPengerjaan.pas' {FinputDivisiPengerjaan},
  uInputUser in 'Users\uInputUser.pas' {FinputUser},
  uDataCategory in 'Item Category\uDataCategory.pas' {FDataCategory},
  uImportGanttChart in 'GantChart\uImportGanttChart.pas' {FImportGC},
  uListOfDivisi in 'LoV\uListOfDivisi.pas' {FDaftarDivisi},
  uRencanaBeritaAcara in 'Rencana Kerja\uRencanaBeritaAcara.pas' {FRencanaBeritaAcara},
  uCancelDate in 'GantChart\uCancelDate.pas' {FCancelDate},
  uScheduleChart in 'GantChart\uScheduleChart.pas' {FGrafikJadwal},
  uJadwalKerjaDivisi in 'Rencana Kerja\uJadwalKerjaDivisi.pas' {FjadwalKerjaDivisi},
  uDataBuyer in 'Item Category\uDataBuyer.pas' {FDataBuyer},
  uInputKategoriProduk in 'Category Product\uInputKategoriProduk.pas' {FInputKategoriProduct},
  uInputKategori in 'Item Category\uInputKategori.pas' {FinputKategori},
  uSettingAkes in 'uSettingAkes.pas' {FsetingAkses},
  uLogin in 'uLogin.pas' {Flogin},
  uDashboard in 'uDashboard.pas' {FDashboard},
  uDataGanttChart in 'GantChart\uDataGanttChart.pas' {FDataGanttChart},
  uBeritaAcara in 'Hasil Kerja\uBeritaAcara.pas' {FBeritaAcara},
  uDataBeritaAcara in 'Hasil Kerja\uDataBeritaAcara.pas' {FDataBa},
  uInputSalesOrder in 'Data Sales Order\uInputSalesOrder.pas' {FinputSalesOrder},
  uDaftarItemSelesaiPerDivisi in 'LoV\uDaftarItemSelesaiPerDivisi.pas' {FDaftarItemProsesDivisi},
  uInputInspect in 'Hasil Kerja\uInputInspect.pas' {FinputInspect},
  uDataHasilKerja in 'Hasil Kerja\uDataHasilKerja.pas' {FDataHasilKerja},
  uInputHasilKerja in 'Hasil Kerja\uInputHasilKerja.pas' {FinputHasilKerja},
  uListSoRencanKerja in 'LoV\uListSoRencanKerja.pas' {FDaftarSORencanaKerja},
  uGanttChart in 'GantChart\uGanttChart.pas' {FGanttChart},
  uInputPekerjaan in 'Jobs\uInputPekerjaan.pas' {FinputPekerjaan},
  uDataDivisi in 'Divisi\uDataDivisi.pas' {FDataDivisi},
  uInputDivisi in 'Divisi\uInputDivisi.pas' {FinputDivisi},
  uDataJobOrder in 'Job Order\uDataJobOrder.pas' {FDataJobOrder},
  uInputJobOrder in 'Job Order\uInputJobOrder.pas' {FinputJobOrder},
  uDaftarItemFails in 'LoV\uDaftarItemFails.pas' {FDaftarItemFails},
  uKoreksiHasilKerja in 'Wip\uKoreksiHasilKerja.pas' {FKoreksiInputHasilKerja};

//  uDataJobOrder in 'Sales Order\uDataJobOrder.pas' {FDataJobOrder};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
 // ReportMemoryLeaksOnShutdown := True;
 // Application.CreateForm(TMariaCon, MariaCon);

  Application.CreateForm(TFMainMenu, FMainMenu);
  Application.CreateForm(TFSettingConnection, FSettingConnection);
  Application.CreateForm(TFInputKategoriProduct, FInputKategoriProduct);
  Application.CreateForm(TFEditJadwalDivisi, FEditJadwalDivisi);
  Application.CreateForm(TFinputComponent, FinputComponent);
  Application.CreateForm(TFinputMaterial, FinputMaterial);
  Application.CreateForm(TFSettingComponentProduct, FSettingComponentProduct);
  Application.CreateForm(TFinputPackingContainer, FinputPackingContainer);
  Application.CreateForm(TFGenerateJobOrders, FGenerateJobOrders);
  Application.CreateForm(TFDaftarBarangCosting, FDaftarBarangCosting);
  Application.CreateForm(TFDaftarDivisiComponent, FDaftarDivisiComponent);
  Application.CreateForm(TFinputPekerjaan, FinputPekerjaan);
  Application.CreateForm(TFDataSoJadwal, FDataSoJadwal);
  Application.CreateForm(TFinputDivisiPengerjaan, FinputDivisiPengerjaan);
  Application.CreateForm(TFinputUser, FinputUser);
  Application.CreateForm(TFImportGC, FImportGC);
  Application.CreateForm(TFDaftarDivisi, FDaftarDivisi);
  Application.CreateForm(TFRencanaBeritaAcara, FRencanaBeritaAcara);
  Application.CreateForm(TFCancelDate, FCancelDate);
  Application.CreateForm(TFGrafikJadwal, FGrafikJadwal);
  Application.CreateForm(TFInputKategoriProduct, FInputKategoriProduct);
  Application.CreateForm(TFinputKategori, FinputKategori);
  Application.CreateForm(TFsetingAkses, FsetingAkses);
  Application.CreateForm(TFlogin, Flogin);
  Application.CreateForm(TFDataGanttChart, FDataGanttChart);
  Application.CreateForm(TFBeritaAcara, FBeritaAcara);
  Application.CreateForm(TFDaftarSalesOrderInspect, FDaftarSalesOrderInspect);
  Application.CreateForm(TFDaftarItemProsesDivisi, FDaftarItemProsesDivisi);
  Application.CreateForm(TFGanttChart, FGanttChart);
  Application.CreateForm(TFGenerateJobOrders, FGenerateJobOrders);
  Application.CreateForm(TFinputDivisiPengerjaan, FinputDivisiPengerjaan);
  Application.CreateForm(TFInputMutasiBarang, FInputMutasiBarang);
  Application.CreateForm(TFDaftarItemProsesDivisi, FDaftarItemProsesDivisi);
  Application.CreateForm(TFKoreksiInputHasilKerja, FKoreksiInputHasilKerja);
  //Application.CreateForm(TFinputProgress, FinputProgress);
  Application.CreateForm(TFDaftarRencanaKerja, FDaftarRencanaKerja);
  Application.CreateForm(TFGanttChartParameters, FGanttChartParameters);
  Application.CreateForm(TFJadwalDivisi, FJadwalDivisi);
  Application.CreateForm(TFinputDivisi, FinputDivisi);
  Application.CreateForm(TFinputBarang, FinputBarang);
  Application.CreateForm(TFDaftarSOGant, FDaftarSOGant);
  Application.CreateForm(TFlistItemJadwal, FlistItemJadwal);
  Application.CreateForm(TFinputJadwalDivisi, FinputJadwalDivisi);
  Application.CreateForm(TFDaftarComponent, FDaftarComponent);
  Application.CreateForm(TFSettingProsesProduksi, FSettingProsesProduksi);
  Application.CreateForm(TFDaftarMaterial, FDaftarMaterial);
  Application.CreateForm(TFDaftarBarangSO, FDaftarBarangSO);
  Application.CreateForm(TFDaftarBarang, FDaftarBarang);
  Application.CreateForm(TFinputKategoriRakit, FinputKategoriRakit);
  Application.CreateForm(TFinputKategori, FinputKategori);
  Application.CreateForm(TFDaftarSO, FDaftarSO);
  Application.CreateForm(TFDaftarSORencanaKerja, FDaftarSORencanaKerja);
  Application.CreateForm(TFLapHasilKerja, FLapHasilKerja);
  Application.CreateForm(TFPilihPeriode, FPilihPeriode);
  Application.CreateForm(TFinputSalesOrder, FinputSalesOrder);
  Application.CreateForm(TFinputJobOrder, FinputJobOrder);
  Application.CreateForm(TFDaftarBarangJobOrder, FDaftarBarangJobOrder);
  Application.CreateForm(TFDaftarPekerjaan, FDaftarPekerjaan);
  Application.CreateForm(TFinputGroupBuyer, FinputGroupBuyer);
  Application.CreateForm(TFloading, Floading);
  Application.CreateForm(TFjadwalKerjaDivisi, FjadwalKerjaDivisi);
  Flogin.Login;
  Application.Run;
end.
