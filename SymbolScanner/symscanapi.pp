{ Symbol/Motorolla Barcode Scanner interface unit.

  Copyright (C) 2008 Arnold Bosch arnoldb@mweb.com.na

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

{ Notes:

  This file was generated mostly automatically by c language conversion
  software for FPC/Lazarus.

  A fair amount of manual editing then was done to get it to work.
  Most notably, conversion/selection of Unicode characters strings for
  Windows CE.

}



unit SymScanAPI;
interface


  const
    External_library='SCNAPI32.DLL'; {Setup as you need}

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


  const
     ERROR_BIT = $80000000;     
     USER_BIT = $20000000;     
     E_SCN_SUCCESS = 0;     
     E_SCN_OPENINGACTIVEKEY = $0001;     
     E_SCN_READINGACTIVEKEY = $0002;     
     E_SCN_OPENINGPARAMKEY = $0003;     
     E_SCN_READINGPARAMKEY = $0004;     
     E_SCN_NOTENOUGHMEMORY = $0005;     
     E_SCN_INVALIDDVCCONTEXT = $0006;     
     E_SCN_INVALIDOPENCONTEXT = $0007;     
     E_SCN_NOTINITIALIZED = $0008;     
     E_SCN_CANTLOADDEVICE = $0009;     
     E_SCN_INVALIDDEVICE = $000A;     
     E_SCN_DEVICEFAILURE = $000B;     
     E_SCN_CANTSTARTDEVICE = $000C;     
     E_SCN_CANTGETDEFAULTS = $000D;     
     E_SCN_NOTSTARTED = $000E;     
     E_SCN_ALREADYSTARTED = $000F;     
     E_SCN_NOTENABLED = $0010;     
     E_SCN_ALREADYENABLED = $0011;     
     E_SCN_INVALIDIOCTRL = $0012;     
     E_SCN_NULLPTR = $0013;     
     E_SCN_INVALIDARG = $0014;     
     E_SCN_BUFFERSIZEIN = $0015;     
     E_SCN_BUFFERSIZEOUT = $0016;     
     E_SCN_STRUCTSIZE = $0017;     
     E_SCN_MISSINGFIELD = $0018;     
     E_SCN_INVALIDHANDLE = $0019;     
     E_SCN_INVALIDPARAM = $001A;     
     E_SCN_CREATEEVENT = $001B;     
     E_SCN_CREATETHREAD = $001C;     
     E_SCN_READCANCELLED = $001D;     
     E_SCN_READTIMEOUT = $001E;     
     E_SCN_READNOTPENDING = $001F;     
     E_SCN_READPENDING = $0020;     
     E_SCN_BUFFERTOOSMALL = $0021;     
     E_SCN_INVALIDSCANBUFFER = $0022;     
     E_SCN_READINCOMPATIBLE = $0023;     
     E_SCN_NOFEEDBACK = $0024;     
     E_SCN_RESTART = $0025;     
     E_SCN_NOTSUPPORTED = $0026;     
     E_SCN_WRONGSTATE = $0027;     
     E_SCN_NOMOREITEMS = $0028;     
     E_SCN_CANTOPENREGKEY = $0029;     
     E_SCN_CANTREADREGVAL = $002A;     
     E_SCN_EXCEPTION = $002B;     
     E_SCN_WIN32ERROR = $002C;     
     E_SCN_ALREADYINUSE = $002D;     
     E_SCN_NOTINUSE = $002E;     
     E_SCN_CANTLOADDECODERDLL = $002F;     
     E_SCN_INVALIDDECODERDLL = $0030;     
     E_SCN_INVALIDSYMBOL = $0031;     
     E_SCN_INVALIDLICENSE = $0032;     
     E_SCN_NOTINSEQUENCE = $0033;     
     E_SCN_DUPLICATESYMBOL = $0034;     
     E_SCN_CANTLOADHALDLL = $0035;     
     E_SCN_INVALIDHALDLL = $0036;     
     E_SCN_CANTLOADCOMPRESSIONDLL = $0037;     

  type
  
     HANDLE = DWORD;
     LPHANDLE = ^HANDLE;
     
     LPCTSTR = PWIDECHAR;
     LPDWORD = ^DWORD;
     
     HWND = DWORD;
     UINT = cardinal;
     BOOL = UINT;
     LPBOOL = ^BOOL;

     TSTRUCT_INFO = record
          dwAllocated : DWORD;
          dwUsed : DWORD;
       end;
     STRUCT_INFO = TSTRUCT_INFO;

     LPSTRUCT_INFO = ^STRUCT_INFO;
     
     RECT = record
          left:longint;
          top:longint;
          right:longint;
          bottom:longint;
     end;
     
     SYSTEMTIME = record
       dYear, wMonth, wDayOfWeek, wDay,
       wHour, wMinute, wSecond, wMilliseconds : word;
     end;

  const
     SCANDEF_VERSION = 507;     
     SCANAPI = 'SCNAPI32.DLL';     
     DECODERS_BUFLEN = 128;     
     MAX_DECODERS = DECODERS_BUFLEN-1;     
     MAX_DEVICE_NAME = 6;
     MAX_PATH = 260;
     DECODER_UPCE0 = '\x30';     
     DECODER_UPCE1 = '\x31';     
     DECODER_UPCA = '\x32';     
     DECODER_MSI = '\x33';     
     DECODER_EAN8 = '\x34';     
     DECODER_EAN13 = '\x35';     
     DECODER_CODABAR = '\x36';     
     DECODER_CODE39 = '\x37';     
     DECODER_D2OF5 = '\x38';     
     DECODER_I2OF5 = '\x39';     
     DECODER_CODE11 = '\x3A';     
     DECODER_CODE93 = '\x3B';     
     DECODER_CODE128 = '\x3C';     
     DECODER_RESERVED_3D = '\x3D';     
     DECODER_RESERVED_3E = '\x3E';     
     DECODER_RESERVED_3F = '\x3F';     
     DECODER_PDF417 = '\x40';     
     DECODER_RESERVED_41 = '\x41';     
     DECODER_TRIOPTIC39 = '\x42';     
     DECODER_RESERVED_43 = '\x43';     
     DECODER_RESERVED_44 = '\x44';     
     DECODER_MICROPDF = '\x45';     
     DECODER_RESERVED_46 = '\x46';     
     DECODER_MACROPDF = '\x47';     
     DECODER_MAXICODE = '\x48';     
     DECODER_DATAMATRIX = '\x49';     
     DECODER_QRCODE = '\x4A';     
     DECODER_MACROMICROPDF = '\x4B';     
     DECODER_RSS14 = '\x4C';     
     DECODER_RSSLIM = '\x4D';     
     DECODER_RSSEXP = '\x4E';     
     DECODER_POINTER = '\x50';     
     DECODER_IMAGE = '\x51';     
     DECODER_SIGNATURE = '\x52';     
     DECODER_WEBCODE = '\x54';     
     DECODER_CUECODE = '\x55';     
     DECODER_COMPOSITE_AB = '\x56';     
     DECODER_COMPOSITE_C = '\x57';     
     DECODER_TLC39 = '\x58';     
     DECODER_RESERVED_59 = '\x59';     
     DECODER_RESERVED_5A = '\x5A';     
     DECODER_USPOSTNET = '\x61';     
     DECODER_USPLANET = '\x62';     
     DECODER_UKPOSTAL = '\x63';     
     DECODER_JAPPOSTAL = '\x64';     
     DECODER_AUSPOSTAL = '\x65';     
     DECODER_DUTCHPOSTAL = '\x66';     
     DECODER_CANPOSTAL = '\x67';     

  type

     DECODER = WIDECHAR;
  (* far ignored *)

     LPDECODER = ^WIDECHAR;

  const
     LABELTYPE_UPCE0 = $30;     
     LABELTYPE_UPCE1 = $31;     
     LABELTYPE_UPCA = $32;     
     LABELTYPE_MSI = $33;     
     LABELTYPE_EAN8 = $34;     
     LABELTYPE_EAN13 = $35;     
     LABELTYPE_CODABAR = $36;     
     LABELTYPE_CODE39 = $37;     
     LABELTYPE_D2OF5 = $38;     
     LABELTYPE_I2OF5 = $39;     
     LABELTYPE_CODE11 = $3A;     
     LABELTYPE_CODE93 = $3B;     
     LABELTYPE_CODE128 = $3C;     
     LABELTYPE_RESERVED_3D = $3D;     
     LABELTYPE_IATA2OF5 = $3E;     
     LABELTYPE_EAN128 = $3F;     
     LABELTYPE_PDF417 = $40;     
     LABELTYPE_ISBT128 = $41;     
     LABELTYPE_TRIOPTIC39 = $42;     
     LABELTYPE_COUPON = $43;     
     LABELTYPE_BOOKLAND = $44;     
     LABELTYPE_MICROPDF = $45;     
     LABELTYPE_CODE32 = $46;     
     LABELTYPE_MACROPDF = $47;     
     LABELTYPE_MAXICODE = $48;     
     LABELTYPE_DATAMATRIX = $49;     
     LABELTYPE_QRCODE = $4A;     
     LABELTYPE_MACROMICROPDF = $4B;     
     LABELTYPE_RSS14 = $4C;     
     LABELTYPE_RSSLIM = $4D;     
     LABELTYPE_RSSEXP = $4E;     
     LABELTYPE_RESERVED_50 = $50;     
     LABELTYPE_IMAGE = $51;     
     LABELTYPE_SIGNATURE = $52;     
     LABELTYPE_WEBCODE = $54;     
     LABELTYPE_CUECODE = $55;     
     LABELTYPE_COMPOSITE_AB = $56;     
     LABELTYPE_COMPOSITE_C = $57;     
     LABELTYPE_TLC39 = $58;     
     LABELTYPE_RESERVED_59 = $59;     
     LABELTYPE_RESERVED_5A = $5A;     
     LABELTYPE_USPOSTNET = $61;     
     LABELTYPE_USPLANET = $62;     
     LABELTYPE_UKPOSTAL = $63;     
     LABELTYPE_JAPPOSTAL = $64;     
     LABELTYPE_AUSPOSTAL = $65;     
     LABELTYPE_DUTCHPOSTAL = $66;     
     LABELTYPE_CANPOSTAL = $67;     
     LABELTYPE_UNKNOWN = $FF;     

  type

     LABELTYPE = DWORD;
  (* far ignored *)

     LPLABELTYPE = ^LABELTYPE;

  const
     SYMBOL_ID_UPCEAN = 'A';     
     SYMBOL_ID_CODE39 = 'B';     
     SYMBOL_ID_CODE32 = 'B';     
     SYMBOL_ID_CODABAR = 'C';     
     SYMBOL_ID_CODE128 = 'D';     
     SYMBOL_ID_CODE93 = 'E';     
     SYMBOL_ID_I2OF5 = 'F';     
     SYMBOL_ID_D2OF5 = 'G';     
     SYMBOL_ID_IATA2OF5 = 'G';     
     SYMBOL_ID_CODE11 = 'H';     
     SYMBOL_ID_MSI = 'J';     
     SYMBOL_ID_UCCEAN128 = 'K';     
     SYMBOL_ID_BOOKLANDEAN = 'L';     
     SYMBOL_ID_TRIOPTIC39 = 'M';     
     SYMBOL_ID_COUPON = 'N';     
     SYMBOL_ID_DATAMATRIX = 'P';     
     SYMBOL_ID_SUPP2_DATAMATRIX = '0';     
     SYMBOL_ID_QRCODE = 'P';     
     SYMBOL_ID_SUPP2_QRCODE = '1';     
     SYMBOL_ID_MAXICODE = 'P';     
     SYMBOL_ID_SUPP2_MAXICODE = '2';     
     SYMBOL_ID_POSTAL = 'P';     
     SYMBOL_ID_SUPP2_USPOSTNET = '3';     
     SYMBOL_ID_SUPP2_USPLANET = '4';     
     SYMBOL_ID_SUPP2_JAPPOSTAL = '5';     
     SYMBOL_ID_SUPP2_UKPOSTAL = '6';     
     SYMBOL_ID_SUPP2_CANPOSTAL = '7';     
     SYMBOL_ID_SUPP2_DUTCHPOSTAL = '8';     
     SYMBOL_ID_SUPP2_AUSPOSTAL = '9';     
     SYMBOL_ID_CUECODE = 'Q';     
     SYMBOL_ID_RSS14 = 'R';     
     SYMBOL_ID_RSSLIM = 'R';     
     SYMBOL_ID_RSSEXP = 'R';     
     SYMBOL_ID_TLC39 = 'T';     
     SYMBOL_ID_WEBCODE = 'W';     
     SYMBOL_ID_PDF417 = 'X';     
     SYMBOL_ID_MICROPDF = 'X';     
     SYMBOL_ID_MACROPDF = 'X';     
     SYMBOL_ID_MACROMICROPDF = 'X';     
     SYMBOL_ID_IMAGE = 'X';     
     AIM_ID_CODE39 = 'A';     
     AIM_ID_CODE128 = 'C';     
     AIM_ID_UCCEAN128 = 'C';     
     AIM_ID_DATAMATRIX = 'd';     
     AIM_ID_RSS = 'e';     
     AIM_ID_UPCEAN = 'E';     
     AIM_ID_CODABAR = 'F';     
     AIM_ID_CODE93 = 'G';     
     AIM_ID_CODE11 = 'H';     
     AIM_ID_I2OF5 = 'I';     
     AIM_ID_PDF417 = 'L';     
     AIM_ID_MICROPDF = 'L';     
     AIM_ID_MACROPDF = 'L';     
     AIM_ID_MACROMICROPDF = 'L';     
     AIM_ID_TLC39 = 'L';     
     AIM_ID_MSI = 'M';     
     AIM_ID_QRCODE = 'Q';     
     AIM_ID_RSS14 = 'e';     
     AIM_ID_RSSLIM = 'e';     
     AIM_ID_RSSEXP = 'e';     
     AIM_ID_D2OF5 = 'S';     
     AIM_ID_IATA2OF5 = 'S';     
     AIM_ID_MAXICODE = 'U';     
     AIM_ID_BOOKLANDEAN = 'X';     
     AIM_ID_TRIOPTIC39 = 'X';     
     AIM_ID_COUPON = 'E';     
     AIM_ID_POSTAL = 'X';     
     AIM_ID_WEBCODE = 'X';     
     AIM_ID_CUECODE = 'X';     
     AIM_ID_IMAGE = 'Z';     
     IMAGE_FORMAT_JPEG = $00000001;     
     TIMEOUT_INFINITE = 0;     

  type
     tagDIRECTIONS =  Longint;
     Const
       DIR_FORWARD = 1;
       DIR_REVERSE = 2;


  type

     tagSCAN_FINDINFO_W = record
          StructInfo : STRUCT_INFO;
          szDeviceName : array[0..(MAX_DEVICE_NAME)-1] of WCHAR;
          szPortName : array[0..(MAX_DEVICE_NAME)-1] of WCHAR;
          szFriendlyName : array[0..(MAX_PATH)-1] of WCHAR;
          szRegistryBasePath : array[0..(MAX_PATH)-1] of WCHAR;
       end;
     SCAN_FINDINFO_W = tagSCAN_FINDINFO_W;
  (* far ignored *)

     LPSCAN_FINDINFO_W = ^SCAN_FINDINFO_W;

     tagSCAN_FINDINFO_A = record
          StructInfo : STRUCT_INFO;
          szDeviceName : array[0..(MAX_DEVICE_NAME)-1] of CHAR;
          szPortName : array[0..(MAX_DEVICE_NAME)-1] of CHAR;
          szFriendlyName : array[0..(MAX_PATH)-1] of CHAR;
          szRegistryBasePath : array[0..(MAX_PATH)-1] of CHAR;
       end;
     SCAN_FINDINFO_A = tagSCAN_FINDINFO_A;
  (* far ignored *)

     LPSCAN_FINDINFO_A = ^SCAN_FINDINFO_A;
// {$ifdef UNICODE}
//
  type
     SCAN_FINDINFO = SCAN_FINDINFO_W;
     LPSCAN_FINDINFO = LPSCAN_FINDINFO_W;
//{$else}

//  type
//     SCAN_FINDINFO = SCAN_FINDINFO_A;
//     LPSCAN_FINDINFO = LPSCAN_FINDINFO_A;
//{$endif}

  type

     tagSCAN_VERSION_INFO = record
          StructInfo : STRUCT_INFO;
          dwHardwareVersion : DWORD;
          dwDecoderVersion : DWORD;
          dwPddVersion : DWORD;
          dwMddVersion : DWORD;
          dwCAPIVersion : DWORD;
          dwPddConfig : DWORD;
       end;
     SCAN_VERSION_INFO = tagSCAN_VERSION_INFO;
  (* far ignored *)

     LPSCAN_VERSION_INFO = ^SCAN_VERSION_INFO;

  const
     MAX_SRC = 32;     

  type

     tagSCAN_BUFFER_W = record
          StructInfo : STRUCT_INFO;
          dwDataBuffSize : DWORD;
          dwOffsetDataBuff : DWORD;
          dwDataLength : DWORD;
          dwTimeout : DWORD;
          dwStatus : DWORD;
          bText : BOOL;
          dwLabelType : LABELTYPE;
          dwRequestID : DWORD;
          TimeStamp : TDateTime;
          dwDirection : DWORD;
          szSource : array[0..(MAX_SRC)-1] of WCHAR;
          bIsMultiPart : BOOL;
          dwScanID : DWORD;
          dwBarcodeID : DWORD;
          dwNumRemaining : DWORD;
          dwOffsetAuxDataBuff : DWORD;
          dwAuxDataLength : DWORD;
       end;
     SCAN_BUFFER_W = tagSCAN_BUFFER_W;
  (* far ignored *)

     LPSCAN_BUFFER_W = ^SCAN_BUFFER_W;

     tagSCAN_BUFFER_A = record
          StructInfo : STRUCT_INFO;
          dwDataBuffSize : DWORD;
          dwOffsetDataBuff : DWORD;
          dwDataLength : DWORD;
          dwTimeout : DWORD;
          dwStatus : DWORD;
          bText : BOOL;
          dwLabelType : LABELTYPE;
          dwRequestID : DWORD;
          TimeStamp : TDateTime;
          dwDirection : DWORD;
          szSource : array[0..(MAX_SRC)-1] of CHAR;
          bIsMultiPart : BOOL;
          dwScanID : DWORD;
          dwBarcodeID : DWORD;
          dwNumRemaining : DWORD;
          dwOffsetAuxDataBuff : DWORD;
          dwAuxDataLength : DWORD;
       end;
     SCAN_BUFFER_A = tagSCAN_BUFFER_A;
  (* far ignored *)

     LPSCAN_BUFFER_A = ^SCAN_BUFFER_A;
//{$ifdef UNICODE}

  type
     SCAN_BUFFER = SCAN_BUFFER_W;
     LPSCAN_BUFFER = LPSCAN_BUFFER_W;
//{$else}

//  type
//     SCAN_BUFFER = SCAN_BUFFER_A;
//     LPSCAN_BUFFER = LPSCAN_BUFFER_A;
//{$endif}

  type
     tagPREAMBLE =  Longint;
     Const
       PREAMBLE_NONE = 0;
       PREAMBLE_SYSTEM_CHAR = 1;
       PREAMBLE_COUNTRY_AND_SYSTEM_CHARS = 2;


  type
     tagMSICHECKDIGITSCHEME =  Longint;
     Const
       MSI_CHKDGT_MOD_11_10 = 0;
       MSI_CHKDGT_MOD_10_10 = 1;


  type
     tagMSICHECKDIGITS =  Longint;
     Const
       MSI_ONE_CHECK_DIGIT = 0;
       MSI_TWO_CHECK_DIGIT = 1;


  type
     tagI2OF5CHECKDIGITS =  Longint;
     Const
       I2OF5_NO_CHECK_DIGIT = 0;
       I2OF5_USS_CHECK_DIGIT = 1;
       I2OF5_OPCC_CHECK_DIGIT = 2;


  type
     tagCODE11CHECKDIGITS =  Longint;
     Const
       CODE11_NO_CHECK_DIGIT = 0;
       CODE11_ONE_CHECK_DIGIT = 1;
       CODE11_TWO_CHECK_DIGIT = 2;


  type
     tagUCCLINKMODE =  Longint;
     Const
       UCC_NEVER = 0;
       UCC_ALWAYS = 1;
       UCC_AUTO = 2;


  type
     tagMULTIMODE =  Longint;
     Const
       MULTI_PART_SINGLE_PACKET = 0;
       MULTI_INDEPENDENT_READS = 1;


  type

     tagUPCEO_PARAMS = record
          bReportCheckDigit : BOOL;
          dwPreamble : DWORD;
          bConvertToUPCA : BOOL;
       end;
     UPCE0_PARAMS = tagUPCEO_PARAMS;

     tagUPCE1_PARAMS = record
          bReportCheckDigit : BOOL;
          dwPreamble : DWORD;
          bConvertToUPCA : BOOL;
       end;
     UPCE1_PARAMS = tagUPCE1_PARAMS;

     tagUPCA_PARAMS = record
          bReportCheckDigit : BOOL;
          dwPreamble : DWORD;
       end;
     UPCA_PARAMS = tagUPCA_PARAMS;

     tagMSI_PARAMS = record
          bRedundancy : BOOL;
          dwCheckDigits : DWORD;
          dwCheckDigitScheme : DWORD;
          bReportCheckDigit : BOOL;
       end;
     MSI_PARAMS = tagMSI_PARAMS;

     tagEAN8_PARAMS = record
          bConvertToEAN13 : BOOL;
       end;
     EAN8_PARAMS = tagEAN8_PARAMS;

     tagCODABAR_PARAMS = record
          bRedundancy : BOOL;
          bClsiEditing : BOOL;
          bNotisEditing : BOOL;
       end;
     CODABAR_PARAMS = tagCODABAR_PARAMS;

     tagCODE39_PARAMS = record
          bVerifyCheckDigit : BOOL;
          bReportCheckDigit : BOOL;
          bConcatenation : BOOL;
          bFullAscii : BOOL;
          bRedundancy : BOOL;
          bConvertToCode32 : BOOL;
          bCode32Prefix : BOOL;
       end;
     CODE39_PARAMS = tagCODE39_PARAMS;

     tagD2OF5_PARAMS = record
          bRedundancy : BOOL;
       end;
     D2OF5_PARAMS = tagD2OF5_PARAMS;

     tagI2OF5_PARAMS = record
          bRedundancy : BOOL;
          dwVerifyCheckDigit : DWORD;
          bReportCheckDigit : BOOL;
          bConvertToEAN13 : BOOL;
       end;
     I2OF5_PARAMS = tagI2OF5_PARAMS;

     tagCODE11_PARAMS = record
          bRedundancy : BOOL;
          dwCheckDigitCount : DWORD;
          bReportCheckDigit : BOOL;
       end;
     CODE11_PARAMS = tagCODE11_PARAMS;

     tagCODE93_PARAMS = record
          bRedundancy : BOOL;
       end;
     CODE93_PARAMS = tagCODE93_PARAMS;

     tagCODE128_PARAMS = record
          bRedundancy : BOOL;
          bEAN128 : BOOL;
          bISBT128 : BOOL;
          bOther128 : BOOL;
       end;
     CODE128_PARAMS = tagCODE128_PARAMS;

     tagTRIOPTIC39_PARAMS = record
          bRedundancy : BOOL;
       end;
     TRIOPTIC39_PARAMS = tagTRIOPTIC39_PARAMS;

     tagMACROPDF_PARAMS = record
          bReportAppendInfo : BOOL;
          bBufferLabels : BOOL;
          bExclusive : BOOL;
          bConvertToPDF417 : BOOL;
       end;
     MACROPDF_PARAMS = tagMACROPDF_PARAMS;

     tagMACROMICROPDF_PARAMS = record
          bReportAppendInfo : BOOL;
          bBufferLabels : BOOL;
          bExclusive : BOOL;
          bConvertToMicroPDF : BOOL;
       end;
     MACROMICROPDF_PARAMS = tagMACROMICROPDF_PARAMS;

     tagIMAGE_PARAMS = record
          CroppingRect : RECT;
          dwResolutionDivisor : DWORD;
          bEnableAiming : BOOL;
          bEnableIllumination : BOOL;
          dwImageFormat : DWORD;
          dwJpegImageQuality : DWORD;
          dwJpegImageSize : DWORD;
       end;
     IMAGE_PARAMS = tagIMAGE_PARAMS;

     tagSIGNATURE_PARAMS = record
          dwImageFormat : DWORD;
          dwJpegImageQuality : DWORD;
          dwJpegImageSize : DWORD;
       end;
     SIGNATURE_PARAMS = tagSIGNATURE_PARAMS;

     tagWEBCODE_PARAMS = record
          bGTWebcode : BOOL;
       end;
     WEBCODE_PARAMS = tagWEBCODE_PARAMS;

     tagCOMPOSITE_AB_PARAMS = record
          dwUCCLinkMode : DWORD;
          dwMultiMode : DWORD;
       end;
     COMPOSITE_AB_PARAMS = tagCOMPOSITE_AB_PARAMS;

     tagCOMPOSITE_C_PARAMS = record
          dwMultiMode : DWORD;
       end;
     COMPOSITE_C_PARAMS = tagCOMPOSITE_C_PARAMS;

     tagDECODER_SPECIFIC = record
         case longint of
            0 : ( dwUntyped : array[0..19] of DWORD );
            1 : ( upce0_params : UPCE0_PARAMS );
            2 : ( upce1_params : UPCE1_PARAMS );
            3 : ( upca_params : UPCA_PARAMS );
            4 : ( msi_params : MSI_PARAMS );
            5 : ( ean8_params : EAN8_PARAMS );
            6 : ( codabar_params : CODABAR_PARAMS );
            7 : ( code39_params : CODE39_PARAMS );
            8 : ( d2of5_params : D2OF5_PARAMS );
            9 : ( i2of5_params : I2OF5_PARAMS );
            10 : ( code11_params : CODE11_PARAMS );
            11 : ( code93_params : CODE93_PARAMS );
            12 : ( code128_params : CODE128_PARAMS );
            13 : ( trioptic39_params : TRIOPTIC39_PARAMS );
            14 : ( image_params : IMAGE_PARAMS );
            15 : ( signature_params : SIGNATURE_PARAMS );
            16 : ( macropdf_params : MACROPDF_PARAMS );
            17 : ( macromicropdf_params : MACROMICROPDF_PARAMS );
            18 : ( webcode_params : WEBCODE_PARAMS );
            19 : ( composite_ab_params : COMPOSITE_AB_PARAMS );
            20 : ( composite_c_params : COMPOSITE_C_PARAMS );
         end;
     DECODER_SPECIFIC = tagDECODER_SPECIFIC;

     DECODER_PARAMS = record
          StructInfo : STRUCT_INFO;
          cDecoder : DECODER;
          dwMinLength : DWORD;
          dwMaxLength : DWORD;
          dec_specific : DECODER_SPECIFIC;
       end;
  (* far ignored *)

     LPDECODER_PARAMS = ^DECODER_PARAMS;

     tagDECODERS = record
          dwDecoderCount : DWORD;
          byList : array[0..(DECODERS_BUFLEN)-1] of BYTE;
       end;
     DECODERS = tagDECODERS;
  (* far ignored *)

     LPDECODERS = ^DECODERS;

     DECODER_LIST = record
          StructInfo : STRUCT_INFO;
          Decoders : DECODERS;
       end;
  (* far ignored *)

     LPDECODER_LIST = ^DECODER_LIST;
     tagAIMTYPE =  Longint;
     Const
       AIM_TYPE_TRIGGER = 0;
       AIM_TYPE_TIMED_HOLD = 1;
       AIM_TYPE_TIMED_RELEASE = 2;


  type
     tagAIMMODE =  Longint;
     Const
       AIM_MODE_NONE = 0;
       AIM_MODE_DOT = 1;
       AIM_MODE_SLAB = 2;
       AIM_MODE_RETICLE = 3;


  type
     tagRASTERMODE =  Longint;
     Const
       RASTER_MODE_NONE = 0;
       RASTER_MODE_OPEN_ALWAYS = 1;
       RASTER_MODE_SMART = 2;
       RASTER_MODE_CYCLONE = 3;


  type
     tagLINEARSECURITYLEVEL =  Longint;
     Const
       SECURITY_REDUNDANCY_AND_LENGTH = 0;
       SECURITY_SHORT_OR_CODABAR = 1;
       SECURITY_ALL_TWICE = 2;
       SECURITY_LONG_AND_SHORT = 3;
       SECURITY_ALL_THRICE = 4;


  type
     tagFOCUSMODE =  Longint;
     Const
       FOCUS_MODE_FIXED = 0;


  type
     tagFOCUSPOSITION =  Longint;
     Const
       FOCUS_POSITION_FAR = 0;
       FOCUS_POSITION_NEAR = 1;


  type

     tagLASER_SPECIFIC = record
          dwAimType : DWORD;
          dwAimDuration : DWORD;
          dwAimMode : DWORD;
          bNarrowBeam : BOOL;
          dwRasterMode : DWORD;
          dwBeamTimer : DWORD;
          bControlScanLed : BOOL;
          bScanLedLogicLevel : BOOL;
          bKlasseEinsEnable : BOOL;
          bBidirRedundancy : BOOL;
          dwLinearSecurityLevel : DWORD;
          dwPointerTimer : DWORD;
          dwRasterHeight : DWORD;
       end;
     LASER_SPECIFIC = tagLASER_SPECIFIC;

     tagCONTACT_SPECIFIC = record
          dwQuietZoneRatio : DWORD;
          dwInitialScanTime : DWORD;
          dwPulseDelay : DWORD;
       end;
     CONTACT_SPECIFIC = tagCONTACT_SPECIFIC;

     tagIMAGER_SPECIFIC = record
          dwAimType : DWORD;
          dwAimDuration : DWORD;
          dwAimMode : DWORD;
          dwBeamTimer : DWORD;
          dwPointerTimer : DWORD;
          dwImageCaptureTimeout : DWORD;
          dwImageCompressionTimeout : DWORD;
          dwLinearSecurityLevel : DWORD;
          dwFocusMode : DWORD;
          dwFocusPosition : DWORD;
       end;
     IMAGER_SPECIFIC = tagIMAGER_SPECIFIC;

     tagREADER_SPECIFIC = record
         case longint of
            0 : ( dwUntyped : array[0..19] of DWORD );
            1 : ( laser_specific : LASER_SPECIFIC );
            2 : ( contact_specific : CONTACT_SPECIFIC );
            3 : ( imager_specific : IMAGER_SPECIFIC );
         end;
     READER_SPECIFIC = tagREADER_SPECIFIC;
     tagREADER_TYPE =  Longint;
     Const
       READER_TYPE_LASER = 0;
       READER_TYPE_CONTACT = 1;
       READER_TYPE_IMAGER = 2;


  type

     tagREADER_PARAMS = record
          StructInfo : STRUCT_INFO;
          dwReaderType : DWORD;
          ReaderSpecific : READER_SPECIFIC;
       end;
     READER_PARAMS = tagREADER_PARAMS;
  (* far ignored *)

     LPREADER_PARAMS = ^READER_PARAMS;

     tagQSNAC_SPECIFIC = record
          dwEnableSettlingTime : DWORD;
          bInverseLabelData : BOOL;
          bWhiteDataLogicLevel : BOOL;
          dwTransitionResolution : DWORD;
          dwPowerSettlingTime : DWORD;
       end;
     QSNAC_SPECIFIC = tagQSNAC_SPECIFIC;
  (* far ignored *)

     LPQSNAC_SPECIFIC = ^QSNAC_SPECIFIC;

     tagSSI_SPECIFIC = record
          dwPowerSettlingTime : DWORD;
          dwPowerOffSettlingTime : DWORD;
       end;
     SSI_SPECIFIC = tagSSI_SPECIFIC;
  (* far ignored *)

     LPSSI_SPECIFIC = ^SSI_SPECIFIC;

     tagLS48XX_SPECIFIC = record
          dwPowerSettlingTime : DWORD;
       end;
     LS48XX_SPECIFIC = tagLS48XX_SPECIFIC;
  (* far ignored *)

     LPLS48XX_SPECIFIC = ^LS48XX_SPECIFIC;

     tagLIGHTHOUSE_SPECIFIC = record
          dwPowerSettlingTime : DWORD;
          dwEnableSettlingTime : DWORD;
          dwLowPowerTime : DWORD;
       end;
     LIGHTHOUSE_SPECIFIC = tagLIGHTHOUSE_SPECIFIC;
  (* far ignored *)

     LPLIGHTHOUSE_SPECIFIC = ^LIGHTHOUSE_SPECIFIC;

     tagINTERFACE_SPECIFIC = record
         case longint of
            0 : ( dwUntyped : array[0..19] of DWORD );
            1 : ( QsnacSpecific : QSNAC_SPECIFIC );
            2 : ( SsiSpecific : SSI_SPECIFIC );
            3 : ( Ls48xxSpecific : LS48XX_SPECIFIC );
            4 : ( LighthouseSpecific : LIGHTHOUSE_SPECIFIC );
         end;
     INTERFACE_SPECIFIC = tagINTERFACE_SPECIFIC;
     tagINTERFACE_TYPE =  Longint;
     Const
       INTERFACE_TYPE_QSNAC = 0;
       INTERFACE_TYPE_SSI = 1;
       INTERFACE_TYPE_LS48XX = 2;
       INTERFACE_TYPE_LIGHTHOUSE = 3;


  type

     tagINTERFACE_PARAMS = record
          StructInfo : STRUCT_INFO;
          dwInterfaceType : DWORD;
          InterfaceSpecific : INTERFACE_SPECIFIC;
       end;
     INTERFACE_PARAMS = tagINTERFACE_PARAMS;
  (* far ignored *)

     LPINTERFACE_PARAMS = ^INTERFACE_PARAMS;

  const
     PARAMETER_NO_CHANGE = $FFFFFFFF;     

  type
     tagCODEIDTYPE =  Longint;
     Const
       CODE_ID_TYPE_NONE = 0;
       CODE_ID_TYPE_SYMBOL = 1;
       CODE_ID_TYPE_AIM = 2;


  type
     tagSCANTYPE =  Longint;
     Const
       SCAN_TYPE_FOREGROUND = 0;
       SCAN_TYPE_BACKGROUND = 1;
       SCAN_TYPE_MONITOR = 2;


  type

     tagSCAN_PARAMS_W = record
          StructInfo : STRUCT_INFO;
          dwCodeIdType : DWORD;
          dwScanType : DWORD;
          bLocalFeedback : BOOL;
          dwDecodeBeepTime : DWORD;
          dwDecodeBeepFrequency : DWORD;
          dwDecodeLedTime : DWORD;
          szWaveFile : array[0..(MAX_PATH)-1] of WCHAR;
          dwStartBeepTime : DWORD;
          dwStartBeepFrequency : DWORD;
          dwStartLedTime : DWORD;
          szStartWaveFile : array[0..(MAX_PATH)-1] of WCHAR;
          dwIntermedBeepTime : DWORD;
          dwIntermedBeepFrequency : DWORD;
          dwIntermedLedTime : DWORD;
          szIntermedWaveFile : array[0..(MAX_PATH)-1] of WCHAR;
          dwFatalBeepTime : DWORD;
          dwFatalBeepFrequency : DWORD;
          dwFatalLedTime : DWORD;
          szFatalWaveFile : array[0..(MAX_PATH)-1] of WCHAR;
          dwNonfatalBeepTime : DWORD;
          dwNonfatalBeepFrequency : DWORD;
          dwNonfatalLedTime : DWORD;
          szNonfatalWaveFile : array[0..(MAX_PATH)-1] of WCHAR;
          dwActivityBeepTime : DWORD;
          dwActivityBeepFrequency : DWORD;
          dwActivityLedTime : DWORD;
          szActivityWaveFile : array[0..(MAX_PATH)-1] of WCHAR;
       end;
     SCAN_PARAMS_W = tagSCAN_PARAMS_W;
  (* far ignored *)

     LPSCAN_PARAMS_W = ^SCAN_PARAMS_W;

     tagSCAN_PARAMS_A = record
          StructInfo : STRUCT_INFO;
          dwCodeIdType : DWORD;
          dwScanType : DWORD;
          bLocalFeedback : BOOL;
          dwDecodeBeepTime : DWORD;
          dwDecodeBeepFrequency : DWORD;
          dwDecodeLedTime : DWORD;
          szWaveFile : array[0..(MAX_PATH)-1] of CHAR;
          dwStartBeepTime : DWORD;
          dwStartBeepFrequency : DWORD;
          dwStartLedTime : DWORD;
          szStartWaveFile : array[0..(MAX_PATH)-1] of CHAR;
          dwIntermedBeepTime : DWORD;
          dwIntermedBeepFrequency : DWORD;
          dwIntermedLedTime : DWORD;
          szIntermedWaveFile : array[0..(MAX_PATH)-1] of CHAR;
          dwFatalBeepTime : DWORD;
          dwFatalBeepFrequency : DWORD;
          dwFatalLedTime : DWORD;
          szFatalWaveFile : array[0..(MAX_PATH)-1] of CHAR;
          dwNonfatalBeepTime : DWORD;
          dwNonfatalBeepFrequency : DWORD;
          dwNonfatalLedTime : DWORD;
          szNonfatalWaveFile : array[0..(MAX_PATH)-1] of CHAR;
          dwActivityBeepTime : DWORD;
          dwActivityBeepFrequency : DWORD;
          dwActivityLedTime : DWORD;
          szActivityWaveFile : array[0..(MAX_PATH)-1] of CHAR;
       end;
     SCAN_PARAMS_A = tagSCAN_PARAMS_A;
  (* far ignored *)

     LPSCAN_PARAMS_A = ^SCAN_PARAMS_A;
//{$ifdef UNICODE}

  type
     SCAN_PARAMS = SCAN_PARAMS_W;
     LPSCAN_PARAMS = LPSCAN_PARAMS_W;
//{$else}

//  type
//     SCAN_PARAMS = SCAN_PARAMS_A;
//     LPSCAN_PARAMS = LPSCAN_PARAMS_A;
//{$endif}

  type
     tagSCANSTATUS =  Longint;
     Const
       SCAN_STATUS_STOPPED = 1;
       SCAN_STATUS_IDLE = 2;
       SCAN_STATUS_WAITING = 3;
       SCAN_STATUS_SCANNING = 4;
       SCAN_STATUS_AIMING = 5;
       SCAN_STATUS_EMPTY = 6;
       SCAN_STATUS_ERROR = 7;


  type

     tagSCAN_STATUS = record
          StructInfo : STRUCT_INFO;
          bEnabled : BOOL;
          dwStatus : DWORD;
          dwKlasseEinsTimeUsed : DWORD;
          dwKlasseEinsTimeLeft : DWORD;
       end;
     SCAN_STATUS = tagSCAN_STATUS;
  (* far ignored *)

     LPSCAN_STATUS = ^SCAN_STATUS;
     tagUPCEANSECURITYLEVEL =  Longint;
     Const
       UPCEAN_SECURITY_NONE = 0;
       UPCEAN_SECURITY_AMBIGUOUS = 1;
       UPCEAN_SECURITY_ALL = 2;


  type
     tagSUPPLEMENTALMODE =  Longint;
     Const
       SUPPLEMENTALS_NONE = 0;
       SUPPLEMENTALS_ALWAYS = 1;
       SUPPLEMENTALS_AUTO = 2;
       SUPPLEMENTALS_SMART = 3;
       SUPPLEMENTALS_378_379 = 4;
       SUPPLEMENTALS_978 = 5;


  type

     tagUPC_EAN_PARAMS = record
          StructInfo : STRUCT_INFO;
          dwSecurityLevel : DWORD;
          bSupplemental2 : BOOL;
          bSupplemental5 : BOOL;
          dwSupplementalMode : DWORD;
          dwRetryCount : DWORD;
          bRandomWeightCheckDigit : BOOL;
          bLinearDecode : BOOL;
          bBookland : BOOL;
          bCoupon : BOOL;
       end;
     UPC_EAN_PARAMS = tagUPC_EAN_PARAMS;
  (* far ignored *)

     LPUPC_EAN_PARAMS = ^UPC_EAN_PARAMS;

     tagDEVICE_INFO = record
          StructInfo : STRUCT_INFO;
          Decoders : DECODERS;
          bBeamWidth : BOOL;
          bAimMode : BOOL;
          bDirection : BOOL;
          bFeedback : BOOL;
          dwSupportedImageFormats : DWORD;
          MaxImageRect : RECT;
       end;
     DEVICE_INFO = tagDEVICE_INFO;
  (* far ignored *)

     LPDEVICE_INFO = ^DEVICE_INFO;

     tagSCAN_APPEND_INFO_W = record
          StructInfo : STRUCT_INFO;
          dwSegmentIndex : DWORD;
          dwSegmentCount : DWORD;
          szFileId : array[0..(MAX_PATH)-1] of WCHAR;
          TimeStamp : SYSTEMTIME;
          dwFileSize : DWORD;
          dwChecksum : DWORD;
          szFileName : array[0..(MAX_PATH)-1] of WCHAR;
          szSender : array[0..(MAX_PATH)-1] of WCHAR;
          szAddressee : array[0..(MAX_PATH)-1] of WCHAR;
       end;
     SCAN_APPEND_INFO_W = tagSCAN_APPEND_INFO_W;
  (* far ignored *)

     LPSCAN_APPEND_INFO_W = ^SCAN_APPEND_INFO_W;

     tagSCAN_APPEND_INFO_A = record
          StructInfo : STRUCT_INFO;
          dwSegmentIndex : DWORD;
          dwSegmentCount : DWORD;
          szFileId : array[0..(MAX_PATH)-1] of CHAR;
          TimeStamp : SYSTEMTIME;
          dwFileSize : DWORD;
          dwChecksum : DWORD;
          szFileName : array[0..(MAX_PATH)-1] of CHAR;
          szSender : array[0..(MAX_PATH)-1] of CHAR;
          szAddressee : array[0..(MAX_PATH)-1] of CHAR;
       end;
     SCAN_APPEND_INFO_A = tagSCAN_APPEND_INFO_A;
  (* far ignored *)

     LPSCAN_APPEND_INFO_A = ^SCAN_APPEND_INFO_A;
//{$ifdef UNICODE}

  type
     SCAN_APPEND_INFO = SCAN_APPEND_INFO_W;
     LPSCAN_APPEND_INFO = LPSCAN_APPEND_INFO_W;
//{$else}

//  type
//     SCAN_APPEND_INFO = SCAN_APPEND_INFO_A;
//     LPSCAN_APPEND_INFO = LPSCAN_APPEND_INFO_A;
//{$endif}

  type
     tagSCAN_EVENT_CODE =  Longint;
     Const
       SCAN_EVENT_ERROR = 0;
       SCAN_EVENT_STATE_CHANGE = 1;
       SCAN_EVENT_ACTIVITY = 2;
       SCAN_EVENT_IMAGE_CAPTURE = 3;
       SCAN_EVENT_IMAGE_ERROR = 4;
       SCAN_EVENT_START_SEQUENCE = 5;
       SCAN_EVENT_SEQUENCE_START = SCAN_EVENT_START_SEQUENCE;
       SCAN_EVENT_SEQUENCE_CONTINUE = (SCAN_EVENT_START_SEQUENCE)+1;
       SCAN_EVENT_SEQUENCE_FAIL = (SCAN_EVENT_START_SEQUENCE)+2;
       SCAN_EVENT_SEQUENCE_ERROR = (SCAN_EVENT_START_SEQUENCE)+3;
       SCAN_EVENT_SEQUENCE_DUPLICATE = (SCAN_EVENT_START_SEQUENCE)+4;
       SCAN_EVENT_SEQUENCE_INVALID = (SCAN_EVENT_START_SEQUENCE)+5;


  type
     tagBEEPPATTERN =  Longint;
     Const
       BEEP_PATTERN_ONE_SHORT_HIGH = 0;
       BEEP_PATTERN_TWO_SHORT_HIGH = 1;
       BEEP_PATTERN_THREE_SHORT_HIGH = 2;
       BEEP_PATTERN_FOUR_SHORT_HIGH = 3;
       BEEP_PATTERN_FIVE_SHORT_HIGH = 4;
       BEEP_PATTERN_ONE_SHORT_LOW = 5;
       BEEP_PATTERN_TWO_SHORT_LOW = 6;
       BEEP_PATTERN_THREE_SHORT_LOW = 7;
       BEEP_PATTERN_FOUR_SHORT_LOW = 8;
       BEEP_PATTERN_FIVE_SHORT_LOW = 9;
       BEEP_PATTERN_ONE_LONG_HIGH = 10;
       BEEP_PATTERN_TWO_LONG_HIGH = 11;
       BEEP_PATTERN_THREE_LONG_HIGH = 12;
       BEEP_PATTERN_FOUR_LONG_HIGH = 13;
       BEEP_PATTERN_FIVE_LONG_HIGH = 14;
       BEEP_PATTERN_ONE_LONG_LOW = 15;
       BEEP_PATTERN_TWO_LONG_LOW = 16;
       BEEP_PATTERN_THREE_LONG_LOW = 17;
       BEEP_PATTERN_FOUR_LONG_LOW = 18;
       BEEP_PATTERN_FIVE_LONG_LOW = 19;
       BEEP_PATTERN_FAST_WARBLE = 20;
       BEEP_PATTERN_SLOW_WARBLE = 21;
       BEEP_PATTERN_MIX1 = 22;
       BEEP_PATTERN_MIX2 = 23;
       BEEP_PATTERN_MIX3 = 24;
       BEEP_PATTERN_MIX4 = 25;


  type
     tagLEDPATTERN =  Longint;
     Const
       LED_PATTERN_DECODE = 1;
       LED_PATTERN_LED1 = 2;
       LED_PATTERN_LED2 = 4;
       LED_PATTERN_LED3 = 8;
       LED_PATTERN_LED4 = 16;
       LED_PATTERN_LED5 = 32;
       LED_PATTERN_LED6 = 64;
       LED_PATTERN_BLACK = 128;
       LED_PATTERN_PULSE_GREEN = 129;
       LED_PATTERN_PULSE_YELLOW = 130;
       LED_PATTERN_PULSE_RED = 131;
       LED_PATTERN_GREEN = 132;
       LED_PATTERN_YELLOW = 133;
       LED_PATTERN_RED = 134;
       LED_PATTERN_ALT_GB = 135;
       LED_PATTERN_ALT_YB = 136;
       LED_PATTERN_ALT_RB = 137;
       LED_PATTERN_ALT_GY = 138;
       LED_PATTERN_ALT_YR = 139;
       LED_PATTERN_ALT_RG = 140;
       LED_PATTERN_ALT_RYG = 141;
       LED_PATTERN_ALT_GYB = 142;
       LED_PATTERN_ALT_YRG = 143;
       LED_PATTERN_ALT_RGB = 144;
       LED_PATTERN_ALT_RYGB = 145;


  type

     tagFEEDBACK_PARAMS = record
          StructInfo : STRUCT_INFO;
          dwBeepTime : DWORD;
          dwBeepFrequency : DWORD;
          dwLedTime : DWORD;
          szWaveFile : array[0..(MAX_PATH)-1] of WCHAR;
          dwBeepPattern : DWORD;
          dwLedPattern : DWORD;
       end;
     FEEDBACK_PARAMS = tagFEEDBACK_PARAMS;
  (* far ignored *)

     LPFEEDBACK_PARAMS = ^FEEDBACK_PARAMS;

  function SCAN_AllocateBuffer_W(bText:BOOL; dwSize:DWORD):LPSCAN_BUFFER_W;external External_library name 'SCAN_AllocateBuffer_W';

  function SCAN_AllocateBuffer_A(bText:BOOL; dwSize:DWORD):LPSCAN_BUFFER_A;external External_library name 'SCAN_AllocateBuffer_A';
//AB : changed to use W
  function SCAN_AllocateBuffer(bText:BOOL; dwSize:DWORD):LPSCAN_BUFFER;external External_library name 'SCAN_AllocateBuffer_W';

//{$ifdef UNICODE}
//
//  type
//     SCAN_AllocateBuffer = SCAN_AllocateBuffer_W;
// {$else}
//
//   type
//      SCAN_AllocateBuffer = SCAN_AllocateBuffer_A;
// {$endif}
//
//   function SCAN_DeallocateBuffer_W(lpScanBuffer:LPSCAN_BUFFER_W):DWORD;external External_library name 'SCAN_DeallocateBuffer_W';
   function SCAN_DeallocateBuffer(lpScanBuffer:LPSCAN_BUFFER):DWORD;external External_library name 'SCAN_DeallocateBuffer_W';
//
//   function SCAN_DeallocateBuffer_A(lpScanBuffer:LPSCAN_BUFFER_A):DWORD;external External_library name 'SCAN_DeallocateBuffer_A';
//
// {$ifdef UNICODE}

//   const
// //      SCAN_DeallocateBuffer = SCAN_DeallocateBuffer_W;
// {$else}
//
//   const
//      SCAN_DeallocateBuffer = SCAN_DeallocateBuffer_A;
// {$endif}

  function SCAN_FindFirst_W(lpScanFindInfo:LPSCAN_FINDINFO_W; lphFindHandle:LPHANDLE):DWORD;external External_library name 'SCAN_FindFirst_W';

  function SCAN_FindFirst_A(lpScanFindInfo:LPSCAN_FINDINFO_A; lphFindHandle:LPHANDLE):DWORD;external External_library name 'SCAN_FindFirst_A';
//AB changed to unicode
  function SCAN_FindFirst(lpScanFindInfo:LPSCAN_FINDINFO; lphFindHandle:LPHANDLE):DWORD;external External_library name 'SCAN_FindFirst_W';

// {$ifdef UNICODE}

//   const
//      SCAN_FindFirst = SCAN_FindFirst_W;
// {$else}
//
//   const
//      SCAN_FindFirst = SCAN_FindFirst_A;
// {$endif}

  function SCAN_FindNext_W(lpScanFindInfo:LPSCAN_FINDINFO_W; hFindHandle:HANDLE):DWORD;external External_library name 'SCAN_FindNext_W';

  function SCAN_FindNext_A(lpScanFindInfo:LPSCAN_FINDINFO_A; hFindHandle:HANDLE):DWORD;external External_library name 'SCAN_FindNext_A';
//ab : changed to W
  function SCAN_FindNext(lpScanFindInfo:LPSCAN_FINDINFO; hFindHandle:HANDLE):DWORD;external External_library name 'SCAN_FindNext_W';

// {$ifdef UNICODE}
//
//   const
//      SCAN_FindNext = SCAN_FindNext_W;
// {$else}
// //
//   const
//      SCAN_FindNext = SCAN_FindNext_A;
// {$endif}

  function SCAN_FindClose(hFindHandle:HANDLE):DWORD;external External_library name 'SCAN_FindClose';

  function SCAN_Open(lpszDeviceName:LPCTSTR; lphScanner:LPHANDLE):DWORD;external External_library name 'SCAN_Open';

  function SCAN_GetVersionInfo(hScanner:HANDLE; lpScanVersionInfo:LPSCAN_VERSION_INFO):DWORD;external External_library name 'SCAN_GetVersionInfo';

  function SCAN_Close(hScanner:HANDLE):DWORD;external External_library name 'SCAN_Close';

  function SCAN_Enable(hScanner:HANDLE):DWORD;external External_library name 'SCAN_Enable';

  function SCAN_Disable(hScanner:HANDLE):DWORD;external External_library name 'SCAN_Disable';

  function SCAN_ReadLabelEvent_W(hScanner:HANDLE; lpScanBuffer:LPSCAN_BUFFER_W; hEvent:HANDLE; dwTimeout:DWORD; lpdwRequestID:LPDWORD):DWORD;external External_library name 'SCAN_ReadLabelEvent_W';

  function SCAN_ReadLabelEvent_A(hScanner:HANDLE; lpScanBuffer:LPSCAN_BUFFER_A; hEvent:HANDLE; dwTimeout:DWORD; lpdwRequestID:LPDWORD):DWORD;external External_library name 'SCAN_ReadLabelEvent_A';

    function SCAN_ReadLabelEvent(hScanner:HANDLE; lpScanBuffer:LPSCAN_BUFFER_W; hEvent:HANDLE; dwTimeout:DWORD; lpdwRequestID:LPDWORD):DWORD;external External_library name 'SCAN_ReadLabelEvent_W';

// {$ifdef UNICODE}
//
//   const
//      SCAN_ReadLabelEvent = SCAN_ReadLabelEvent_W;
// {$else}
//
//   const
//      SCAN_ReadLabelEvent = SCAN_ReadLabelEvent_A;
// {$endif}

  function SCAN_ReadLabelMsg_W(hScanner:HANDLE; lpScanBuffer:LPSCAN_BUFFER_W; hWnd:HWND; uiMsgNo:UINT; dwTimeout:DWORD; 
             lpdwRequestID:LPDWORD):DWORD;external External_library name 'SCAN_ReadLabelMsg_W';

  function SCAN_ReadLabelMsg_A(hScanner:HANDLE; lpScanBuffer:LPSCAN_BUFFER_A; hWnd:HWND; uiMsgNo:UINT; dwTimeout:DWORD; 
             lpdwRequestID:LPDWORD):DWORD;external External_library name 'SCAN_ReadLabelMsg_A';

  function SCAN_ReadLabelMsg(hScanner:HANDLE; lpScanBuffer:LPSCAN_BUFFER; hWnd:HWND; uiMsgNo:UINT; dwTimeout:DWORD;
             lpdwRequestID:LPDWORD):DWORD;external External_library name 'SCAN_ReadLabelMsg_W';


// {$ifdef UNICODE}
//
//   const
//      SCAN_ReadLabelMsg = SCAN_ReadLabelMsg_W;
// {$else}
//
//   const
//      SCAN_ReadLabelMsg = SCAN_ReadLabelMsg_A;
// {$endif}

  function SCAN_ReadLabelWait_W(hScanner:HANDLE; lpScanBuffer:LPSCAN_BUFFER_W; dwTimeout:DWORD):DWORD;external External_library name 'SCAN_ReadLabelWait_W';

  function SCAN_ReadLabelWait_A(hScanner:HANDLE; lpScanBuffer:LPSCAN_BUFFER_A; dwTimeout:DWORD):DWORD;external External_library name 'SCAN_ReadLabelWait_A';
  function SCAN_ReadLabelWait(hScanner:HANDLE; lpScanBuffer:LPSCAN_BUFFER; dwTimeout:DWORD):DWORD;external External_library name 'SCAN_ReadLabelWait_W';

// {$ifdef UNICODE}
//
//   const
//      SCAN_ReadLabelWait = SCAN_ReadLabelWait_W;
// {$else}
//
//   const
//      SCAN_ReadLabelWait = SCAN_ReadLabelWait_A;
// {$endif}

  function SCAN_CancelRead(hScanner:HANDLE; dwRequestID:DWORD):DWORD;external External_library name 'SCAN_CancelRead';

  function SCAN_Flush(hScanner:HANDLE):DWORD;external External_library name 'SCAN_Flush';

  function SCAN_GetSoftTrigger(hScanner:HANDLE; lpSoftTrigger:LPBOOL):DWORD;external External_library name 'SCAN_GetSoftTrigger';

  function SCAN_SetSoftTrigger(hScanner:HANDLE; lpSoftTrigger:LPBOOL):DWORD;external External_library name 'SCAN_SetSoftTrigger';

  function SCAN_GetDeviceInfo(hScanner:HANDLE; lpDeviceInfo:LPDEVICE_INFO):DWORD;external External_library name 'SCAN_GetDeviceInfo';

  function SCAN_GetSupportedDecoders(hScanner:HANDLE; lpDecoderList:LPDECODER_LIST):DWORD;external External_library name 'SCAN_GetSupportedDecoders';

  function SCAN_GetEnabledDecoders(hScanner:HANDLE; lpDecoderList:LPDECODER_LIST):DWORD;external External_library name 'SCAN_GetEnabledDecoders';

  function SCAN_SetEnabledDecoders(hScanner:HANDLE; lpDecoderList:LPDECODER_LIST):DWORD;external External_library name 'SCAN_SetEnabledDecoders';

  function SCAN_GetDecoderParams(hScanner:HANDLE; lpDecoder:LPDECODER; lpDecoderParams:LPDECODER_PARAMS):DWORD;external External_library name 'SCAN_GetDecoderParams';

  function SCAN_SetDecoderParams(hScanner:HANDLE; lpDecoder:LPDECODER; lpDecoderParams:LPDECODER_PARAMS):DWORD;external External_library name 'SCAN_SetDecoderParams';

  function SCAN_GetUPCEANParams(hScanner:HANDLE; lpUPCEANParams:LPUPC_EAN_PARAMS):DWORD;external External_library name 'SCAN_GetUPCEANParams';

  function SCAN_SetUPCEANParams(hScanner:HANDLE; lpUPCEANParams:LPUPC_EAN_PARAMS):DWORD;external External_library name 'SCAN_SetUPCEANParams';

  function SCAN_GetReaderParams(hScanner:HANDLE; lpReaderParams:LPREADER_PARAMS):DWORD;external External_library name 'SCAN_GetReaderParams';

  function SCAN_SetReaderParams(hScanner:HANDLE; lpReaderParams:LPREADER_PARAMS):DWORD;external External_library name 'SCAN_SetReaderParams';

  function SCAN_GetInterfaceParams(hScanner:HANDLE; lpInterfaceParams:LPINTERFACE_PARAMS):DWORD;external External_library name 'SCAN_GetInterfaceParams';

  function SCAN_SetInterfaceParams(hScanner:HANDLE; lpInterfaceParams:LPINTERFACE_PARAMS):DWORD;external External_library name 'SCAN_SetInterfaceParams';

  function SCAN_GetScanParameters_W(hScanner:HANDLE; lpScanParams:LPSCAN_PARAMS_W):DWORD;external External_library name 'SCAN_GetScanParameters_W';

  function SCAN_GetScanParameters_A(hScanner:HANDLE; lpScanParams:LPSCAN_PARAMS_A):DWORD;external External_library name 'SCAN_GetScanParameters_A';
  function SCAN_GetScanParameters(hScanner:HANDLE; lpScanParams:LPSCAN_PARAMS_A):DWORD;external External_library name 'SCAN_GetScanParameters_W';

// {$ifdef UNICODE}
//
//   const
//      SCAN_GetScanParameters = SCAN_GetScanParameters_W;
// {$else}
//
//   const
//      SCAN_GetScanParameters = SCAN_GetScanParameters_A;
// {$endif}

  function SCAN_SetScanParameters_W(hScanner:HANDLE; lpScanParams:LPSCAN_PARAMS_W):DWORD;external External_library name 'SCAN_SetScanParameters_W';

  function SCAN_SetScanParameters_A(hScanner:HANDLE; lpScanParams:LPSCAN_PARAMS_A):DWORD;external External_library name 'SCAN_SetScanParameters_A';
  function SCAN_SetScanParameters(hScanner:HANDLE; lpScanParams:LPSCAN_PARAMS):DWORD;external External_library name 'SCAN_SetScanParameters_W';

// {$ifdef UNICODE}
//
//   const
//      SCAN_SetScanParameters = SCAN_SetScanParameters_W;
// {$else}
//
//   const
//      SCAN_SetScanParameters = SCAN_SetScanParameters_A;
// {$endif}

  function SCAN_GetScanStatus(hScanner:HANDLE; lpScanStatus:LPSCAN_STATUS):DWORD;external External_library name 'SCAN_GetScanStatus';

  function SCAN_RegisterScanMessage(hScanner:HANDLE; hWnd:HWND; uiMessage:UINT):DWORD;external External_library name 'SCAN_RegisterScanMessage';

  function SCAN_DeregisterScanMessage(hScanner:HANDLE):DWORD;external External_library name 'SCAN_DeregisterScanMessage';

  function SCAN_DoRemoteFeedback(hScanner:HANDLE; lpFeedbackParams:LPFEEDBACK_PARAMS):DWORD;external External_library name 'SCAN_DoRemoteFeedback';

//  function SCAN_Ioctl(hScanner:HANDLE; dwIoctlCode:DWORD; lpvInBuf:LPVOID; dwInBufSize:DWORD; lpvOutBuf:LPVOID;
//             dwOutBufSize:DWORD; lpdwActualOut:LPDWORD):DWORD;external External_library name 'SCAN_Ioctl';


implementation



end.
