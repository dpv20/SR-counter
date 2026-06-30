create or replace PACKAGE BODY gwpks_query_cust_claccounts AS

  /*----------------------------------------------------------------------------------------------------
      **
      ** File Name      : gwpks_query_install_payment.SQL
      **
      ** Module         : CL
      **
      ** This source is part of the FLEXCUBE Software System and is copyrighted by Oracle Financial Services Software Limited.

      ** All rights reserved.  No part of this work may be reproduced, stored in a retrieval system,
      ** adopted or transmitted in any form or by any means, electronic, mechanical, photographic,
      ** graphic, optic recording or otherwise, translated in any language or computer language, without
      ** the prior written permission of Oracle Financial Services Software Limited.

      ** Oracle Financial Services Software Limited.
      ** 10-11, SDF I, SEEPZ, Andheri (East),
      ** Mumbai - 400 096.
      ** India
      ** Copyright ©  2013 by Oracle Financial Services Software Limited.
      **

          ** Log Number /RS TAG           :
          ** Modified By                  :
          ** Modified On                  :
          ** Site Code                    :
          ** Search String                :
      ----------------------------------------------------------------------------------------------------*/
  pkg_key    CLOB := EMPTY_CLOB;
  pkg_data   CLOB := EMPTY_CLOB;
  pkg_parent CLOB := EMPTY_CLOB;
  pkg_format CLOB := EMPTY_CLOB;

  PROCEDURE dbg(p_msg VARCHAR2) IS
  BEGIN
    IF debug.pkg_debug_on <> 2
    THEN
      debug.pr_debug('IF', 'gwpks_query_cust_claccounts-->' || p_msg);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END dbg;

   FUNCTION fn_reassign_clob(p_key         IN OUT CLOB,
                            p_data        IN OUT CLOB,
                            p_parent      IN OUT CLOB,
                            p_format      IN OUT CLOB,
                            p_error_code  IN OUT VARCHAR2,
                            p_error_param IN OUT VARCHAR2) RETURN BOOLEAN IS

  BEGIN



    dbms_lob.writeappend(pkg_key, LENGTH(p_key), p_key);

    dbms_lob.writeappend(pkg_data, LENGTH(p_data), p_data);

    dbms_lob.writeappend(pkg_parent, LENGTH(p_parent), p_parent);

    dbms_lob.writeappend(pkg_format, LENGTH(p_format), p_format);

    dbg('Returning true from the function fn_reassign_clob');
    RETURN TRUE;

  EXCEPTION
    WHEN OTHERS THEN
      dbg('Oracle Error in assigning CLOB-->' || SQLERRM);
      dbg('Failed at line-->' || dbms_utility.format_error_backtrace);
      p_error_code  := 'AC-UNC06';
      p_error_param := SQLERRM;
      RETURN FALSE;
  END fn_reassign_clob;

  PROCEDURE pr_log_error(p_source     VARCHAR2
            ,p_err_code   VARCHAR2
            ,p_err_params VARCHAR2) IS
    l_fid VARCHAR2(32767) := 'CLQPAYQY';
  BEGIN
    cspks_req_utils.pr_log_error(p_source, l_fid, p_err_code, p_err_params);
  END pr_log_error;

  FUNCTION fn_ts_to_type(prectype    IN VARCHAR2
            ,pkey        IN VARCHAR2
            ,pdata       IN VARCHAR2
            ,p_rec_qclacc IN OUT TY_REC_CLACC
            ,p_err_code  IN OUT VARCHAR2
            ,p_err_param IN OUT VARCHAR2) RETURN BOOLEAN IS
    l_rec            VARCHAR2(30);
    l_parent_counter NUMBER(3) := 1;
    l_field_counter  NUMBER(3) := 1;
    lkey             VARCHAR2(8000);
    ldata            VARCHAR2(8000);
    l_curr_col       VARCHAR2(8000);
    l_curr_val       VARCHAR2(8000);
    l_dsn_rec_cnt_2  NUMBER;
  BEGIN
    dbg('inside fn_ts_to_type function of gwpks_query_cust_claccounts');
    dbg('prectype:' || prectype);
    dbg('l_parent_counter:' || l_parent_counter);
    l_rec := nvl(cspkes_misc.fn_getparam(prectype, l_parent_counter, '>'), '??');
    WHILE l_rec <> 'EOPL'
    LOOP
      lkey  := nvl(cspkes_misc.fn_getparam(pkey, l_parent_counter, '>'), '??');
      ldata := nvl(cspkes_misc.fn_getparam(pdata, l_parent_counter, '>'), NULL);
      dbg('lkey:' || lkey);
      dbg('ldata:' || ldata);
/*      IF l_rec IN ('Cl-Query-Cl-Accounts')
      THEN*/
        dbg('l_reck is :' || l_rec);
        WHILE nvl(cspkes_misc.fn_getparam(lkey, l_field_counter, '~'), '??') <> 'EOPL'
        LOOP
          l_curr_col := nvl(cspkes_misc.fn_getparam(lkey, l_field_counter, '~'), '??');
          dbg('l_curr_col' || l_curr_col);
          l_curr_val := nvl(cspkes_misc.fn_getparam(ldata, l_field_counter, '~'), NULL);
          dbg('l_curr_val' || l_curr_val);
          dbg('l_curr_col:' || l_curr_col);
          IF l_curr_col = 'ACCNO'
          THEN
                p_rec_qclacc.g_account_number := l_curr_val;
                dbg('passing ACCOUNT NUMBER is :' || p_rec_qclacc.g_account_number);
          ELSIF l_curr_col = 'CUSTOMERNO'
           THEN
                p_rec_qclacc.G_CUSTOMER_NO := l_curr_val;

          ELSIF l_curr_col = 'BRNCODE'
           THEN
                p_rec_qclacc.g_branch_code := l_curr_val;

          ELSIF l_curr_col = 'USERDEFINEDSTATUS'
           THEN
                p_rec_qclacc.G_USER_DEFINED_STATUS := l_curr_val;

          ELSIF l_curr_col = 'SHORTNAME'
           THEN
                p_rec_qclacc.G_SHORT_NAME := l_curr_val;

          ELSIF l_curr_col = 'ACCOUNTSTATUS'
          THEN
                p_rec_qclacc.G_ACCOUNT_STATUS := l_curr_val;

          ELSIF l_curr_col = 'LASTRECNO'
          THEN
                p_rec_qclacc.G_LAST_REC_NO := l_curr_val;

          ELSIF l_curr_col = 'NORECPERPAGE'
          THEN
                p_rec_qclacc.G_NOREC_PER_PAGE := l_curr_val;

          END IF;
          l_field_counter := l_field_counter + 1;
        END LOOP;
        l_field_counter := 1;
  /*    END IF;*/
      l_field_counter  := 1;
      l_parent_counter := l_parent_counter + 1;
      l_rec            := nvl(cspkes_misc.fn_getparam(prectype, l_parent_counter, '>'), '??');
      dbg('the l_rec is  :' || l_rec);
    END LOOP;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      clpkss_logger.pr_log_exception('Inside WHEN OTHERS In Function fn_ts_to_type' || SQLERRM);
      p_err_code  := 'ED-INVDATA';
      p_err_param := SQLERRM || '~' || l_rec;
      RETURN FALSE;
  END fn_ts_to_type;


  FUNCTION fn_replybuilder(p_wrk_claccnts IN TY_CLACCOUNT_TB
          ,p_rec_claccounts       IN TY_REC_CLACC -- ingreso
          ,p_key     IN OUT NOCOPY CLOB
          ,p_data       IN OUT NOCOPY CLOB
          ,p_parent    IN OUT NOCOPY CLOB
          ,p_format    IN OUT NOCOPY CLOB
          ,p_mode      IN VARCHAR2
          ,p_errs      IN OUT VARCHAR2
          ,p_prms      IN OUT VARCHAR2) RETURN BOOLEAN IS

            i_2 NUMBER(5);
            p_data_1 varchar2(32767);
            p_key_1 varchar2(32767);
            L_ERROR_CODE VARCHAR2(255);
            L_ERROR_PARAM VARCHAR2(255);
            p_tslist VARCHAR2(1000);
            g_cnt_lvl NUMBER := 1;
            g_cnt_lvl2 NUMBER;

  BEGIN
    dbg('Inside Function gwpks_query_cust_claccounts.fn_ReplyBuilder');
    dbg('p_mode ' || p_mode);
    dbg('p_Data --> ' || p_data);
    dbg('p_Key  --> ' || p_key);
    dbg('P_Format --> ' || p_format);
    dbg('P_Parent --> ' || p_parent);
    dbg('Building Childs Of :');

      dbms_lob.createtemporary(pkg_key, true);
      dbms_lob.createtemporary(pkg_data, true);
      dbms_lob.createtemporary(pkg_parent, true);
      dbms_lob.createtemporary(pkg_format, true);
      dbg('Before creating ');

      dbms_lob.open(pkg_key, dbms_lob.lob_readwrite);
      dbms_lob.open(pkg_data, dbms_lob.lob_readwrite);
      dbms_lob.open(pkg_parent, dbms_lob.lob_readwrite);
      dbms_lob.open(pkg_format, dbms_lob.lob_readwrite);



      p_data :=p_data ||p_rec_claccounts.G_CUSTOMER_NO|| '~' ||
                        p_rec_claccounts.G_ACCOUNT_NUMBER|| '~' ||
                        p_rec_claccounts.G_BRANCH_CODE || '~' ||
                        p_rec_claccounts.G_SHORT_NAME || '~' ||
                        p_rec_claccounts.G_ACCOUNT_STATUS || '~' ||
                        p_rec_claccounts.G_USER_DEFINED_STATUS || '~' ||
                        p_rec_claccounts.G_LAST_REC_NO || '~' ||
                        p_rec_claccounts.G_NOREC_PER_PAGE || '~' ||
                        p_rec_claccounts.G_TOTAL_REC_NO || '~' ||'>';


      p_key := 'CUSTOMERNO~ACCNO~BRNCODE~SHORTNAME~ACCOUNTSTATUS~USERDEFINEDSTATUS~LASTRECNO~NORECPERPAGE~TOTALRECNO~>';


      p_parent := 'C-Cl-Query-Accounts' || '>';

        p_format := p_format || '1' || '>';

                  IF NOT fn_reassign_clob(p_key,
                                  p_data,
                                  p_parent,
                                  p_format,
                                  L_ERROR_CODE,
                                  L_ERROR_PARAM) THEN
            dbg('Assigning the clob variable failed-->' || L_ERROR_CODE || '~~' ||
                L_ERROR_PARAM);
            RETURN FALSE;
          END IF;



      p_tslist   := 'ACCNO~BRANCH~ALTACCNO~ACCOUNTSTATUS~USERDEFINEDSTATUS~PRODUCTCODE~PRODUCTDESC~AMOUNTFINANCED~VALUEDATE~BOOKDATE~MATURITYDATE~ORIGINALSTDATE~CURRENCY~NETPRINCIPAL~NOOFINSTALLMENTS~NOOFINSTALLNOW~CUSTOMERID~MAKERID~SHORTNAME~OVERDUEDAYS~NOPAIDINSTALL~UDEVAL~NXTPAIDINSTALL~NEXTINSTALLDUE~FIELDCHAR1~FIELDCHAR2~FIELDCHAR3~FIELDCHAR4~FIELDCHAR5~FIELDCHAR6~FIELDCHAR7~FIELDCHAR8~FIELDCHAR9~FIELDCHAR10~FIELDCHAR11~FIELDCHAR12~FIELDCHAR13~FIELDCHAR14~FIELDCHAR15~FIELDCHAR16~FIELDCHAR17~FIELDCHAR18~FIELDCHAR19~FIELDCHAR20~FIELDNUMBER1~FIELDNUMBER2~FIELDNUMBER3~FIELDNUMBER4~FIELDNUMBER5~FIELDNUMBER6~FIELDNUMBER7~FIELDNUMBER8~FIELDNUMBER9~FIELDNUMBER10~FIELDNUMBER11~FIELDNUMBER12~FIELDNUMBER13~FIELDNUMBER14~FIELDNUMBER15~FIELDNUMBER16~FIELDNUMBER17~FIELDNUMBER18~FIELDNUMBER19~FIELDNUMBER20~FIELDDATE1~FIELDDATE2~FIELDDATE3~FIELDDATE4~FIELDDATE5~FIELDDATE6~FIELDDATE7~FIELDDATE8~FIELDDATE9~FIELDDATE10~>';
      -- LEGOVDDAYS~TOTALODDAYS :: Added Rajesh
      g_cnt_lvl2 := 0;

      IF p_wrk_claccnts.count >0
       THEN
       dbg('Total Count '||p_wrk_claccnts.count);
       FOR i_2 in 1 .. p_wrk_claccnts.count
           LOOP
          p_key    := EMPTY_CLOB();
          p_data   := EMPTY_CLOB();
          p_parent := EMPTY_CLOB();
          p_format := EMPTY_CLOB();
          g_cnt_lvl2 := g_cnt_lvl2+1;

           DBG('Asinging parent '||i_2);
                  p_parent := p_parent || 'C-CLACCDET' || '>';
                  p_data := p_data ||p_wrk_claccnts(i_2).ACCOUNT_NUMBER|| '~' ||
                  p_wrk_claccnts(i_2).BRANCH_CODE|| '~' ||
                  p_wrk_claccnts(i_2).ALT_ACC_NO|| '~' ||
                  p_wrk_claccnts(i_2).ACCOUNT_STATUS|| '~' ||
                  p_wrk_claccnts(i_2).USER_DEFINED_STATUS|| '~' ||
                  p_wrk_claccnts(i_2).PRODUCT_CODE|| '~' ||
                  p_wrk_claccnts(i_2).PRODUCT_DESC|| '~' ||
                  p_wrk_claccnts(i_2).AMOUNT_FINANCED|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).VALUE_DATE, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).BOOK_DATE, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).MATURITY_DATE, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).ORIGINAL_ST_DATE, 'YYYY-MM-DD')|| '~' ||
                  p_wrk_claccnts(i_2).CURRENCY|| '~' ||
                  p_wrk_claccnts(i_2).NET_PRINCIPAL|| '~' ||
                  p_wrk_claccnts(i_2).NO_OF_INSTALLMENTS|| '~' ||
                  p_wrk_claccnts(i_2).NO_OF_INSTALL_NOW|| '~' ||
                  p_wrk_claccnts(i_2).CUSTOMER_ID|| '~' ||
                  p_wrk_claccnts(i_2).MAKER_ID|| '~' ||
                  p_wrk_claccnts(i_2).SHORT_NAME|| '~' ||
                  p_wrk_claccnts(i_2).OVERDUEDAYS|| '~' ||
                  p_wrk_claccnts(i_2).NO_PAID_INSTALL|| '~' ||
                  p_wrk_claccnts(i_2).UDE_VAL|| '~' ||
                  p_wrk_claccnts(i_2).NEXT_INSTALL_NO|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).NEXT_INSTALL_DUE, 'YYYY-MM-DD')|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_1|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_2|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_3|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_4|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_5|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_6|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_7|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_8|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_9|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_10|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_11|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_12|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_13|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_14|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_15|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_16|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_17|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_18|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_19|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_CHAR_20|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_1|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_2|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_3|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_4|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_5|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_6|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_7|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_8|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_9|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_10|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_11|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_12|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_13|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_14|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_15|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_16|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_17|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_18|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_19|| '~' ||
                  p_wrk_claccnts(i_2).FIELD_NUMBER_20|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_1, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_2, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_3, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_4, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_5, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_6, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_7, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_8, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_9, 'YYYY-MM-DD')|| '~' ||
                  TO_CHAR(p_wrk_claccnts(i_2).FIELD_DATE_10, 'YYYY-MM-DD')|| '~' || '>';

           p_key      := p_key || p_tslist;
           p_format := p_format || g_cnt_lvl || '.' ||g_cnt_lvl2 || '>';



              dbg('p_Data --> ' || p_data);
              dbg('p_parent  --> ' || p_parent);
              dbg('p_key  --> ' || p_key);
          IF NOT fn_reassign_clob(p_key,
                                  p_data,
                                  p_parent,
                                  p_format,
                                  L_ERROR_CODE,
                                  L_ERROR_PARAM) THEN
            dbg('Assigning the clob variable failed-->' || L_ERROR_CODE || '~~' ||
                L_ERROR_PARAM);
            RETURN FALSE;
          END IF;

           END LOOP;
        END IF;


      P_KEY  :=  PKG_KEY;
      P_DATA :=  PKG_DATA;
      p_parent := pkg_parent;
      p_format := pkg_format;
      dbms_lob.close(pkg_key);
      dbms_lob.close(pkg_data);
      dbms_lob.close(pkg_parent);
      dbms_lob.close(pkg_format);
      dbg('p_Data --> ' || p_data);
      dbg('p_parent --> ' || p_parent);
    dbg('End of Fn_FsReplybuilder');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
    dbg('wot:'||dbms_utility.format_error_backtrace );
      clpkss_logger.pr_log_exception('In WOT of fn_ReplyBuilder with SQLERRM ->' || SQLERRM);
      p_errs := 'ED-UPLOTH';
      p_prms := 'fn_ReplyBuilder ~' || SQLCODE || '~';
      RETURN FALSE;
  END fn_replybuilder;
FUNCTION fn_query( p_source         IN VARCHAR2
                  ,p_rec_claccounts IN OUT TY_REC_CLACC -- ingreso
                  ,p_wrk_claccounts IN OUT TY_CLACCOUNT_TB -- salida
                  ,p_err_code       IN OUT VARCHAR2
                  ,p_err_params     IN OUT VARCHAR2) RETURN BOOLEAN IS
  l_acc_number         cltbs_account_apps_master.account_number%TYPE;
  l_brn_cd             cltbs_account_apps_master.branch_code%TYPE;
  l_dynamic_sql_stmt   VARCHAR2(32767);
  l_dynamic_sql_count  VARCHAR2(32767);
  l_oddays             NUMBER;
  l_max_paid_sch       NUMBER;
  l_schedule_odue_date DATE;
  l_total_no_sch       NUMBER;
  l_product_desc       VARCHAR2(255);
  l_ude_val            NUMBER;
  l_total_records      NUMBER := 0;
  l_next_install_no    NUMBER;
  l_where_cond         VARCHAR2(100);

BEGIN

  dbg('Inside Query ...'||p_rec_claccounts.G_ACCOUNT_NUMBER);
  dbg('p_rec_claccounts.G_LAST_REC_NO' || p_rec_claccounts.G_LAST_REC_NO);
  dbg('p_rec_claccounts.G_NOREC_PER_PAGE' ||
      p_rec_claccounts.G_NOREC_PER_PAGE);


 IF p_rec_claccounts.G_ACCOUNT_NUMBER IS NULL
 THEN
    IF p_rec_claccounts.G_USER_DEFINED_STATUS IS NOT NULL AND p_rec_claccounts.G_ACCOUNT_STATUS IS NOT NULL
    THEN

    l_where_cond := ''''||p_rec_claccounts.G_CUSTOMER_NO
                       ||''' AND USER_DEFINED_STATUS = '''||p_rec_claccounts.G_USER_DEFINED_STATUS
                       ||''' AND ACCOUNT_STATUS = '''||p_rec_claccounts.G_ACCOUNT_STATUS||'''';

    ELSIF p_rec_claccounts.G_USER_DEFINED_STATUS IS NOT NULL AND p_rec_claccounts.G_ACCOUNT_STATUS IS NULL
     THEN
      l_where_cond := ''''||p_rec_claccounts.G_CUSTOMER_NO
                       ||''' AND USER_DEFINED_STATUS = '''||p_rec_claccounts.G_USER_DEFINED_STATUS||'''';

    ELSIF p_rec_claccounts.G_USER_DEFINED_STATUS IS NULL AND p_rec_claccounts.G_ACCOUNT_STATUS IS NOT NULL
     THEN

       l_where_cond := ''''||p_rec_claccounts.G_CUSTOMER_NO
                          ||''' AND ACCOUNT_STATUS = '''||p_rec_claccounts.G_ACCOUNT_STATUS||'''';
    ELSE
    l_where_cond := ''''||p_rec_claccounts.G_CUSTOMER_NO||'''';

    END IF;

  ELSE

    IF p_rec_claccounts.G_USER_DEFINED_STATUS IS NOT NULL AND p_rec_claccounts.G_ACCOUNT_STATUS IS NOT NULL
    THEN

     l_where_cond := ''''||p_rec_claccounts.G_ACCOUNT_NUMBER
                       ||''' AND BRANCH_CODE = '''||p_rec_claccounts.G_BRANCH_CODE
                       ||''' AND USER_DEFINED_STATUS = '''||p_rec_claccounts.G_USER_DEFINED_STATUS
                       ||''' AND ACCOUNT_STATUS = '''||p_rec_claccounts.G_ACCOUNT_STATUS||'''';

    ELSIF p_rec_claccounts.G_USER_DEFINED_STATUS IS NOT NULL AND p_rec_claccounts.G_ACCOUNT_STATUS IS NULL
     THEN
      l_where_cond := ''''||p_rec_claccounts.G_ACCOUNT_NUMBER
                       ||''' AND BRANCH_CODE = '''||p_rec_claccounts.G_BRANCH_CODE
                       ||''' AND USER_DEFINED_STATUS = '''||p_rec_claccounts.G_USER_DEFINED_STATUS||'''';

    ELSIF p_rec_claccounts.G_USER_DEFINED_STATUS IS NULL AND p_rec_claccounts.G_ACCOUNT_STATUS IS NOT NULL
     THEN

       l_where_cond := ''''||p_rec_claccounts.G_ACCOUNT_NUMBER
                       ||''' AND BRANCH_CODE = '''||p_rec_claccounts.G_BRANCH_CODE
                          ||''' AND ACCOUNT_STATUS = '''||p_rec_claccounts.G_ACCOUNT_STATUS||'''';
    ELSE
    l_where_cond := ''''||p_rec_claccounts.G_ACCOUNT_NUMBER
                       ||''' AND BRANCH_CODE = '''||p_rec_claccounts.G_BRANCH_CODE||'''';

    END IF;

  END IF;


  IF p_rec_claccounts.G_ACCOUNT_NUMBER is NULL THEN

    l_dynamic_sql_count := 'SELECT COUNT(1)
                            FROM (
                            SELECT a.* ,row_number()
                            OVER (PARTITION BY CUSTOMER_ID ORDER BY ACCOUNT_NUMBER ASC) as ROWNO
                            FROM  cltbs_account_apps_master a
                            where customer_id = ' || l_where_cond || ')';

    EXECUTE IMMEDIATE l_dynamic_sql_count INTO l_total_records;

    l_dynamic_sql_stmt := 'SELECT ACCOUNT_NUMBER,
          BRANCH_CODE,
          ALT_ACC_NO,
          ACCOUNT_STATUS,
          USER_DEFINED_STATUS,
          PRODUCT_CODE,
          NULL PRODUCT_DESC,
          AMOUNT_FINANCED,
          VALUE_DATE,
          BOOK_DATE,
          MATURITY_DATE,
          ORIGINAL_ST_DATE,
          CURRENCY,
          NET_PRINCIPAL,
          NO_OF_INSTALLMENTS,
          NULL NO_OF_INSTALL_NOW,
          CUSTOMER_ID,
          MAKER_ID,
          NULL SHORT_NAME,
          NULL OVERDUEDAYS,
          NULL NO_PAID_INSTALL,
          NULL UDE_VAL,
          NULL NEXT_INSTALL_NO,
          NULL NEXT_INSTALL_DUE,
          FIELD_CHAR_1,
          FIELD_CHAR_2,
          FIELD_CHAR_3,
          FIELD_CHAR_4,
          FIELD_CHAR_5,
          FIELD_CHAR_6,
          FIELD_CHAR_7,
          FIELD_CHAR_8,
          FIELD_CHAR_9,
          FIELD_CHAR_10,
          FIELD_CHAR_11,
          FIELD_CHAR_12,
          FIELD_CHAR_13,
          FIELD_CHAR_14,
          FIELD_CHAR_15,
          FIELD_CHAR_16,
          FIELD_CHAR_17,
          FIELD_CHAR_18,
          FIELD_CHAR_19,
          FIELD_CHAR_20,
          FIELD_NUMBER_1,
          FIELD_NUMBER_2,
          FIELD_NUMBER_3,
          FIELD_NUMBER_4,
          FIELD_NUMBER_5,
          FIELD_NUMBER_6,
          FIELD_NUMBER_7,
          FIELD_NUMBER_8,
          FIELD_NUMBER_9,
          FIELD_NUMBER_10,
          FIELD_NUMBER_11,
          FIELD_NUMBER_12,
          FIELD_NUMBER_13,
          FIELD_NUMBER_14,
          FIELD_NUMBER_15,
          FIELD_NUMBER_16,
          FIELD_NUMBER_17,
          FIELD_NUMBER_18,
          FIELD_NUMBER_19,
          FIELD_NUMBER_20,
          FIELD_DATE_1,
          FIELD_DATE_2,
          FIELD_DATE_3,
          FIELD_DATE_4,
          FIELD_DATE_5,
          FIELD_DATE_6,
          FIELD_DATE_7,
          FIELD_DATE_8,
          FIELD_DATE_9,
          FIELD_DATE_10 FROM (
  SELECT    a.* ,row_number() OVER (PARTITION BY CUSTOMER_ID ORDER BY ACCOUNT_NUMBER ASC) as ROWNO
  FROM  cltbs_account_apps_master a
  where customer_id = ' || l_where_cond || ')
  WHERE ROWNO BETWEEN ' ||
                          (p_rec_claccounts.G_LAST_REC_NO + 1) || ' AND ' ||
                          (p_rec_claccounts.G_LAST_REC_NO +
                           p_rec_claccounts.G_NOREC_PER_PAGE) || ' ';

     IF p_rec_claccounts.G_LAST_REC_NO + p_rec_claccounts.G_NOREC_PER_PAGE >l_total_records
     THEN
        p_rec_claccounts.G_LAST_REC_NO := l_total_records;
        p_rec_claccounts.G_TOTAL_REC_NO := l_total_records;

     ELSE
        p_rec_claccounts.G_LAST_REC_NO  := p_rec_claccounts.G_LAST_REC_NO +
                                         p_rec_claccounts.G_NOREC_PER_PAGE;
        p_rec_claccounts.G_TOTAL_REC_NO := l_total_records;
     END IF;

  ELSE

    dbg('Going to query only one account');

    l_dynamic_sql_stmt := 'SELECT ACCOUNT_NUMBER,
          BRANCH_CODE,
          ALT_ACC_NO,
          ACCOUNT_STATUS,
          USER_DEFINED_STATUS,
          PRODUCT_CODE,
          NULL PRODUCT_DESC,
          AMOUNT_FINANCED,
          VALUE_DATE,
          BOOK_DATE,
          MATURITY_DATE,
          ORIGINAL_ST_DATE,
          CURRENCY,
          NET_PRINCIPAL,
          NO_OF_INSTALLMENTS,
          NULL NO_OF_INSTALL_NOW,
          CUSTOMER_ID,
          MAKER_ID,
          NULL SHORT_NAME,
          NULL OVERDUEDAYS,
          NULL NO_PAID_INSTALL,
          NULL UDE_VAL,
          NULL NEXT_INSTALL_NO,
          NULL NEXT_INSTALL_DUE,
          FIELD_CHAR_1,
          FIELD_CHAR_2,
          FIELD_CHAR_3,
          FIELD_CHAR_4,
          FIELD_CHAR_5,
          FIELD_CHAR_6,
          FIELD_CHAR_7,
          FIELD_CHAR_8,
          FIELD_CHAR_9,
          FIELD_CHAR_10,
          FIELD_CHAR_11,
          FIELD_CHAR_12,
          FIELD_CHAR_13,
          FIELD_CHAR_14,
          FIELD_CHAR_15,
          FIELD_CHAR_16,
          FIELD_CHAR_17,
          FIELD_CHAR_18,
          FIELD_CHAR_19,
          FIELD_CHAR_20,
          FIELD_NUMBER_1,
          FIELD_NUMBER_2,
          FIELD_NUMBER_3,
          FIELD_NUMBER_4,
          FIELD_NUMBER_5,
          FIELD_NUMBER_6,
          FIELD_NUMBER_7,
          FIELD_NUMBER_8,
          FIELD_NUMBER_9,
          FIELD_NUMBER_10,
          FIELD_NUMBER_11,
          FIELD_NUMBER_12,
          FIELD_NUMBER_13,
          FIELD_NUMBER_14,
          FIELD_NUMBER_15,
          FIELD_NUMBER_16,
          FIELD_NUMBER_17,
          FIELD_NUMBER_18,
          FIELD_NUMBER_19,
          FIELD_NUMBER_20,
          FIELD_DATE_1,
          FIELD_DATE_2,
          FIELD_DATE_3,
          FIELD_DATE_4,
          FIELD_DATE_5,
          FIELD_DATE_6,
          FIELD_DATE_7,
          FIELD_DATE_8,
          FIELD_DATE_9,
          FIELD_DATE_10
          FROM cltbs_account_apps_master
          WHERE account_number = ' || l_where_cond ;

      p_rec_claccounts.G_LAST_REC_NO := NULL;
      p_rec_claccounts.G_TOTAL_REC_NO := NULL;
      p_rec_claccounts.G_NOREC_PER_PAGE := NULL;

  END IF;

  dbg('Query: ' || l_dynamic_sql_stmt);

  execute immediate l_dynamic_sql_stmt BULK COLLECT
    into p_wrk_claccounts;

  dbg('p_wrk_claccounts.COUNT:'||p_wrk_claccounts.COUNT);
  -- Populating
  IF p_wrk_claccounts.COUNT > 0 THEN

    FOR i in p_wrk_claccounts.first .. p_wrk_claccounts.last LOOP
      BEGIN
      l_product_desc := NULL;
      l_ude_val      := NULL;


        IF p_wrk_claccounts(i).user_defined_status <> 'NORM'
           AND p_wrk_claccounts(i).account_status = 'A'
        THEN

         SELECT MAX(oddays)
            INTO l_oddays
            FROM cltb_overdue_days
           WHERE account_number = p_wrk_claccounts(i).account_number
             AND branch_code = p_wrk_claccounts(i).branch_code;

          p_wrk_claccounts(i).overduedays := l_oddays;

          --  max not paid less or equal to todays date

          SELECT max(schedule_due_date), max(schedule_no)
            INTO l_schedule_odue_date, l_next_install_no
            FROM (SELECT schedule_due_date, max(schedule_no) schedule_no
                    FROM cltb_account_schedules
                   WHERE account_number = p_wrk_claccounts(i)
                  .account_number
                     AND branch_code = p_wrk_claccounts(i)
                  .branch_code
                     AND schedule_flag IS NOT NULL
                     AND schedule_due_date <= global.application_date
                   group by schedule_due_date
                  having sum(nvl(amount_due, 0)) - sum(nvl(amount_settled, 0)) > 0);


            p_wrk_claccounts(i).NEXT_INSTALL_DUE := l_schedule_odue_date;
            p_wrk_claccounts(i).NEXT_INSTALL_NO := l_next_install_no;

        ELSIF  p_wrk_claccounts(i).account_status = 'A'
        THEN

          SELECT min(schedule_due_date), max(schedule_no)
            INTO l_schedule_odue_date, l_next_install_no
            FROM (SELECT schedule_due_date, max(schedule_no) schedule_no
                    FROM cltb_account_schedules
                   WHERE account_number = p_wrk_claccounts(i).account_number
                     AND branch_code = p_wrk_claccounts(i).branch_code
                     AND schedule_flag IS NOT NULL
                   group by schedule_due_date
                  having sum(nvl(amount_due, 0)) - sum(nvl(amount_settled, 0)) > 0);
             dbg('Asigning next due date FOR ACTIVE:' || l_schedule_odue_date);

            p_wrk_claccounts(i).NEXT_INSTALL_DUE := l_schedule_odue_date;
            p_wrk_claccounts(i).NEXT_INSTALL_NO := l_next_install_no;
        ELSE
          dbg('Asigning next due date NO ACTIVE');
            p_wrk_claccounts(i).NEXT_INSTALL_DUE := NULL;
            p_wrk_claccounts(i).NEXT_INSTALL_NO := NULL;
        END IF;


        IF  p_wrk_claccounts(i).account_status NOT IN ( 'L', 'V' )
         THEN
          SELECT max(schedule_no)
              INTO l_max_paid_sch
              FROM (SELECT schedule_no
                      FROM cltb_account_schedules
                     WHERE account_number = p_wrk_claccounts(i)
                    .account_number
                       AND branch_code = p_wrk_claccounts(i).branch_code
                     group by schedule_no
                     having sum(nvl(amount_due, 0))>0
                    and sum(nvl(amount_due, 0)) - sum(nvl(amount_settled, 0)) = 0);

            p_wrk_claccounts(i).no_paid_install := nvl(l_max_paid_sch, 0);


            SELECT max(schedule_no)
              INTO l_total_no_sch
              FROM cltb_account_schedules
             WHERE account_number = p_wrk_claccounts(i).account_number
               AND branch_code = p_wrk_claccounts(i).branch_code;

            p_wrk_claccounts(i).NO_OF_INSTALL_NOW := l_total_no_sch;

           ELSIF p_wrk_claccounts(i).account_status = 'L'
           THEN

             SELECT max(schedule_no)
              INTO l_total_no_sch
              FROM cltb_account_schedules
             WHERE account_number = p_wrk_claccounts(i).account_number
               AND branch_code = p_wrk_claccounts(i).branch_code;

                p_wrk_claccounts(i).NO_OF_INSTALL_NOW := l_total_no_sch;
                p_wrk_claccounts(i).no_paid_install  := l_total_no_sch;

           ELSIF p_wrk_claccounts(i).account_status = 'V'
           THEN

             p_wrk_claccounts(i).NO_OF_INSTALL_NOW := NULL;
             p_wrk_claccounts(i).no_paid_install  := NULL;

           END IF;



            dbg('p_wrk_claccounts(i).account_number ' || p_wrk_claccounts(i)
                .account_number);
            BEGIN
                SELECT PRODUCT_DESC
                  INTO l_product_desc
                  FROM CLTM_PRODUCT
                 WHERE product_code = p_wrk_claccounts(i).product_code;

                p_wrk_claccounts(i).product_desc := l_product_desc;
            EXCEPTION
            WHEN NO_DATA_FOUND
             THEN
                  p_wrk_claccounts(i).product_desc := NULL;
            END;

            BEGIN
                SELECT ude_value
                  INTO l_ude_val
                  FROM cltb_account_ude_values
                 WHERE account_number = p_wrk_claccounts(i).account_number
                   AND branch_code = p_wrk_claccounts(i).branch_code
                   AND ude_id = 'INTEREST_RATE'
                   AND effective_Date in
                       (SELECT MAX(EFFECTIVE_DATE)
                          FROM cltb_account_ude_values
                         WHERE account_number = p_wrk_claccounts(i).account_number
                           AND branch_code = p_wrk_claccounts(i).branch_code
                           AND ude_id = 'INTEREST_RATE'
                           AND EFFECTIVE_DATE <= GLOBAL.application_date);

                p_wrk_claccounts(i).ude_val := l_ude_val;
            EXCEPTION
            WHEN NO_DATA_FOUND
             THEN
              p_wrk_claccounts(i).ude_val := 0;
            END;

      EXCEPTION
        WHEN OTHERS THEN
          DBG('ErrorSQL:' || sqlerrm);
          DBG('ErrorLine:' || dbms_utility.format_error_backtrace);
      END;
    END LOOP;

  ELSE

    p_err_code := 'ED-INVDATA';
    RETURN FALSE;

  END IF;

  -----------------
  dbg('In Fn_Query..');

  RETURN TRUE;
EXCEPTION
  WHEN OTHERS THEN
    debug.pr_debug('**',
                   'In When others Line ..' ||
                   dbms_utility.format_error_backtrace);
    debug.pr_debug('**', 'In When others of error ..' || sqlerrm);
    debug.pr_debug('**', 'In When others of Fn_query ..');
    debug.pr_debug('**', SQLERRM);
    p_err_code := 'ST-OTHR-001';
    RETURN FALSE;
END fn_query;

  PROCEDURE pr_process_msg(p_is_in_msg_clob  IN VARCHAR2
          ,p_rec_msg_header  IN gwpks_service_router.ty_biz_process_header
          ,p_is_out_msg_clob OUT VARCHAR2
          ,p_instr_rec       IN OUT NOCOPY gwpks_service_router.ty_processing_instructions
          ,p_flag            OUT NUMBER
          ,p_err_code        IN OUT VARCHAR2
          ,p_err_param       IN OUT VARCHAR2) IS
    l_parents_list       VARCHAR2(32767);
    l_parents_format     VARCHAR2(32767);
    l_ts_tag_names       VARCHAR2(32767);
    l_ts_tag_values      VARCHAR2(32767);
    l_ts_tag_format      VARCHAR2(32767);
    l_ts_clob_tag_names  CLOB;
    l_ts_clob_tag_values CLOB;
    l_ts_clob_tag_format CLOB;
    l_res_parents_list   VARCHAR2(32767);
    l_res_parents_format VARCHAR2(32767);
    l_res_ts_tag_names   VARCHAR2(32767);
    l_res_ts_tag_values  VARCHAR2(32767);
    l_res_ts_tag_format  VARCHAR2(32767);
    l_is_tag_clob        VARCHAR2(1) := 'Y';
    l_err_tbl            ovpks.tbl_error;
    error_exception EXCEPTION;
    l_is_in_msg_clob  VARCHAR2(1) := p_is_in_msg_clob;
    l_rec_qclacc       TY_REC_CLACC; --
    pflag             VARCHAR2(10);
    l_source_ref      VARCHAR2(16);
    l_source_code     VARCHAR2(30);
    l_serial          VARCHAR2(100);
    l_account_master  cltbs_account_apps_master%ROWTYPE;
    --l_wrk_claccnts ty_inst_pay;
    l_wrk_claccnts    TY_CLACCOUNT_TB;


    l_sch_count NUMBER(10);
  BEGIN
    dbg('In gwpks_query_cust_claccounts.pr_process_msg..');
    dbg('Parsing the XML..' || p_is_in_msg_clob);
    p_flag := -1;
    IF NOT gwpks_xml_parser.fn_xml_parser(p_rec_msg_header.SOURCE
                 ,l_parents_list
                 ,l_parents_format
                 ,l_ts_tag_names
                 ,l_ts_tag_values
                 ,l_ts_tag_format
                 ,l_ts_clob_tag_names
                 ,l_ts_clob_tag_values
                 ,l_ts_clob_tag_format
                 ,l_is_in_msg_clob
                 ,l_is_tag_clob
                 ,p_err_code
                 ,p_err_param)
    THEN
      dbg('FAILED IN gwpks_xml_parser.fn_parse_xml in gwpks_query_cust_claccounts');
      l_err_tbl(1).err_code := p_err_code;
      l_err_tbl(1).params := p_err_param;
      RAISE error_exception;
    END IF;
    dbg(l_parents_list);
    dbg('About to call gwpks_query_cust_claccounts.fn_ts_to_type ');
    dbg('l_parents_list' || l_parents_list);
    dbg('l_ts_tag_names' || l_ts_tag_names);
    dbg('l_ts_tag_values' || l_ts_tag_values);
    IF NOT fn_ts_to_type(l_parents_list, l_ts_tag_names, l_ts_tag_values, l_rec_qclacc, p_err_code, p_err_param)
    THEN
      dbg('FAILED IN fn_ts_to_types');
      pr_log_error(p_rec_msg_header.SOURCE, p_err_code, p_err_param);
            RAISE error_exception;
    END IF;
    -----Check mandatory-----------
    IF l_rec_qclacc.G_CUSTOMER_NO IS NULL
    AND l_rec_qclacc.G_SHORT_NAME IS NULL
       AND l_rec_qclacc.G_ACCOUNT_NUMBER IS NULL
    THEN
      p_err_code  := 'ST-MAND-001';
      p_err_param := 'ACCNO';
      pr_log_error(p_rec_msg_header.SOURCE, p_err_code, p_err_param);
      RAISE error_exception;
    END IF;
  BEGIN
    IF l_rec_qclacc.G_CUSTOMER_NO IS NOT NULL AND l_rec_qclacc.G_SHORT_NAME IS NULL
    THEN
       SELECT SHORT_NAME
       INTO  l_rec_qclacc.G_SHORT_NAME
       FROM STTM_CUSTOMER
       WHERE CUSTOMER_NO = l_rec_qclacc.G_CUSTOMER_NO;

       dbg('Getting Short Name');

    ELSIF l_rec_qclacc.G_CUSTOMER_NO IS NULL AND l_rec_qclacc.G_SHORT_NAME IS NOT NULL
    THEN
       SELECT CUSTOMER_NO
       INTO  l_rec_qclacc.G_CUSTOMER_NO
       FROM STTM_CUSTOMER
       WHERE SHORT_NAME = l_rec_qclacc.G_SHORT_NAME;

         dbg('Getting Short customer_no');
    END IF;

    IF l_rec_qclacc.G_LAST_REC_NO IS NULL
    THEN
     l_rec_qclacc.G_LAST_REC_NO := 0;
    END IF;

    IF l_rec_qclacc.G_NOREC_PER_PAGE IS NULL AND l_rec_qclacc.G_ACCOUNT_NUMBER IS NULL
     THEN
     l_rec_qclacc.G_NOREC_PER_PAGE:= 20;
    END IF;

     IF l_rec_qclacc.G_ACCOUNT_NUMBER IS NOT NULL AND l_rec_qclacc.G_BRANCH_CODE IS NULL
     THEN
       SELECT BRANCH_CODE
       INTO l_rec_qclacc.G_BRANCH_CODE
       FROM CLTB_ACCOUNT_APPS_MASTER
       WHERE ACCOUNT_NUMBER = l_rec_qclacc.G_ACCOUNT_NUMBER;

    END IF;

    dbg('check mandatory sucess');
    -----query functionality-----------------

    EXCEPTION WHEN OTHERS
    THEN
      p_err_code  := 'ED-INVDATA';
      p_err_param := SQLERRM;
      pr_log_error(p_rec_msg_header.SOURCE, p_err_code, p_err_param);
      RAISE error_exception;
     END;
    IF NOT fn_query(p_rec_msg_header.SOURCE, l_rec_qclacc, l_wrk_claccnts, p_err_code, p_err_param)
    THEN
      dbg('Failed in Fn_query..');
                  pr_log_error(p_rec_msg_header.SOURCE, p_err_code, p_err_param);
      RAISE error_exception;
    END IF;

       IF NOT fn_replybuilder(
                 l_wrk_claccnts
                ,l_rec_qclacc
                ,l_ts_clob_tag_names
                ,l_ts_clob_tag_values
                ,l_res_parents_format
                ,l_ts_clob_tag_format
                ,p_instr_rec.msg_xchange_pattern
                ,p_err_code
                ,p_err_param)
    THEN
      dbg('Failed in fn_ReplyBuilder..');
      dbg('Error  :' || p_err_code || ':' || p_err_param);
              pr_log_error(p_rec_msg_header.SOURCE, p_err_code, p_err_param);
      RAISE error_exception;
    ELSE
      ovpkss.pr_appendtbl('ST-SAVE-023', 'Record Successfully Retrieved');
    END IF;
    dbg('l_res_ts_tag_values :' || l_res_ts_tag_values);
    dbg('l_res_ts_tag_names : ' || l_res_ts_tag_names);
    dbg('l_res_parents_list : ' || l_res_parents_list);--~dfdf^dfdf
    dbg('l_res_parents_format : ' || l_res_parents_format);--1.2.3
    dbg('Calling  gwpkss_xml_crtr.fn_create_xml..');

    dbg('l_is_in_msg_clob'||l_is_in_msg_clob);
    IF nvl(l_is_in_msg_clob, 'N') = 'Y' THEN
      l_ts_clob_tag_names  := l_res_ts_tag_names;
      l_ts_clob_tag_values := l_res_ts_tag_values;
    END IF;
     IF nvl(l_is_in_msg_clob, 'N') = 'Y' THEN
      l_ts_clob_tag_names  := l_res_ts_tag_names;
      l_ts_clob_tag_values := l_res_ts_tag_values;
    END IF;

    IF NOT gwpks_xml_crtr_cu.fn_xml_creator_ovd(p_rec_msg_header,
                                                p_instr_rec,
                                                'Y',
                                                l_res_parents_format,--Installment-Payment>C-CLACCDET>
                                                l_ts_clob_tag_format,--1.1>
                                                l_res_ts_tag_names,
                                                l_res_ts_tag_values,
                                                l_ts_tag_format,
                                                l_ts_clob_tag_names,
                                                l_ts_clob_tag_values,
                                                l_ts_clob_tag_format,
                                                'S',
                                                p_is_out_msg_clob) THEN
      dbg('FAILED IN gwpkss_xml_crtr.fn_create_xml');
      RAISE error_exception;
    END IF;

    p_flag := 0;
    dbg('Succcessfully Returned from Function Handler -FlgStatus: ' ||
        p_flag);
    RETURN;

    p_flag := 0;
    dbg('Succcessfully Returned from Function Handler -FlgStatus: ' || p_flag);
    RETURN;
  EXCEPTION
    WHEN error_exception THEN
      dbg('Inside the exception error_exception');
      dbg('value for l_ts_tag_names' || l_ts_tag_names);
      dbg('value for l_ts_tag_values' || l_ts_tag_values);
      dbg('value for l_parents_format' || l_parents_format);
      dbg('value for l_parents_list' || l_parents_list);
      dbg('value for l_res_ts_tag_names' || l_res_ts_tag_names);
      dbg('value for l_res_ts_tag_values' || l_res_ts_tag_values);
      dbg('value for l_parents_list' || l_parents_list);
      dbg('value for l_ts_tag_names' || l_ts_tag_names);
      dbg('value for l_ts_tag_values' || l_ts_tag_values);
      l_res_ts_tag_names  := p_err_code;
      l_res_ts_tag_values := p_err_param;
      dbg('Assigned the values');
      dbg('value for l_res_ts_tag_names' || l_res_ts_tag_names);
      dbg('value for l_res_ts_tag_values' || l_res_ts_tag_values);
      IF NOT gwpks_error_builder.fn_error_builder(p_instr_rec
                     ,l_ts_tag_names
                     ,l_ts_tag_values
                     ,l_parents_format
                     ,l_parents_list
                     ,l_res_ts_tag_names
                     ,l_res_ts_tag_values
                     ,l_parents_list
                     ,l_ts_tag_names
                     ,l_ts_tag_values
                     ,l_parents_format)
      THEN
        dbg('failed in Error Building..');
        RETURN;
      END IF;
      dbg('After calling the error builder');
      dbg('value for l_parents_list' || l_parents_list);
      dbg('value for l_ts_tag_names' || l_ts_tag_names);
      dbg('value for l_ts_tag_values' || l_ts_tag_values);
      dbg('value for l_parents_format' || l_parents_format);
      IF NOT gwpkss_xml_crtr.fn_xml_creator(p_rec_msg_header
                   ,p_instr_rec
                   ,p_is_in_msg_clob
                   ,l_res_parents_list
                   ,l_res_parents_format
                   ,l_res_ts_tag_names
                   ,l_res_ts_tag_values
                   ,l_res_ts_tag_format
                   ,l_ts_clob_tag_names
                   ,l_ts_clob_tag_values
                   ,l_ts_clob_tag_format
                   ,'E'
                   ,p_is_out_msg_clob)
      THEN
        dbg('FAILED IN gwpkss_xml_crtr.fn_create_xml' || SQLERRM);
        RETURN;
      END IF;
      p_flag      := 0;
      p_err_code  := NULL;
      p_err_param := NULL;
      RETURN;
    WHEN OTHERS THEN
      IF NOT gwpks_error_builder.fn_error_builder(p_instr_rec
                     ,l_ts_tag_names
                     ,l_ts_tag_values
                     ,l_parents_format
                     ,l_parents_list
                     ,l_res_ts_tag_names
                     ,l_res_ts_tag_values
                     ,l_parents_list
                     ,l_ts_tag_names
                     ,l_ts_tag_values
                     ,l_parents_format)
      THEN
        dbg('failed in Error Building..');
        RETURN;
      END IF;
      p_err_code := 'GW-ERR002';
      p_err_param := NULL;
      IF NOT gwpkss_xml_crtr.fn_xml_creator(p_rec_msg_header
                   ,p_instr_rec
                   ,p_is_in_msg_clob
                   ,l_res_parents_list
                   ,l_res_parents_format
                   ,l_res_ts_tag_names
                   ,l_res_ts_tag_values
                   ,l_res_ts_tag_format
                   ,l_ts_clob_tag_names
                   ,l_ts_clob_tag_values
                   ,l_ts_clob_tag_format
                   ,'E'
                   ,p_is_out_msg_clob)
      THEN
        clpkss_logger.pr_log_exception('In When Others of Gwpks_CreateETDLQDeal.pr_process_msg..' ||
                   SQLERRM);
        RETURN;
      END IF;
  END pr_process_msg;

END gwpks_query_cust_claccounts;
/
