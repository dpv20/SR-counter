create or replace PACKAGE BODY gwpks_ca_queryaccmove
AS
/*
----------------------------------------------------------------------------------------------------
      **
      ** File Name      : gwpks_CA_QueryAccMove.sql
      **
      ** Module         : CA
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
      ** Copyright ?     ** Copyright 2012 - 2013 by Oracle Financial Services Software Limited.
      **

====================================================================================================
****************************************    CHANGE HISTORY      ************************************
====================================================================================================

      **    Log Number      : FALITR1FCC1051
      **    Modified By     : Darshan Patil
      **    Modified On     : 24-DEC-2013
      **    Modified Reason : Failed to uplodad error.
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1051

      **    Log Number      : FALITR1FCC1158
      **    Modified By     : Darshan Patil
      **    Modified On     : 07-JAN-2014
      **    Modified Reason : Failed to uplodad error.
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1158

      **    Log Number      : FALITR1FCC1159
      **    Modified By     : Darshan Patil
      **    Modified On     : 07-JAN-2014
      **    Modified Reason : Failed to uplodad error.
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1159

    **    Log Number      : FALITR1FCC1159
      **    Modified By     : Darshan Patil
      **    Modified On     : 09-JAN-2014
      **    Modified Reason : Latest Record Not Getting In The Response.
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1196

      **    Log Number      : FALITR1FCC1194
      **    Modified By     : Darshan Patil
      **    Modified On     : 09-JAN-2014
      **    Modified Reason : Process for Closed Account Also.
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1194

      **    Log Number      : FALITR1FCC1193
      **    Modified By     : Darshan Patil
      **    Modified On     : 09-JAN-2014
      **    Modified Reason : Process for Closed Account Also.
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1193

    **    Log Number      : FALITR1FCC1198
      **    Modified By     : Darshan Patil
      **    Modified On     : 09-JAN-2014
      **    Modified Reason : Duplicate for the 193.
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1198

      **    Log Number      : FALITR1FCC1280
      **    Modified By     : Darshan Patil
      **    Modified On     : 09-JAN-2014
      **    Modified Reason : Validation For Number Of Record.
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1280

      **    Log Number      : FALITR1FCC1282
      **    Modified By     : Darshan Patil
      **    Modified On     : 09-JAN-2014
      **    Modified Reason : Validation For Number Of Record.
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1282

    **    Log Number      : CLPBFBFCC0825
      **    Modified By     : Anand Prabhu
      **    Modified On     : 03-FEB-2014
      **    Modified Reason : Message added in the response for the successful query
      **    Search String   : Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_CLPBFBFCC0825

    **    Modified By     : Anand
    **    Modified On     : 03-APR-2014
    **    Modified Reason : Formatted Response as per FS
    **    Search String   : anand_changes_03042014 starts/ends

    **    Modified By     : Anand
    **    Modified On     : 13-JUNE-2014
    **    Modified Reason : Query should work even for closed accounts as well.
    **    Search String   : onsite_changes_13062014/CLPBFBFCC1107 starts/ends

    **    SFR No          : CLPBFBFCC1365
    **    Modified By     : Monisha
    **    Modified On     : 04-DEC-2014
    **    Modified Reason : Code changes did for including new fields FCCREF,PRD and MODULE.
    **    Search String   : CLPFLBL_IFC69_04-DEC-2014_Onsite:CLPBFBFCC1365 Changes

  **    SFR No          : CLPBFBFCC1379
    **    Modified By     : Monisha
    **    Modified On     : 18-DEC-2014
    **    Modified Reason : 1) Code changes to query records based on trn_dt and txn_init_dt.
                          2) Cleaning up of the code.
    **    Search String   : CLPFLBL_IFC69_18-DEC-2014_Onsite:CLPBFBFCC1379 Changes

    **    SFR No          : CLPBFBFCC1391
    **    Modified By     : Claudio
    **    Modified On     : 29-JAN-2015
    **    Modified Reason : Code changes to query records excluding reversals done on the same day
    **    Search String   : CLPBFBFCC1391 Changes

  **    SFR No          : CLPBFBFCC1427
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 17-Mar-2015
    **    Modified Reason : System was not displaying the tanked transactions in the response message.
    **    Search String   : CLPBFBFCC1427 Changes

  **    SFR No          : CLPBFBFCC1507
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 02-Jun-2015
    **    Modified Reason : System should display the transactions in descending order of the transaction posted when queried with Number of Records options.
    **    Search String   : CLPBFBFCC1507 Changes

  **    SFR No          : CLPBFBFCC1509
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 03-Jun-2015
    **    Modified Reason : System was displaying the error GW-QAT-010 when TODATE is passed as next working day.
    **    Search String   : CLPBFBFCC1509 Changes

  **    SFR No          : CLPBFBFCC1518
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 05-Jun-2015
    **    Modified Reason : System should display the narrative for the transaction in the first preference. In case, narrative is null then transaction code description
              should be displayed.
    **    Search String   : CLPBFBFCC1518 Changes

  **    SFR No          : CLPBFBFCC1562
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 31-Jul-2015
    **    Modified Reason : a) Bank requested to add the instrument no in the response message.
              b) The number of records is paramterized now.
    **    Search String   : CLPBFBFCC1562 Changes

  **    SFR No          : PA876CLPBFBIMPSUPP-31
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 03-Nov-2015
    **    Modified Reason : System should display the transaction in order of the transaction date and ac entry serial number. Made changes in the function fn_reply_acdtl.
    **    Search String   : PA876CLPBFBIMPSUPP-31 Changes

  **    Log Number      : PA876CLPBFBIMPSUPP-25
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 14-Oct-2015
    **    Modified Reason : Development of the RS ORA-127. Enhancements in QueryAccMove and Accounts
              statements for LOC accounts.
    **    Search String   : PA876CLPBFBIMPSUPP-25 Changes

  **    Log Number      : PA876CLPBFBIMPSUPP-76
    **    Modified By     : Himanshu Lamba
    **    Modified On     : 21-Dec-2015
    **    Modified Reason : Bank has requested to display description of transaction code for charge transactions.
              System was displaying the description of the narrative sent in the RT file for the charge transactions before.
    **    Search String   : PA876CLPBFBIMPSUPP-76 Changes

  **    Log Number      : PA876CLPBFBIMPSUPP-100
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 19-Jan-2016
    **    Modified Reason : System was not displaying the outward clearing bulk deposit entry as consolidated entry.
    **    Search String   : PA876CLPBFBIMPSUPP-100 Changes

    **    Log Number      : PA876CLPBFBIMPSUPP-154
    **    Modified By     : Claudio Toro
    **    Modified On     : 10-Apr-2016
    **    Modified Reason : System was not displaying instrument no for migrated transactions.
    **    Search String   : PA876CLPBFBIMPSUPP-154 Changes

  **    Log Number      : PA876CLPBFBIMPSUPP-156
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 11-Apr-2016
    **    Modified Reason : System was displaying the Oracle Error in case the length of the message exceeded the VARCHAR2 length. Provided a Temp Fix. Need to Handle in CLOB.
    **    Search String   : PA876CLPBFBIMPSUPP-156 Changes

  **    Log Number      : PA876CLPBFBIMPSUPP-159
    **    Modified By     : Arinjoy Ghosh
    **    Modified On     : 11-Apr-2016
    **    Modified Reason : System was displaying the Oracle Error in case the length of the message exceeded the VARCHAR2 length. CLOB handling done.
    **    Search String   : PA876CLPBFBIMPSUPP-159 changes

  **    Log Number      : PA876CLPBFBIMPSUPP-192
    **    Modified By     : Nanjunda Rao
    **    Modified On     : 09-May-2016
    **    Modified Reason : Instrument Code is made NULL for the CL transactions..
    **    Search String   : PA876CLPBFBIMPSUPP-192 changes

  **    Log Number      : PA876CLPBFBIMPSUPP-243
  **    Modified By     : Nanjunda Rao
  **    Modified On     : 30-Jul-2016
  **    Modified Reason : Query of the accounting movements for the closed LOC accounts.
  **    Search String   : PA876CLPBFBIMPSUPP-243 Changes

    **    SFR No          : PA876CLPBFBIMPSUPP-251
    **    Modified BY   : Nanjunda Rao
    **    Modified Reason : ORA-153 - Alternate Account Number Changes
    **    Date            : 20-Sep-2016
    **    Search String   : PA876CLPBFBIMPSUPP-251 Changes (ORA_153 Changes)

    **    SFR No          : 3-15952769661
    **    Modified BY   : Nanjunda Rao
    **    Modified Reason : Performance Tuning Changes
    **    Date            : 17-Oct-2017
    **    Search String   : 3-15952769661 Changes

  **    Log Number      : 3-16396619361
  **    Modified By     : Saikat Biswas
  **    Modified On     : 08-Jan-2018
  **    Modified Reason : To fix the less number of movements in the response when there is
                          CG consolidation.
  **    Search String   : 3-16396619361 Changes

  **    Log Number      : 3-18011148071
  **    Modified By     : Nanjunda Rao
  **    Modified On     : 02-Aug-2018
  **    Modified Reason : Performance Tuning Changes
  **    Search String   : 3-18011148071 Changes

  **    Modified By     : Rajesh Podili
  **    Modified On     : 16-Oct-2020
  **    Modified Reason : Performance Tuning Changes
                          Acvw_all_entries_custom joining with other taking bit more time.
                          Because of that reason add code to pick once and that result utilize while joing with other tables.
                          added code to verify if the accounts as any Clearing transatcions or not. in case clearing transactions exists then picked those enntries as well.
                          Since l_mig_txns is Default Trues, always system trying pointing to Case 2 and 3 only. So Changed to false.
                          Case 1(Query By No of Transactions).
                             1.  Initially checking in actb_daily_log.
                             2.  In case daily log transactions not sufficient, then based on No of transactions identifying the transaction date from actb_vd_bal.
                             3.  Querying from actb_history with ?>=? above transactions with that universe ordering by desc and then picking transactions.
                             4.  In case above transactions also not  sufficient  then pick the clearing transactions.
  **    Search String   : <Onsite_Performance_tuning_Changes_16102020>

  **  Modified By        : Rajesh Podili
  **  Modified On        : 24-Mar-2021
  **  Modified Reason    : ORA-275: Switch TRF Changes
                           Added the code to Pick switch products from new tables as well.
  **  Search String      : <Onsite_changes_24032021>

  **    Log Number      : 3-24800255101
  **    Modified By     : Sharath - Rafael
  **    Modified On     : 2nd delivery on 12-May-2021.  Initially delivered on 22Dec2020, but left aside due to ORA-275.
  **    Modified Reason : Checks protested not being displayed. Added fix.
  **    Search String   : <3-24800255101> Start/End

----------------------------------------------------------------------------------------------------
*/

g_cnt_lvl2       NUMBER := 0;
g_cnt_lvl        NUMBER := 0;
g_cnt_lvl3       NUMBER := 0; -- PA876CLPBFBIMPSUPP-25 Changes -- 14Oct2015
g_cnt_lvl4     NUMBER := 0; -- PA876CLPBFBIMPSUPP-25 Changes -- 14Oct2015
pkg_custrec      sttms_cust_account%ROWTYPE;

-- PA876CLPBFBIMPSUPP-159 changes Starts
pkg_key               CLOB := EMPTY_CLOB;
pkg_data              CLOB := EMPTY_CLOB;
pkg_parent            CLOB := EMPTY_CLOB;
pkg_format            CLOB := EMPTY_CLOB;
-- PA876CLPBFBIMPSUPP-159 changes Ends
pkg_tb_acvw_all_entries  tb_acvw_all_entries_ind;  -- <Onsite_Performance_tuning_Changes_16102020>
pkg_tb_acvw_all_entries_clr  tb_acvw_all_entries_ind;  -- <Onsite_Performance_tuning_Changes_16102020>
TYPE g_rec_acc_dtl IS RECORD
  ( g_accno     acvws_all_ac_entries.ac_no%TYPE,
      g_accbrn    acvws_all_ac_entries.ac_branch%TYPE,
      g_frmdt     date,
      g_todate    date,
      g_norec       NUMBER,
      g_user_id     VARCHAR2(15),
      g_branch_code sttms_branch.branch_code%TYPE);

tbl_swprod      gwpkss_ca_queryaccmove.typ_protprod; -- 3-15952769661 Changes -- 17Oct2017

PROCEDURE dbg(p_msg VARCHAR2)
IS
BEGIN

IF debug.pkg_debug_on <> 2
THEN
    debug.pr_debug('IF', p_msg);
END IF;

EXCEPTION
WHEN OTHERS
THEN
    NULL;
END dbg;
-- <Onsite_changes_24032021> Start
FUNCTION fn_get_switch_products RETURN tb_switch_products result_cache  IS
        l_tb_switch_products tb_switch_products := tb_switch_products();
        l_index              PLS_INTEGER;
    BEGIN
        l_index := 0;
        l_tb_switch_products.extend;
        FOR k IN (SELECT DISTINCT product_code
                  FROM   swtms_product_mapping_cu
                  UNION
                  SELECT product_code
                  FROM   swtms_product_mapping_detail)
        LOOP
            l_index := l_index + 1;
            l_tb_switch_products.extend;
            l_tb_switch_products(l_index) := k.product_code;
        END LOOP;
        return l_tb_switch_products;
    END fn_get_switch_products;
-- <Onsite_changes_24032021> End
-- <Onsite_Performance_tuning_Changes_16102020> Start
-- To Retive data from acvw_all_ac_entries_custom..
FUNCTION fn_get_accounting_entries RETURN tb_acvw_all_entries
    PIPELINED IS
    l_rec                 ty_acvw_all_entries;
BEGIN
    dbg('In fn_get_accounting_entries...' || pkg_tb_acvw_all_entries.count || ': Clearing :'||pkg_tb_acvw_all_entries_clr.count );
    IF pkg_tb_acvw_all_entries.count > 0
    THEN
        FOR cur_rec IN pkg_tb_acvw_all_entries.first .. pkg_tb_acvw_all_entries.last
        LOOP
            l_rec.ac_branch      := pkg_tb_acvw_all_entries(cur_rec).ac_branch;
            l_rec.ac_no          := pkg_tb_acvw_all_entries(cur_rec).ac_no;
            l_rec.ac_entry_sr_no := pkg_tb_acvw_all_entries(cur_rec).ac_entry_sr_no;
            l_rec.trn_ref_no     := pkg_tb_acvw_all_entries(cur_rec).trn_ref_no;
            l_rec.module         := pkg_tb_acvw_all_entries(cur_rec).module;
            l_rec.txn_init_date  := pkg_tb_acvw_all_entries(cur_rec).txn_init_date;
            l_rec.value_dt       := pkg_tb_acvw_all_entries(cur_rec).value_dt;
            l_rec.trn_dt         := pkg_tb_acvw_all_entries(cur_rec).trn_dt;
            l_rec.lcy_amount     := pkg_tb_acvw_all_entries(cur_rec).lcy_amount;
            --l_rec.trn_brn       := l_tb_acvw_all_entries(cur_rec).trn_brn;
            l_rec.trn_code         := pkg_tb_acvw_all_entries(cur_rec).trn_code;
            l_rec.drcr_ind         := pkg_tb_acvw_all_entries(cur_rec).drcr_ind;
            l_rec.event            := pkg_tb_acvw_all_entries(cur_rec).event;
            l_rec.auth_stat        := pkg_tb_acvw_all_entries(cur_rec).auth_stat;
            l_rec.instrument_code  := pkg_tb_acvw_all_entries(cur_rec).instrument_code;
            l_rec.amount_tag       := pkg_tb_acvw_all_entries(cur_rec).amount_tag;
            l_rec.dont_showin_stmt := pkg_tb_acvw_all_entries(cur_rec).dont_showin_stmt;
            --dbg('Building Rec ::' || l_rec.ac_no);
            PIPE ROW(l_rec);
        END LOOP;
    ELSE
        dbg('No Accounts based for account ');
        -- Null Record
        PIPE ROW(l_rec);
    END IF;
    -- Clearing Entriess.
    IF pkg_tb_acvw_all_entries_clr.count > 0 then
      FOR cur_rec IN pkg_tb_acvw_all_entries_clr.first .. pkg_tb_acvw_all_entries_clr.last
        LOOP
            l_rec.ac_branch      := pkg_tb_acvw_all_entries_clr(cur_rec).ac_branch;
            l_rec.ac_no          := pkg_tb_acvw_all_entries_clr(cur_rec).ac_no;
            l_rec.ac_entry_sr_no := pkg_tb_acvw_all_entries_clr(cur_rec).ac_entry_sr_no;
            l_rec.trn_ref_no     := pkg_tb_acvw_all_entries_clr(cur_rec).trn_ref_no;
            l_rec.module         := pkg_tb_acvw_all_entries_clr(cur_rec).module;
            l_rec.txn_init_date  := pkg_tb_acvw_all_entries_clr(cur_rec).txn_init_date;
            l_rec.value_dt       := pkg_tb_acvw_all_entries_clr(cur_rec).value_dt;
            l_rec.trn_dt         := pkg_tb_acvw_all_entries_clr(cur_rec).trn_dt;
            l_rec.lcy_amount     := pkg_tb_acvw_all_entries_clr(cur_rec).lcy_amount;
            --l_rec.trn_brn       := l_tb_acvw_all_entries(cur_rec).trn_brn;
            l_rec.trn_code         := pkg_tb_acvw_all_entries_clr(cur_rec).trn_code;
            l_rec.drcr_ind         := pkg_tb_acvw_all_entries_clr(cur_rec).drcr_ind;
            l_rec.event            := pkg_tb_acvw_all_entries_clr(cur_rec).event;
            l_rec.auth_stat        := pkg_tb_acvw_all_entries_clr(cur_rec).auth_stat;
            l_rec.instrument_code  := pkg_tb_acvw_all_entries_clr(cur_rec).instrument_code;
            l_rec.amount_tag       := pkg_tb_acvw_all_entries_clr(cur_rec).amount_tag;
            l_rec.dont_showin_stmt := pkg_tb_acvw_all_entries_clr(cur_rec).dont_showin_stmt;
            --dbg('Building Rec ::' || l_rec.ac_no);
            PIPE ROW(l_rec);
        END LOOP;
    END IF;
    RETURN;
END fn_get_accounting_entries;

-- Function to Build Accouning Entriess...
PROCEDURE pr_build_accounting_entries(p_ac_branch actb_daily_log.ac_branch%TYPE,
                                      p_ac_no     actb_daily_log.ac_no%TYPE,
                                      p_from_dt   actb_daily_log.trn_dt%TYPE,
                                      p_to_dt     actb_daily_log.trn_dt%TYPE,
                                      p_no_rec    NUMBER,
                                      p_case_no   NUMBER) IS
    l_clearing_count      PLS_INTEGER;
    l_no_rec_with_grace   pls_integer;
    l_filter_trn_date     date;
    l_entries_history     tb_acvw_all_entries_ind;
    l_indx_cnt            pls_integer;

BEGIN
    dbg('In pr_build_accounting_entries for Case Number :' || p_case_no);
    IF P_CASE_NO = 1
    THEN
      -- Verifying Dailylog has enough data.. for Hight Volume Accounts...
      SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
             ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
             ,amount_tag,dont_showin_stmt
        BULK   COLLECT
        INTO   pkg_tb_acvw_all_entries
        FROM (SELECT ac_branch, ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
             ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
             ,amount_tag,dont_showin_stmt
        FROM   actb_daily_log
        WHERE  ac_branch = p_ac_branch
        AND    ac_no = p_ac_no
        AND    auth_stat = 'A'
        AND    NVL(dont_showin_stmt,'N') = 'N'
        AND    DELETE_STAT <> 'D'
        ORDER BY trn_dt DESC , ac_entry_sr_no DESC)
        WHERE rownum <= p_no_rec;
        dbg('pkg_tb_acvw_all_entries.count ::'||pkg_tb_acvw_all_entries.count);
       IF pkg_tb_acvw_all_entries.count <  p_no_rec THEN
       l_no_rec_with_grace:= (p_no_rec - pkg_tb_acvw_all_entries.count)+1; -- 1 Safe Side..
       -- Going to pick Nth Record to reduce order by universe...
       BEGIN
          SELECT val_dt into l_filter_trn_date
          FROM   (SELECT val_dt FROM (SELECT val_dt
                                      FROM   actb_vd_bal
                                      WHERE  brn = p_ac_branch
                                      AND    acc = p_ac_no
                                      ORDER  BY val_dt DESC)
                WHERE  rownum <= l_no_rec_with_grace
                ORDER  BY val_dt ASC)
          WHERE  rownum = 1;
       EXCEPTION
          WHEN no_data_found THEN
            dbg('VD Balance Date not exists.. Go with application date..');
            l_filter_trn_date:= global.application_date;
        END;
          dbg('l_filter_trn_date ::'||l_filter_trn_date);
        SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                ,amount_tag,dont_showin_stmt
        BULK   COLLECT
        INTO   l_entries_history
        FROM (SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                ,trn_dt,lcy_amount,trn_code,drcr_ind,event,'A' auth_stat,instrument_code
                ,amount_tag,dont_showin_stmt
        FROM   actb_history
        WHERE  ac_branch = p_ac_branch
        AND    ac_no = p_ac_no
        AND    trn_dt >= l_filter_trn_date
        AND    NVL(dont_showin_stmt,'N') = 'N'
        ORDER BY trn_dt DESC , ac_entry_sr_no DESC)
        WHERE rownum <= p_no_rec;
        DBG('l_entries_history.count ::' || l_entries_history.count);
          -- Going to Merge Data...
       IF l_entries_history.count>0 then
         l_indx_cnt := pkg_tb_acvw_all_entries.count;
         FOR k in l_entries_history.first .. l_entries_history.last LOOP
           l_indx_cnt:=l_indx_cnt+1;
           pkg_tb_acvw_all_entries(l_indx_cnt):= l_entries_history(k);
         END LOOP;
       END IF;
       END IF;
       -- Checking any outward Claring Transactions...
        SELECT COUNT(1)
        INTO   l_clearing_count
        FROM   (TABLE(gwpks_ca_queryaccmove.fn_get_accounting_entries)) R
        WHERE  module = 'CG'
        AND    EXISTS (SELECT 1
                FROM   csvws_clearing_master_c P
                WHERE  reference_no = R.TRN_REF_NO
                --AND NVL(P.BULK,'N') ='Y' <3-24800255101> Commented this condition
                --and direction = 'O' <3-24800255101> Commented this condition
		);
       dbg('l_clearing_count ::'||l_clearing_count);
       IF l_clearing_count > 0  THEN
        -- Account Contain Clearing transactions So better to Pick All based on trn date..
       IF l_filter_trn_date  IS NULL THEN
       BEGIN
          SELECT val_dt into l_filter_trn_date
          FROM   (SELECT val_dt FROM (SELECT val_dt
                                      FROM   actb_vd_bal
                                      WHERE  brn = p_ac_branch
                                      AND    acc = p_ac_no
                                      ORDER  BY val_dt DESC)
                WHERE  rownum <= p_no_rec
                ORDER  BY val_dt ASC)
          WHERE  rownum = 1;
       EXCEPTION
          WHEN no_data_found THEN
            dbg('VD Balance Date not exists.. Go with application date..');
            l_filter_trn_date:= global.application_date;
        END;
       END IF;
       pkg_tb_acvw_all_entries.delete;
       SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                ,trn_dt,lcy_amount,trn_code,drcr_ind,event,'A' auth_stat,instrument_code
                ,amount_tag,dont_showin_stmt
        BULK   COLLECT
        INTO   pkg_tb_acvw_all_entries
        FROM   acvw_all_ac_entries_custom
        WHERE  ac_branch = p_ac_branch
        AND    ac_no = p_ac_no
        AND    trn_dt >= l_filter_trn_date
        AND    NVL(dont_showin_stmt,'N') = 'N'
        ORDER BY trn_dt DESC , ac_entry_sr_no DESC;
       END IF;

        -- In Case Queries No fi rows less then adding Clearing entries if exists..
        IF pkg_tb_acvw_all_entries.count < p_no_rec  OR l_clearing_count > 0--<3-24800255101> Added OR l_clearing_count > 0
        THEN
            dbg('Does it reach this point?');
            SELECT COUNT(1)
            INTO   l_clearing_count
            FROM   cstbs_clearing_rejection
            WHERE  rem_account = p_ac_no
            AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%');
            dbg('Creating record Count Case 1::' || l_clearing_count);
            IF l_clearing_count > 0
            THEN
                SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                       ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                       ,amount_tag,dont_showin_stmt
                BULK   COLLECT
                INTO   pkg_tb_acvw_all_entries_clr
                FROM   acvw_all_ac_entries_custom
                WHERE  trn_ref_no IN (SELECT trn_ref_no
                                      FROM   cstbs_clearing_rejection
                                      WHERE  rem_account = p_ac_no
                                      AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%'))
                AND    NVL(dont_showin_stmt,
                           'N') = 'N'
                AND    rownum <= p_no_rec
          --<3-24800255101> Start
          UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  trn_ref_no IN (SELECT prot_trn_ref_no
                      FROM CATM_PROTEST_MASTER B
                      WHERE B.REM_ACCOUNT = p_ac_no
                      AND B.REM_ACC_BRANCH = p_ac_branch)
                    AND    trn_dt BETWEEN p_from_dt AND p_to_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N';
          --<3-24800255101> End
            END IF;
        END IF;

    ELSIF P_CASE_NO = 2
    THEN
        -- Verifing any Clearing entries exists...
        SELECT COUNT(1)
        INTO   l_clearing_count
        FROM   cstbs_clearing_rejection
        WHERE  rem_account = p_ac_no
        AND    txn_date BETWEEN p_from_dt AND p_to_dt
        AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%');
        dbg('Creating record Count Case 2::' || l_clearing_count);
        IF l_clearing_count > 0
        THEN
            SELECT *
            BULK   COLLECT
            INTO   pkg_tb_acvw_all_entries
            FROM   (SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  ac_branch = p_ac_branch
                    AND    ac_no = p_ac_no
                    AND    NVL(dont_showin_stmt,'N') = 'N'
                    AND  ((event = 'CONV' AND txn_init_date BETWEEN p_from_dt AND p_to_dt)
                           or (event <> 'CONV' AND trn_dt BETWEEN p_from_dt AND p_to_dt))
                    UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                          ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                          ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  trn_ref_no IN (SELECT trn_ref_no
                                          FROM   cstbs_clearing_rejection
                                          WHERE  rem_account = p_ac_no
                                          AND    txn_date BETWEEN p_from_dt AND p_to_dt
                                          AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%'))
                    AND    trn_dt BETWEEN p_from_dt AND p_to_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N')--;
         --<3-24800255101> Start
          UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  trn_ref_no IN (SELECT prot_trn_ref_no
                      FROM CATM_PROTEST_MASTER B
                      WHERE B.REM_ACCOUNT = p_ac_no
                      AND B.REM_ACC_BRANCH = p_ac_branch)
                    AND    trn_dt BETWEEN p_from_dt AND p_to_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N';
          --<3-24800255101> End
        ELSE
            -- Since there is no Clearing...
            SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                     BULK   COLLECT INTO   pkg_tb_acvw_all_entries
                    FROM   acvw_all_ac_entries_custom
                    WHERE  ac_branch = p_ac_branch
                    AND    ac_no = p_ac_no
                    AND    NVL(dont_showin_stmt,'N') = 'N'
                    AND  ((event = 'CONV' AND txn_init_date BETWEEN p_from_dt AND p_to_dt)
                           or (event <> 'CONV' AND trn_dt BETWEEN p_from_dt AND p_to_dt));
        END IF;
        --- Clearing End..
    ELSIF P_CASE_NO = 3
    THEN
        -- Verifing any Clearing entries exists...
        SELECT COUNT(1)
        INTO   l_clearing_count
        FROM   cstbs_clearing_rejection
        WHERE  rem_account = p_ac_no
        AND    txn_date >= p_from_dt
        AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%');
        dbg('Creating record Count Case 3::' || l_clearing_count);
        IF l_clearing_count > 0
        THEN
            SELECT *
            BULK   COLLECT
            INTO   pkg_tb_acvw_all_entries
            FROM   (SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  ac_branch = p_ac_branch
                    AND    ac_no = p_ac_no
                    AND    NVL(dont_showin_stmt,'N') = 'N'
                    AND    ((event = 'CONV' AND txn_init_date >= p_from_dt)
                           or (event <> 'CONV' AND trn_dt >= p_from_dt))
                    UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  trn_ref_no IN (SELECT trn_ref_no
                                          FROM   cstbs_clearing_rejection
                                          WHERE  rem_account = p_ac_no
                                          AND    txn_date >= p_from_dt
                                          AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%'))
                    AND    trn_dt >= p_from_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N')--;
          --<3-24800255101> Start
          UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  trn_ref_no IN (SELECT prot_trn_ref_no
                      FROM CATM_PROTEST_MASTER B
                      WHERE B.REM_ACCOUNT = p_ac_no
                      AND B.REM_ACC_BRANCH = p_ac_branch)
                    AND    trn_dt BETWEEN p_from_dt AND p_to_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N';
          --<3-24800255101> End
        ELSE

           SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    BULK   COLLECT  INTO   pkg_tb_acvw_all_entries
                    FROM   acvw_all_ac_entries_custom
                    WHERE  ac_branch = p_ac_branch
                    AND    ac_no = p_ac_no
                    AND    NVL(dont_showin_stmt,'N') = 'N'
                    AND    ((event = 'CONV' AND txn_init_date >= p_from_dt)
                           or (event <> 'CONV' AND trn_dt >= p_from_dt));
        END IF;
        --- Clearing End..
    ELSIF p_case_no = 4
    THEN

        -- Verifing any Clearing entries exists...
        SELECT COUNT(1)
        INTO   l_clearing_count
        FROM   cstbs_clearing_rejection
        WHERE  rem_account = p_ac_no
        AND    txn_date >= p_from_dt
        AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%');
        dbg('Creating record Count Case 4::' || l_clearing_count);
        IF l_clearing_count > 0
        THEN
            SELECT *
            BULK   COLLECT
            INTO   pkg_tb_acvw_all_entries
            FROM   (SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   actbs_daily_log
                    WHERE  ac_branch = p_ac_branch
                    AND    ac_no = p_ac_no
                    AND    NVL(dont_showin_stmt,
                               'N') = 'N'
                    AND    trn_dt >= p_from_dt
                    AND    NVL(delete_stat,'X') <> 'D'
                    UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   actbs_daily_log
                    WHERE  trn_ref_no IN (SELECT trn_ref_no
                                          FROM   cstbs_clearing_rejection
                                          WHERE  rem_account = p_ac_no
                                          AND    txn_date >= p_from_dt
                                          AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%'))
                    AND    trn_dt >= p_from_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N')--;
          --<3-24800255101> Start
          UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   actbs_daily_log
                    WHERE  trn_ref_no IN (SELECT prot_trn_ref_no
                      FROM CATM_PROTEST_MASTER B
                      WHERE B.REM_ACCOUNT = p_ac_no
                      AND B.REM_ACC_BRANCH = p_ac_branch)
                    AND    trn_dt BETWEEN p_from_dt AND p_to_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N';
          --<3-24800255101> End
        ELSE
            SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                   ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                   ,amount_tag,dont_showin_stmt
            BULK   COLLECT
            INTO   pkg_tb_acvw_all_entries
            FROM   actbs_daily_log
            WHERE  ac_branch = p_ac_branch
            AND    ac_no = p_ac_no
            AND    NVL(dont_showin_stmt,'N') = 'N'
            AND    trn_dt >= p_from_dt
            AND    NVL(delete_stat,'X') <> 'D';
        END IF;
        --- Clearing End..
    ELSIF P_CASE_NO = 5
    THEN
        -- Verifing any Clearing entries exists...
        SELECT COUNT(1)
        INTO   l_clearing_count
        FROM   cstbs_clearing_rejection
        WHERE  rem_account = p_ac_no
        AND    txn_date BETWEEN p_from_dt AND p_to_dt
        AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%');
        dbg('Creating record Count Case 5::' || l_clearing_count);
        IF l_clearing_count > 0
        THEN
            SELECT *
            BULK   COLLECT
            INTO   pkg_tb_acvw_all_entries
            FROM   (SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  ac_branch = p_ac_branch
                    AND    ac_no = p_ac_no
                    AND    NVL(dont_showin_stmt,'N') = 'N'
                    AND    trn_dt BETWEEN p_from_dt AND p_to_dt
                    UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  trn_ref_no IN (SELECT trn_ref_no
                                          FROM   cstbs_clearing_rejection
                                          WHERE  rem_account = p_ac_no
                                          AND    txn_date BETWEEN p_from_dt AND p_to_dt
                                          AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%'))
                    AND    trn_dt BETWEEN p_from_dt AND p_to_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N')--;
					--<3-24800255101> Start
					UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  trn_ref_no IN (SELECT prot_trn_ref_no
										  FROM CATM_PROTEST_MASTER B
										  WHERE B.REM_ACCOUNT = p_ac_no
										  AND B.REM_ACC_BRANCH = p_ac_branch)
                    AND    trn_dt BETWEEN p_from_dt AND p_to_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N';
					--<3-24800255101> End
        ELSE
            SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                   ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                   ,amount_tag,dont_showin_stmt
            BULK   COLLECT
            INTO   pkg_tb_acvw_all_entries
            FROM   acvw_all_ac_entries_custom
            WHERE  ac_branch = p_ac_branch
            AND    ac_no = p_ac_no
            AND    NVL(dont_showin_stmt,'N') = 'N'
            AND    trn_dt BETWEEN p_from_dt AND p_to_dt;
        END IF;
    ELSIF P_CASE_NO = 6
    THEN

        -- Verifing any Clearing entries exists...
        SELECT COUNT(1)
        INTO   l_clearing_count
        FROM   cstbs_clearing_rejection
        WHERE  rem_account = p_ac_no
        AND    txn_date >= p_from_dt
        AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%');
        dbg('Creating record Count Case 6::' || l_clearing_count);
        IF l_clearing_count > 0
        THEN
            SELECT *
            BULK   COLLECT
            INTO   pkg_tb_acvw_all_entries
            FROM   (SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  ac_branch = p_ac_branch
                    AND    ac_no = p_ac_no
                    AND    NVL(dont_showin_stmt,'N') = 'N'
                    AND    trn_dt >= p_from_dt
                    UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  trn_ref_no IN (SELECT trn_ref_no
                                          FROM   cstbs_clearing_rejection
                                          WHERE  rem_account = p_ac_no
                                          AND    txn_date >= p_from_dt
                                          AND    (err_code LIKE '%CG-REJR-09%' OR err_code LIKE '%CG-REJR-08%'))
                    AND    trn_dt >= p_from_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N')--;
               -- <3-24800255101> Start
                   UNION
                    SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
                    FROM   acvw_all_ac_entries_custom
                    WHERE  trn_ref_no IN (SELECT prot_trn_ref_no
                      FROM CATM_PROTEST_MASTER B
                      WHERE B.REM_ACCOUNT = p_ac_no
                      AND B.REM_ACC_BRANCH = p_ac_branch)
                    AND    trn_dt BETWEEN p_from_dt AND p_to_dt
                    AND    NVL(dont_showin_stmt,'N') = 'N';
               --<3-24800255101> End
        ELSE
            SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,txn_init_date,value_dt
                           ,trn_dt,lcy_amount,trn_code,drcr_ind,event,auth_stat,instrument_code
                           ,amount_tag,dont_showin_stmt
            BULK   COLLECT
            INTO   pkg_tb_acvw_all_entries
            FROM   acvw_all_ac_entries_custom
            WHERE  ac_branch = p_ac_branch
            AND    ac_no = p_ac_no
            AND    NVL(dont_showin_stmt,'N') = 'N'
            AND    trn_dt >= p_from_dt;
        END IF;
    END IF;
    dbg('Sucessfully Completed pr_build_accounting_entries....');
END pr_build_accounting_entries;

-- <Onsite_Performance_tuning_Changes_16102020> end

-- CLPBFBFCC1518 Changes Start Here -- 05Jun2015
FUNCTION fn_get_tagdescption
         (p_param           VARCHAR2,
          p_param_val       VARCHAR2
         )
RETURN VARCHAR2
IS

l_brn_rec           sttms_branch%ROWTYPE;
lt_trnrec           sttms_trn_code%ROWTYPE;

BEGIN

IF p_param = 'BRN'
THEN
    IF NOT cvpkss_utils.fn_get_branch_record
                      ( p_brn           => p_param_val,
                        p_branch_record => l_brn_rec)
    THEN
        RETURN '1';
    END IF;

    RETURN l_brn_rec.branch_name;

ELSIF p_param = 'TRN'
THEN
    cvpkss_utils.get_trn_code(p_trncode => p_param_val,
                              l_trnrec  => lt_trnrec);
    RETURN lt_trnrec.trn_desc;
END IF;

RETURN '0';
END fn_get_tagdescption;

FUNCTION fn_get_trndescription
         ( p_trn_ref_no   VARCHAR2,
           p_trn_code     VARCHAR2
         )
RETURN VARCHAR2
IS

l_description     detbs_rtl_teller.narrative%TYPE;

BEGIN

SELECT narrative
  INTO l_description
  FROM detbs_rtl_teller
 WHERE trn_ref_no = p_trn_ref_no
   AND narrative IS NOT NULL
   AND NVL(module, 'XX') != 'DD';

RETURN l_description;

EXCEPTION
WHEN NO_DATA_FOUND
THEN
    l_description:= fn_get_tagdescption('TRN', p_trn_code);
    RETURN l_description;
END fn_get_trndescription;

FUNCTION fn_get_trndescription
         ( p_trn_ref_no   VARCHAR2
          ,p_trn_code     VARCHAR2
      ,p_product    VARCHAR2
      ,p_module         VARCHAR2--PA876CLPBFBIMPSUPP-76 Changes
      ,p_amount_tag     VARCHAR2--PA876CLPBFBIMPSUPP-76 Changes
         )
RETURN VARCHAR2
IS

l_description     detbs_rtl_teller.narrative%TYPE;
l_idx         cgtms_bank_parameters.prot_inward_prod%TYPE;
l_iw_prod     cgtms_bank_parameters.prot_inward_prod%TYPE;
l_ip_prod     cgtms_bank_parameters.prot_inward_prod%TYPE;

PROCEDURE pr_protdesc
    ( p_trn_ref_no      VARCHAR2
     ,p_description IN OUT  VARCHAR2
    )
IS

BEGIN

SELECT reason_desc
  INTO p_description
  FROM  ( SELECT x.prot_ref_no, y.reason_code, z.reason_desc
        FROM catm_protest_master x, catm_protest_reason y, cstb_clg_rej_reason z
       WHERE x.prot_ref_no = y.prot_ref_no
         AND x.prot_trn_ref_no = p_trn_ref_no
         AND y.reason_code = z.reason_code
       ORDER BY reason_code
        )
 WHERE ROWNUM = 1;

dbg('Description is-->'||p_description);

EXCEPTION
WHEN OTHERS
THEN
    dbg('Oracle error while getting the protest reason description');
  p_description := NULL;
END pr_protdesc;

BEGIN

IF p_product IS NOT NULL
THEN
  l_idx := UPPER(LTRIM(RTRIM(p_product)));
  IF gwpkss_ca_queryaccmove.tbl_protprod.FIRST IS NULL
  THEN
    BEGIN
      SELECT prot_inward_prod, prot_internal_prod
        INTO l_iw_prod, l_ip_prod
        FROM cgtms_bank_parameters
       WHERE bank_code = global.pkg_bank.bank_code;

      IF l_iw_prod IS NOT NULL
      THEN
        gwpkss_ca_queryaccmove.tbl_protprod(l_iw_prod) := 'IW';
      END IF;

      IF l_ip_prod IS NOT NULL
      THEN
                gwpkss_ca_queryaccmove.tbl_protprod(l_ip_prod) := 'IP';
      END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
      dbg('1.No Maintenance');
    WHEN OTHERS
    THEN
      dbg('2.Oracle Err-->'||SQLERRM);
    END;
  END IF;

  IF gwpkss_ca_queryaccmove.tbl_protprod.EXISTS(l_idx)
  THEN
    dbg('Protest contract-->'||l_idx);
    pr_protdesc(p_trn_ref_no, l_description);
  END IF;
END IF;

IF l_description IS NULL
THEN
  dbg('Now checking for ATM transaction.');

  -- 3-15952769661 Changes Start Here -- 17Oct2017
  IF tbl_swprod.FIRST IS NULL
  THEN
    FOR x IN (
          -- <Onsite_changes_24032021> start
          /*SELECT product_code
          FROM swtms_product_mapping_cu*/
          SELECT column_value as product_code
              FROM  TABLE(gwpks_ca_queryaccmove.fn_get_switch_products)
              where column_value is not null
          -- <Onsite_changes_24032021> end
          )
    LOOP
      tbl_swprod(x.product_code) := 'SW';
    END LOOP;
  END IF;
  -- 3-15952769661 Changes End Here -- 17Oct2017

  -- 3-15952769661 Changes Start Here -- 17Oct2017
  IF tbl_swprod.EXISTS(l_idx)
  THEN
  -- 3-15952769661 Changes Start Here -- 17Oct2017
    BEGIN
      SELECT TRIM(accept_addr)
        INTO l_description
        FROM swtbs_txn_log_cu
       WHERE trn_ref_no = p_trn_ref_no
         AND ROWNUM = 1;
    EXCEPTION
    WHEN OTHERS
    THEN
      l_description := NULL;
    END;
  END IF; -- 3-15952769661 Changes -- 17Oct2017

  IF l_description IS NULL
  THEN
      --PA876CLPBFBIMPSUPP-76 Changes Starts
    IF NVL(p_module,'XX') = 'RT' AND NVL(p_amount_tag,'XX') LIKE 'CHG_AMT%'
    THEN
      l_description:= fn_get_tagdescption('TRN', p_trn_code);
      dbg('Now inside to check description for charge transaction'||l_description);
    ELSE
    --PA876CLPBFBIMPSUPP-76 Changes Ends
      SELECT narrative
        INTO l_description
        FROM detbs_rtl_teller
       WHERE trn_ref_no = p_trn_ref_no
         AND narrative IS NOT NULL
         AND NVL(module, 'XX') != 'DD';
    END IF;--PA876CLPBFBIMPSUPP-76 Changes
  END IF;
END IF;

RETURN l_description;

EXCEPTION
WHEN NO_DATA_FOUND
THEN
    l_description:= fn_get_tagdescption('TRN', p_trn_code);
    RETURN l_description;
END fn_get_trndescription;
-- CLPBFBFCC1518 Changes End Here -- 05Jun2015

-- PA876CLPBFBIMPSUPP-159 changes Starts
FUNCTION fn_reassign_clob
     ( p_key        IN OUT  CLOB
    ,p_data       IN OUT  CLOB
    ,p_parent     IN OUT  CLOB
        ,p_format     IN OUT  CLOB
    ,p_error_code   IN OUT  VARCHAR2
        ,p_error_param  IN OUT  VARCHAR2
     )
RETURN BOOLEAN
IS

BEGIN

dbg('Inside the function fn_reassign_clob');

dbms_lob.writeappend(pkg_key,
           LENGTH(p_key),
           p_key);

dbms_lob.writeappend(pkg_data,
           LENGTH(p_data),
           p_data);

dbms_lob.writeappend(pkg_parent,
           LENGTH(p_parent),
           p_parent);

dbms_lob.writeappend(pkg_format,
           LENGTH(p_format),
           p_format);

dbg('Returning true from the function fn_reassign_clob');
RETURN TRUE;

EXCEPTION
WHEN OTHERS
THEN
  dbg('Oracle Error in assigning CLOB-->'||SQLERRM);
  dbg('Failed at line-->'||dbms_utility.format_error_backtrace);
  p_error_code := 'AC-UNC06';
  p_error_param := SQLERRM;
  RETURN FALSE;
END fn_reassign_clob;
-- PA876CLPBFBIMPSUPP-159 changes Ends

FUNCTION fn_validate_req_val
    ( p_recv_ic_dtl IN OUT g_rec_acc_dtl,
      p_err_code    IN OUT VARCHAR2,
      p_err_param   IN OUT VARCHAR2
    )
RETURN BOOLEAN
IS

TYPE l_type_cur IS REF CURSOR;
l_var_type      l_type_cur;
l_dummy         VARCHAR2(1);
l_accrec            sttms_cust_account%ROWTYPE; -- PA876CLPBFBIMPSUPP-251 Changes -- 20Sep2016
not_a_valid_day   EXCEPTION;
not_a_valid_month   EXCEPTION;
not_a_valid_year  EXCEPTION;
PRAGMA EXCEPTION_INIT(not_a_valid_day, -1847);
PRAGMA EXCEPTION_INIT(not_a_valid_month, -1843);
PRAGMA EXCEPTION_INIT(not_a_valid_year, -1841);

BEGIN

dbg('to_date(p_recv_dc_status_dtl.g_from_date ' || to_date(p_recv_ic_dtl.g_frmdt, 'YYYY-MM-DD') || ' ' || global.application_date);
dbg('p_recv_dc_status_dtl.g_to_date ' || to_date(p_recv_ic_dtl.g_todate, 'YYYY-MM-DD'));
dbg('no of record value is ' || to_number(p_recv_ic_dtl.g_norec));

IF p_recv_ic_dtl.g_accno IS NULL
THEN
  dbg('GW-QAT-001 : Account Number Can Not Be Blank ');
  p_err_code  := 'GW-QAT-001;';
  p_err_param := ' Account Number Can Not Be Blank;';
  RETURN FALSE;
ELSIF p_recv_ic_dtl.g_accbrn IS NULL
THEN
  dbg('GW-QAT-002 : Account Branch Can Not Be Blank');
  p_err_code  := 'GW-QAT-002;';
  p_err_param := 'Account Branch Can Not Be Blank;';
  RETURN FALSE;
END IF;


-- PA876CLPBFBIMPSUPP-251 Changes Start Here -- 20Sep2016
BEGIN
  -- 3-18011148071 Changes Start Here -- 02Aug2018
  /*
  SELECT *
    INTO l_accrec
    FROM sttms_cust_account
   WHERE cust_ac_no = p_recv_ic_dtl.g_accno
     AND branch_code = p_recv_ic_dtl.g_accbrn;
  */
  IF NOT cvpkss_utils.get_sttm_cust_acc
                ( p_recv_ic_dtl.g_accbrn
         ,p_recv_ic_dtl.g_accno
         ,l_accrec
                )
  THEN
    dbg('Invalid account. Returning from here.');
    p_err_code  := 'GW-QAT-005;';
    p_err_param := 'Invalid Account Number;';
    RETURN FALSE;
  END IF;
  -- 3-18011148071 Changes End Here -- 02Aug2018
EXCEPTION
WHEN OTHERS
THEN
  BEGIN
    SELECT *
      INTO l_accrec
      FROM sttms_cust_account
     WHERE alt_ac_no = p_recv_ic_dtl.g_accno
       AND branch_code = p_recv_ic_dtl.g_accbrn;

    dbg('1.Before Cust Ac No-->'||p_recv_ic_dtl.g_accno);
    p_recv_ic_dtl.g_accno := l_accrec.cust_ac_no;
    dbg('1.After Cust Ac No-->'||p_recv_ic_dtl.g_accno);
  EXCEPTION
  WHEN OTHERS
  THEN
    -- 3-18011148071 Changes Start Here -- 02Aug2018
    NULL;
    dbg('Invalid account. Returning from here.');
    p_err_code  := 'GW-QAT-005;';
    p_err_param := 'Invalid Account Number;';
    RETURN FALSE;
    -- 3-18011148071 Changes End Here -- 02Aug2018
  END;
END;
-- PA876CLPBFBIMPSUPP-251 Changes End Here -- 20Sep2016

-- 3-18011148071 Changes Start Here -- 02Aug2018
/*
IF p_recv_ic_dtl.g_accno IS NOT NULL
THEN
    OPEN l_var_type FOR SELECT 1
              FROM sttm_cust_account
             WHERE cust_ac_no = p_recv_ic_dtl.g_accno
               AND branch_code = p_recv_ic_dtl.g_accbrn
               AND auth_stat = 'A'
               AND record_stat IN ('O','C')
               AND ROWNUM = 1;
  FETCH l_var_type INTO l_dummy;
  IF l_var_type%NOTFOUND
  THEN
    dbg('GW-QAT-005 : Invalid Account Number');
    p_err_code  := 'GW-QAT-005;';
    p_err_param := 'Invalid Account Number;';
    RETURN FALSE;
  END IF;
END IF;
*/
-- 3-18011148071 Changes End Here -- 02Aug2018

IF p_recv_ic_dtl.g_accbrn IS NOT NULL
THEN
  OPEN l_var_type FOR SELECT 1
              FROM sttm_branch
             WHERE branch_code = p_recv_ic_dtl.g_accbrn
               AND auth_stat = 'A'
               AND record_stat = 'O';
  FETCH l_var_type INTO l_dummy;

  IF l_var_type%NOTFOUND
  THEN
    dbg('GW-QAT-006 : Invalid Branch Code');
    p_err_code  := 'GW-QAT-006;';
    p_err_param := 'Invalid Branch Code;';
    RETURN FALSE;
  END IF;
END IF;

-- 3-18011148071 Changes Start Here -- 02Aug2018
/*
IF p_recv_ic_dtl.g_accno IS NOT NULL AND p_recv_ic_dtl.g_accbrn IS NOT NULL
THEN
  OPEN l_var_type FOR SELECT 1
              FROM sttm_cust_account
             WHERE cust_ac_no = p_recv_ic_dtl.g_accno
               AND branch_code = p_recv_ic_dtl.g_accbrn
               AND auth_stat = 'A'
               AND record_stat IN ('O','C');

  FETCH l_var_type INTO l_dummy;

  IF l_var_type%NOTFOUND
  THEN
    dbg('GW-QAT-008 : Invalid Combination Of Account Number and Account Branch');
    p_err_code  := 'GW-QAT-008;';
    p_err_param := 'Invalid Combination Of Account Number and Account Branch;';
    RETURN FALSE;
  END IF;
END IF;
*/
-- 3-18011148071 Changes End Here -- 02Aug2018

IF p_recv_ic_dtl.g_norec IS NULL
THEN
  dbg('in the validaton for the from date and to data');
  IF p_recv_ic_dtl.g_frmdt > nvl(p_recv_ic_dtl.g_todate, global.application_date)
  THEN
    dbg('GW-QAT-009 : From Date Should Be Less Than Or Equal To To Date Or Application Date');
    p_err_code  := 'GW-QAT-009;';
    p_err_param := 'From Date Should Be Less Than Or Equal To To Date;';
    RETURN FALSE;
    -- CLPBFBFCC1509 Changes Start Here -- 03Jun2015
    /*
      ELSIF p_recv_ic_dtl.g_todate > global.application_date THEN
      dbg('GW-QAT-010 : To Date Should Be Less Than Or Equal To Application Date');
      p_err_code  := 'GW-QAT-010;';
      p_err_param := 'To Date Should Be Less Than Or Equal To Application Date;';
      RETURN FALSE;
    */
    -- CLPBFBFCC1509 Changes End Here -- 03Jun2015
  --CLPFLBL_IFC69_18-DEC-2014_Onsite:CLPBFBFCC1379 Changes starts
  ELSIF p_recv_ic_dtl.g_todate IS NOT NULL AND p_recv_ic_dtl.g_frmdt IS NULL
  THEN
    p_err_code  := 'GW-QAT-014;';
    p_err_param := 'From Date can not be null when To Date is provided;';
    RETURN FALSE;
  --CLPFLBL_IFC69_18-DEC-2014_Onsite:CLPBFBFCC1379 Changes ends
  END IF;
END IF;

RETURN TRUE;

EXCEPTION
WHEN not_a_valid_day OR not_a_valid_month OR not_a_valid_year
THEN
    dbg('NOT A VALID DATE ' || SQLERRM || ' ' || SQLCODE);
    p_err_code  := 'GW-QAT-003;';
    p_err_param := 'Not A Valid Date Format;';
    ovpkss.pr_appendtbl(p_err_code, p_err_param);
    RETURN FALSE;
WHEN OTHERS
THEN
  dbg('FAILED IN THE fn_validate_req_val');
  RETURN FALSE;
END fn_validate_req_val;

-- PA876CLPBFBIMPSUPP-25 Changes Start Here -- 14Oct2015

FUNCTION Fn_Query_Cont_Udfdetails
    ( p_Product_Id   IN     VARCHAR2
         ,p_Key          IN     VARCHAR2
         ,p_Not_In_List  IN     VARCHAR2
         ,p_Udf_Rec      IN OUT   cstms_contract_userdef_fields%ROWTYPE
         ,p_Udf_Det      IN OUT   uvpkss_udf_upload.ty_upl_cont_udf
         ,p_Error_Code   IN OUT   VARCHAR2
         ,p_Error_Params IN OUT   VARCHAR2
    )
RETURN BOOLEAN
IS

i               NUMBER := 0;
l_Version       NUMBER := 1;
l_Field_Num     NUMBER := 0;
l_Product_Code  VARCHAR2(100);
l_Not_In_List   VARCHAR2(32767) := '~' || p_Not_In_List || '~';
l_Key           VARCHAR2(32767) := p_Key;

CURSOR Cr_Udfdet(p_Ref VARCHAR2, p_Ver NUMBER, p_Product_Id VARCHAR2)
    IS SELECT p.Field_Name,
        p.Field_Num,
          DECODE( p.Field_Num
                     ,1
                     ,Field_Val_1
                     ,2
                     ,Field_Val_2
                     ,3
                     ,Field_Val_3
                     ,4
                     ,Field_Val_4
                     ,5
                     ,Field_Val_5
                     ,6
                     ,Field_Val_6
                     ,7
                     ,Field_Val_7
                     ,8
                     ,Field_Val_8
                     ,9
                     ,Field_Val_9
                     ,10
                     ,Field_Val_10
                     ,11
                     ,Field_Val_11
                     ,12
                     ,Field_Val_12
                     ,13
                     ,Field_Val_13
                     ,14
                     ,Field_Val_14
                     ,15
                     ,Field_Val_15
                     ,16
                     ,Field_Val_16
                     ,17
                     ,Field_Val_17
                     ,18
                     ,Field_Val_18
                     ,19
                     ,Field_Val_19
                     ,20
                     ,Field_Val_20
                     ,21
                     ,Field_Val_21
                     ,22
                     ,Field_Val_22
                     ,23
                     ,Field_Val_23
                     ,24
                     ,Field_Val_24
                     ,25
                     ,Field_Val_25
                     ,26
                     ,Field_Val_26
                     ,27
                     ,Field_Val_27
                     ,28
                     ,Field_Val_28
                     ,29
                     ,Field_Val_29
                     ,30
                     ,Field_Val_30
                     ,31
                     ,Field_Val_31
                     ,32
                     ,Field_Val_32
                     ,33
                     ,Field_Val_33
                     ,34
                     ,Field_Val_34
                     ,35
                     ,Field_Val_35
                     ,36
                     ,Field_Val_36
                     ,37
                     ,Field_Val_37
                     ,38
                     ,Field_Val_38
                     ,39
                     ,Field_Val_39
                     ,40
                     ,Field_Val_40
                     ,41
                     ,Field_Val_41
                     ,42
                     ,Field_Val_42
                     ,43
                     ,Field_Val_43
                     ,44
                     ,Field_Val_44
                     ,45
                     ,Field_Val_45
                     ,46
                     ,Field_Val_46
                     ,47
                     ,Field_Val_47
                     ,48
                     ,Field_Val_48
                     ,49
                     ,Field_Val_49
                     ,50
                     ,Field_Val_50
                     ,51
                     ,Field_Val_51
                     ,52
                     ,Field_Val_52
                     ,53
                     ,Field_Val_53
                     ,54
                     ,Field_Val_54
                     ,55
                     ,Field_Val_55
                     ,56
                     ,Field_Val_56
                     ,57
                     ,Field_Val_57
                     ,58
                     ,Field_Val_58
                     ,59
                     ,Field_Val_59
                     ,60
                     ,Field_Val_60
                     ,61
                     ,Field_Val_61
                     ,62
                     ,Field_Val_62
                     ,63
                     ,Field_Val_63
                     ,64
                     ,Field_Val_64
                     ,65
                     ,Field_Val_65
                     ,66
                     ,Field_Val_66
                     ,67
                     ,Field_Val_67
                     ,68
                     ,Field_Val_68
                     ,69
                     ,Field_Val_69
                     ,70
                     ,Field_Val_70
                     ,71
                     ,Field_Val_71
                     ,72
                     ,Field_Val_72
                     ,73
                     ,Field_Val_73
                     ,74
                     ,Field_Val_74
                     ,75
                     ,Field_Val_75
                     ,76
                     ,Field_Val_76
                     ,77
                     ,Field_Val_77
                     ,78
                     ,Field_Val_78
                     ,79
                     ,Field_Val_79
                     ,80
                     ,Field_Val_80
                     ,81
                     ,Field_Val_81
                     ,82
                     ,Field_Val_82
                     ,83
                     ,Field_Val_83
                     ,84
                     ,Field_Val_84
                     ,85
                     ,Field_Val_85
                     ,86
                     ,Field_Val_86
                     ,87
                     ,Field_Val_87
                     ,88
                     ,Field_Val_88
                     ,89
                     ,Field_Val_89
                     ,90
                     ,Field_Val_90
                     ,91
                     ,Field_Val_91
                     ,92
                     ,Field_Val_92
                     ,93
                     ,Field_Val_93
                     ,94
                     ,Field_Val_94
                     ,95
                     ,Field_Val_95
                     ,96
                     ,Field_Val_96
                     ,97
                     ,Field_Val_97
                     ,98
                     ,Field_Val_98
                     ,99
                     ,Field_Val_99
          ) AS Field_Value, f.Field_Type AS Data_Type, f.Val_Type AS Val_Type
         FROM cstms_contract_userdef_fields u, cstms_product_udf_fields_map p, udtm_fields f
        WHERE p.Product_Code = p_Product_Id
      AND p.Auth_Stat = 'A'
      AND f.Field_Name = p.Field_Name
      AND u.Product_Code(+) = p.Product_Code
      AND u.Contract_Ref_No(+) = p_Ref
      AND u.Version_No(+) = p_Ver
      AND p.Field_Num <= 99
        UNION
       SELECT p.Field_Name,
        p.Field_Num,
        DECODE( p.Field_Num
                     ,100
                     ,Field_Val_100
                     ,101
                     ,Field_Val_101
                     ,102
                     ,Field_Val_102
                     ,103
                     ,Field_Val_103
                     ,104
                     ,Field_Val_104
                     ,105
                     ,Field_Val_105
                     ,106
                     ,Field_Val_106
                     ,107
                     ,Field_Val_107
                     ,108
                     ,Field_Val_108
                     ,109
                     ,Field_Val_109
                     ,110
                     ,Field_Val_110
                     ,111
                     ,Field_Val_111
                     ,112
                     ,Field_Val_112
                     ,113
                     ,Field_Val_113
                     ,114
                     ,Field_Val_114
                     ,115
                     ,Field_Val_115
                     ,116
                     ,Field_Val_116
                     ,117
                     ,Field_Val_117
                     ,118
                     ,Field_Val_118
                     ,119
                     ,Field_Val_119
                     ,120
                     ,Field_Val_120
                     ,121
                     ,Field_Val_121
                     ,122
                     ,Field_Val_122
                     ,123
                     ,Field_Val_123
                     ,124
                     ,Field_Val_124
                     ,125
                     ,Field_Val_125
                     ,126
                     ,Field_Val_126
                     ,127
                     ,Field_Val_127
                     ,128
                     ,Field_Val_128
                     ,129
                     ,Field_Val_129
                     ,130
                     ,Field_Val_130
                     ,131
                     ,Field_Val_131
                     ,132
                     ,Field_Val_132
                     ,133
                     ,Field_Val_133
                     ,134
                     ,Field_Val_134
                     ,135
                     ,Field_Val_135
                     ,136
                     ,Field_Val_136
                     ,137
                     ,Field_Val_137
                     ,138
                     ,Field_Val_138
                     ,139
                     ,Field_Val_139
                     ,140
                     ,Field_Val_140
                     ,141
                     ,Field_Val_141
                     ,142
                     ,Field_Val_142
                     ,143
                     ,Field_Val_143
                     ,144
                     ,Field_Val_144
                     ,145
                     ,Field_Val_145
                     ,146
                     ,Field_Val_146
                     ,147
                     ,Field_Val_147
                     ,148
                     ,Field_Val_148
                     ,149
                     ,Field_Val_149
                     ,150
                     ,Field_Val_150
                     ,151
                     ,Field_Val_151
                     ,152
                     ,Field_Val_152
                     ,153
                     ,Field_Val_153
                     ,154
                     ,Field_Val_154
                     ,155
                     ,Field_Val_155
                     ,156
                     ,Field_Val_156
                     ,157
                     ,Field_Val_157
                     ,158
                     ,Field_Val_158
                     ,159
                     ,Field_Val_159
                     ,160
                     ,Field_Val_160
                     ,161
                     ,Field_Val_161
                     ,162
                     ,Field_Val_162
                     ,163
                     ,Field_Val_163
                     ,164
                     ,Field_Val_164
                     ,165
                     ,Field_Val_165
                     ,166
                     ,Field_Val_166
                     ,167
                     ,Field_Val_167
                     ,168
                     ,Field_Val_168
                     ,169
                     ,Field_Val_169
                     ,170
                     ,Field_Val_170
                     ,171
                     ,Field_Val_171
                     ,172
                     ,Field_Val_172
                     ,173
                     ,Field_Val_173
                     ,174
                     ,Field_Val_174
                     ,175
                     ,Field_Val_175
                     ,176
                     ,Field_Val_176
                     ,177
                     ,Field_Val_177
                     ,178
                     ,Field_Val_178
                     ,179
                     ,Field_Val_179
                     ,180
                     ,Field_Val_180
                     ,181
                     ,Field_Val_181
                     ,182
                     ,Field_Val_182
                     ,183
                     ,Field_Val_183
                     ,184
                     ,Field_Val_184
                     ,185
                     ,Field_Val_185
                     ,186
                     ,Field_Val_186
                     ,187
                     ,Field_Val_187
                     ,188
                     ,Field_Val_188
                     ,189
                     ,Field_Val_189
                     ,190
                     ,Field_Val_190
                     ,191
                     ,Field_Val_191
                     ,192
                     ,Field_Val_192
                     ,193
                     ,Field_Val_193
                     ,194
                     ,Field_Val_194
                     ,195
                     ,Field_Val_195
                     ,196
                     ,Field_Val_196
                     ,197
                     ,Field_Val_197
                     ,198
                     ,Field_Val_198
                     ,199
                     ,Field_Val_199
                     ,200
                     ,Field_Val_200) AS Field_Value, f.Field_Type AS Data_Type, f.Val_Type AS Val_Type
        FROM cstms_contract_userdef_fields u, cstms_product_udf_fields_map p, udtm_fields f
               WHERE p.Product_Code = p_product_id
           AND p.Auth_Stat = 'A'
         AND f.Field_Name = p.Field_Name
         AND u.Product_Code(+) = p.Product_Code
         AND u.Contract_Ref_No(+) = p_Ref
         AND u.Version_No(+) = p_Ver
               AND p.Field_Num > 99
               ORDER BY Field_Num;

BEGIN

RETURN TRUE;  -- PA876CLPBFBIMPSUPP-159 changes

Dbg('Inside Function fn_query_cont_udfdetails');
p_Udf_Det.DELETE;
l_Key := Cspkes_Misc.Fn_Getparam(p_Key, 1, '~');

SELECT MAX(Version_No)
  INTO l_Version
  FROM Cstms_Contract_Userdef_Fields x
 WHERE Contract_Ref_No = l_Key;

BEGIN
  SELECT product_code
    INTO l_product_code
    FROM cstms_contract_userdef_fields x
   WHERE contract_ref_no = l_Key
     AND Version_No = l_Version;
EXCEPTION
WHEN OTHERS
THEN
  Dbg('Failed in Selcting From Cstms_Contract_Userdef_Fields..');
  Dbg(SQLERRM);
  l_Product_Code := NULL;
END;

    --FCJ CHNAGES STARTS Changed the Index ..Also Modified the Cursor
FOR Each_Trn IN Cr_Udfdet(l_Key, l_Version, l_product_code)
LOOP
  IF p_Not_In_List IS NOT NULL
  THEN
    IF NOT uvpkss_udf_upload.Fn_Get_Cont_Field_No
                ( l_Product_Code
                 ,Each_Trn.Field_Name
                 ,l_Field_Num
                 ,p_Error_Code
                 ,p_Error_Params
                )
    THEN
      Dbg('Failed in  Fn_Get_Cont_Field_No..');
      RETURN FALSE;
    END IF;
  END IF;

  IF INSTR(l_Not_In_List, '~' || l_Field_Num || '~') = 0
  THEN
    i := i + 1;
    Dbg('Inside UDF Loop.......... ' || i);
    p_Udf_Det(i) .Field_Name := Each_Trn.Field_Name;
    p_Udf_Det(i) .Field_Val := Each_Trn.Field_Value;
    p_Udf_Det(i) .Data_Type := Each_Trn.Data_Type;
    p_Udf_Det(i) .Val_Type := Each_Trn.Val_Type;
  END IF;
END LOOP;

Dbg('Successfully Returns From the Function fn_query_cont_udfdetails.');
RETURN TRUE;

EXCEPTION
WHEN OTHERS
THEN
    Dbg('When others in fn_query_func_udfdetails-->' || SQLERRM);
    p_Error_Code   := 'ST-OTHR-001';
    p_Error_Params := 'In the function fn_query_cont_udfdetails ';
    RETURN FALSE;
END fn_query_cont_udfdetails;

-- PA876CLPBFBIMPSUPP-243 Changes Start Here -- 30Jul2016
FUNCTION fn_get_mcr_accclsd
    ( p_branch_code IN VARCHAR2
     ,p_acc_no      IN VARCHAR2
     ,p_prod        IN VARCHAR2
     ,p_from_date   IN DATE
     ,p_to_date     IN DATE
    )
RETURN icpkss_maint.tb_acc_sde_vals
IS

l_Tb_Acc_Sde_Vals   icpkss_maint.tb_acc_sde_vals;
l_rule              ictms_rule.rule_id%TYPE;
mr                  NUMBER := 0;

BEGIN
dbg('Inside function fn_get_mcr_accclsd');

SELECT rule
  INTO l_rule
  FROM ictms_pr_int m
 WHERE m.product_code = p_prod;

IF l_rule IS NOT NULL
THEN
    FOR x IN (SELECT brn, acc, frm_dt, frm_el2
              FROM ictbs_is_vals u1
               WHERE acc = p_acc_no
           AND brn = p_branch_code
         AND rule_id = l_rule
                 AND u1.frm_dt = (SELECT MAX(frm_dt)
                  FROM ictb_is_vals u1
                   WHERE brn = p_branch_code
                   AND acc = p_acc_no
                   AND frm_dt <= p_from_date)
               UNION
              SELECT brn, acc, frm_dt, frm_el2
              FROM ictb_is_vals u2
               WHERE acc = p_acc_no
             AND brn = p_branch_code
                 AND rule_id = l_rule
                 AND u2.frm_dt BETWEEN p_from_date+1 AND p_to_date)
  LOOP
    mr := mr+1;
    l_Tb_Acc_Sde_Vals(mr).sde_id := 'MCR_RATE1';
    l_Tb_Acc_Sde_Vals(mr).from_dt := x.frm_dt;
    l_Tb_Acc_Sde_Vals(mr).to_dt := NULL;
    l_Tb_Acc_Sde_Vals(mr).sde_val := x.frm_el2;
  END LOOP;

  IF l_Tb_Acc_Sde_Vals.COUNT > 0
  THEN
    FOR x IN l_Tb_Acc_Sde_Vals.FIRST..l_Tb_Acc_Sde_Vals.LAST
    LOOP
      IF l_Tb_Acc_Sde_Vals.NEXT(x) IS NOT NULL
      THEN
        l_Tb_Acc_Sde_Vals(x).to_dt := l_Tb_Acc_Sde_Vals(l_Tb_Acc_Sde_Vals.next(x)).from_dt - 1;
      ELSE
        l_Tb_Acc_Sde_Vals(x).to_dt := p_to_date;
      END IF;
    END LOOP;

    FOR i IN l_Tb_Acc_Sde_Vals.FIRST .. l_Tb_Acc_Sde_Vals.LAST
    LOOP
      dbg('BAL SDE VALS : i ' || i || ' ~ ' || l_Tb_Acc_Sde_Vals(i).FROM_DT || ' ~ ' ||
         l_Tb_Acc_Sde_Vals(i).TO_DT || ' ~ ' || l_Tb_Acc_Sde_Vals(i).SDE_VAL || ' ~ ');
      dbg('------------------------------------------------------');
    END LOOP;
  END IF;
END IF;

dbg('Returning from fn_get_mcr_accclsd with records count-->'||l_Tb_Acc_Sde_Vals.COUNT);
RETURN l_Tb_Acc_Sde_Vals;

EXCEPTION
WHEN OTHERS
THEN
    DBG('Oracle Error-->'||SQLERRM||'~'||dbms_utility.format_error_backtrace);
    l_Tb_Acc_Sde_Vals.DELETE;
    RETURN l_Tb_Acc_Sde_Vals;
END fn_get_mcr_accclsd;
-- PA876CLPBFBIMPSUPP-243 Changes End Here -- 30Jul2016

FUNCTION fn_reply_locdtl
         ( p_acc_dtl        IN OUT        g_rec_acc_dtl,
           p_resp_node_name IN            VARCHAR2,
           p_data           IN OUT NOCOPY   CLOB,   -- PA876CLPBFBIMPSUPP-159 changes
           p_key            IN OUT NOCOPY   CLOB,   -- PA876CLPBFBIMPSUPP-159 changes
           p_parent         IN OUT NOCOPY   CLOB,       -- PA876CLPBFBIMPSUPP-159 changes
           p_format         IN OUT NOCOPY   CLOB,   -- PA876CLPBFBIMPSUPP-159 changes
           p_err_code       IN OUT        VARCHAR2,
           p_err_param      IN OUT        VARCHAR2
         )
RETURN BOOLEAN
IS

TYPE rec_accprod IS RECORD
     ( prod         ictms_pr_int.product_code%TYPE
    ,last_liq_dt  DATE
    ,next_liq_dt  DATE
   );
TYPE typ_accprod IS TABLE OF rec_accprod INDEX BY BINARY_INTEGER;

tbl_accprod         typ_accprod;
l_int_rate          ictms_pr_int_udevals.ude_value%TYPE;
l_prod_type         ictms_pr_int_c.product_calc_type%TYPE;
l_noofrecs          cstbs_param.param_val%TYPE;
l_daterec           sttms_dates%ROWTYPE;
l_prod              ictbs_acc_pr.prod%TYPE;
l_tot_util          getms_facility.utilisation%TYPE := 0;
l_start_util        getms_facility.utilisation%TYPE := 0;
p_tslist        VARCHAR2(32767);
l_counter           NUMBER := 0;
l_tax_amt           NUMBER := 0;
l_from_date         DATE;
l_to_date           DATE;
l_flag              CHAR(1) := 'N';
idx                 NUMBER := 1;
l_udf_rec     cstms_contract_userdef_fields%ROWTYPE;
l_udf_det     uvpkss_udf_upload.Ty_Upl_Cont_Udf;
l_mcr       CHAR(1);
l_mcr_rate      NUMBER;
l_Tb_Acc_Sde_Vals   Icpks_Maint.Tb_Acc_Sde_Vals;
l_data_temp     VARCHAR2(32767); -- 3-18011148071 Changes -- 02Aug2018

TYPE ty_rec_reply_acc IS RECORD
(
  accbrn              acvws_all_ac_entries.ac_branch%TYPE,
  accno               acvws_all_ac_entries.ac_no%TYPE,
  acsrno              acvws_all_ac_entries.ac_entry_sr_no%TYPE,
  trn_ref_no          acvws_all_ac_entries.trn_ref_no%TYPE,
  module              acvws_all_ac_entries.module%TYPE,
  product             actbs_daily_log.product%TYPE,
  valdate             acvws_all_ac_entries.value_dt%TYPE,
  trndate             acvws_all_ac_entries.trn_dt%TYPE,
  amnt                acvws_all_ac_entries.lcy_amount%TYPE,
  trnbrn              acvws_all_ac_entries.ac_branch%TYPE,
  trncode             acvws_all_ac_entries.trn_code%TYPE,
  trndesc             detbs_rtl_teller.narrative%TYPE,
  drcrind             acvws_all_ac_entries.drcr_ind%TYPE,
  event               acvws_all_ac_entries.event%TYPE,
  instrument_code     acvws_all_ac_entries.instrument_code%TYPE,
  tot_util            getms_facility.utilisation%TYPE,
  interest_rate       NUMBER(24,12),
  interest_amt        NUMBER
);
rec_reply_acc         ty_rec_reply_acc;

TYPE ty_rec_console IS RECORD
(
  rec_reply_acc     ty_rec_reply_acc,
  udf_det       uvpkss_udf_upload.Ty_Upl_Cont_Udf
);
TYPE ty_tb_reply_acc IS TABLE OF ty_rec_console INDEX BY PLS_INTEGER;
tbl_consol_entries    ty_tb_reply_acc;

TYPE ty_cursor IS REF CURSOR RETURN ty_rec_reply_acc;
cur_accmov            ty_cursor;

CURSOR cr_int_chrg(p_cust_ac_no VARCHAR2, p_branch_code VARCHAR2, p_prod  VARCHAR2)
    IS SELECT DISTINCT *
     FROM ictw_memo_booking
      WHERE brn = p_branch_code
      AND acc = p_cust_ac_no
      AND prod = p_prod;

BEGIN

dbg('Inside function fn_reply_locdtl for LOC account');
dbg('Account Branch-->'||p_acc_dtl.g_accbrn);
dbg('Account Number-->'||p_acc_dtl.g_accno);
dbg('From Date-->'||p_acc_dtl.g_frmdt);
dbg('To Date-->'||p_acc_dtl.g_todate);
dbg('Number of Records-->'||p_acc_dtl.g_norec);

dbg('Start of validation for LOC account');
-- For LOC accounts, the query will be based on Dates only. Number of records in the request message will not be used.
IF p_acc_dtl.g_frmdt IS NULL AND p_acc_dtl.g_todate IS NOT NULL
THEN
    dbg('From Date is null when To Date is not null');
  p_err_code  := 'GW-QAT-014;';
  p_err_param := 'From Date can not be null when To Date is provided;';
  RETURN FALSE;
END IF;

IF p_acc_dtl.g_frmdt > nvl(p_acc_dtl.g_todate, global.application_date)
THEN
  dbg('GW-QAT-009 : From Date Should Be Less Than Or Equal To To Date Or Application Date');
  p_err_code  := 'GW-QAT-009;';
  p_err_param := 'From Date Should Be Less Than Or Equal To To Date;';
  RETURN FALSE;
END IF;

p_key     := p_tslist;
p_parent  := p_resp_node_name;
p_format  := '1';
g_cnt_lvl   := g_cnt_lvl + 1;
l_counter   := l_counter + 1;

p_tslist    := 'ACCNO~ACCBRN~';
p_data      := p_data || '>' || p_acc_dtl.g_accno ||'~'|| p_acc_dtl.g_accbrn ||'~' || '>';
p_key       := p_key || '>' || p_tslist || '>';
p_parent    := p_parent || '>Cotms-QueryAccMove-Master' || '>';
p_format    := p_format || '>' || g_cnt_lvl || '.' || l_counter || '>';

BEGIN
  SELECT y.product_code, x.last_liq_dt, x.next_liq_dt
    BULK COLLECT INTO tbl_accprod
    FROM ictms_pr_int y, ictms_rule_frm z, ictbs_acc_pr x
   WHERE x.prod = y.product_code
     AND z.rule_id = y.rule
     AND x.acc = p_acc_dtl.g_accno
     AND x.brn = p_acc_dtl.g_accbrn;
EXCEPTION
WHEN OTHERS
THEN
    dbg('Oracle Error while getting the product-->'||SQLERRM);
END;

IF tbl_accprod.COUNT = 0
THEN
    SELECT y.product_code, NULL, NULL
    BULK COLLECT INTO tbl_accprod
      FROM ictms_pr_int y, ictms_pr_int_aclass x, ictms_rule_frm z
     WHERE x.product_code = y.product_code
     AND z.rule_id = y.rule
     AND aclass = pkg_custrec.account_class;
END IF;
-- PA876CLPBFBIMPSUPP-159 changes Starts
  dbms_lob.createtemporary(pkg_key, true);
  dbms_lob.createtemporary(pkg_data, true);
  dbms_lob.createtemporary(pkg_parent, true);
  dbms_lob.createtemporary(pkg_format, true);
  dbg('Before creating ');

  dbms_lob.open(pkg_key, dbms_lob.lob_readwrite);
  dbms_lob.open(pkg_data, dbms_lob.lob_readwrite);
  dbms_lob.open(pkg_parent, dbms_lob.lob_readwrite);
  dbms_lob.open(pkg_format, dbms_lob.lob_readwrite);

  IF NOT fn_reassign_clob
       ( p_key
      ,p_data
      ,p_parent
      ,p_format
      ,p_err_code
      ,p_err_param
       )
  THEN
    dbg('Assigning the clob variable failed-->'||p_err_code||'~~'||p_err_param);
    RETURN FALSE;
  END IF;

-- PA876CLPBFBIMPSUPP-159 changes Ends
IF tbl_accprod.COUNT > 0
THEN
    p_tslist := 'PRODUCT~PRODTYPE~FROMDATE~TODATE~TAXRATE~TAXAMT~';
    FOR x IN tbl_accprod.FIRST..tbl_accprod.LAST -- Loop through products.
  LOOP
      dbg('Prod~NextLiqDt~LastLiqDt-->'||tbl_accprod(x).prod||'~'||tbl_accprod(x).next_liq_dt||'~'||tbl_accprod(x).last_liq_dt);
    l_int_rate  := NULL;
    l_tax_amt := NULL;

    l_counter := l_counter + 1;
    l_int_rate := gwpkss_queryaccliqditiondate.fn_get_intrate_1
                      ( p_acc_dtl.g_accno
                       ,p_acc_dtl.g_accbrn
                       ,pkg_custrec.ccy
                       ,tbl_accprod(x).prod
                       ,GREATEST(NVL(p_acc_dtl.g_todate, global.application_date), global.application_date)
                       ,l_prod_type
                      );

    dbg('Got the tax rate as-->'||l_int_rate);

    -- PA876CLPBFBIMPSUPP-243 Changes Start Here -- 30Jul2017
    IF pkg_custrec.record_stat = 'C' AND l_prod_type = 'I'
    THEN
      l_prod := tbl_accprod(x).prod;
    END IF;
    -- PA876CLPBFBIMPSUPP-243 Changes End Here -- 30Jul2017

    dbg('Populate the from date and to date');
    IF tbl_accprod(x).next_liq_dt IS NOT NULL
    THEN
      -- Tax amount will be displayed only for the current cycle.
      -- And this will depend on the input parameters.
      -- If number of records are given; if todate is in the current liq cycle.
      IF NVL(p_acc_dtl.g_todate, global.application_date) BETWEEN tbl_accprod(x).last_liq_dt+1 AND tbl_accprod(x).next_liq_dt
      THEN
        l_from_date := tbl_accprod(x).last_liq_dt+1;
        l_to_date   := tbl_accprod(x).next_liq_dt;
      END IF;

      dbg('FromDate-->'||l_from_date);
      dbg('ToDate-->'||l_to_date);

      IF l_prod_type = 'T'
      THEN
        IF l_to_date IS NOT NULL
        THEN
          DELETE FROM ictw_memo_booking
              WHERE brn = p_acc_dtl.g_accbrn
              AND acc = p_acc_dtl.g_accno
              AND prod = tbl_accprod(x).prod;
          dbg('1.Number of rows deleted-->'||SQL%ROWCOUNT);

          icpks_test.pr_icalc
                  ( p_acc_dtl.g_accbrn
                   ,p_acc_dtl.g_accno
                   ,tbl_accprod(x).prod
                   ,l_from_date
                   ,l_to_date
                  );

          dbg('Calculation is finished.');
          FOR each_rec IN cr_int_chrg(p_acc_dtl.g_accno, p_acc_dtl.g_accbrn, tbl_accprod(x).prod) -- Loop through products.
          LOOP
            l_tax_amt := each_rec.amt;
          END LOOP;
          dbg('Tax amount is-->'||l_tax_amt);

          DELETE FROM ictw_memo_booking
              WHERE brn = p_acc_dtl.g_accbrn
              AND acc = p_acc_dtl.g_accno
              AND prod = tbl_accprod(x).prod;
          dbg('2.Number of rows deleted-->'||SQL%ROWCOUNT);
        END IF;
      ELSE
                IF l_to_date IS NOT NULL
        THEN
          BEGIN
            SELECT /*+Parallel(2)*/NVL(SUM(cur_run_accr), 0)
              INTO l_tax_amt
              FROM ictbs_entries_history
             WHERE brn = p_acc_dtl.g_accbrn
               AND acc = p_acc_dtl.g_accno
               AND prod = tbl_accprod(x).prod
               AND run_date BETWEEN l_from_date AND l_to_date;
          EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
            dbg('WNDF while getting accr amt');
            l_tax_amt := NULL;
          WHEN OTHERS
          THEN
            dbg('Oracle Error while getting accr amt-->'||SQLERRM);
            l_tax_amt := NULL;
          END;
        END IF;
      END IF;
    END IF;

    p_data    := p_data || tbl_accprod(x).prod || '~' || l_prod_type || '~' ||
           TO_CHAR(l_from_date, Cspks_Req_Global.g_Ws_Date_Format) || '~' ||
           TO_CHAR(l_to_date, Cspks_Req_Global.g_Ws_Date_Format) || '~' ||
           l_int_rate || '~' ||l_tax_amt || '~' || '>';
    p_key     := p_key || p_tslist || '>';
    p_parent  := p_parent || 'Cotms-Interest-Liqd-Details' || '>';
    p_format  := p_format || g_cnt_lvl || '.' || l_counter || '>';
  END LOOP;
END IF;

-- PA876CLPBFBIMPSUPP-243 Changes Start Here -- 30Jul2017
IF l_prod IS NULL
THEN
-- PA876CLPBFBIMPSUPP-243 Changes End Here -- 30Jul2017
  l_prod := acpkss_stmt_custom.fn_get_int_prod
              ( p_acc_dtl.g_accno
               ,p_acc_dtl.g_accbrn
              );
END IF; -- PA876CLPBFBIMPSUPP-243 Changes -- 30Jul2017
dbg('Got the interest product-->'||l_prod);

BEGIN
  SELECT 'Y'
      INTO l_mcr
    FROM ictms_rule_sde m, ictms_pr_int n
   WHERE m.rule_id = n.rule
     AND n.product_code = l_prod
     AND m.sde_id = 'MCR_RATE1';
EXCEPTION
WHEN NO_DATA_FOUND
THEN
  l_mcr := 'N';
END;

dbg('Getting the accounting entries now');
l_noofrecs := NVL(cspkss_os_param.get_param_val('NOOFRECS'), '50');
-- Need to get the from date and to date. This is required to display previous utilization for that day.
cvpks_utils.get_brn_date
       ( p_acc_dtl.g_accbrn
    ,l_daterec
       );

l_from_date := NVL(p_acc_dtl.g_frmdt, l_daterec.today);
l_to_date   := NVL(p_acc_dtl.g_todate, l_daterec.next_working_day);
dbg('From Date and ToDate is-->'|| l_from_date ||'~'||l_to_date);

dbg('Get the util amount at the start of the period');
BEGIN
SELECT ABS(bal)
  INTO l_start_util
  FROM actbs_vd_bal z
 WHERE brn = p_acc_dtl.g_accbrn
   AND acc = p_acc_dtl.g_accno
   AND val_dt = (SELECT MAX(val_dt)
                 FROM actbs_vd_bal
          WHERE brn = z.brn
          AND acc = z.acc
          AND val_dt < l_from_date);
EXCEPTION
WHEN NO_DATA_FOUND
THEN
    dbg('WNDF while getting the utilization at start of period');
  BEGIN
    SELECT DECODE(ac_ccy, global.lcy, lcy_amount, fcy_amount)
        INTO l_start_util
      FROM acvws_all_ac_entries_custom
     WHERE ac_branch = p_acc_dtl.g_accbrn
         AND ac_no = p_acc_dtl.g_accno
       AND event = 'CONV'
       AND dont_showin_stmt = 'Y';
  EXCEPTION
  WHEN NO_DATA_FOUND
  THEN
    dbg('WNDF while selecting the opening bal for CONV entries');
    l_start_util := 0;
  WHEN OTHERS
  THEN
    dbg('Oracle Err while selecting the opening bal for CONV entries-->'||SQLERRM);
    l_start_util := 0;
  END;
WHEN OTHERS
THEN
    dbg('Oracle Err while getting the utilization at start of period-->'||SQLERRM);
  l_start_util := 0;
END;

dbg('Utilization at the start of period-->'||l_from_date||'~'||l_start_util);
l_tot_util := l_start_util;

p_tslist := 'ACCBRN~ACCNO~FCCREF~MODULE~PRD~VALDATE~TRNDATE~AMNT~TRNBRN~TRNCODE~TRNDESC~DRCRIND~INSTRNO~TOTUTIL~INTACCR~INTRATE~';

FOR l_day IN ( SELECT l_from_date + LEVEL - 1 AS loopday
                 FROM dual
              CONNECT BY LEVEL <= l_to_date - l_from_date + 1
             )
LOOP
    l_flag := 'N';
    OPEN cur_accmov
   FOR SELECT *
       FROM (SELECT ac_branch, ac_no, ac_entry_sr_no, trn_ref_no, module,
            DECODE(module,'DD',SUBSTR(trn_ref_no,4,4),'RT',SUBSTR(trn_ref_no,4,4)) product, value_dt,
            DECODE(event,'CONV',txn_init_date,trn_dt) trndate,
            DECODE(pkg_custrec.ccy, global.lcy, lcy_amount, fcy_amount) amnt,
            SUBSTR(trn_ref_no,1,3) trn_brn,
            vw.trn_code, trn_desc, drcr_ind, event, instrument_code,
            '' tot_util, '' interest_rate, '' interest_amt
           FROM acvws_all_ac_entries_custom vw,sttms_trn_code cd
          WHERE vw.trn_code=cd.trn_code
          AND vw.ac_no = p_acc_dtl.g_accno
          AND vw.ac_branch = p_acc_dtl.g_accbrn
          AND vw.auth_stat = 'A'
          AND ((vw.event = 'CONV' AND vw.txn_init_date = l_day.loopday)
            OR
             (vw.event <> 'CONV' AND vw.trn_dt = l_day.loopday))
          AND NVL(vw.dont_showin_stmt, 'N') = 'N'
          ORDER BY DECODE(event, 'CONV', txn_init_date, trn_dt), vw.ac_entry_sr_no)
          WHERE ROWNUM <= nvl(p_acc_dtl.g_norec,l_noofrecs);
  LOOP
    FETCH cur_accmov INTO rec_reply_acc;
    EXIT WHEN cur_accmov%NOTFOUND;
    l_flag := 'Y';

    dbg('AcEntrySrno~Event~TxnDt~DrcrInd~Amt-->'||rec_reply_acc.acsrno||'~'||rec_reply_acc.event||'~'|| rec_reply_acc.trndate||'~'||rec_reply_acc.drcrind||'~'||rec_reply_acc.amnt);

    IF rec_reply_acc.drcrind = 'D'
    THEN
      l_tot_util := rec_reply_acc.amnt + l_tot_util;
      dbg('1.l_tot_util-->' || l_tot_util || '~TxnAmt~' || rec_reply_acc.amnt);
    ELSE
      l_tot_util := l_tot_util - rec_reply_acc.amnt;
      dbg('2.l_tot_util-->' || l_tot_util || '~TxnAmt~' || rec_reply_acc.amnt);
    END IF;

    tbl_consol_entries(idx).rec_reply_acc.accbrn        := rec_reply_acc.accbrn;
    tbl_consol_entries(idx).rec_reply_acc.accno         := rec_reply_acc.accno;
    tbl_consol_entries(idx).rec_reply_acc.acsrno        := rec_reply_acc.acsrno;
    tbl_consol_entries(idx).rec_reply_acc.trn_ref_no    := rec_reply_acc.trn_ref_no;
    tbl_consol_entries(idx).rec_reply_acc.module        := rec_reply_acc.module;
    tbl_consol_entries(idx).rec_reply_acc.product       := rec_reply_acc.product;
    tbl_consol_entries(idx).rec_reply_acc.valdate       := rec_reply_acc.valdate;
    tbl_consol_entries(idx).rec_reply_acc.trndate       := rec_reply_acc.trndate;
    tbl_consol_entries(idx).rec_reply_acc.amnt          := rec_reply_acc.amnt;
    tbl_consol_entries(idx).rec_reply_acc.trnbrn        := rec_reply_acc.trnbrn;
    tbl_consol_entries(idx).rec_reply_acc.trncode       := rec_reply_acc.trncode;
    tbl_consol_entries(idx).rec_reply_acc.trndesc       := rec_reply_acc.trndesc;
    tbl_consol_entries(idx).rec_reply_acc.drcrind       := rec_reply_acc.drcrind;
    tbl_consol_entries(idx).rec_reply_acc.event         := rec_reply_acc.event;
    tbl_consol_entries(idx).rec_reply_acc.instrument_code   := rec_reply_acc.instrument_code;
    tbl_consol_entries(idx).rec_reply_acc.tot_util          := l_tot_util;
    tbl_consol_entries(idx).rec_reply_acc.interest_rate     := NULL;
    tbl_consol_entries(idx).rec_reply_acc.interest_amt      := NULL;

    l_udf_rec := NULL;
    l_udf_det.DELETE;

    IF rec_reply_acc.module IN ('RT') OR rec_reply_acc.event IN ('CONV')
    THEN
      dbg('Getting the UDF details for the transaction-->'||rec_reply_acc.trn_ref_no);
      IF NOT fn_query_cont_udfdetails
                ( NULL
                 ,rec_reply_acc.trn_ref_no
                 ,NULL
                 ,l_udf_rec
                 ,l_udf_det
                 ,p_err_code
                 ,p_err_param
                )
      THEN
        dbg('Error during querying the UDF details for the contract-->'||rec_reply_acc.trn_ref_no);
        RETURN FALSE;
      END IF;
    END IF;
    IF l_udf_det.COUNT > 0
    THEN
        dbg('No of UDFs-->'||l_udf_det.COUNT);
      tbl_consol_entries(idx).udf_det := l_udf_det;
    END IF;

    idx := idx + 1;
  END LOOP;
  CLOSE cur_accmov;

  IF l_flag = 'N' AND l_tot_util != 0 AND l_day.loopday <= global.application_date -- PA876CLPBFBIMPSUPP-100 Changes -- 19Jan2016
  THEN
    dbg('No Entries for the date-->'||l_day.loopday);
    tbl_consol_entries(idx).rec_reply_acc.accbrn        := p_acc_dtl.g_accbrn;
    tbl_consol_entries(idx).rec_reply_acc.accno         := p_acc_dtl.g_accno;
    tbl_consol_entries(idx).rec_reply_acc.acsrno        := NULL;
    tbl_consol_entries(idx).rec_reply_acc.trn_ref_no    := NULL;
    tbl_consol_entries(idx).rec_reply_acc.module        := NULL;
    tbl_consol_entries(idx).rec_reply_acc.product       := NULL;
    tbl_consol_entries(idx).rec_reply_acc.valdate       := l_day.loopday;
    tbl_consol_entries(idx).rec_reply_acc.trndate       := l_day.loopday;
    tbl_consol_entries(idx).rec_reply_acc.amnt          := NULL;
    tbl_consol_entries(idx).rec_reply_acc.trnbrn        := NULL;
    tbl_consol_entries(idx).rec_reply_acc.trncode       := NULL;
    tbl_consol_entries(idx).rec_reply_acc.trndesc       := cspkss_os_param.get_param_val('DESC_PREV_BAL');
    tbl_consol_entries(idx).rec_reply_acc.drcrind       := NULL;
    tbl_consol_entries(idx).rec_reply_acc.event         := NULL;
    tbl_consol_entries(idx).rec_reply_acc.instrument_code   := NULL;
    tbl_consol_entries(idx).rec_reply_acc.tot_util          := l_tot_util;
    tbl_consol_entries(idx).rec_reply_acc.interest_rate     := NULL;
    tbl_consol_entries(idx).rec_reply_acc.interest_amt      := NULL;
    idx := idx + 1;
  END IF;
END LOOP;

dbg('Deriving the MCR Rate for the period.');
IF NVL(l_mcr, 'N') = 'Y'
THEN
  -- PA876CLPBFBIMPSUPP-243 Changes Start Here -- 30Jul2017
    IF pkg_custrec.record_stat = 'O'
  THEN
  -- PA876CLPBFBIMPSUPP-243 Changes End Here -- 30Jul2017
    l_Tb_Acc_Sde_Vals(1).Sde_Id        := 'MCR_RATE1';
    l_Tb_Acc_Sde_Vals(1).From_Dt       := l_from_date;
    l_Tb_Acc_Sde_Vals(1).To_Dt         := l_to_date;

    Icpkss_Calc.g_Ictb_Acc_Pr.Prod := l_prod;
    l_Tb_Acc_Sde_Vals := icpkss_maint_custom.fn_get_mcr_sde_vals
                        ( p_acc_dtl.g_accbrn
                         ,p_acc_dtl.g_accno
                         ,l_Tb_Acc_Sde_Vals(1).Sde_Id
                         ,l_Tb_Acc_Sde_Vals(1).From_Dt
                         ,l_Tb_Acc_Sde_Vals(1).To_Dt
                        );
  -- PA876CLPBFBIMPSUPP-243 Changes Start Here -- 30Jul2017
    ELSE
        l_Tb_Acc_Sde_Vals := fn_get_mcr_accclsd
                  ( p_acc_dtl.g_accbrn
                   ,p_acc_dtl.g_accno
                   ,l_prod
                   ,l_from_date
                   ,l_to_date
                  );
  END IF;
  -- PA876CLPBFBIMPSUPP-243 Changes End Here -- 30Jul2017
END IF;

IF tbl_consol_entries.COUNT > 0
THEN
  dbg('*********************Start of the response details*********************');
  dbg('SlNo~AcEntrySrNo~TrnRefNo~ValDt~TrnDt~DrcrInd~Amnt~TrnCd~Event~TotUtil');
  FOR m IN tbl_consol_entries.FIRST..tbl_consol_entries.LAST
  LOOP
    dbg(m||'~'||tbl_consol_entries(m).rec_reply_acc.acsrno||'~'||tbl_consol_entries(m).rec_reply_acc.trn_ref_no||'~'||
      tbl_consol_entries(m).rec_reply_acc.valdate||'~'||tbl_consol_entries(m).rec_reply_acc.trndate||'~'||tbl_consol_entries(m).rec_reply_acc.drcrind||'~'||
      tbl_consol_entries(m).rec_reply_acc.amnt||'~'||tbl_consol_entries(m).rec_reply_acc.trndesc||'~'||tbl_consol_entries(m).rec_reply_acc.event||'~'||
      tbl_consol_entries(m).rec_reply_acc.tot_util);
  END LOOP;
  dbg('*********************End of the response details*********************');
  -- PA876CLPBFBIMPSUPP-159 changes Starts
  dbms_lob.createtemporary(pkg_key, true);
  dbms_lob.createtemporary(pkg_data, true);
  dbms_lob.createtemporary(pkg_parent, true);
  dbms_lob.createtemporary(pkg_format, true);
  dbg('Before creating ');

  dbms_lob.open(pkg_key, dbms_lob.lob_readwrite);
  dbms_lob.open(pkg_data, dbms_lob.lob_readwrite);
  dbms_lob.open(pkg_parent, dbms_lob.lob_readwrite);
  dbms_lob.open(pkg_format, dbms_lob.lob_readwrite);

  IF NOT fn_reassign_clob
       ( p_key
      ,p_data
      ,p_parent
      ,p_format
      ,p_err_code
      ,p_err_param
       )
  THEN
    dbg('Assigning the clob variable failed-->'||p_err_code||'~~'||p_err_param);
    RETURN FALSE;
  END IF;

  -- PA876CLPBFBIMPSUPP-159 changes Ends

  dbg('**********************Final Entries***********************************');
  FOR m IN tbl_consol_entries.FIRST..tbl_consol_entries.LAST
  LOOP
    -- PA876CLPBFBIMPSUPP-159 changes Starts
      p_key         := EMPTY_CLOB();
      p_data        := EMPTY_CLOB();
      p_parent      := EMPTY_CLOB();
      p_format      := EMPTY_CLOB();
    -- PA876CLPBFBIMPSUPP-159 changes Ends
    l_tax_amt := acpkss_stmt_custom.fn_get_int_accr_amt
                  ( tbl_consol_entries(m).rec_reply_acc.trndate
                   ,p_acc_dtl.g_accno
                   ,p_acc_dtl.g_accbrn
                   );
    BEGIN
    l_int_rate := gwpkss_queryaccliqditiondate.fn_get_intrate_1
                      ( p_acc_dtl.g_accno
                       ,p_acc_dtl.g_accbrn
                       ,pkg_custrec.ccy
                       ,l_prod
                       ,tbl_consol_entries(m).rec_reply_acc.trndate
                       ,l_prod_type
                      );

    IF NVL(l_mcr, 'N') = 'Y'
    THEN
      l_mcr_rate := NULL;
      FOR i IN l_Tb_Acc_Sde_Vals.FIRST..l_Tb_Acc_Sde_Vals.LAST
      LOOP
        dbg('FromDt~ToDt~MCRRate-->'||l_Tb_Acc_Sde_Vals(i).from_dt||'~'||l_Tb_Acc_Sde_Vals(i).to_dt||'~'||l_Tb_Acc_Sde_Vals(i).Sde_Val);
      END LOOP;

      FOR i IN l_Tb_Acc_Sde_Vals.FIRST..l_Tb_Acc_Sde_Vals.LAST
      LOOP
        IF tbl_consol_entries(m).rec_reply_acc.trndate BETWEEN l_Tb_Acc_Sde_Vals(i).from_dt AND l_Tb_Acc_Sde_Vals(i).to_dt
        THEN
          l_mcr_rate := l_Tb_Acc_Sde_Vals(i).sde_val;
          EXIT;
        END IF;
      END LOOP;

      dbg('MCR Rate for TrnDate~UtilAmt-->'||tbl_consol_entries(m).rec_reply_acc.trndate||'~'||tbl_consol_entries(m).rec_reply_acc.tot_util||' is-->'||l_mcr_rate);
      IF l_mcr_rate IS NOT NULL
      THEN
        l_int_rate := ROUND(LEAST(l_int_rate, l_mcr_rate)/360, 4);
      ELSE
        l_int_rate := ROUND(l_int_rate/360, 4);
      END IF;
    ELSE
      l_int_rate := ROUND(l_int_rate/360, 4);
    END IF;

    dbg('Int Rate-->'||l_int_rate);

    EXCEPTION
    WHEN OTHERS
    THEN
      dbg(' error in gettign int rate-->'||SQLERRM);
    END;

    dbg('SlNo~AcEntrySrNo~TrnRefNo~ValDt~TrnDt~DrcrInd~Amnt~TrnCd~Event~TotUtil~IntAccrAmt~IntRate');
    dbg(m||'~'||tbl_consol_entries(m).rec_reply_acc.acsrno||'~'||tbl_consol_entries(m).rec_reply_acc.trn_ref_no||'~'||
      tbl_consol_entries(m).rec_reply_acc.valdate||'~'||tbl_consol_entries(m).rec_reply_acc.trndate||'~'||tbl_consol_entries(m).rec_reply_acc.drcrind||'~'||
      tbl_consol_entries(m).rec_reply_acc.amnt||'~'||tbl_consol_entries(m).rec_reply_acc.trndesc||'~'||tbl_consol_entries(m).rec_reply_acc.event||'~'||
      tbl_consol_entries(m).rec_reply_acc.tot_util||'~'||l_tax_amt||'~'||l_int_rate);

    l_counter := l_counter + 1;
    -- 3-18011148071 Changes Start Here -- 02Aug2018
    /*
    p_data    := p_data || tbl_consol_entries(m).rec_reply_acc.accbrn
              || '~' || tbl_consol_entries(m).rec_reply_acc.accno
              || '~' || tbl_consol_entries(m).rec_reply_acc.trn_ref_no
              || '~' || tbl_consol_entries(m).rec_reply_acc.module
              || '~' || tbl_consol_entries(m).rec_reply_acc.product
              || '~' || to_char(tbl_consol_entries(m).rec_reply_acc.valdate, 'RRRR-MM-DD')
              || '~' || to_char(tbl_consol_entries(m).rec_reply_acc.trndate, 'RRRR-MM-DD')
              || '~' || tbl_consol_entries(m).rec_reply_acc.amnt
              || '~' || tbl_consol_entries(m).rec_reply_acc.trnbrn
              || '~' || tbl_consol_entries(m).rec_reply_acc.trncode
              || '~' || tbl_consol_entries(m).rec_reply_acc.trndesc
              || '~' || CASE tbl_consol_entries(m).rec_reply_acc.drcrind WHEN 'D' THEN 'C' WHEN 'C' THEN 'D' END
              || '~' || tbl_consol_entries(m).rec_reply_acc.instrument_code
              || '~' || tbl_consol_entries(m).rec_reply_acc.tot_util
              || '~' || l_tax_amt
              || '~' || TO_CHAR(l_int_rate, 'FM99999999990.9000')||'~>';
    */
    l_data_temp := NULL;
    l_data_temp := tbl_consol_entries(m).rec_reply_acc.accbrn
              || '~' || tbl_consol_entries(m).rec_reply_acc.accno
              || '~' || tbl_consol_entries(m).rec_reply_acc.trn_ref_no
              || '~' || tbl_consol_entries(m).rec_reply_acc.module
              || '~' || tbl_consol_entries(m).rec_reply_acc.product
              || '~' || to_char(tbl_consol_entries(m).rec_reply_acc.valdate, 'RRRR-MM-DD')
              || '~' || to_char(tbl_consol_entries(m).rec_reply_acc.trndate, 'RRRR-MM-DD')
              || '~' || tbl_consol_entries(m).rec_reply_acc.amnt
              || '~' || tbl_consol_entries(m).rec_reply_acc.trnbrn
              || '~' || tbl_consol_entries(m).rec_reply_acc.trncode
              || '~' || tbl_consol_entries(m).rec_reply_acc.trndesc
              || '~' || CASE tbl_consol_entries(m).rec_reply_acc.drcrind WHEN 'D' THEN 'C' WHEN 'C' THEN 'D' END
              || '~' || tbl_consol_entries(m).rec_reply_acc.instrument_code
              || '~' || tbl_consol_entries(m).rec_reply_acc.tot_util
              || '~' || l_tax_amt
              || '~' || TO_CHAR(l_int_rate, 'FM99999999990.9000')||'~>';

    dbms_lob.createtemporary(p_data, TRUE);
    dbms_lob.append(p_data,to_clob(l_data_temp));
    l_data_temp := NULL;
    -- 3-18011148071 Changes End Here -- 02Aug2018

    p_key     := p_key || p_tslist || '>';
    p_parent  := p_parent || 'CA-Acc-Move-Dtls>';
    p_format  := p_format || g_cnt_lvl || '.' || l_counter || '>';

    IF tbl_consol_entries(m).udf_det.COUNT > 0
    THEN
      g_cnt_lvl3 := 0;
      FOR udfval IN tbl_consol_entries(m).udf_det.FIRST..tbl_consol_entries(m).udf_det.LAST
      LOOP
        -- g_cnt_lvl3 := g_cnt_lvl3 + 1;
        -- PA876CLPBFBIMPSUPP-156 Changes Start Here -- 11Apr2016
        IF tbl_consol_entries(m).udf_det(udfval).Field_Val IS NOT NULL
        THEN
            p_parent   := p_parent || 'Cotms-UDF-Details' || '>';
            g_cnt_lvl3 := g_cnt_lvl3 + 1;
        -- PA876CLPBFBIMPSUPP-156 Changes End Here -- 11Apr2016
          p_format   := p_format || g_cnt_lvl || '.' || l_counter || '.' ||g_cnt_lvl3 || '>';
          p_key      := p_key || 'FIELDNAME' || '~' || 'FIELDVAL' ||'~' || '>';
          p_data     := p_data || tbl_consol_entries(m).udf_det(udfval).Field_Name || '~' || tbl_consol_entries(m).udf_det(udfval).Field_Val || '~'||'>';
        END IF;-- PA876CLPBFBIMPSUPP-156 Changes -- 11Apr2016
      END LOOP;
    END IF;
-- PA876CLPBFBIMPSUPP-159 changes Starts
    IF NOT fn_reassign_clob
         ( p_key
        ,p_data
        ,p_parent
        ,p_format
        ,p_err_code
        ,p_err_param
         )
    THEN
      dbg('Assigning the clob variable failed-->'||p_err_code||'~~'||p_err_param);
      RETURN FALSE;
    END IF;
-- PA876CLPBFBIMPSUPP-159 changes Ends
  END LOOP;
ELSE
  dbg('No Accounting entries');
  ovpkss.pr_appendtbl('GW-QAT-016', null);
END IF;
-- PA876CLPBFBIMPSUPP-159 changes Starts
  p_key    := pkg_key;
  p_data   := pkg_data;
  p_parent := pkg_parent;
  p_format := pkg_format;

  dbg('Length of p_key-->'||LENGTH(p_key));
  dbg('Length of p_data-->'||LENGTH(p_data));
  dbg('Length of p_parent-->'||LENGTH(p_parent));
  dbg('Length of p_format-->'||LENGTH(p_format));
  dbms_lob.close(pkg_key);
  dbms_lob.close(pkg_data);
  dbms_lob.close(pkg_parent);
  dbms_lob.close(pkg_format);

-- PA876CLPBFBIMPSUPP-159 changes Ends
--dbg('p_data-->'||p_data);   -- PA876CLPBFBIMPSUPP-159 changes
--dbg('p_key-->'||p_key);   -- PA876CLPBFBIMPSUPP-159 changes
--dbg('p_parent-->'||p_parent); -- PA876CLPBFBIMPSUPP-159 changes
--dbg('p_format-->'||p_format); -- PA876CLPBFBIMPSUPP-159 changes

dbg('Returning true from function fn_reply_locdtl');
RETURN TRUE;

EXCEPTION
WHEN OTHERS
THEN
    dbg('Oracle Error in the function fn_reply_locdtl-->'||SQLERRM);
  p_err_code  := 'AC-UNC05';
  p_err_param := SQLERRM;
    RETURN FALSE;
END fn_reply_locdtl;

FUNCTION fn_reply_acdtl
    ( p_acc_dtl        IN OUT         g_rec_acc_dtl,
          p_resp_node_name IN             VARCHAR2,
          p_data           IN OUT NOCOPY    CLOB,   -- PA876CLPBFBIMPSUPP-159 changes
          p_key            IN OUT NOCOPY    CLOB,   -- PA876CLPBFBIMPSUPP-159 changes
          p_parent         IN OUT NOCOPY    CLOB,       -- PA876CLPBFBIMPSUPP-159 changes
          p_format         IN OUT NOCOPY    CLOB,       -- PA876CLPBFBIMPSUPP-159 changes
          p_err_code       IN OUT         VARCHAR2,
          p_err_param      IN OUT         VARCHAR2
        )
RETURN BOOLEAN
IS

p_tslist     VARCHAR2(1000);

TYPE ty_rec_reply_acc IS RECORD
(
  accbrn          acvws_all_ac_entries.ac_branch%TYPE,
  accno           acvws_all_ac_entries.ac_no%TYPE,
  acsrno          acvws_all_ac_entries.ac_entry_sr_no%TYPE,
  trn_ref_no      acvws_all_ac_entries.trn_ref_no%TYPE,
  module          acvws_All_Ac_Entries.MODULE%TYPE,
  product         actbs_daily_log.product%TYPE,
  valdate         acvws_all_ac_entries.value_dt%TYPE,
  trndate         acvws_all_ac_entries.trn_dt%TYPE,
  amnt            acvws_all_ac_entries.lcy_amount%TYPE,
  trnbrn          acvws_all_ac_entries.ac_branch%TYPE,
  trncode         acvws_all_ac_entries.trn_code%TYPE,
  trndesc         detbs_rtl_teller.narrative%TYPE,
  drcrind         acvws_all_ac_entries.drcr_ind%TYPE,
  event         acvws_all_ac_entries.event%TYPE,
  instrument_code   acvws_all_ac_entries.instrument_code%TYPE,
  amount_tag        acvws_all_ac_entries.amount_tag%TYPE--PA876CLPBFBIMPSUPP-76 Changes
);
TYPE ty_tb_reply_acc IS TABLE OF ty_rec_reply_acc INDEX BY PLS_INTEGER;
l_ty_tb_reply_acc ty_tb_reply_acc;
l_indx                NUMBER;

l_dynamic_sql_stmt    VARCHAR2(32767);

l_noofrecs          cstbs_param.param_val%TYPE;
l_count           NUMBER := 0;
l_loc_acct        CHAR(1) := 'N';
l_udf_rec       cstms_contract_userdef_fields%ROWTYPE;
l_udf_det       uvpkss_udf_upload.Ty_Upl_Cont_Udf;
--<<3-16396619361 Changes>> start
l_cur           sys_refcursor; -- saikat
b_have_recs     boolean :=false;
l_limit         number;
l_rec_clubbed   number := 0;
--<<3-16396619361 Changes>> end
-- PA876CLPBFBIMPSUPP-100 Changes Start Here -- 19Jan2016
TYPE typ_rec_consol IS RECORD
     ( rec_reply_acc      ty_rec_reply_acc,
     tbl_udf_det        uvpkss_udf_upload.Ty_Upl_Cont_Udf
   );
TYPE typ_tbl_consol IS TABLE OF typ_rec_consol INDEX BY PLS_INTEGER;
tbl_consol          typ_tbl_consol;
l_indx_consl        NUMBER := 0;

l_conol_dep                  BOOLEAN := FALSE;
l_con_dep                    NUMBER(22, 3);
l_con_chg                    NUMBER(22, 3);
l_con_chg_f                  BOOLEAN := FALSE;
l_bulk_dep                   VARCHAR2(1) := 'N';
l_bulk_chg                   VARCHAR2(1) := 'N';
l_lcy                        sttms_branch.branch_lcy%TYPE;
l_entamt                     NUMBER(22, 3);
l_instrument_code_2          VARCHAR2(16);
l_adj_ent                    mstbs_acc_stmt_detail_fal%ROWTYPE;
l_instr_no                   actbs_daily_log.instrument_code%TYPE;
l_counter          NUMBER := 0; -- PA876CLPBFBIMPSUPP-251 Changes -- 20Sep2016

-- 3-18011148071 Changes Start Here -- 02Aug2018
l_data_temp          VARCHAR2(32767);
l_cursor                     SYS_REFCURSOR;
l_case                       CHAR(1);
l_mig_txns           BOOLEAN := TRUE;
l_min_conv_date        cstbs_param.param_name%TYPE;
l_max_conv_date        cstbs_param.param_val%TYPE;
-- 3-18011148071 Changes End Here -- 02Aug2018

FUNCTION fn_get_bulkdep
         ( l_acentry           IN            ty_rec_reply_acc
          ,l_lcy               IN            VARCHAR2
          ,l_con_chg_f         OUT           BOOLEAN
          ,l_conol_dep         OUT           BOOLEAN
          ,l_bulk_chg          OUT           VARCHAR2
          ,l_bulk_dep          OUT           VARCHAR2
          ,l_entamt            IN OUT        NUMBER
          ,l_con_dep           OUT           NUMBER
          ,l_con_chg           OUT           NUMBER
          ,l_instrument_code_2 OUT           VARCHAR2
          ,l_adj_ent           OUT           mstbs_acc_stmt_detail_fal%ROWTYPE
          )
RETURN BOOLEAN
IS

l_rev_count      NUMBER := 0;
l_inst_no_2      cstbs_clearing_bulkdet.instrument_no_2%TYPE;
l_adj_amt        cstbs_clearing_master_c.adj_amt%TYPE;
l_drcr_ind       actbs_daily_log.drcr_ind%TYPE;
m                NUMBER;

BEGIN

dbg('Inside function fn_get_bulkdep for trn_ref_no-->'||l_acentry.trn_ref_no);
dbg('Ac Entry Sr No-->'||l_acentry.acsrno);
l_adj_ent := NULL;
l_adj_amt := 0;

IF l_acentry.module = 'CG'
THEN
    l_con_chg_f := FALSE;
    l_conol_dep := FALSE;
    l_bulk_chg  := 'N';
    l_bulk_dep  := 'N';

    IF l_acentry.drcrind = 'C'
    THEN
        BEGIN
          dbg('Deposit inserting for trn_ref_no-->' || l_acentry.trn_ref_no);
          dbg('Inserting for ac_brn-->' || l_acentry.accbrn);
          dbg('Inserting for ac_no-->' || l_acentry.accno);
          dbg('Inserting for instrument_code-->' || l_acentry.instrument_code);

          SELECT instrument_amt, NVL(BULK, 'N'), NVL(adj_amt, 0)
            INTO l_con_dep, l_bulk_dep, l_adj_amt
            FROM csvws_clearing_master_c
           WHERE reference_no = l_acentry.trn_ref_no
             AND NVL(BULK, 'N') = 'Y'
             AND direction = 'O'
             AND acc_branch = l_acentry.accbrn;

          dbg('Rao, After Select Statement-->'||l_bulk_dep);

      IF l_bulk_dep = 'Y'
      THEN
        BEGIN
          INSERT INTO mstb_acc_stmt_blkchqdp
               (trn_ref_no, ac_no, ac_brn, instrument_code, drcr_ind, event)
             VALUES
               (l_acentry.trn_ref_no,
                l_acentry.accno,
                l_acentry.accbrn,
                l_acentry.instrument_code,
                l_acentry.drcrind,
                l_acentry.event
                );

          l_entamt  := l_con_dep + l_adj_amt;
          l_con_dep := l_con_dep + l_adj_amt;
          dbg('Rao, l_con_dep-->'||l_con_dep);
          IF l_adj_amt <> 0
          THEN
            IF l_adj_amt < 0
            THEN
              l_drcr_ind := 'C';
            ELSE
              l_drcr_ind := 'D';
            END IF;

            dbg('Rao, l_drcr_ind-->'||l_drcr_ind);

            IF l_acentry.event = 'REVR'
            THEN
              l_adj_amt  := -1 * ABS(l_adj_amt);
            ELSE
              l_adj_amt  := ABS(l_adj_amt);
            END IF;

            SELECT trn_code, event, amount_tag
              INTO l_adj_ent.trn_code, l_adj_ent.event, l_adj_ent.amount_tag
              FROM acvws_all_ac_entries_custom x
             WHERE x.trn_ref_no = l_acentry.trn_ref_no
               AND x.trn_dt = l_acentry.trndate
               AND x.ac_branch = l_acentry.accbrn
               AND x.ac_no = l_acentry.accno
               AND x.drcr_ind = l_drcr_ind
               AND x.lcy_amount = l_adj_amt
               AND x.related_reference IS NULL;

            l_adj_ent.cust_ac_no := l_acentry.accno;
            l_adj_ent.acc_brn := l_acentry.accbrn;
            l_adj_ent.trn_date := l_acentry.trndate;
            l_adj_ent.instrument_code := l_acentry.instrument_code;
            l_adj_ent.drcr_ind := l_drcr_ind;
            l_adj_ent.trn_amnt := l_adj_amt;
            l_adj_ent.org_trn_ref_no := l_acentry.trn_ref_no;
            l_adj_ent.module := 'CG';
          END IF;

          IF l_acentry.event = 'REVR'
          THEN
              l_entamt  := -1 * l_entamt;
              l_con_dep := -1 * l_con_dep;
          END IF;
          l_conol_dep := FALSE;
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN
          dbg('Dup Val on Index while inserting into mstb_acc_stmt_blkchqdp');
          l_rec_clubbed := l_rec_clubbed + 1; --<<3-16396619361 Changes>>
          l_bulk_dep  := 'Y';
          l_conol_dep := TRUE;
        END;
      END IF;
      dbg('L_CONOL_DEP FOR l_bulk_dep settign false');

        EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            dbg('nO DATA FOUND NOT BULK DEP' || l_acentry.TRN_REF_NO);
            l_bulk_dep  := 'N';
            l_con_dep   := 0;
            l_conol_dep := FALSE;
            dbg('L_CONOL_DEP FOR l_bulk_dep settign false');
        WHEN DUP_VAL_ON_INDEX
        THEN
            dbg('dUP INSERTING FOR trn_ref_no' || l_acentry.TRN_REF_NO);
            dbg('dUP INSERTING FOR ac_brn' || l_acentry.accbrn);
            dbg('dUP INSERTING FOR AC_NO' || l_acentry.accno);
            dbg('dUP INSERTING FOR instrument_code' ||l_acentry.instrument_code);
            l_bulk_dep  := 'Y';
            l_conol_dep := TRUE;
        WHEN OTHERS
        THEN
            dbg('dUP INSERTING FOR instrument_code' || SQLERRM);
            dbg('L_CONOL_DEP FOR l_bulk_dep settign true');
            l_bulk_dep  := 'Y';
            l_conol_dep := TRUE;
            RETURN FALSE;
        END;
    ELSIF l_acentry.drcrind = 'D'
    THEN
        BEGIN
      SELECT 1
        INTO l_rev_count
        FROM csvws_clearing_master_c
       WHERE reference_no = l_acentry.trn_ref_no
         AND NVL(BULK, 'N') = 'Y'
         AND direction = 'O'
         AND acc_branch = l_acentry.accbrn;

      l_bulk_dep  := 'Y';
      -- l_conol_dep := TRUE;
      l_conol_dep := FALSE;
      l_con_dep := l_entamt;
      dbg('l_CON_CHG_F FOR l_bulk_dep settign false');
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            dbg('nO DATA FOUND NOT BULK DEP' || l_acentry.TRN_REF_NO);
            l_bulk_chg  := 'N';
            l_con_chg   := 0;
            l_con_chg_f := FALSE;
            dbg('L_CONOL_DEP FOR l_bulk_dep settign false');
        WHEN DUP_VAL_ON_INDEX
        THEN
            dbg('dUP INSERTING FOR trn_ref_no' || l_acentry.TRN_REF_NO);
            dbg('dUP INSERTING FOR ac_brn' || l_acentry.accbrn);
            dbg('dUP INSERTING FOR AC_NO' || l_acentry.accno);
            dbg('dUP INSERTING FOR instrument_code' ||l_acentry.instrument_code);
            l_bulk_chg  := 'Y';
            l_con_chg_f := TRUE;
        WHEN OTHERS
        THEN
            dbg('dUP INSERTING FOR instrument_code' || SQLERRM);
            dbg('L_CONOL_DEP FOR l_bulk_dep settign true');
            l_bulk_chg  := 'Y';
            l_con_chg_f := TRUE;
            RETURN FALSE;
        END;
    END IF;
ELSIF l_acentry.MODULE <> 'CG'
THEN
    dbg('deposit inserting for trn_ref_no-->' || l_acentry.trn_ref_no);
    dbg('inserting for ac_brn-->' || l_acentry.accbrn);
    dbg('inserting for ac_no-->' || l_acentry.accno);
    dbg('inserting for l_entamt-->' || l_entamt);
    l_bulk_dep  := 'N';
    l_bulk_chg  := 'N';
    l_conol_dep := FALSE;
    l_con_chg_f := FALSE;
    dbg('l_conol_dep for l_bulk_dep setting false');
END IF;

dbg('Returning true from fn_get_bulkdep');
RETURN TRUE;

END fn_get_bulkdep;
-- PA876CLPBFBIMPSUPP-100 Changes End Here -- 19Jan2016

-- 3-18011148071 Changes Start Here -- 02Aug2018
PROCEDURE get_cursor( p_case            IN      CHAR
                     ,p_refcur          OUT     SYS_REFCURSOR
                    )
IS

BEGIN

dbg('In get_cursor, case is-->'||p_case);

IF p_case = 1
THEN
    OPEN p_refcur
     FOR SELECT *
      FROM ( SELECT ac_branch, ac_no, ac_entry_sr_no, trn_ref_no, module, SUBSTR(trn_ref_no,4,4) product,
             value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, vw.trn_code, NULL trn_desc, drcr_ind,
             event, instrument_code , amount_tag
          -- <Onsite_Performance_tuning_Changes_16102020> start
          --FROM acvws_all_ac_entries_custom vw
          from (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) vw
          -- <Onsite_Performance_tuning_Changes_16102020> end
         WHERE vw.ac_no = p_acc_dtl.g_accno
           AND vw.ac_branch = p_acc_dtl.g_accbrn
           AND vw.auth_stat = 'A'
           /*
           AND (vw.event = 'CONV'
            OR
             vw.event <> 'CONV')
           */
           AND NVL(vw.dont_showin_stmt, 'N') = 'N'
         UNION ALL
        SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.product_code product,
             value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
             event, instrument_code , amount_tag
          -- <Onsite_Performance_tuning_Changes_16102020> start
          --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c b
          FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a, csvws_clearing_master_c b
          -- <Onsite_Performance_tuning_Changes_16102020> end
         WHERE a.trn_ref_no = b.reference_no
           AND b.direction = 'I'
           AND b.org_account = p_acc_dtl.g_accno
           -- AND NVL(ib, 'N') = 'N'
           AND a.ac_no = b.rem_account
           AND a.ac_branch = b.acc_branch
           AND b.org_account IS NOT NULL
           AND b.status = 'REJR'
           AND EXISTS (SELECT 1
                 FROM cstbs_clearing_rejection m
                WHERE m.trn_ref_no = b.reference_no
                  -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
           AND NVL(dont_showin_stmt, 'N') = 'N'
         UNION ALL
        SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.prot_prod product,
             value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
             event, instrument_code , amount_tag
          -- <Onsite_Performance_tuning_Changes_16102020> start
          --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c c, catms_protest_master b
          FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries))  a, csvws_clearing_master_c c, catms_protest_master b
          -- <Onsite_Performance_tuning_Changes_16102020> end
         WHERE a.trn_ref_no = b.prot_trn_ref_no
           AND b.module_reference_no = c.reference_no
           AND c.direction = 'I'
           AND a.ac_no = c.rem_account
           AND a.ac_branch = c.acc_branch
           AND b.rem_account = p_acc_dtl.g_accno
           AND b.rem_acc_branch = p_acc_dtl.g_accbrn
           -- AND NVL(ib, 'N') = 'N'
           AND c.status = 'REJR'
           AND EXISTS (SELECT 1
                 FROM cstbs_clearing_rejection m
                WHERE m.trn_ref_no = c.reference_no
                  -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
           AND NVL(dont_showin_stmt, 'N') = 'N'
         ORDER BY trndate DESC , ac_entry_sr_no DESC
      );
ELSIF p_case = 2
THEN
    OPEN p_refcur
     FOR SELECT *
       FROM ( SELECT ac_branch, ac_no, ac_entry_sr_no, trn_ref_no, module, SUBSTR(trn_ref_no,4,4) product,
               value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, vw.trn_code,
               NULL trn_desc, drcr_ind, event, instrument_code , amount_tag
           -- <Onsite_Performance_tuning_Changes_16102020> Start
           --FROM acvws_all_ac_entries_custom vw
           FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) vw
           -- <Onsite_Performance_tuning_Changes_16102020> End
           WHERE vw.ac_no = p_acc_dtl.g_accno
             AND vw.ac_branch = p_acc_dtl.g_accbrn
             AND vw.auth_stat = 'A'
             AND (vw.event = 'CONV' AND vw.txn_init_date BETWEEN p_acc_dtl.g_frmdt AND NVL(p_acc_dtl.g_todate, global.application_date)
              OR
              vw.event <> 'CONV' AND vw.trn_dt BETWEEN p_acc_dtl.g_frmdt AND NVL(p_acc_dtl.g_todate, global.application_date))
             AND NVL(vw.dont_showin_stmt, 'N') = 'N'
           UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.product_code product,
               value_dt, trn_dt trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
               event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> start
            --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c b
            FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
                 csvws_clearing_master_c b
            -- <Onsite_Performance_tuning_Changes_16102020> End
           WHERE a.trn_ref_no = b.reference_no
             AND a.trn_dt BETWEEN p_acc_dtl.g_frmdt AND NVL(p_acc_dtl.g_todate, global.application_date)
             AND b.direction = 'I'
             AND b.org_account = p_acc_dtl.g_accno
             -- AND NVL(ib, 'N') = 'N'
             AND a.ac_no = b.rem_account
             AND a.ac_branch = b.acc_branch
             AND b.org_account IS NOT NULL
             AND b.status = 'REJR'
             AND EXISTS (SELECT 1
                   FROM cstbs_clearing_rejection m
                  WHERE m.trn_ref_no = b.reference_no
                    -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
             AND NVL(dont_showin_stmt, 'N') = 'N'
           UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.prot_prod product,
               value_dt, trn_dt trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
               event, instrument_code , amount_tag
           -- <Onsite_Performance_tuning_Changes_16102020> Start
           --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c c, catms_protest_master b
           FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
                csvws_clearing_master_c c, catms_protest_master b
           -- <Onsite_Performance_tuning_Changes_16102020> End
           WHERE a.trn_ref_no = b.prot_trn_ref_no
             AND b.module_reference_no = c.reference_no
             AND c.direction = 'I'
             AND a.trn_dt BETWEEN p_acc_dtl.g_frmdt AND NVL(p_acc_dtl.g_todate, global.application_date)
             AND a.ac_no = c.rem_account
             AND a.ac_branch = c.acc_branch
             AND b.rem_account = p_acc_dtl.g_accno
             AND b.rem_acc_branch = p_acc_dtl.g_accbrn
             -- AND NVL(ib, 'N') = 'N'
             AND c.status = 'REJR'
             AND EXISTS (SELECT 1
                   FROM cstbs_clearing_rejection m
                  WHERE m.trn_ref_no = c.reference_no
                    -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
             AND NVL(dont_showin_stmt, 'N') = 'N'
           ORDER BY trndate, ac_entry_sr_no
        );
ELSIF p_case = 3
THEN
    OPEN p_refcur
     FOR SELECT *
       FROM ( SELECT ac_branch, ac_no, ac_entry_sr_no, trn_ref_no, module, SUBSTR(trn_ref_no,4,4) product,
               value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, vw.trn_code,
               NULL trn_desc, drcr_ind, event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> Start
            -- FROM acvws_all_ac_entries_custom vw
            FROM  (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) vw
            -- <Onsite_Performance_tuning_Changes_16102020> end
           WHERE vw.ac_no = p_acc_dtl.g_accno
             AND vw.ac_branch = p_acc_dtl.g_accbrn
             AND vw.auth_stat = 'A'
             AND ((vw.event = 'CONV' AND vw.txn_init_date >= p_acc_dtl.g_frmdt)
               OR
              (vw.event <> 'CONV' AND vw.trn_dt >= p_acc_dtl.g_frmdt))
             AND NVL(vw.dont_showin_stmt, 'N') = 'N'
           UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.product_code product,
               value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
               event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> start
            --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c b
            FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
             csvws_clearing_master_c b
            -- <Onsite_Performance_tuning_Changes_16102020> End
           WHERE a.trn_ref_no = b.reference_no
             AND b.direction = 'I'
             AND a.trn_dt >= p_acc_dtl.g_frmdt
             AND b.org_account = p_acc_dtl.g_accno
             -- AND NVL(ib, 'N') = 'N'
             AND a.ac_no = b.rem_account
             AND a.ac_branch = b.acc_branch
             AND b.org_account IS NOT NULL
             AND b.status = 'REJR'
             AND EXISTS (SELECT 1
                   FROM cstbs_clearing_rejection m
                  WHERE m.trn_ref_no = b.reference_no
                    -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
             AND NVL(dont_showin_stmt, 'N') = 'N'
           UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.prot_prod product,
               value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
               event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> start
            --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c c, catms_protest_master b
            FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
                 csvws_clearing_master_c c, catms_protest_master b
            -- <Onsite_Performance_tuning_Changes_16102020> end
           WHERE a.trn_ref_no = b.prot_trn_ref_no
             AND b.module_reference_no = c.reference_no
             AND c.direction = 'I'
             AND a.trn_dt >= p_acc_dtl.g_frmdt
             AND a.ac_no = c.rem_account
             AND a.ac_branch = c.acc_branch
             AND b.rem_account = p_acc_dtl.g_accno
             AND b.rem_acc_branch = p_acc_dtl.g_accbrn
             -- AND NVL(ib, 'N') = 'N'
             AND c.status = 'REJR'
             AND EXISTS (SELECT 1
                   FROM cstbs_clearing_rejection m
                  WHERE m.trn_ref_no = c.reference_no
                    -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
             AND NVL(dont_showin_stmt, 'N') = 'N'
           ORDER BY trndate, ac_entry_sr_no
          );
ELSIF p_case = 4
THEN
    OPEN p_refcur
     FOR SELECT *
         FROM ( SELECT ac_branch, ac_no, ac_entry_sr_no, trn_ref_no, module, SUBSTR(trn_ref_no,4,4) product,
                 value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, substr(trn_ref_no,1,3) trn_brn, vw.trn_code,
                 NULL trn_desc, drcr_ind, event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> Start
            --FROM actbs_daily_log vw
              FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) vw
            -- <Onsite_Performance_tuning_Changes_16102020> End
           WHERE vw.ac_no = p_acc_dtl.g_accno
               AND vw.ac_branch = p_acc_dtl.g_accbrn
               AND vw.auth_stat = 'A'
           --AND NVL(vw.delete_stat,'X') <> 'D'  -- <Onsite_Performance_tuning_Changes_16102020>
           AND ((vw.event = 'CONV' AND vw.txn_init_date >= global.application_date)
                OR
              (vw.event <> 'CONV' AND vw.trn_dt >= global.application_date))
               AND NVL(vw.dont_showin_stmt, 'N') = 'N'
             UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.product_code product,
                 value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code,
             NULL trn_desc, drcr_ind, event, instrument_code , amount_tag
              -- <Onsite_Performance_tuning_Changes_16102020> Start
              --FROM actbs_daily_log a, csvws_clearing_master_c b
              FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
               csvws_clearing_master_c b
              -- <Onsite_Performance_tuning_Changes_16102020> End
             WHERE a.trn_ref_no = b.reference_no
           AND b.direction = 'I'
               AND b.org_account = p_acc_dtl.g_accno
               -- AND NVL(ib, 'N') = 'N'
               AND a.ac_no = b.rem_account
               AND a.ac_branch = b.acc_branch
               AND b.org_account IS NOT NULL
               AND b.status = 'REJR'
               AND EXISTS (SELECT 1
                     FROM cstbs_clearing_rejection m
                    WHERE m.trn_ref_no = b.reference_no
                      -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                  )
               AND a.trn_dt >= global.application_date
              -- AND NVL(a.delete_stat,'X') <> 'D'  -- <Onsite_Performance_tuning_Changes_16102020>
               AND a.auth_stat = 'A'
               AND NVL(dont_showin_stmt, 'N') = 'N'
             UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.prot_prod product,
             value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code,
             NULL trn_desc, drcr_ind, event, instrument_code , amount_tag
              -- <Onsite_Performance_tuning_Changes_16102020> Start
              -- FROM actbs_daily_log a, csvws_clearing_master_c c, catms_protest_master b
              FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
                   csvws_clearing_master_c c, catms_protest_master b
              -- <Onsite_Performance_tuning_Changes_16102020> end
             WHERE a.trn_ref_no = b.prot_trn_ref_no
               AND b.module_reference_no = c.reference_no
               AND c.direction = 'I'
               AND a.ac_no = c.rem_account
               AND a.ac_branch = c.acc_branch
               AND b.rem_account = p_acc_dtl.g_accno
               AND b.rem_acc_branch = p_acc_dtl.g_accbrn
               -- AND NVL(ib, 'N') = 'N'
               AND c.status = 'REJR'
               AND EXISTS (SELECT 1
                     FROM cstbs_clearing_rejection m
                    WHERE m.trn_ref_no = c.reference_no
                      -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                  )
               AND a.trn_dt >= global.application_date
              -- AND NVL(a.delete_stat,'X') <> 'D'  -- <Onsite_Performance_tuning_Changes_16102020>
               AND a.auth_stat = 'A'
               AND NVL(dont_showin_stmt, 'N') = 'N'
             ORDER BY trndate, ac_entry_sr_no
            );
ELSIF p_case = 5
THEN
    OPEN p_refcur
     FOR SELECT *
       FROM ( SELECT ac_branch, ac_no, ac_entry_sr_no, trn_ref_no, module, SUBSTR(trn_ref_no,4,4) product,
               value_dt, trn_dt trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, vw.trn_code,
               NULL trn_desc, drcr_ind, event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> Start
            --FROM acvws_all_ac_entries_custom vw
            FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) vw
            -- <Onsite_Performance_tuning_Changes_16102020> End
           WHERE vw.ac_no = p_acc_dtl.g_accno
             AND vw.ac_branch = p_acc_dtl.g_accbrn
             AND vw.auth_stat = 'A'
             AND (vw.trn_dt BETWEEN p_acc_dtl.g_frmdt AND NVL(p_acc_dtl.g_todate, global.application_date))
             AND NVL(vw.dont_showin_stmt, 'N') = 'N'
           UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.product_code product,
               value_dt, trn_dt trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
               event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> Start
            --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c b
            FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
            csvws_clearing_master_c b
            -- <Onsite_Performance_tuning_Changes_16102020> End
           WHERE a.trn_ref_no = b.reference_no
             AND a.trn_dt BETWEEN p_acc_dtl.g_frmdt AND NVL(p_acc_dtl.g_todate, global.application_date)
             AND b.direction = 'I'
             AND b.org_account = p_acc_dtl.g_accno
             -- AND NVL(ib, 'N') = 'N'
             AND a.ac_no = b.rem_account
             AND a.ac_branch = b.acc_branch
             AND b.org_account IS NOT NULL
             AND b.status = 'REJR'
             AND EXISTS (SELECT 1
                   FROM cstbs_clearing_rejection m
                  WHERE m.trn_ref_no = b.reference_no
                    -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
             AND NVL(dont_showin_stmt, 'N') = 'N'
           UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.prot_prod product,
               value_dt, trn_dt trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
               event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> Start
            --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c c, catms_protest_master b
            FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
            csvws_clearing_master_c c, catms_protest_master b
            -- <Onsite_Performance_tuning_Changes_16102020> end
           WHERE a.trn_ref_no = b.prot_trn_ref_no
             AND b.module_reference_no = c.reference_no
             AND c.direction = 'I'
             AND a.trn_dt BETWEEN p_acc_dtl.g_frmdt AND NVL(p_acc_dtl.g_todate, global.application_date)
             AND a.ac_no = c.rem_account
             AND a.ac_branch = c.acc_branch
             AND b.rem_account = p_acc_dtl.g_accno
             AND b.rem_acc_branch = p_acc_dtl.g_accbrn
             -- AND NVL(ib, 'N') = 'N'
             AND c.status = 'REJR'
             AND EXISTS (SELECT 1
                   FROM cstbs_clearing_rejection m
                  WHERE m.trn_ref_no = c.reference_no
                    -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
             AND NVL(dont_showin_stmt, 'N') = 'N'
           ORDER BY trndate, ac_entry_sr_no
        );
ELSIF p_case = 6
THEN
    OPEN p_refcur
     FOR SELECT *
       FROM ( SELECT ac_branch, ac_no, ac_entry_sr_no, trn_ref_no, module, SUBSTR(trn_ref_no,4,4) product,
               value_dt, trn_dt trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, vw.trn_code,
               NULL trn_desc, drcr_ind, event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> Start
            --FROM acvws_all_ac_entries_custom vw
            FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) vw
            -- <Onsite_Performance_tuning_Changes_16102020> End
           WHERE vw.ac_no = p_acc_dtl.g_accno
             AND vw.ac_branch = p_acc_dtl.g_accbrn
             AND vw.auth_stat = 'A'
             AND (vw.trn_dt >= p_acc_dtl.g_frmdt)
             AND NVL(vw.dont_showin_stmt, 'N') = 'N'
           UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.product_code product,
               value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
               event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> Start
            --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c b
            FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
             csvws_clearing_master_c b
            -- <Onsite_Performance_tuning_Changes_16102020>
           WHERE a.trn_ref_no = b.reference_no
             AND b.direction = 'I'
             AND a.trn_dt >= p_acc_dtl.g_frmdt
             AND b.org_account = p_acc_dtl.g_accno
             -- AND NVL(ib, 'N') = 'N'
             AND a.ac_no = b.rem_account
             AND a.ac_branch = b.acc_branch
             AND b.org_account IS NOT NULL
             AND b.status = 'REJR'
             AND EXISTS (SELECT 1
                   FROM cstbs_clearing_rejection m
                  WHERE m.trn_ref_no = b.reference_no
                    -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
             AND NVL(dont_showin_stmt, 'N') = 'N'
           UNION ALL
          SELECT p_acc_dtl.g_accbrn, p_acc_dtl.g_accno, ac_entry_sr_no, trn_ref_no, module, b.prot_prod product,
               value_dt, DECODE(event, 'CONV', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, a.trn_code, NULL trn_desc, drcr_ind,
               event, instrument_code , amount_tag
            -- <Onsite_Performance_tuning_Changes_16102020> Start
            --FROM acvws_all_ac_entries_custom a, csvws_clearing_master_c c, catms_protest_master b
            FROM (table(gwpks_ca_queryaccmove.fn_get_accounting_entries)) a,
                  csvws_clearing_master_c c, catms_protest_master b
            -- <Onsite_Performance_tuning_Changes_16102020> End
           WHERE a.trn_ref_no = b.prot_trn_ref_no
             AND b.module_reference_no = c.reference_no
             AND c.direction = 'I'
             AND a.trn_dt >= p_acc_dtl.g_frmdt
             AND a.ac_no = c.rem_account
             AND a.ac_branch = c.acc_branch
             AND b.rem_account = p_acc_dtl.g_accno
             AND b.rem_acc_branch = p_acc_dtl.g_accbrn
             -- AND NVL(ib, 'N') = 'N'
             AND c.status = 'REJR'
             AND EXISTS (SELECT 1
                   FROM cstbs_clearing_rejection m
                  WHERE m.trn_ref_no = c.reference_no
                    -- AND (INSTR(m.err_code, 'CG-REJR-09', 1) > 0 OR INSTR(m.err_code, 'CG-REJR-08', 1) > 0)
                  AND (m.err_code LIKE '%CG-REJR-09%' OR m.err_code LIKE '%CG-REJR-08%')
                )
             AND NVL(dont_showin_stmt, 'N') = 'N'
           ORDER BY trndate, ac_entry_sr_no
          );
END IF;

END get_cursor;
-- 3-18011148071 Changes End Here -- 02Aug2018

BEGIN

dbg('Inside Function fn_reply_acdtl with parameters');
dbg('Account Branch-->'||p_acc_dtl.g_accbrn);
dbg('Account Number-->'||p_acc_dtl.g_accno);
dbg('From Date-->'||p_acc_dtl.g_frmdt);
dbg('To Date-->'||p_acc_dtl.g_todate);
dbg('Number of Records-->'||p_acc_dtl.g_norec);

pkg_custrec := NULL;
IF NOT cvpkss_utils.get_sttm_cust_acc
                ( p_acc_dtl.g_accbrn
         ,p_acc_dtl.g_accno
         ,pkg_custrec
                )
THEN
    dbg('Invalid account. Returning from here.');
  p_err_code  := 'GW-QAT-005;';
  p_err_param := 'Invalid Account Number;';
  RETURN FALSE;
END IF;

IF acpkss_stmt_custom.fn_is_locacctcls(pkg_custrec.account_class)
THEN
    dbg('This account is LOC account.');
    l_loc_acct := 'Y';
END IF;

IF l_loc_acct = 'Y'
THEN
  dbg('New call for the LOC accounts');
    IF NOT fn_reply_locdtl
           ( p_acc_dtl
        ,p_resp_node_name
        ,p_data
        ,p_key
        ,p_parent
        ,p_format
        ,p_err_code
        ,p_err_param)
  THEN
    dbg('Function fn_reply_locdtl returned false');
    RETURN FALSE;
  END IF;
ELSE
    dbg('Existing flow for Non LOC accounts.');
    l_noofrecs := NVL(cspkss_os_param.get_param_val('NOOFRECS'), '50');
    l_lcy := global.lcy; -- PA876CLPBFBIMPSUPP-100 Changes -- 19Jan2016

    -- 3-18011148071 Changes Start Here -- 02Aug2018
  l_min_conv_date := cspkss_os_param.get_param_val('MIN_CONV_DATE');
  l_max_conv_date := cspkss_os_param.get_param_val('MAX_CONV_DATE');

  dbg('MIN CONV DATE~MAX CONV DATE-->'||TO_DATE(l_min_conv_date, 'DD-MM-RRRR')||'~'||TO_DATE(l_max_conv_date, 'DD-MM-RRRR'));
  l_mig_txns    := false; -- <Onsite_Performance_tuning_Changes_16102020>
  IF ((p_acc_dtl.g_frmdt IS NOT NULL AND p_acc_dtl.g_todate IS NOT NULL)
    OR
     (p_acc_dtl.g_frmdt IS NOT NULL AND p_acc_dtl.g_todate IS NULL))
  THEN
    IF p_acc_dtl.g_frmdt BETWEEN TO_DATE(l_min_conv_date, 'DD-MM-RRRR') AND TO_DATE(l_max_conv_date, 'DD-MM-RRRR')
    THEN
      dbg('Query in the migration period.');
      l_mig_txns := TRUE;
    END IF;
  END IF;

  IF p_acc_dtl.g_norec IS NOT NULL
  THEN
    l_case := 1;
  ELSIF (p_acc_dtl.g_frmdt IS NOT NULL AND p_acc_dtl.g_todate IS NOT NULL AND l_mig_txns )
  THEN
    l_case := 2;
  ELSIF (p_acc_dtl.g_frmdt IS NOT NULL AND p_acc_dtl.g_todate IS NULL AND l_mig_txns)
  THEN
    l_case := 3;
  ELSIF p_acc_dtl.g_frmdt IS NULL AND p_acc_dtl.g_todate IS NULL
  THEN
    l_case := 4;
  ELSIF (p_acc_dtl.g_frmdt IS NOT NULL AND p_acc_dtl.g_todate IS NOT NULL AND NOT l_mig_txns )
  THEN
    l_case := 5;
  ELSIF (p_acc_dtl.g_frmdt IS NOT NULL AND p_acc_dtl.g_todate IS NULL AND NOT l_mig_txns)
  THEN
    l_case := 6;
  END IF;

  dbg('Case is-->'||l_case);
  -- <Onsite_Performance_tuning_Changes_16102020> Start
  -- Building Table based on Case number with accouning entries...
    pr_build_accounting_entries(p_acc_dtl.g_accbrn,
                                p_acc_dtl.g_accno,
                                NVL(p_acc_dtl.g_frmdt,global.application_date),
                                NVL(p_acc_dtl.g_todate,global.application_date),
                                p_acc_dtl.g_norec,
                                l_case);
  -- <Onsite_Performance_tuning_Changes_16102020> end
  get_cursor(l_case, l_cursor);
  -- 3-18011148071 Changes End Here -- 02Aug2018

  dbg('DYNAMIC SQL QUERY IS ---->>> ' || l_dynamic_sql_stmt);
  --<<3-16396619361 Changes >> Commented execute immediate and added open cursor below
  --EXECUTE IMMEDIATE l_dynamic_sql_stmt BULK COLLECT INTO l_ty_tb_reply_acc USING IN l_noofrecs;


  -- PA876CLPBFBIMPSUPP-251 Changes Start Here -- 20Sep2016
  p_key     := p_tslist;
  p_parent  := p_resp_node_name;
  p_format  := '1';
  g_cnt_lvl   := g_cnt_lvl + 1;
  l_counter   := l_counter + 1;


  p_tslist    := 'ACCNO~ACCBRN~ALTACCNO~';
  p_data      := p_data || '>' || p_acc_dtl.g_accno ||'~'|| p_acc_dtl.g_accbrn ||'~'|| pkg_custrec.alt_ac_no||'~'|| '>';
  p_key       := p_key || '>' || p_tslist || '>';
  p_parent    := p_parent || '>Cotms-QueryAccMove-Master' || '>';
  p_format    := p_format || '>' || g_cnt_lvl || '.' || l_counter || '>';
  -- PA876CLPBFBIMPSUPP-251 Changes End Here -- 20Sep2016

  --<<3-16396619361 Changes>> start
  l_limit := NVL(p_acc_dtl.g_norec,l_noofrecs);
  -- OPEN l_cur FOR l_dynamic_sql_stmt; -- 3-18011148071 Changes -- 02Aug2018
  LOOP
    IF l_rec_clubbed > 0 THEN
      l_limit := l_rec_clubbed;
      l_rec_clubbed := 0;
    END IF;
    FETCH l_cursor BULK COLLECT INTO l_ty_tb_reply_acc LIMIT l_limit;

    --IF l_ty_tb_reply_acc.COUNT = 0
    IF l_ty_tb_reply_acc.COUNT = 0 and not b_have_recs
    --<<3-16396619361 Changes>> end
    THEN
      dbg('GW-QAT-007 : No Account Movement Has Done For The Account Number');
      p_err_code  := 'GW-QAT-007;';
      p_err_param := 'No Account Movement Has Done For The Account Number;';
      RETURN FALSE;
    END IF;

    dbg('AFTER EXECUTE DYNAMIC SQL QUERY ');
    b_have_recs := true; --<<3-16396619361 Changes>>
    -- PA876CLPBFBIMPSUPP-251 Changes Start Here -- 20Sep2016
    /*
    p_key    := p_tslist || '~>';
    p_parent := p_resp_node_name||'>';
    p_format := '1>';
    p_tslist := 'ACCBRN~ACCNO~FCCREF~MODULE~PRD~VALDATE~TRNDATE~AMNT~TRNBRN~TRNCODE~TRNDESC~DRCRIND~INSTRNO~>';
    p_data   := p_data || '~>';
    */
    -- PA876CLPBFBIMPSUPP-251 Changes End Here -- 20Sep2016

    --dbg('p_data for fn_reply_acdtl -> ' || p_data); -- PA876CLPBFBIMPSUPP-159 changes
    --dbg('p_key for fn_reply_acdtl ->  ' || p_key);  -- PA876CLPBFBIMPSUPP-159 changes
    --dbg('p_parent fn_reply_acdtl -> ' || p_parent); -- PA876CLPBFBIMPSUPP-159 changes
    --dbg('p_format for fn_reply_acdtl -> ' || p_format);-- PA876CLPBFBIMPSUPP-159 changes

    dbg('l_ty_tb_reply_acc ::'||l_ty_tb_reply_acc.count);
    l_indx := l_ty_tb_reply_acc.FIRST;
    WHILE l_indx IS NOT NULL
    LOOP
      dbg('l_indx ::'||l_indx);
      --PA876CLPBFBIMPSUPP-76 Changes Starts
      --l_ty_tb_reply_acc(l_indx).trndesc := fn_get_trndescription( l_ty_tb_reply_acc(l_indx).trn_ref_no, l_ty_tb_reply_acc(l_indx).trncode, l_ty_tb_reply_acc(l_indx).product);
      l_ty_tb_reply_acc(l_indx).trndesc := fn_get_trndescription( l_ty_tb_reply_acc(l_indx).trn_ref_no,
                                    l_ty_tb_reply_acc(l_indx).trncode,
                                    l_ty_tb_reply_acc(l_indx).product,
                                    l_ty_tb_reply_acc(l_indx).module,
                                    l_ty_tb_reply_acc(l_indx).amount_tag
                                  );
      --PA876CLPBFBIMPSUPP-76 Changes Ends

      -- PA876CLPBFBIMPSUPP-192 Changes Start Here -- 09May2016
      IF NVL(l_ty_tb_reply_acc(l_indx).module,'XX') = 'CL' AND l_ty_tb_reply_acc(l_indx).instrument_code IS NOT NULL
      THEN
        l_ty_tb_reply_acc(l_indx).instrument_code := NULL;
        dbg('Assigning instrument code as NULL' || l_ty_tb_reply_acc(l_indx).instrument_code);
      END IF;
      -- PA876CLPBFBIMPSUPP-192 Changes End Here -- 09May2016

      -- PA876CLPBFBIMPSUPP-154 Changes start
      IF l_ty_tb_reply_acc(l_indx).instrument_code IS NOT NULL AND LENGTH(l_ty_tb_reply_acc(l_indx).instrument_code) < 7
      THEN
        l_ty_tb_reply_acc(l_indx).instrument_code := LPAD(l_ty_tb_reply_acc(l_indx).instrument_code, 7, '0');
      END IF;
      -- PA876CLPBFBIMPSUPP-154 Changes end
      l_instr_no := l_ty_tb_reply_acc(l_indx).instrument_code; -- PA876CLPBFBIMPSUPP-100 Changes -- 19Jan2019

      IF l_ty_tb_reply_acc(l_indx).module IN ('RT', 'DD') AND l_ty_tb_reply_acc(l_indx).drcrind = 'D' AND l_ty_tb_reply_acc(l_indx).instrument_code IS NOT NULL
      THEN
        BEGIN
          SELECT 1
          INTO l_count
          FROM detbs_rtl_teller
           WHERE trn_ref_no = l_ty_tb_reply_acc(l_indx).trn_ref_no
           AND dr_instrument_code = l_ty_tb_reply_acc(l_indx).instrument_code
           AND EXISTS (SELECT 1
               FROM catms_check_details
              WHERE account = l_ty_tb_reply_acc(l_indx).accno
              AND branch = l_ty_tb_reply_acc(l_indx).accbrn
              AND check_no = l_ty_tb_reply_acc(l_indx).instrument_code
              AND status = 'U');

        EXCEPTION
        WHEN OTHERS
        THEN
          dbg('Here 1');
          -- l_ty_tb_reply_acc(l_indx).instrument_code := NULL; -- PA876CLPBFBIMPSUPP-100 Changes -- 19Jan2019
          l_instr_no := NULL; -- PA876CLPBFBIMPSUPP-100 Changes -- 19Jan2019
        END;
      ELSIF l_ty_tb_reply_acc(l_indx).module IN ('CG') AND l_ty_tb_reply_acc(l_indx).drcrind = 'D' AND l_ty_tb_reply_acc(l_indx).instrument_code IS NOT NULL
      THEN
        BEGIN
          SELECT 1
          INTO l_count
          FROM csvws_clearing_master_c
           WHERE reference_no = l_ty_tb_reply_acc(l_indx).trn_ref_no
           AND direction = 'I'
           AND (rem_account = l_ty_tb_reply_acc(l_indx).accno AND acc_branch = l_ty_tb_reply_acc(l_indx).accbrn
            OR
            org_account = l_ty_tb_reply_acc(l_indx).accno
            )
           AND instrument_no_1 = l_ty_tb_reply_acc(l_indx).instrument_code
           AND EXISTS (SELECT 1
               FROM catms_check_details
              WHERE account = l_ty_tb_reply_acc(l_indx).accno
              AND branch = l_ty_tb_reply_acc(l_indx).accbrn
              AND check_no = l_ty_tb_reply_acc(l_indx).instrument_code);

        EXCEPTION
        WHEN OTHERS
        THEN
          dbg('Here 2');
          -- l_ty_tb_reply_acc(l_indx).instrument_code := NULL; -- PA876CLPBFBIMPSUPP-100 Changes -- 19Jan2019
          l_instr_no := NULL; -- PA876CLPBFBIMPSUPP-100 Changes -- 19Jan2019
        END;
      ELSIF gwpkss_ca_queryaccmove.tbl_protprod.EXISTS(l_ty_tb_reply_acc(l_indx).product)
      THEN
        dbg('Here 3');
      -- PA876CLPBFBIMPSUPP-154 Changes start
      ELSIF l_ty_tb_reply_acc(l_indx).module IN ('AC') AND l_ty_tb_reply_acc(l_indx).drcrind = 'D'
        AND l_ty_tb_reply_acc(l_indx).instrument_code IS NOT NULL
      THEN
        dbg('This is a migrated debit transaction with an instrument no');
        BEGIN
          SELECT 1
          INTO l_count
          FROM cavws_cheque_status
           WHERE branch = l_ty_tb_reply_acc(l_indx).accbrn
           AND account = l_ty_tb_reply_acc(l_indx).accno
           AND check_no = l_ty_tb_reply_acc(l_indx).instrument_code;
        EXCEPTION
        WHEN OTHERS
        THEN
          dbg('Here 5');
          l_instr_no := NULL;
        END;
      -- PA876CLPBFBIMPSUPP-154 Changes end
      ELSE
        dbg('Here 4');
        -- l_ty_tb_reply_acc(l_indx).instrument_code := NULL; -- PA876CLPBFBIMPSUPP-100 Changes -- 19Jan2019
        l_instr_no := NULL; -- PA876CLPBFBIMPSUPP-100 Changes -- 19Jan2019
      END IF;

      -- PA876CLPBFBIMPSUPP-100 Changes Start Here -- 19Jan2016
      l_entamt := l_ty_tb_reply_acc(l_indx).amnt;

      IF NOT fn_get_bulkdep
         ( l_ty_tb_reply_acc(l_indx)
          ,l_lcy
          ,l_con_chg_f
          ,l_conol_dep
          ,l_bulk_chg
          ,l_bulk_dep
          ,l_entamt
          ,l_con_dep
          ,l_con_chg
          ,l_instrument_code_2
          ,l_adj_ent
          )
      THEN
        dbg('Function fn_get_bulkdep returned false');
        p_err_code  := 'FX-BAT02';
        p_err_param := 'FN_GET_BULKDEP';
        RETURN FALSE;
      END IF;

      IF l_conol_dep = FALSE AND l_con_chg_f = FALSE
      THEN
        IF l_bulk_dep = 'Y'
        THEN
          l_entamt := NVL(l_con_dep, 0);
        ELSIF l_bulk_chg = 'Y'
        THEN
          l_entamt := NVL(l_con_chg, 0);
        END IF;
      -- PA876CLPBFBIMPSUPP-100 Changes End Here -- 19Jan2016

        l_udf_rec := NULL;
        l_udf_det.DELETE;

        IF l_ty_tb_reply_acc(l_indx).module IN ('RT') OR l_ty_tb_reply_acc(l_indx).event IN ('CONV')
        THEN
          dbg('Getting the UDF details for the transaction-->'||l_ty_tb_reply_acc(l_indx).trn_ref_no);
          IF NOT fn_query_cont_udfdetails
              ( NULL
               ,l_ty_tb_reply_acc(l_indx).trn_ref_no
               ,NULL
               ,l_udf_rec
               ,l_udf_det
               ,p_err_code
               ,p_err_param
              )
          THEN
          dbg('Error during querying the UDF details for the contract-->'||l_ty_tb_reply_acc(l_indx).trn_ref_no);
          RETURN FALSE;
          END IF;
        END IF;

        -- PA876CLPBFBIMPSUPP-100 Changes Start Here -- 19Jan2016
        l_indx_consl := l_indx_consl + 1;
        tbl_consol(l_indx_consl).rec_reply_acc.accbrn       := l_ty_tb_reply_acc(l_indx).accbrn;
        tbl_consol(l_indx_consl).rec_reply_acc.accno        := l_ty_tb_reply_acc(l_indx).accno;
        tbl_consol(l_indx_consl).rec_reply_acc.acsrno       := l_ty_tb_reply_acc(l_indx).acsrno;
        tbl_consol(l_indx_consl).rec_reply_acc.trn_ref_no   := l_ty_tb_reply_acc(l_indx).trn_ref_no;
        tbl_consol(l_indx_consl).rec_reply_acc.module       := l_ty_tb_reply_acc(l_indx).module;
        tbl_consol(l_indx_consl).rec_reply_acc.product      := l_ty_tb_reply_acc(l_indx).product;
        tbl_consol(l_indx_consl).rec_reply_acc.valdate      := l_ty_tb_reply_acc(l_indx).valdate;
        tbl_consol(l_indx_consl).rec_reply_acc.trndate      := l_ty_tb_reply_acc(l_indx).trndate;
        tbl_consol(l_indx_consl).rec_reply_acc.amnt         := l_entamt;
        tbl_consol(l_indx_consl).rec_reply_acc.trnbrn       := l_ty_tb_reply_acc(l_indx).trnbrn;
        tbl_consol(l_indx_consl).rec_reply_acc.trncode      := l_ty_tb_reply_acc(l_indx).trncode;
        tbl_consol(l_indx_consl).rec_reply_acc.trndesc      := l_ty_tb_reply_acc(l_indx).trndesc;
        tbl_consol(l_indx_consl).rec_reply_acc.drcrind      := l_ty_tb_reply_acc(l_indx).drcrind;
        tbl_consol(l_indx_consl).rec_reply_acc.event        := l_ty_tb_reply_acc(l_indx).event;
        tbl_consol(l_indx_consl).rec_reply_acc.instrument_code := l_instr_no;
        tbl_consol(l_indx_consl).rec_reply_acc.amount_tag      := l_ty_tb_reply_acc(l_indx).amount_tag;
        tbl_consol(l_indx_consl).tbl_udf_det                   := l_udf_det;

        IF l_adj_ent.org_trn_ref_no IS NOT NULL
        THEN
          l_indx_consl := l_indx_consl + 1;
          tbl_consol(l_indx_consl).rec_reply_acc.accbrn       := l_ty_tb_reply_acc(l_indx).accbrn;
          tbl_consol(l_indx_consl).rec_reply_acc.accno        := l_ty_tb_reply_acc(l_indx).accno;
          tbl_consol(l_indx_consl).rec_reply_acc.acsrno       := l_ty_tb_reply_acc(l_indx).acsrno;
          tbl_consol(l_indx_consl).rec_reply_acc.trn_ref_no   := l_ty_tb_reply_acc(l_indx).trn_ref_no;
          tbl_consol(l_indx_consl).rec_reply_acc.module       := l_ty_tb_reply_acc(l_indx).module;
          tbl_consol(l_indx_consl).rec_reply_acc.product      := l_ty_tb_reply_acc(l_indx).product;
          tbl_consol(l_indx_consl).rec_reply_acc.valdate      := l_ty_tb_reply_acc(l_indx).valdate;
          tbl_consol(l_indx_consl).rec_reply_acc.trndate      := l_ty_tb_reply_acc(l_indx).trndate;
          tbl_consol(l_indx_consl).rec_reply_acc.amnt         := l_adj_ent.trn_amnt;
          tbl_consol(l_indx_consl).rec_reply_acc.trnbrn       := l_ty_tb_reply_acc(l_indx).trnbrn;
          tbl_consol(l_indx_consl).rec_reply_acc.trncode      := l_adj_ent.trn_code;
          tbl_consol(l_indx_consl).rec_reply_acc.trndesc      := fn_get_trndescription( l_ty_tb_reply_acc(l_indx).trn_ref_no,
                                                l_adj_ent.trn_code,
                                                l_ty_tb_reply_acc(l_indx).product,
                                                l_ty_tb_reply_acc(l_indx).module,
                                                l_ty_tb_reply_acc(l_indx).amount_tag
                                                 );
          tbl_consol(l_indx_consl).rec_reply_acc.drcrind      := l_adj_ent.drcr_ind;
          tbl_consol(l_indx_consl).rec_reply_acc.event        := l_ty_tb_reply_acc(l_indx).event;
          tbl_consol(l_indx_consl).rec_reply_acc.instrument_code := l_instr_no;
          tbl_consol(l_indx_consl).rec_reply_acc.amount_tag      := l_ty_tb_reply_acc(l_indx).amount_tag;
        END IF;
      END IF;
      -- PA876CLPBFBIMPSUPP-100 Changes End Here -- 19Jan2016

      l_indx := l_ty_tb_reply_acc.NEXT(l_indx);
    END LOOP;

  --<<3-16396619361 Changes>> start
  EXIT WHEN l_rec_clubbed = 0;
  END LOOP;
  CLOSE l_cursor;
  --<<3-16396619361 Changes>> end

  /*
  dbg('p_data for fn_reply_acdtl -> ' || p_data);
  dbg('p_key for fn_reply_acdtl ->  ' || p_key);
  dbg('p_parent fn_reply_acdtl -> ' || p_parent);
  dbg('p_format for fn_reply_acdtl -> ' || p_format);
  */
  -- PA876CLPBFBIMPSUPP-159 changes Starts
  dbms_lob.createtemporary(pkg_key, true);
  dbms_lob.createtemporary(pkg_data, true);
  dbms_lob.createtemporary(pkg_parent, true);
  dbms_lob.createtemporary(pkg_format, true);
  dbg('Before creating ');

  dbms_lob.open(pkg_key, dbms_lob.lob_readwrite);
  dbms_lob.open(pkg_data, dbms_lob.lob_readwrite);
  dbms_lob.open(pkg_parent, dbms_lob.lob_readwrite);
  dbms_lob.open(pkg_format, dbms_lob.lob_readwrite);

  IF NOT fn_reassign_clob
       ( p_key
      ,p_data
      ,p_parent
      ,p_format
      ,p_err_code
      ,p_err_param
       )
  THEN
    dbg('Assigning the clob variable failed-->'||p_err_code||'~~'||p_err_param);
    RETURN FALSE;
  END IF;

  -- PA876CLPBFBIMPSUPP-251 Changes Start Here -- 20Sep2016
  p_tslist := 'ACCBRN~ACCNO~FCCREF~MODULE~PRD~VALDATE~TRNDATE~AMNT~TRNBRN~TRNCODE~TRNDESC~DRCRIND~INSTRNO~>';
  g_cnt_lvl2 := 1;
  -- PA876CLPBFBIMPSUPP-251 Changes End Here -- 20Sep2016

  -- PA876CLPBFBIMPSUPP-159 changes Ends
  -- PA876CLPBFBIMPSUPP-100 Changes Start Here -- 19Jan2016
  IF tbl_consol.COUNT > 0
  THEN
      FOR mn IN tbl_consol.FIRST..tbl_consol.LAST
    LOOP
      -- PA876CLPBFBIMPSUPP-159 changes Starts
      p_key         := EMPTY_CLOB();
      p_data        := EMPTY_CLOB();
      p_parent      := EMPTY_CLOB();
      p_format      := EMPTY_CLOB();
      -- PA876CLPBFBIMPSUPP-159 changes Ends
      g_cnt_lvl2 := g_cnt_lvl2 + 1;
      -- 3-18011148071 Changes Start Here -- 02Aug2018
      /*
      p_data  := p_data || tbl_consol(mn).rec_reply_acc.accbrn
                 || '~' || tbl_consol(mn).rec_reply_acc.accno
                 || '~' || tbl_consol(mn).rec_reply_acc.trn_ref_no
                 || '~' || tbl_consol(mn).rec_reply_acc.module
                 || '~' || tbl_consol(mn).rec_reply_acc.product
                 || '~' || TO_CHAR(tbl_consol(mn).rec_reply_acc.valdate, 'RRRR-MM-DD')
                 || '~' || TO_CHAR(tbl_consol(mn).rec_reply_acc.trndate, 'RRRR-MM-DD')
                 || '~' || tbl_consol(mn).rec_reply_acc.amnt
                 || '~' || tbl_consol(mn).rec_reply_acc.trnbrn
                 || '~' || tbl_consol(mn).rec_reply_acc.trncode
                 || '~' || tbl_consol(mn).rec_reply_acc.trndesc
                 || '~' || CASE tbl_consol(mn).rec_reply_acc.drcrind WHEN 'D' THEN 'C' WHEN 'C' THEN 'D' END
                 || '~' || tbl_consol(mn).rec_reply_acc.instrument_code||'~>';
      */
      l_data_temp := NULL;
      l_data_temp := tbl_consol(mn).rec_reply_acc.accbrn
                 || '~' || tbl_consol(mn).rec_reply_acc.accno
                 || '~' || tbl_consol(mn).rec_reply_acc.trn_ref_no
                 || '~' || tbl_consol(mn).rec_reply_acc.module
                 || '~' || tbl_consol(mn).rec_reply_acc.product
                 || '~' || TO_CHAR(tbl_consol(mn).rec_reply_acc.valdate, 'RRRR-MM-DD')
                 || '~' || TO_CHAR(tbl_consol(mn).rec_reply_acc.trndate, 'RRRR-MM-DD')
                 || '~' || tbl_consol(mn).rec_reply_acc.amnt
                 || '~' || tbl_consol(mn).rec_reply_acc.trnbrn
                 || '~' || tbl_consol(mn).rec_reply_acc.trncode
                 || '~' || tbl_consol(mn).rec_reply_acc.trndesc
                 || '~' || CASE tbl_consol(mn).rec_reply_acc.drcrind WHEN 'D' THEN 'C' WHEN 'C' THEN 'D' END
                 || '~' || tbl_consol(mn).rec_reply_acc.instrument_code||'~>';
      dbms_lob.createtemporary(p_data, TRUE);
      dbms_lob.append(p_data,to_clob(l_data_temp));
      l_data_temp := NULL;

      -- p_key    := p_key || p_tslist;
      dbms_lob.createtemporary(p_key, TRUE);
      dbms_lob.append(p_key,to_clob(p_tslist));

      -- p_parent := p_parent || 'CA-Acc-Move-Dtls'||'>';
      l_data_temp := 'CA-Acc-Move-Dtls'||'>';
      dbms_lob.createtemporary(p_parent, TRUE);
      dbms_lob.append(p_parent,to_clob(l_data_temp));
      l_data_temp := NULL;

      -- p_format := p_format || g_cnt_lvl || '.' || g_cnt_lvl2||'>';
      l_data_temp := g_cnt_lvl || '.' || g_cnt_lvl2||'>';
      dbms_lob.createtemporary(p_format, TRUE);
      dbms_lob.append(p_format,to_clob(l_data_temp));
      l_data_temp := NULL;
      -- 3-18011148071 Changes End Here -- 02Aug2018

      dbg('UDF Details now');

      IF tbl_consol(mn).tbl_udf_det.COUNT > 0
      THEN
        g_cnt_lvl3 := 0;
        FOR udfval IN tbl_consol(mn).tbl_udf_det.FIRST..tbl_consol(mn).tbl_udf_det.LAST
        LOOP
          -- PA876CLPBFBIMPSUPP-156 Changes Start Here -- 11Apr2016
          IF tbl_consol(mn).tbl_udf_det(udfval).Field_Val IS NOT NULL
          THEN
            p_parent   := p_parent || 'Cotms-UDF-Details' || '>';
            g_cnt_lvl3 := g_cnt_lvl3 + 1;
          -- PA876CLPBFBIMPSUPP-156 Changes End Here -- 11Apr2016
              p_format   := p_format || g_cnt_lvl || '.' || g_cnt_lvl2|| '.' ||g_cnt_lvl3 || '>';
            p_key      := p_key || 'FIELDNAME' || '~' || 'FIELDVAL' ||'~' || '>';
            p_data     := p_data || tbl_consol(mn).tbl_udf_det(udfval).Field_Name || '~' || tbl_consol(mn).tbl_udf_det(udfval).Field_Val || '~'||'>';
          END IF; -- PA876CLPBFBIMPSUPP-156 Changes -- 11Apr2016
        END LOOP;
      END IF;
      -- PA876CLPBFBIMPSUPP-159 changes Starts
      IF NOT fn_reassign_clob
           ( p_key
          ,p_data
          ,p_parent
          ,p_format
          ,p_err_code
          ,p_err_param
           )
      THEN
        dbg('Assigning the clob variable failed-->'||p_err_code||'~~'||p_err_param);
        RETURN FALSE;
      END IF;
      --dbg('Length of pkg key-->'||LENGTH(pkg_key));
      -- PA876CLPBFBIMPSUPP-159 changes Ends
      END LOOP;
  END IF;

  DELETE FROM mstb_acc_stmt_blkchqdp
      WHERE ac_no = p_acc_dtl.g_accno
      AND ac_brn = p_acc_dtl.g_accbrn;
  -- PA876CLPBFBIMPSUPP-100 Changes End Here -- 19Jan2016
  -- PA876CLPBFBIMPSUPP-159 changes Starts
  p_key    := pkg_key;
  p_data   := pkg_data;
  p_parent := pkg_parent;
  p_format := pkg_format;

  dbms_lob.close(pkg_key);
  dbms_lob.close(pkg_data);
  dbms_lob.close(pkg_parent);
  dbms_lob.close(pkg_format);
  -- PA876CLPBFBIMPSUPP-159 changes Ends
END IF;

dbg('Returning true from fn_reply_acdtl');
RETURN TRUE;

EXCEPTION
WHEN OTHERS
THEN
    clpkss_logger.pr_log_exception('Inside WHEN OTHERS In Function fn_reply_acdtl' ||SQLERRM || '~' || dbms_utility.format_error_backtrace);
  dbg(dbms_utility.format_error_backtrace);
  p_err_code  := 'ED-INVDATA';
  p_err_param := SQLERRM;
  RETURN FALSE;
END fn_reply_acdtl;

FUNCTION fn_reply_acdtl_old( p_acc_dtl        IN OUT      g_rec_acc_dtl,
               p_resp_node_name IN        VARCHAR2,
               p_data           IN OUT NOCOPY   VARCHAR2,
               p_key            IN OUT NOCOPY   VARCHAR2,
               p_parent         IN OUT NOCOPY   VARCHAR2,
               p_format         IN OUT NOCOPY   VARCHAR2,
               p_err_code       IN OUT      VARCHAR2,
               p_err_param      IN OUT      VARCHAR2
              )
RETURN BOOLEAN
IS

p_tslist    VARCHAR2(1000);

TYPE ty_rec_reply_acc IS RECORD
(
  accbrn      acvws_all_ac_entries.ac_branch%TYPE,
  accno       acvws_all_ac_entries.ac_no%TYPE,
  acsrno      acvws_all_ac_entries.ac_entry_sr_no%TYPE, --CLPFLBL_IFC69_18-DEC-2014_Onsite:CLPBFBFCC1379 Changes
  trn_ref_no  acvws_all_ac_entries.trn_ref_no%TYPE,
  module      acvws_All_Ac_Entries.MODULE%TYPE,
  product     actbs_daily_log.product%TYPE,
  valdate     acvws_all_ac_entries.value_dt%TYPE,
  trndate     acvws_all_ac_entries.trn_dt%TYPE,
  amnt        acvws_all_ac_entries.lcy_amount%TYPE,
  trnbrn      acvws_all_ac_entries.ac_branch%TYPE,
  trncode     acvws_all_ac_entries.trn_code%TYPE,
  -- CLPBFBFCC1518 Changes Start Here -- 05Jun2015
  -- trndesc    sttm_trn_code.trn_desc%TYPE,
  trndesc     detbs_rtl_teller.narrative%TYPE,
  -- CLPBFBFCC1518 Changes End Here -- 05Jun2015
  drcrind     acvws_all_ac_entries.drcr_ind%TYPE
  -- CLPBFBFCC1518 Changes Start Here -- 05Jun2015
  ,event    acvws_all_ac_entries.event%TYPE
  -- CLPBFBFCC1518 Changes End Here -- 05Jun2015
  ,instrument_code acvws_all_ac_entries.instrument_code%TYPE -- CLPBFBFCC1562 Changes -- 30Jul2015
);

TYPE ty_tb_reply_acc IS TABLE OF ty_rec_reply_acc INDEX BY PLS_INTEGER;
l_ty_tb_reply_acc ty_tb_reply_acc;
l_indx            NUMBER;

--CLPFLBL_IFC69_18-DEC-2014_Onsite:CLPBFBFCC1379 Changes starts
l_dynamic_sql_stmt VARCHAR2(32767);

--CLPFLBL_IFC69_04-DEC-2014_Onsite:CLPBFBFCC1365 Changes starts
--Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1196 start
--Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1193 start
/* l_dynamic_sql_stmt VARCHAR2(32767) := 'SELECT * FROM (select ac_branch,ac_no,value_dt,trn_dt,lcy_amount,substr(trn_ref_no,1,3) trn_brn,vw.trn_code,trn_desc,drcr_ind from ACVWS_ALL_AC_ENTRIES VW,sttms_trn_code cd where vw.trn_code=cd.trn_code and vw.ac_no = ' || '''' ||
                    p_acc_dtl.g_accno || '''' ||
                    ' and ac_branch = ' || '''' ||
                    p_acc_dtl.g_accbrn || '''' ||
                    ' AND vw.AUTH_STAT = ' || '''A''';*/
--Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1196 end
/*   l_dynamic_sql_stmt VARCHAR2(32767) := 'SELECT * FROM (select ac_branch,ac_no,trn_ref_no,module,decode(module,''DD'',substr(trn_ref_no,4,4),''RT'',substr(trn_ref_no,4,4)) product,value_dt,trn_dt,lcy_amount,substr(trn_ref_no,1,3) trn_brn,vw.trn_code,trn_desc,drcr_ind from ACVWS_ALL_AC_ENTRIES VW,sttms_trn_code cd where vw.trn_code=cd.trn_code and vw.ac_no = ' || '''' ||
                    p_acc_dtl.g_accno || '''' ||
                    ' and ac_branch = ' || '''' ||
                    p_acc_dtl.g_accbrn || '''' ||
                    ' AND vw.AUTH_STAT = ' || '''A''';*/
--CLPFLBL_IFC69_04-DEC-2014_Onsite:CLPBFBFCC1365 Changes ends
--CLPFLBL_IFC69_18-DEC-2014_Onsite:CLPBFBFCC1379 Changes ends

-- CLPBFBFCC1562 Changes Start Here -- 29Jul2015
l_noofrecs    cstbs_param.param_val%TYPE;
l_count     NUMBER := 0;
-- CLPBFBFCC1562 Changes End Here -- 29Jul2015

BEGIN

dbg('Inside Function fn_reply_acdtl');

l_noofrecs := NVL(cspkss_os_param.get_param_val('NOOFRECS'), '50'); -- CLPBFBFCC1562 Changes -- 29Jul2015

--CLPFLBL_IFC69_18-DEC-2014_Onsite:CLPBFBFCC1379 Changes starts
--Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1158 START
--Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1198 start
/*IF p_acc_dtl.g_todate IS NOT NULL AND p_acc_dtl.g_norec IS NULL THEN
  l_dynamic_sql_stmt := l_dynamic_sql_stmt || ' and trn_dt <= ' || '''' ||
             \* to_date(p_acc_dtl.g_todate, 'YYYY-MM-DD') || '''';*\ --anand_changes_03042014
            p_acc_dtl.g_todate || ''''; --anand_changes_03042014

END IF;

IF p_acc_dtl.g_frmdt IS NOT NULL AND p_acc_dtl.g_norec IS NULL THEN
  l_dynamic_sql_stmt := l_dynamic_sql_stmt || ' and trn_dt >= ' || '''' ||
             \*to_date(p_acc_dtl.g_frmdt, 'YYYY-MM-DD') || '''';*\ --anand_changes_03042014
            p_acc_dtl.g_frmdt || ''''; --anand_changes_03042014

END IF;
-- Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1198 start
IF p_acc_dtl.g_todate IS NULL AND p_acc_dtl.g_frmdt IS NULL AND
   p_acc_dtl.g_norec IS NULL THEN
  l_dynamic_sql_stmt := l_dynamic_sql_stmt || ' and trn_dt = ' || '''' ||
            global.application_date || '''';

END IF;

IF p_acc_dtl.g_norec IS NOT NULL AND p_acc_dtl.g_norec <= 50 --Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1280
 THEN
  l_dynamic_sql_stmt := l_dynamic_sql_stmt ||
            ' order by vw.ac_entry_sr_no DESC ) where ROWNUM <= ' || '''' ||
            p_acc_dtl.g_norec || '''';
ELSE
  l_dynamic_sql_stmt := l_dynamic_sql_stmt ||
            ' order by vw.ac_entry_sr_no DESC ) where ROWNUM<=50 '; --Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1196 --Oracle FLEXCUBE Universal Banking FCUBS_11.3.83.1.0FALACL_R2_FALITR1FCC1282

END IF;*/

-- CLPBFBFCC1391 Changes start - Commenting existing select
/*
IF p_acc_dtl.g_norec IS NOT NULL
THEN
  l_dynamic_sql_stmt := 'SELECT * FROM (
                 SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,decode(module,''DD'',substr(trn_ref_no,4,4),''RT'',substr(trn_ref_no,4,4)) product,value_dt,
                    decode(event,''CONV'',txn_init_date,trn_dt) trndate,lcy_amount,substr(trn_ref_no,1,3) trn_brn,vw.trn_code,trn_desc,drcr_ind
                 FROM acvws_all_ac_entries vw,sttms_trn_code cd
                WHERE vw.trn_code=cd.trn_code
                 AND vw.ac_no = ' || ''''|| p_acc_dtl.g_accno || ''''||'
                 AND vw.ac_branch = '||''''|| p_acc_dtl.g_accbrn || ''''||'
                 AND vw.auth_stat = ''A''
                 AND (vw.event = ''CONV''
                    OR
                    vw.event <> ''CONV'')
                 ORDER BY vw.ac_entry_sr_no)
               WHERE ROWNUM <= nvl('||''''||p_acc_dtl.g_norec ||''''||',50)';
ELSIF (p_acc_dtl.g_frmdt IS NOT NULL OR p_acc_dtl.g_todate IS NOT NULL)
THEN
  l_dynamic_sql_stmt := 'SELECT * FROM (
                 SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,decode(module,''DD'',substr(trn_ref_no,4,4),''RT'',substr(trn_ref_no,4,4)) product,value_dt,
                    decode(event,''CONV'',txn_init_date,trn_dt) trndate,lcy_amount,substr(trn_ref_no,1,3) trn_brn,vw.trn_code,trn_desc,drcr_ind
                 FROM acvws_all_ac_entries vw,sttms_trn_code cd
                WHERE vw.trn_code=cd.trn_code
                 AND vw.ac_no = ' || ''''|| p_acc_dtl.g_accno || ''''||'
                 AND vw.ac_branch = '||''''|| p_acc_dtl.g_accbrn || ''''||'
                 AND vw.auth_stat = ''A''
                 AND (vw.event = ''CONV'' AND vw.txn_init_date BETWEEN '||'''' ||p_acc_dtl.g_frmdt ||'''' ||'AND NVL('||''''||p_acc_dtl.g_todate||''''||','||''''||global.application_date||''''||')
                    OR
                    vw.event <> ''CONV'' AND vw.trn_dt BETWEEN '||'''' ||p_acc_dtl.g_frmdt ||'''' ||'AND NVL('||''''||p_acc_dtl.g_todate||''''||','||''''||global.application_date||''''||' ))
                 ORDER BY vw.ac_entry_sr_no)
               WHERE ROWNUM <= nvl('||''''||p_acc_dtl.g_norec ||''''||',50)';

ELSIF p_acc_dtl.g_frmdt IS NULL AND p_acc_dtl.g_todate IS NULL
THEN
  l_dynamic_sql_stmt := 'SELECT * FROM (
                 SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,decode(module,''DD'',substr(trn_ref_no,4,4),''RT'',substr(trn_ref_no,4,4)) product,value_dt,
                    trn_dt,lcy_amount,substr(trn_ref_no,1,3) trn_brn,vw.trn_code,trn_desc,drcr_ind
                 FROM actbs_daily_log vw,sttms_trn_code cd
                WHERE vw.trn_code=cd.trn_code
                  AND vw.ac_no = ' || ''''|| p_acc_dtl.g_accno || '''' ||'
                  AND vw.ac_branch = '||''''|| p_acc_dtl.g_accbrn || ''''||'
                  AND vw.auth_stat = ''A''
                  AND nvl(vw.delete_stat,''X'') <> ''D''
                  AND trn_dt = '||''''||global.application_date||''''||'
                ORDER BY vw.ac_entry_sr_no)
               WHERE ROWNUM <= NVL('||''''||p_acc_dtl.g_norec ||''''||',50)';

END IF;
*/
--CLPFLBL_IFC69_18-DEC-2014_Onsite:CLPBFBFCC1379 Changes ends

-- CLPBFBFCC1391 Changes - Adding select with exclude reversals done on the same day logic
IF p_acc_dtl.g_norec IS NOT NULL
THEN
  l_dynamic_sql_stmt := 'SELECT * FROM (
                 SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,decode(module,''DD'',substr(trn_ref_no,4,4),''RT'',substr(trn_ref_no,4,4)) product,value_dt,
                    decode(event,''CONV'',txn_init_date,trn_dt) trndate,lcy_amount,substr(trn_ref_no,1,3) trn_brn,vw.trn_code,trn_desc,drcr_ind
                    ,event, instrument_code -- CLPBFBFCC1518 Changes -- 05Jun2015
                 FROM acvws_all_ac_entries_custom vw,sttms_trn_code cd
                WHERE vw.trn_code=cd.trn_code
                 AND vw.ac_no = ' || ''''|| p_acc_dtl.g_accno || ''''||'
                 AND vw.ac_branch = '||''''|| p_acc_dtl.g_accbrn || ''''||'
                 AND vw.auth_stat = ''A''
                 AND (vw.event = ''CONV''
                    OR
                    vw.event <> ''CONV'')
                 AND nvl(vw.dont_showin_stmt, ''N'') = ''N''
                 ORDER BY trndate DESC , vw.ac_entry_sr_no DESC) -- CLPBFBFCC1507 Changes -- 02Jun2015 -- PA876CLPBFBIMPSUPP-31 Changes -- 03Nov2015
               WHERE ROWNUM <= nvl('||''''||p_acc_dtl.g_norec ||''''||',:l_noofrecs)'; -- CLPBFBFCC1562 Changes -- 29Jul2015
ELSIF (p_acc_dtl.g_frmdt IS NOT NULL AND p_acc_dtl.g_todate IS NOT NULL) -- CLPBFBFCC1427 Changes -- 17Mar2015 -- Added AND clause.
THEN
  l_dynamic_sql_stmt := 'SELECT * FROM (
                 SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,decode(module,''DD'',substr(trn_ref_no,4,4),''RT'',substr(trn_ref_no,4,4)) product,value_dt,
                    decode(event,''CONV'',txn_init_date,trn_dt) trndate,lcy_amount,substr(trn_ref_no,1,3) trn_brn,vw.trn_code,trn_desc,drcr_ind
                    ,event, instrument_code -- CLPBFBFCC1518 Changes -- 05Jun2015
                 FROM acvws_all_ac_entries_custom vw,sttms_trn_code cd
                WHERE vw.trn_code=cd.trn_code
                 AND vw.ac_no = ' || ''''|| p_acc_dtl.g_accno || ''''||'
                 AND vw.ac_branch = '||''''|| p_acc_dtl.g_accbrn || ''''||'
                 AND vw.auth_stat = ''A''
                 AND (vw.event = ''CONV'' AND vw.txn_init_date BETWEEN '||'''' ||p_acc_dtl.g_frmdt ||'''' ||'AND NVL('||''''||p_acc_dtl.g_todate||''''||','||''''||global.application_date||''''||')
                    OR
                    vw.event <> ''CONV'' AND vw.trn_dt BETWEEN '||'''' ||p_acc_dtl.g_frmdt ||'''' ||'AND NVL('||''''||p_acc_dtl.g_todate||''''||','||''''||global.application_date||''''||' ))
                 AND nvl(vw.dont_showin_stmt, ''N'') = ''N''
                 ORDER BY trndate, vw.ac_entry_sr_no) -- PA876CLPBFBIMPSUPP-31 Changes -- 03Nov2015
               WHERE ROWNUM <= nvl('||''''||p_acc_dtl.g_norec ||''''||',:l_noofrecs)'; -- CLPBFBFCC1562 Changes -- 29Jul2015
-- CLPBFBFCC1427 Changes Start Here -- 17Mar2015
ELSIF (p_acc_dtl.g_frmdt IS NOT NULL AND p_acc_dtl.g_todate IS NULL)
THEN
  l_dynamic_sql_stmt := 'SELECT *
               FROM (
                 SELECT ac_branch, ac_no, ac_entry_sr_no, trn_ref_no, module, DECODE(module, ''DD'', SUBSTR(trn_ref_no,4,4), ''RT'', SUBSTR(trn_ref_no,4,4)) product,
                    value_dt, DECODE(event, ''CONV'', txn_init_date, trn_dt) trndate, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, vw.trn_code,
                    trn_desc, drcr_ind
                    ,event, instrument_code -- CLPBFBFCC1518 Changes -- 05Jun2015
                 FROM acvws_all_ac_entries_custom vw, sttms_trn_code cd
                WHERE vw.trn_code = cd.trn_code
                  AND vw.ac_no = ' || ''''|| p_acc_dtl.g_accno || ''''||'
                  AND vw.ac_branch = '||''''|| p_acc_dtl.g_accbrn || ''''||'
                  AND vw.auth_stat = ''A''
                  AND ((vw.event = ''CONV'' AND vw.txn_init_date >= '||'''' ||p_acc_dtl.g_frmdt ||''''||')
                     OR
                     (vw.event <> ''CONV'' AND vw.trn_dt >= '||'''' ||p_acc_dtl.g_frmdt ||''''||' ))
                  AND NVL(vw.dont_showin_stmt, ''N'') = ''N''
                ORDER BY trndate, vw.ac_entry_sr_no) -- PA876CLPBFBIMPSUPP-31 Changes -- 03Nov2015
               WHERE ROWNUM <= NVL('||''''||p_acc_dtl.g_norec ||''''||',:l_noofrecs)'; -- CLPBFBFCC1562 Changes -- 29Jul2015
ELSIF p_acc_dtl.g_frmdt IS NULL AND p_acc_dtl.g_todate IS NULL
THEN
  l_dynamic_sql_stmt := 'SELECT * FROM (
                 (SELECT ac_branch,ac_no,ac_entry_sr_no,trn_ref_no,module,decode(module,''DD'',substr(trn_ref_no,4,4),''RT'',substr(trn_ref_no,4,4)) product,value_dt,
                    trn_dt,lcy_amount,substr(trn_ref_no,1,3) trn_brn,vw.trn_code,trn_desc,drcr_ind
                    ,event, instrument_code -- CLPBFBFCC1518 Changes -- 05Jun2015
                 FROM actbs_daily_log vw,sttms_trn_code cd
                WHERE vw.trn_code=cd.trn_code
                  AND vw.ac_no = ' || ''''|| p_acc_dtl.g_accno || '''' ||'
                  AND vw.ac_branch = '||''''|| p_acc_dtl.g_accbrn || ''''||'
                  AND vw.auth_stat = ''A''
                  AND nvl(vw.delete_stat,''X'') <> ''D''
                  AND trn_dt = '||''''||global.application_date||''''||'
                  AND nvl(vw.dont_showin_stmt, ''N'') = ''N''
                UNION
                SELECT ac_branch, ac_no, ac_entry_sr_no, trn_ref_no, module, DECODE(module,''DD'',SUBSTR(trn_ref_no,4,4),''RT'',SUBSTR(trn_ref_no,4,4)) product,
                     value_dt, trn_dt, lcy_amount, SUBSTR(trn_ref_no,1,3) trn_brn, vw1.trn_code, trn_desc, drcr_ind
                     ,event, instrument_code -- CLPBFBFCC1518 Changes -- 05Jun2015
                  FROM actbs_daily_log vw1, sttms_trn_code cd
                 WHERE vw1.trn_code = cd.trn_code
                   AND vw1.ac_no = ' || ''''|| p_acc_dtl.g_accno || '''' ||'
                   AND vw1.ac_branch = '||''''|| p_acc_dtl.g_accbrn || ''''||'
                   AND vw1.auth_stat = ''A''
                   AND NVL(vw1.delete_stat,''X'') <> ''D''
                   AND vw1.balance_upd = ''T''
                   AND NVL(vw1.dont_showin_stmt, ''N'') = ''N''
                )
                ORDER BY trn_dt, ac_entry_sr_no) -- PA876CLPBFBIMPSUPP-31 Changes -- 03Nov2015
               WHERE ROWNUM <= NVL('||''''||p_acc_dtl.g_norec ||''''||',:l_noofrecs)'; -- CLPBFBFCC1562 Changes -- 29Jul2015
-- CLPBFBFCC1427 Changes End Here -- 17Mar2015
END IF;
-- CLPBFBFCC1391 Changes end
dbg('DYNAMIC SQL QUERY IS ---->>> ' || l_dynamic_sql_stmt);

EXECUTE IMMEDIATE l_dynamic_sql_stmt BULK COLLECT INTO l_ty_tb_reply_acc USING IN l_noofrecs; -- CLPBFBFCC1562 Changes -- 29Jul2015

IF l_ty_tb_reply_acc.COUNT = 0
THEN
    dbg('GW-QAT-007 : No Account Movement Has Done For The Account Number');
    p_err_code  := 'GW-QAT-007;';
    p_err_param := 'No Account Movement Has Done For The Account Number;';
    RETURN FALSE;
END IF;

dbg('AFTER EXECUTE DYNAMIC SQL QUERY ');

p_key    := p_tslist;
p_parent := p_resp_node_name;
p_format := '1';
p_tslist := 'ACCBRN~ACCNO~FCCREF~MODULE~PRD~VALDATE~TRNDATE~AMNT~TRNBRN~TRNCODE~TRNDESC~DRCRIND~INSTRNO~'; -- CLPBFBFCC1562 Changes -- 29Jul2015

l_indx := l_ty_tb_reply_acc.FIRST;
WHILE l_indx IS NOT NULL
LOOP
  l_ty_tb_reply_acc(l_indx).trndesc := fn_get_trndescription( l_ty_tb_reply_acc(l_indx).trn_ref_no, l_ty_tb_reply_acc(l_indx).trncode); -- CLPBFBFCC1518 Changes -- 05Jun2015

  -- CLPBFBFCC1562 Changes Start Here -- 29Jul2015
  IF l_ty_tb_reply_acc(l_indx).module IN ('RT', 'DD') AND l_ty_tb_reply_acc(l_indx).drcrind = 'D' AND l_ty_tb_reply_acc(l_indx).instrument_code IS NOT NULL
  THEN
    BEGIN
      SELECT 1
        INTO l_count
        FROM detbs_rtl_teller
       WHERE trn_ref_no = l_ty_tb_reply_acc(l_indx).trn_ref_no
         AND dr_instrument_code = l_ty_tb_reply_acc(l_indx).instrument_code
         AND EXISTS (SELECT 1
               FROM catms_check_details
              WHERE account = l_ty_tb_reply_acc(l_indx).accno
                AND branch = l_ty_tb_reply_acc(l_indx).accbrn
                AND check_no = l_ty_tb_reply_acc(l_indx).instrument_code
                AND status = 'U');

    EXCEPTION
    WHEN OTHERS
    THEN
      l_ty_tb_reply_acc(l_indx).instrument_code := NULL;
    END;
  ELSIF l_ty_tb_reply_acc(l_indx).module IN ('CG') AND l_ty_tb_reply_acc(l_indx).drcrind = 'D' AND l_ty_tb_reply_acc(l_indx).instrument_code IS NOT NULL
  THEN
    BEGIN
      SELECT 1
        INTO l_count
        FROM csvws_clearing_master_c
       WHERE reference_no = l_ty_tb_reply_acc(l_indx).trn_ref_no
         AND direction = 'I'
         AND rem_account = l_ty_tb_reply_acc(l_indx).accno
         AND acc_branch = l_ty_tb_reply_acc(l_indx).accbrn
         AND instrument_no_1 = l_ty_tb_reply_acc(l_indx).instrument_code
         AND EXISTS (SELECT 1
               FROM catms_check_details
              WHERE account = l_ty_tb_reply_acc(l_indx).accno
                AND branch = l_ty_tb_reply_acc(l_indx).accbrn
                AND check_no = l_ty_tb_reply_acc(l_indx).instrument_code
                AND status = 'U');

    EXCEPTION
    WHEN OTHERS
    THEN
      l_ty_tb_reply_acc(l_indx).instrument_code := NULL;
    END;
  ELSE
    l_ty_tb_reply_acc(l_indx).instrument_code := NULL;
  END IF;
  -- CLPBFBFCC1562 Changes End Here -- 29Jul2015

  g_cnt_lvl2 := g_cnt_lvl2 + 1;
  p_data   := p_data || '>' || l_ty_tb_reply_acc(l_indx).accbrn
             || '~' || l_ty_tb_reply_acc(l_indx).accno
             || '~' || l_ty_tb_reply_acc(l_indx).trn_ref_no
             || '~' || l_ty_tb_reply_acc(l_indx).module
             || '~' || l_ty_tb_reply_acc(l_indx).product
             || '~' || to_char(l_ty_tb_reply_acc(l_indx).valdate, 'RRRR-MM-DD')
             || '~' || to_char(l_ty_tb_reply_acc(l_indx).trndate, 'RRRR-MM-DD')
             || '~' || l_ty_tb_reply_acc(l_indx).amnt
             || '~' || l_ty_tb_reply_acc(l_indx).trnbrn
             || '~' || l_ty_tb_reply_acc(l_indx).trncode
             || '~' || l_ty_tb_reply_acc(l_indx).trndesc
             || '~' || CASE l_ty_tb_reply_acc(l_indx).drcrind WHEN 'D' THEN 'C' WHEN 'C' THEN 'D' END
             || '~' || l_ty_tb_reply_acc(l_indx).instrument_code -- CLPBFBFCC1562 Changes -- 29Jul2015
       ;
  p_key    := p_key || '>' || p_tslist;
  p_parent := p_parent || '>CA-Acc-Move-Dtls';
  p_format := p_format || '>1.' || g_cnt_lvl2;
  dbg('Calling reply for debit card detail :');

  dbg('p_data for fn_reply_acdtl -> ' || p_data);
  dbg('p_key for fn_reply_acdtl ->  ' || p_key);
  dbg('p_parent fn_reply_acdtl -> ' || p_parent);
  dbg('p_format for fn_reply_acdtl -> ' || p_format);
  l_indx := l_ty_tb_reply_acc.NEXT(l_indx);
END LOOP;

RETURN TRUE;

EXCEPTION
WHEN OTHERS
THEN
    clpkss_logger.pr_log_exception('Inside WHEN OTHERS In Function fn_reply_acdtl' ||SQLERRM);
  p_err_code  := 'ED-INVDATA';
  p_err_param := SQLERRM;
  RETURN FALSE;
END fn_reply_acdtl_old;
-- PA876CLPBFBIMPSUPP-25 Changes End Here -- 14Oct2015

FUNCTION fn_ts_to_type(prectype      IN VARCHAR2,
                       pkey          IN VARCHAR2,
                       pdata         IN VARCHAR2,
                       p_recv_ac_dtl IN OUT g_rec_acc_dtl,
                       p_err_code    IN OUT VARCHAR2,
                       p_err_param   IN OUT VARCHAR2)
RETURN BOOLEAN
IS

l_rec            VARCHAR2(30);
l_parent_counter NUMBER(3) := 1;
l_field_counter  NUMBER(3) := 1;
lkey             VARCHAR2(8000);
ldata            VARCHAR2(8000);
l_curr_col       VARCHAR2(8000);
l_curr_val       VARCHAR2(8000);

invalid_no_of_rec EXCEPTION;
PRAGMA EXCEPTION_INIT(invalid_no_of_rec, -6502);

BEGIN

dbg('prectype:' || prectype);
dbg('l_parent_counter:' || l_parent_counter);

l_rec := nvl(cspkes_misc.fn_getparam(prectype, l_parent_counter, '>'), '??');

WHILE l_rec <> 'EOPL'
LOOP
  lkey  := nvl(cspkes_misc.fn_getparam(pkey, l_parent_counter, '>'), '??');
  ldata := nvl(cspkes_misc.fn_getparam(pdata, l_parent_counter, '>'), NULL);

  dbg('lkey:' || lkey);
  dbg('ldata:' || ldata);
  dbg('l_rec:' || l_rec);
  WHILE nvl(cspkes_misc.fn_getparam(lkey, l_field_counter, '~'), '??') <> 'EOPL'
  LOOP
    l_curr_col := nvl(cspkes_misc.fn_getparam(lkey,
                        l_field_counter,
                        '~'),
            '??');
    dbg('l_curr_col' || l_curr_col);

    l_curr_val := nvl(cspkes_misc.fn_getparam(ldata,
                        l_field_counter,
                        '~'),
            NULL);

    dbg('l_curr_val' || l_curr_val);
    dbg('l_curr_col:' || l_curr_col);

    IF l_curr_col = 'ACCNO'
    THEN
      dbg('Found ACCNO..');
      p_recv_ac_dtl.g_accno := l_curr_val;
      dbg('ACCNO :' || p_recv_ac_dtl.g_accno);
    ELSIF l_curr_col = 'ACCBRN'
    THEN
      dbg('Found ACCBRN..' || l_curr_val);
      p_recv_ac_dtl.g_accbrn := l_curr_val;
      dbg('ACCBRN :' || p_recv_ac_dtl.g_accbrn);
    ELSIF l_curr_col = 'FRMDT'
    THEN
      dbg('Found FRMDT..');
      p_recv_ac_dtl.g_frmdt := to_date(l_curr_val, 'RRRR-MM-DD');
      dbg('FRMDT :' || p_recv_ac_dtl.g_frmdt);
    ELSIF l_curr_col = 'TODATE'
    THEN
      dbg('Found TODATE..');
      p_recv_ac_dtl.g_todate := to_date(l_curr_val, 'RRRR-MM-DD');
      dbg('TODATE :' || p_recv_ac_dtl.g_todate);
    ELSIF l_curr_col = 'NOREC'
    THEN
      dbg('Found NOREC..');
      p_recv_ac_dtl.g_norec := l_curr_val;
      dbg('NOREC :' || p_recv_ac_dtl.g_norec);
    END IF;
    l_field_counter := l_field_counter + 1;
  END LOOP;

  l_field_counter  := 1;
  l_parent_counter := l_parent_counter + 1;
  l_rec            := nvl(cspkes_misc.fn_getparam(prectype,
                          l_parent_counter,
                          '>'),
              '??');
  dbg('the l_rec is' || l_rec);
END LOOP;

RETURN TRUE;

EXCEPTION
WHEN invalid_no_of_rec
THEN
    dbg('GW-QAT-004 : Not A Valid Value For Number Of Record ');
    p_err_code  := 'GW-QAT-004;';
    p_err_param := 'Not A Valid Value For Number Of Record~;';
    RETURN FALSE;
WHEN OTHERS
THEN
    clpkss_logger.pr_log_exception('Inside WHEN OTHERS In Function fn_ts_to_type' || SQLERRM);
    p_err_code  := 'ED-INVDATA';
    p_err_param := SQLERRM || '~' || l_rec;
    RETURN FALSE;
END fn_ts_to_type;

FUNCTION fn_replybuilder
    ( p_recv_ac_dtl IN OUT      g_rec_acc_dtl,
      p_data        IN OUT NOCOPY   CLOB,   -- PA876CLPBFBIMPSUPP-159 changes
      p_key         IN OUT NOCOPY   CLOB,   -- PA876CLPBFBIMPSUPP-159 changes
      p_parent      IN OUT NOCOPY   CLOB,   -- PA876CLPBFBIMPSUPP-159 changes
      p_format      IN OUT NOCOPY   CLOB,   -- PA876CLPBFBIMPSUPP-159 changes
      p_mode        IN        VARCHAR2,
      p_err_code    IN OUT      VARCHAR2,
      p_err_param   IN OUT      VARCHAR2
    )
RETURN BOOLEAN
IS

BEGIN

dbg('Inside Function gwpks_ca_queryaccmove.fn_ReplyBuilder');
dbg('p_mode ' || p_mode);

dbg('About to call gwpks_ca_queryaccmove.fn_Reply_FULL');
dbg('Primary Key Or Full Screen Value--->' || substr(p_mode, 3, 2));

IF NOT fn_reply_acdtl(p_recv_ac_dtl,
            'Cotms-QueryAccMove-Full',
            p_data,
            p_key,
            p_parent,
            p_format,
            p_err_code,
            p_err_param)
THEN
  dbg('Error in Building reply for component type Details'||dbms_utility.format_error_backtrace);  -- PA876CLPBFBIMPSUPP-159 changes
  RETURN FALSE;
END IF;

ovpkss.pr_appendtbl('GW-QAT-012', null);
RETURN TRUE;

EXCEPTION
WHEN OTHERS
THEN
  clpkss_logger.pr_log_exception('In WOT of fn_ReplyBuilder with SQLERRM ->' ||SQLERRM);
  p_err_code  := 'ED-UPLOTH';
  p_err_param := 'fn_ReplyBuilder ~' || SQLCODE || '~';
  RETURN FALSE;
END fn_replybuilder;

PROCEDURE pr_process_msg
     ( p_is_in_msg_clob  IN   VARCHAR2,
       p_rec_msg_header  IN   gwpks_service_router.ty_biz_process_header,
       p_is_out_msg_clob OUT  VARCHAR2,
       p_instr_rec       IN OUT NOCOPY gwpks_service_router.ty_processing_instructions,
       p_flag            OUT  NUMBER,
       p_err_code        IN OUT VARCHAR2,
       p_err_param       IN OUT VARCHAR2
     )
IS

l_parents_list       VARCHAR2(32767);
l_parents_format     VARCHAR2(32767);
l_ts_tag_names       VARCHAR2(32767);
l_ts_tag_values      VARCHAR2(32767);
l_ts_tag_format      VARCHAR2(32767);
l_ts_clob_tag_names  CLOB;
l_ts_clob_tag_values CLOB;
l_ts_clob_tag_format CLOB;

--l_res_parents_list   VARCHAR2(32767); -- PA876CLPBFBIMPSUPP-159 changes
--l_res_parents_format VARCHAR2(32767); -- PA876CLPBFBIMPSUPP-159 changes
l_res_parents_list   CLOB;        -- PA876CLPBFBIMPSUPP-159 changes
l_res_parents_format CLOB;        -- PA876CLPBFBIMPSUPP-159 changes
l_res_ts_tag_names   VARCHAR2(32767);
l_res_ts_tag_values  VARCHAR2(32767);
l_res_ts_tag_format  VARCHAR2(32767);

l_is_tag_clob VARCHAR2(1);

l_err_tbl ovpks.tbl_error;
error_exception EXCEPTION;

l_is_in_msg_clob VARCHAR2(1) := p_is_in_msg_clob;
l_recv_ac_dtl    g_rec_acc_dtl;

p_parent CLOB;   -- PA876CLPBFBIMPSUPP-159_18_04_2016 changes
p_key    CLOB;   -- PA876CLPBFBIMPSUPP-159_18_04_2016 changes
p_data   CLOB;   -- PA876CLPBFBIMPSUPP-159_18_04_2016 changes

BEGIN

dbg('In gwpks_ca_queryaccmove..');
dbg('Parsing the XML..');
p_flag := -1;


IF NOT gwpks_xml_parser.fn_xml_parser(p_rec_msg_header.SOURCE,
                    l_parents_list,
                    l_parents_format,
                    l_ts_tag_names,
                    l_ts_tag_values,
                    l_ts_tag_format,
                    l_ts_clob_tag_names,
                    l_ts_clob_tag_values,
                    l_ts_clob_tag_format,
                    l_is_in_msg_clob,
                    l_is_tag_clob,
                    p_err_code,
                    p_err_param)
THEN
  dbg('FAILED IN gwpks_xml_parser.fn_parse_xml in gwpks_ca_queryaccmove');
  l_err_tbl(1).err_code := p_err_code;
  l_err_tbl(1).params := p_err_param;
  ovpkss.pr_appendtbl(p_err_code, p_err_param);
  RAISE error_exception;
END IF;

dbg(l_parents_list);
dbg('About to call gwpks_ca_queryaccmove.fn_ts_to_type ');


IF NOT fn_ts_to_type(l_parents_list,
           l_ts_tag_names,
           l_ts_tag_values,
           l_recv_ac_dtl,
           p_err_code,
           p_err_param)
THEN
  dbg('FAILED IN fn_ts_to_types in gwpks_ca_queryaccmove');
  l_err_tbl(1).err_code := p_err_code;
  l_err_tbl(1).params := p_err_param;
  ovpkss.pr_appendtbl(p_err_code, p_err_param);
  RAISE error_exception;
END IF;


IF NOT fn_validate_req_val(l_recv_ac_dtl, p_err_code, p_err_param)
THEN
  dbg('FAILED IN fn_validate_req_val in gwpks_ca_queryaccmove');
  l_err_tbl(1).err_code := p_err_code;
  l_err_tbl(1).params := 'INVALID DATA';
  ovpkss.pr_appendtbl(p_err_code, p_err_param);
  RAISE error_exception;
END IF;

dbg(' Calling the function fn_ReplyBuilder  ');


IF NOT fn_replybuilder(l_recv_ac_dtl,
             --l_res_ts_tag_values  -- PA876CLPBFBIMPSUPP-159 changes
             l_ts_clob_tag_values,  -- PA876CLPBFBIMPSUPP-159 changes
             --l_res_ts_tag_names   -- PA876CLPBFBIMPSUPP-159 changes
             l_ts_clob_tag_names,   -- PA876CLPBFBIMPSUPP-159 changes
             --l_res_parents_list,  -- PA876CLPBFBIMPSUPP-159_18_04_2016 changes
             p_parent,              -- PA876CLPBFBIMPSUPP-159_18_04_2016 changes
             --l_res_parents_format,-- PA876CLPBFBIMPSUPP-159_18_04_2016 changes
             l_ts_clob_tag_format,  -- PA876CLPBFBIMPSUPP-159_18_04_2016 changes
             p_instr_rec.msg_xchange_pattern,
             p_err_code,
             p_err_param)
THEN
  dbg('Failed in fn_ReplyBuilder..'||dbms_utility.format_error_backtrace); -- PA876CLPBFBIMPSUPP-159 changes
  dbg('Error  :' || p_err_code || ':' || p_err_param);
  l_err_tbl.DELETE;
  l_err_tbl(1).err_code := p_err_code;
  l_err_tbl(1).params := p_err_param;
  ovpkss.pr_appendtbl(p_err_code, p_err_param);
  RAISE error_exception;
END IF;

dbg('l_res_ts_tag_values :' || l_res_ts_tag_values);
dbg('l_res_ts_tag_names : ' || l_res_ts_tag_names);
dbg('Calling  gwpkss_xml_crtr.fn_create_xml..');

IF nvl(l_is_in_msg_clob, 'N') = 'Y'
THEN
  l_ts_clob_tag_names  := l_res_ts_tag_names;
  l_ts_clob_tag_values := l_res_ts_tag_values;
END IF;
-- PA876CLPBFBIMPSUPP-159_18_04_2016 changes starts
/*IF NOT gwpkss_xml_crtr.fn_xml_creator
          ( p_rec_msg_header,
            p_instr_rec,
            p_is_in_msg_clob,
            l_res_parents_list,
            l_res_parents_format,
            l_res_ts_tag_names,
            l_res_ts_tag_values,
            l_res_ts_tag_format,
            l_ts_clob_tag_names,
            l_ts_clob_tag_values,
            l_ts_clob_tag_format,
            'S',
            p_is_out_msg_clob
          )
THEN
  dbg('FAILED IN gwpkss_xml_crtr.fn_create_xml');
  RAISE error_exception;
END IF;*/

IF NOT gwpks_xml_crtr_cu.fn_xml_creator_ovd
          ( p_rec_msg_header ,
      p_instr_rec ,
      'Y',
        p_parent,
      l_ts_clob_tag_format,
      p_key,
      p_data,
      l_ts_tag_format,
      l_ts_clob_tag_names,
      l_ts_clob_tag_values,
      l_ts_clob_tag_format,
      'S',
       p_is_out_msg_clob
          )
THEN
  dbg('FAILED IN gwpkss_xml_crtr.fn_create_xml');
  RAISE error_exception;
END IF;

-- PA876CLPBFBIMPSUPP-159_18_04_2016 changes ends
p_flag := 0;
dbg('Succcessfully Returned from Function Handler -FlgStatus: ' || p_flag);
RETURN;

EXCEPTION
WHEN error_exception
THEN
  dbg('Inside Error Exception of gwpks_ca_queryaccmove.Pr_Process_Msg');
  l_res_ts_tag_names  := 'BRN>';
  l_res_ts_tag_values := l_recv_ac_dtl.g_branch_code || '~' || '>';

  IF NOT gwpks_error_builder.fn_error_builder
              ( p_instr_rec,
                l_ts_tag_names,
                l_ts_tag_values,
                l_parents_format,
                l_parents_list,
                l_res_ts_tag_names,
                l_res_ts_tag_values,
                l_parents_list,
                l_ts_tag_names,
                l_ts_tag_values,
                l_parents_format
              )
  THEN
    dbg('failed in Error Building..');
    RETURN;
  END IF;

  IF NOT gwpkss_xml_crtr.fn_xml_creator
              ( p_rec_msg_header,
                p_instr_rec,
                p_is_in_msg_clob,
                l_res_parents_list,
                l_res_parents_format,
                l_res_ts_tag_names,
                l_res_ts_tag_values,
                l_res_ts_tag_format,
                l_ts_clob_tag_names,
                l_ts_clob_tag_values,
                l_ts_clob_tag_format,
                'E',
                p_is_out_msg_clob
              )
  THEN
    dbg('FAILED IN gwpkss_xml_crtr.fn_create_xml' || SQLERRM);
    RETURN;
  END IF;

  p_flag      := 0;
  p_err_code  := NULL;
  p_err_param := NULL;
  RETURN;
WHEN OTHERS
THEN
  Dbg(dbms_utility.format_error_backtrace || SQLERRM);
  l_res_ts_tag_names  := l_err_tbl(1).err_code || '~' || '>';
  l_res_ts_tag_values := l_err_tbl(1).params || '~' || '>';

  IF NOT gwpks_error_builder.fn_error_builder
              ( p_instr_rec,
                l_ts_tag_names,
                l_ts_tag_values,
                l_parents_format,
                l_parents_list,
                l_res_ts_tag_names,
                l_res_ts_tag_values,
                l_parents_list,
                l_ts_tag_names,
                l_ts_tag_values,
                l_parents_format
              )
  THEN
    dbg('failed in Error Building..');
    RETURN;
  END IF;

  l_err_tbl.DELETE;
  l_err_tbl(1).err_code := 'GW-ERR002';
  l_err_tbl(1).params := NULL;

  IF NOT gwpkss_xml_crtr.fn_xml_creator
              ( p_rec_msg_header,
                p_instr_rec,
                p_is_in_msg_clob,
                l_res_parents_list,
                l_res_parents_format,
                l_res_ts_tag_names,
                l_res_ts_tag_values,
                l_res_ts_tag_format,
                l_ts_clob_tag_names,
                l_ts_clob_tag_values,
                l_ts_clob_tag_format,
                'E',
                p_is_out_msg_clob
              )
  THEN
    clpkss_logger.pr_log_exception('In When Others of  gwpks_ca_queryaccmove.pr_process_msg..' || SQLERRM);
    RETURN;
  END IF;
END pr_process_msg;

END gwpks_ca_queryaccmove;
/
