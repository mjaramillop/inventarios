﻿using Inventarios.DTO.TablasMaestras;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Data;
using System.Reflection;
using System.Text;
using System.Xml.Linq;

namespace Inventarios.Utils
{
    public class Utilidades
    {
        public int TiempoDeEspera = 600; // 600 segundos

        private readonly IConfiguration _iconfiguration;

        public Utilidades(IConfiguration iconfigutarion)

        {
            _iconfiguration = iconfigutarion;
        }

        public string ejecutarsql(string comando)
        {
            comando = comando.Trim();
            if (comando.Length == 0) return "  ";
            string xmensaje = "";
            SqlConnection xconexion = new SqlConnection(_iconfiguration.GetConnectionString("connectionstring"));
            SqlCommand xcomando = new SqlCommand(comando, xconexion);
            try
            {
                xconexion.Open();
                xcomando.ExecuteNonQuery();
                xconexion.Close();
                xconexion.Dispose();
            }
            catch (Exception e)
            {
                xconexion.Close();
                xconexion.Dispose();
                xmensaje = "Error : " + e.Message.ToString();
            }
            return xmensaje;
        }

        public DataTable creartabla(string comando)
        {
            DataTable table = new DataTable();
            DataSet xdataset = new DataSet();

            SqlConnection xconexion = new SqlConnection(_iconfiguration.GetConnectionString("connectionstring"));
            SqlCommand xcomando = new SqlCommand(comando, xconexion);
            SqlDataAdapter xadaptador = new SqlDataAdapter(comando, xconexion);

            try
            {
                xconexion.Open();
                xadaptador.SelectCommand.CommandTimeout = TiempoDeEspera;
                xadaptador.Fill(xdataset);
                table = xdataset.Tables[0];
            }
            catch (Exception ee)
            {
                string msg = ee.ToString();
                return table;
            }

            xconexion.Close();

            return table;
        }

        public string MontoEscrito(string valor)
        {
            string[] datos = new string[1000];
            datos[0] = "";
            datos[1] = "UN";
            datos[2] = "DOS";
            datos[3] = "TRES";
            datos[4] = "CUATRO";
            datos[5] = "CINCO";
            datos[6] = "SEIS";
            datos[7] = "SIETE";
            datos[8] = "OCHO";
            datos[9] = "NUEVE";
            datos[10] = "DIEZ";
            datos[11] = "ONCE";
            datos[12] = "DOCE";
            datos[13] = "TRECE";
            datos[14] = "CATORCE";
            datos[15] = "QUINCE";
            datos[16] = "DIECISEIS";
            datos[17] = "DIECISIETE";
            datos[18] = "DIECIOCHO";
            datos[19] = "DIECINUEVE";
            datos[20] = "VEINTE";
            datos[21] = "VEINTIUN";
            datos[22] = "VEINTIDÓS";
            datos[23] = "VEINTITRÉS";
            datos[24] = "VEINTICUATRO";
            datos[25] = "VEINTICINCO";
            datos[26] = "VEINTISÉIS";
            datos[27] = "VEINTISIETE";
            datos[28] = "VEINTIOCHO";
            datos[29] = "VEINTINUEVE";
            datos[30] = "TREINTA";
            datos[31] = "TREINTA Y UN";
            datos[32] = "TREINTA Y DOS";
            datos[33] = "TREINTA Y TRES";
            datos[34] = "TREINTA Y CUATRO";
            datos[35] = "TREINTA Y CINCO";
            datos[36] = "TREINTA Y SEIS";
            datos[37] = "TREINTA Y SIETE";
            datos[38] = "TREINTA Y OCHO";
            datos[39] = "TREINTA Y NUEVE";
            datos[40] = "CUARENTA";
            datos[41] = "CUARENTA Y UN";
            datos[42] = "CUARENTA Y DOS";
            datos[43] = "CUARENTA Y TRES";
            datos[44] = "CUARENTA Y CUATRO";
            datos[45] = "CUARENTA Y CINCO";
            datos[46] = "CUARENTA Y SEIS";
            datos[47] = "CUARENTA Y SIETE";
            datos[48] = "CUARENTA Y OCHO";
            datos[49] = "CUARENTA Y NUEVE";
            datos[50] = "CINCUENTA";
            datos[51] = "CINCUENTA Y UN";
            datos[52] = "CINCUENTA Y DOS";
            datos[53] = "CINCUENTA Y TRES";
            datos[54] = "CINCUENTA Y CUATRO";
            datos[55] = "CINCUENTA Y CINCO";
            datos[56] = "CINCUENTA Y SEIS";
            datos[57] = "CINCUENTA Y SIETE";
            datos[58] = "CINCUENTA Y OCHO";
            datos[59] = "CINCUENTA Y NUEVE";
            datos[60] = "SESENTA";
            datos[61] = "SESENTA Y UN";
            datos[62] = "SESENTA Y DOS";
            datos[63] = "SESENTA Y TRES";
            datos[64] = "SESENTA Y CUATRO";
            datos[65] = "SESENTA Y CINCO";
            datos[66] = "SESENTA Y SEIS";
            datos[67] = "SESENTA Y SIETE";
            datos[68] = "SESENTA Y OCHO";
            datos[69] = "SESENTA Y NUEVE";
            datos[70] = "SETENTA";
            datos[71] = "SETENTA Y UN";
            datos[72] = "SETENTA Y DOS";
            datos[73] = "SETENTA Y TRES";
            datos[74] = "SETENTA Y CUATRO";
            datos[75] = "SETENTA Y CINCO";
            datos[76] = "SETENTA Y SEIS";
            datos[77] = "SETENTA Y SIETE";
            datos[78] = "SETENTA Y OCHO";
            datos[79] = "SETENTA Y NUEVE";
            datos[80] = "OCHENTA";
            datos[81] = "OCHENTA Y UN";
            datos[82] = "OCHENTA Y DOS";
            datos[83] = "OCHENTA Y TRES";
            datos[84] = "OCHENTA Y CUATRO";
            datos[85] = "OCHENTA Y CINCO";
            datos[86] = "OCHENTA Y SEIS";
            datos[87] = "OCHENTA Y SIETE";
            datos[88] = "OCHENTA Y OCHO";
            datos[89] = "OCHENTA Y NUEVE";
            datos[90] = "NOVENTA";
            datos[91] = "NOVENTA Y UN";
            datos[92] = "NOVENTA Y DOS";
            datos[93] = "NOVENTA Y TRES";
            datos[94] = "NOVENTA Y CUATRO";
            datos[95] = "NOVENTA Y CINCO";
            datos[96] = "NOVENTA Y SEIS";
            datos[97] = "NOVENTA Y SIETE";
            datos[98] = "NOVENTA Y OCHO";
            datos[99] = "NOVENTA Y NUEVE";
            datos[100] = "CIEN";
            datos[101] = "CIENTO UN";
            datos[102] = "CIENTO DOS";
            datos[103] = "CIENTO TRES";
            datos[104] = "CIENTO CUATRO";
            datos[105] = "CIENTO CINCO";
            datos[106] = "CIENTO SEIS";
            datos[107] = "CIENTO SIETE";
            datos[108] = "CIENTO OCHO";
            datos[109] = "CIENTO NUEVE";
            datos[110] = "CIENTO DIEZ";
            datos[111] = "CIENTO ONCE";
            datos[112] = "CIENTO DOCE";
            datos[113] = "CIENTO TRECE";
            datos[114] = "CIENTO CATORCE";
            datos[115] = "CIENTO QUINCE";
            datos[116] = "CIENTO DIECISEIS";
            datos[117] = "CIENTO DIECISIETE";
            datos[118] = "CIENTO DIECIOCHO";
            datos[119] = "CIENTO DIECINUEVE";
            datos[120] = "CIENTO VEINTE";
            datos[121] = "CIENTO VEINTIUN";
            datos[122] = "CIENTO VEINTIDÓS";
            datos[123] = "CIENTO VEINTITRÉS";
            datos[124] = "CIENTO VEINTICUATRO";
            datos[125] = "CIENTO VEINTICINCO";
            datos[126] = "CIENTO VEINTISÉIS";
            datos[127] = "CIENTO VEINTISIETE";
            datos[128] = "CIENTO VEINTIOCHO";
            datos[129] = "CIENTO VEINTINUEVE";
            datos[130] = "CIENTO TREINTA";
            datos[131] = "CIENTO TREINTA Y UN";
            datos[132] = "CIENTO TREINTA Y DOS";
            datos[133] = "CIENTO TREINTA Y TRES";
            datos[134] = "CIENTO TREINTA Y CUATRO";
            datos[135] = "CIENTO TREINTA Y CINCO";
            datos[136] = "CIENTO TREINTA Y SEIS";
            datos[137] = "CIENTO TREINTA Y SIETE";
            datos[138] = "CIENTO TREINTA Y OCHO";
            datos[139] = "CIENTO TREINTA Y NUEVE";
            datos[140] = "CIENTO CUARENTA";
            datos[141] = "CIENTO CUARENTA Y UN";
            datos[142] = "CIENTO CUARENTA Y DOS";
            datos[143] = "CIENTO CUARENTA Y TRES";
            datos[144] = "CIENTO CUARENTA Y CUATRO";
            datos[145] = "CIENTO CUARENTA Y CINCO";
            datos[146] = "CIENTO CUARENTA Y SEIS";
            datos[147] = "CIENTO CUARENTA Y SIETE";
            datos[148] = "CIENTO CUARENTA Y OCHO";
            datos[149] = "CIENTO CUARENTA Y NUEVE";
            datos[150] = "CIENTO CINCUENTA";
            datos[151] = "CIENTO CINCUENTA Y UN";
            datos[152] = "CIENTO CINCUENTA Y DOS";
            datos[153] = "CIENTO CINCUENTA Y TRES";
            datos[154] = "CIENTO CINCUENTA Y CUATRO";
            datos[155] = "CIENTO CINCUENTA Y CINCO";
            datos[156] = "CIENTO CINCUENTA Y SEIS";
            datos[157] = "CIENTO CINCUENTA Y SIETE";
            datos[158] = "CIENTO CINCUENTA Y OCHO";
            datos[159] = "CIENTO CINCUENTA Y NUEVE";
            datos[160] = "CIENTO SESENTA";
            datos[161] = "CIENTO SESENTA Y UN";
            datos[162] = "CIENTO SESENTA Y DOS";
            datos[163] = "CIENTO SESENTA Y TRES";
            datos[164] = "CIENTO SESENTA Y CUATRO";
            datos[165] = "CIENTO SESENTA Y CINCO";
            datos[166] = "CIENTO SESENTA Y SEIS";
            datos[167] = "CIENTO SESENTA Y SIETE";
            datos[168] = "CIENTO SESENTA Y OCHO";
            datos[169] = "CIENTO SESENTA Y NUEVE";
            datos[170] = "CIENTO SETENTA";
            datos[171] = "CIENTO SETENTA Y UN";
            datos[172] = "CIENTO SETENTA Y DOS";
            datos[173] = "CIENTO SETENTA Y TRES";
            datos[174] = "CIENTO SETENTA Y CUATRO";
            datos[175] = "CIENTO SETENTA Y CINCO";
            datos[176] = "CIENTO SETENTA Y SEIS";
            datos[177] = "CIENTO SETENTA Y SIETE";
            datos[178] = "CIENTO SETENTA Y OCHO";
            datos[179] = "CIENTO SETENTA Y NUEVE";
            datos[180] = "CIENTO OCHENTA";
            datos[181] = "CIENTO OCHENTA Y UN";
            datos[182] = "CIENTO OCHENTA Y DOS";
            datos[183] = "CIENTO OCHENTA Y TRES";
            datos[184] = "CIENTO OCHENTA Y CUATRO";
            datos[185] = "CIENTO OCHENTA Y CINCO";
            datos[186] = "CIENTO OCHENTA Y SEIS";
            datos[187] = "CIENTO OCHENTA Y SIETE";
            datos[188] = "CIENTO OCHENTA Y OCHO";
            datos[189] = "CIENTO OCHENTA Y NUEVE";
            datos[190] = "CIENTO NOVENTA";
            datos[191] = "CIENTO NOVENTA Y UN";
            datos[192] = "CIENTO NOVENTA Y DOS";
            datos[193] = "CIENTO NOVENTA Y TRES";
            datos[194] = "CIENTO NOVENTA Y CUATRO";
            datos[195] = "CIENTO NOVENTA Y CINCO";
            datos[196] = "CIENTO NOVENTA Y SEIS";
            datos[197] = "CIENTO NOVENTA Y SIETE";
            datos[198] = "CIENTO NOVENTA Y OCHO";
            datos[200] = "DOSCIENTOS";
            datos[201] = "DOSCIENTOS UN";
            datos[202] = "DOSCIENTOS DOS";
            datos[203] = "DOSCIENTOS TRES";
            datos[204] = "DOSCIENTOS CUATRO";
            datos[205] = "DOSCIENTOS CINCO";
            datos[206] = "DOSCIENTOS SEIS";
            datos[207] = "DOSCIENTOS SIETE";
            datos[208] = "DOSCIENTOS OCHO";
            datos[209] = "DOSCIENTOS NUEVE";
            datos[210] = "DOSCIENTOS DIEZ";
            datos[211] = "DOSCIENTOS ONCE";
            datos[212] = "DOSCIENTOS DOCE";
            datos[213] = "DOSCIENTOS TRECE";
            datos[214] = "DOSCIENTOS CATORCE";
            datos[215] = "DOSCIENTOS QUINCE";
            datos[216] = "DOSCIENTOS DIECISEIS";
            datos[217] = "DOSCIENTOS DIECISIETE";
            datos[218] = "DOSCIENTOS DIECIOCHO";
            datos[219] = "DOSCIENTOS DIECINUEVE";
            datos[220] = "DOSCIENTOS VEINTE";
            datos[221] = "DOSCIENTOS VEINTIUN";
            datos[222] = "DOSCIENTOS VEINTIDÓS";
            datos[223] = "DOSCIENTOS VEINTITRÉS";
            datos[224] = "DOSCIENTOS VEINTICUATRO";
            datos[225] = "DOSCIENTOS VEINTICINCO";
            datos[226] = "DOSCIENTOS VEINTISÉIS";
            datos[227] = "DOSCIENTOS VEINTISIETE";
            datos[228] = "DOSCIENTOS VEINTIOCHO";
            datos[229] = "DOSCIENTOS VEINTINUEVE";
            datos[230] = "DOSCIENTOS TREINTA";
            datos[231] = "DOSCIENTOS TREINTA Y UN";
            datos[232] = "DOSCIENTOS TREINTA Y DOS";
            datos[233] = "DOSCIENTOS TREINTA Y TRES";
            datos[234] = "DOSCIENTOS TREINTA Y CUATRO";
            datos[235] = "DOSCIENTOS TREINTA Y CINCO";
            datos[236] = "DOSCIENTOS TREINTA Y SEIS";
            datos[237] = "DOSCIENTOS TREINTA Y SIETE";
            datos[238] = "DOSCIENTOS TREINTA Y OCHO";
            datos[239] = "DOSCIENTOS TREINTA Y NUEVE";
            datos[240] = "DOSCIENTOS CUARENTA";
            datos[241] = "DOSCIENTOS CUARENTA Y UN";
            datos[242] = "DOSCIENTOS CUARENTA Y DOS";
            datos[243] = "DOSCIENTOS CUARENTA Y TRES";
            datos[244] = "DOSCIENTOS CUARENTA Y CUATRO";
            datos[245] = "DOSCIENTOS CUARENTA Y CINCO";
            datos[246] = "DOSCIENTOS CUARENTA Y SEIS";
            datos[247] = "DOSCIENTOS CUARENTA Y SIETE";
            datos[248] = "DOSCIENTOS CUARENTA Y OCHO";
            datos[249] = "DOSCIENTOS CUARENTA Y NUEVE";
            datos[250] = "DOSCIENTOS CINCUENTA";
            datos[251] = "DOSCIENTOS CINCUENTA Y UN";
            datos[252] = "DOSCIENTOS CINCUENTA Y DOS";
            datos[253] = "DOSCIENTOS CINCUENTA Y TRES";
            datos[254] = "DOSCIENTOS CINCUENTA Y CUATRO";
            datos[255] = "DOSCIENTOS CINCUENTA Y CINCO";
            datos[256] = "DOSCIENTOS CINCUENTA Y SEIS";
            datos[257] = "DOSCIENTOS CINCUENTA Y SIETE";
            datos[258] = "DOSCIENTOS CINCUENTA Y OCHO";
            datos[259] = "DOSCIENTOS CINCUENTA Y NUEVE";
            datos[260] = "DOSCIENTOS SESENTA";
            datos[261] = "DOSCIENTOS SESENTA Y UN";
            datos[262] = "DOSCIENTOS SESENTA Y DOS";
            datos[263] = "DOSCIENTOS SESENTA Y TRES";
            datos[264] = "DOSCIENTOS SESENTA Y CUATRO";
            datos[265] = "DOSCIENTOS SESENTA Y CINCO";
            datos[266] = "DOSCIENTOS SESENTA Y SEIS";
            datos[267] = "DOSCIENTOS SESENTA Y SIETE";
            datos[268] = "DOSCIENTOS SESENTA Y OCHO";
            datos[269] = "DOSCIENTOS SESENTA Y NUEVE";
            datos[270] = "DOSCIENTOS SETENTA";
            datos[271] = "DOSCIENTOS SETENTA Y UN";
            datos[272] = "DOSCIENTOS SETENTA Y DOS";
            datos[273] = "DOSCIENTOS SETENTA Y TRES";
            datos[274] = "DOSCIENTOS SETENTA Y CUATRO";
            datos[275] = "DOSCIENTOS SETENTA Y CINCO";
            datos[276] = "DOSCIENTOS SETENTA Y SEIS";
            datos[277] = "DOSCIENTOS SETENTA Y SIETE";
            datos[278] = "DOSCIENTOS SETENTA Y OCHO";
            datos[279] = "DOSCIENTOS SETENTA Y NUEVE";
            datos[280] = "DOSCIENTOS OCHENTA";
            datos[281] = "DOSCIENTOS OCHENTA Y UN";
            datos[282] = "DOSCIENTOS OCHENTA Y DOS";
            datos[283] = "DOSCIENTOS OCHENTA Y TRES";
            datos[284] = "DOSCIENTOS OCHENTA Y CUATRO";
            datos[285] = "DOSCIENTOS OCHENTA Y CINCO";
            datos[286] = "DOSCIENTOS OCHENTA Y SEIS";
            datos[287] = "DOSCIENTOS OCHENTA Y SIETE";
            datos[288] = "DOSCIENTOS OCHENTA Y OCHO";
            datos[289] = "DOSCIENTOS OCHENTA Y NUEVE";
            datos[290] = "DOSCIENTOS NOVENTA";
            datos[291] = "DOSCIENTOS NOVENTA Y UN";
            datos[292] = "DOSCIENTOS NOVENTA Y DOS";
            datos[293] = "DOSCIENTOS NOVENTA Y TRES";
            datos[294] = "DOSCIENTOS NOVENTA Y CUATRO";
            datos[295] = "DOSCIENTOS NOVENTA Y CINCO";
            datos[296] = "DOSCIENTOS NOVENTA Y SEIS";
            datos[297] = "DOSCIENTOS NOVENTA Y SIETE";
            datos[298] = "DOSCIENTOS NOVENTA Y OCHO";
            datos[299] = "DOSCIENTOS NOVENTA Y NUEVE";
            datos[300] = "TRESCIENTOS";
            datos[301] = "TRESCIENTOS UN";
            datos[302] = "TRESCIENTOS DOS";
            datos[303] = "TRESCIENTOS TRES";
            datos[304] = "TRESCIENTOS CUATRO";
            datos[305] = "TRESCIENTOS CINCO";
            datos[306] = "TRESCIENTOS SEIS";
            datos[307] = "TRESCIENTOS SIETE";
            datos[308] = "TRESCIENTOS OCHO";
            datos[309] = "TRESCIENTOS NUEVE";
            datos[310] = "TRESCIENTOS DIEZ";
            datos[311] = "TRESCIENTOS ONCE";
            datos[312] = "TRESCIENTOS DOCE";
            datos[313] = "TRESCIENTOS TRECE";
            datos[314] = "TRESCIENTOS CATORCE";
            datos[315] = "TRESCIENTOS QUINCE";
            datos[316] = "TRESCIENTOS DIECISEIS";
            datos[317] = "TRESCIENTOS DIECISIETE";
            datos[318] = "TRESCIENTOS DIECIOCHO";
            datos[319] = "TRESCIENTOS DIECINUEVE";
            datos[320] = "TRESCIENTOS VEINTE";
            datos[321] = "TRESCIENTOS VEINTIUN";
            datos[322] = "TRESCIENTOS VEINTIDÓS";
            datos[323] = "TRESCIENTOS VEINTITRÉS";
            datos[324] = "TRESCIENTOS VEINTICUATRO";
            datos[325] = "TRESCIENTOS VEINTICINCO";
            datos[326] = "TRESCIENTOS VEINTISÉIS";
            datos[327] = "TRESCIENTOS VEINTISIETE";
            datos[328] = "TRESCIENTOS VEINTIOCHO";
            datos[329] = "TRESCIENTOS VEINTINUEVE";
            datos[330] = "TRESCIENTOS TREINTA";
            datos[331] = "TRESCIENTOS TREINTA Y UN";
            datos[332] = "TRESCIENTOS TREINTA Y DOS";
            datos[333] = "TRESCIENTOS TREINTA Y TRES";
            datos[334] = "TRESCIENTOS TREINTA Y CUATRO";
            datos[335] = "TRESCIENTOS TREINTA Y CINCO";
            datos[336] = "TRESCIENTOS TREINTA Y SEIS";
            datos[337] = "TRESCIENTOS TREINTA Y SIETE";
            datos[338] = "TRESCIENTOS TREINTA Y OCHO";
            datos[339] = "TRESCIENTOS TREINTA Y NUEVE";
            datos[340] = "TRESCIENTOS CUARENTA";
            datos[341] = "TRESCIENTOS CUARENTA Y UN";
            datos[342] = "TRESCIENTOS CUARENTA Y DOS";
            datos[343] = "TRESCIENTOS CUARENTA Y TRES";
            datos[344] = "TRESCIENTOS CUARENTA Y CUATRO";
            datos[345] = "TRESCIENTOS CUARENTA Y CINCO";
            datos[346] = "TRESCIENTOS CUARENTA Y SEIS";
            datos[347] = "TRESCIENTOS CUARENTA Y SIETE";
            datos[348] = "TRESCIENTOS CUARENTA Y OCHO";
            datos[349] = "TRESCIENTOS CUARENTA Y NUEVE";
            datos[350] = "TRESCIENTOS CINCUENTA";
            datos[351] = "TRESCIENTOS CINCUENTA Y UN";
            datos[352] = "TRESCIENTOS CINCUENTA Y DOS";
            datos[353] = "TRESCIENTOS CINCUENTA Y TRES";
            datos[354] = "TRESCIENTOS CINCUENTA Y CUATRO";
            datos[355] = "TRESCIENTOS CINCUENTA Y CINCO";
            datos[356] = "TRESCIENTOS CINCUENTA Y SEIS";
            datos[357] = "TRESCIENTOS CINCUENTA Y SIETE";
            datos[358] = "TRESCIENTOS CINCUENTA Y OCHO";
            datos[359] = "TRESCIENTOS CINCUENTA Y NUEVE";
            datos[360] = "TRESCIENTOS SESENTA";
            datos[361] = "TRESCIENTOS SESENTA Y UN";
            datos[362] = "TRESCIENTOS SESENTA Y DOS";
            datos[363] = "TRESCIENTOS SESENTA Y TRES";
            datos[364] = "TRESCIENTOS SESENTA Y CUATRO";
            datos[365] = "TRESCIENTOS SESENTA Y CINCO";
            datos[366] = "TRESCIENTOS SESENTA Y SEIS";
            datos[367] = "TRESCIENTOS SESENTA Y SIETE";
            datos[368] = "TRESCIENTOS SESENTA Y OCHO";
            datos[369] = "TRESCIENTOS SESENTA Y NUEVE";
            datos[370] = "TRESCIENTOS SETENTA";
            datos[371] = "TRESCIENTOS SETENTA Y UN";
            datos[372] = "TRESCIENTOS SETENTA Y DOS";
            datos[373] = "TRESCIENTOS SETENTA Y TRES";
            datos[374] = "TRESCIENTOS SETENTA Y CUATRO";
            datos[375] = "TRESCIENTOS SETENTA Y CINCO";
            datos[376] = "TRESCIENTOS SETENTA Y SEIS";
            datos[377] = "TRESCIENTOS SETENTA Y SIETE";
            datos[378] = "TRESCIENTOS SETENTA Y OCHO";
            datos[379] = "TRESCIENTOS SETENTA Y NUEVE";
            datos[380] = "TRESCIENTOS OCHENTA";
            datos[381] = "TRESCIENTOS OCHENTA Y UN";
            datos[382] = "TRESCIENTOS OCHENTA Y DOS";
            datos[383] = "TRESCIENTOS OCHENTA Y TRES";
            datos[384] = "TRESCIENTOS OCHENTA Y CUATRO";
            datos[385] = "TRESCIENTOS OCHENTA Y CINCO";
            datos[386] = "TRESCIENTOS OCHENTA Y SEIS";
            datos[387] = "TRESCIENTOS OCHENTA Y SIETE";
            datos[388] = "TRESCIENTOS OCHENTA Y OCHO";
            datos[389] = "TRESCIENTOS OCHENTA Y NUEVE";
            datos[390] = "TRESCIENTOS NOVENTA";
            datos[391] = "TRESCIENTOS NOVENTA Y UN";
            datos[392] = "TRESCIENTOS NOVENTA Y DOS";
            datos[393] = "TRESCIENTOS NOVENTA Y TRES";
            datos[394] = "TRESCIENTOS NOVENTA Y CUATRO";
            datos[395] = "TRESCIENTOS NOVENTA Y CINCO";
            datos[396] = "TRESCIENTOS NOVENTA Y SEIS";
            datos[397] = "TRESCIENTOS NOVENTA Y SIETE";
            datos[398] = "TRESCIENTOS NOVENTA Y OCHO";
            datos[399] = "TRESCIENTOS NOVENTA Y NUEVE";
            datos[400] = "CUATROCIENTOS";
            datos[401] = "CUATROCIENTOS UN";
            datos[402] = "CUATROCIENTOS DOS";
            datos[403] = "CUATROCIENTOS TRES";
            datos[404] = "CUATROCIENTOS CUATRO";
            datos[405] = "CUATROCIENTOS CINCO";
            datos[406] = "CUATROCIENTOS SEIS";
            datos[407] = "CUATROCIENTOS SIETE";
            datos[408] = "CUATROCIENTOS OCHO";
            datos[409] = "CUATROCIENTOS NUEVE";
            datos[410] = "CUATROCIENTOS DIEZ";
            datos[411] = "CUATROCIENTOS ONCE";
            datos[412] = "CUATROCIENTOS DOCE";
            datos[413] = "CUATROCIENTOS TRECE";
            datos[414] = "CUATROCIENTOS CATORCE";
            datos[415] = "CUATROCIENTOS QUINCE";
            datos[416] = "CUATROCIENTOS DIECISEIS";
            datos[417] = "CUATROCIENTOS DIECISIETE";
            datos[418] = "CUATROCIENTOS DIECIOCHO";
            datos[419] = "CUATROCIENTOS DIECINUEVE";
            datos[420] = "CUATROCIENTOS VEINTE";
            datos[421] = "CUATROCIENTOS VEINTIUN";
            datos[422] = "CUATROCIENTOS VEINTIDÓS";
            datos[423] = "CUATROCIENTOS VEINTITRÉS";
            datos[424] = "CUATROCIENTOS VEINTICUATRO";
            datos[425] = "CUATROCIENTOS VEINTICINCO";
            datos[426] = "CUATROCIENTOS VEINTISÉIS";
            datos[427] = "CUATROCIENTOS VEINTISIETE";
            datos[428] = "CUATROCIENTOS VEINTIOCHO";
            datos[429] = "CUATROCIENTOS VEINTINUEVE";
            datos[430] = "CUATROCIENTOS TREINTA";
            datos[431] = "CUATROCIENTOS TREINTA Y UN";
            datos[432] = "CUATROCIENTOS TREINTA Y DOS";
            datos[433] = "CUATROCIENTOS TREINTA Y TRES";
            datos[434] = "CUATROCIENTOS TREINTA Y CUATRO";
            datos[435] = "CUATROCIENTOS TREINTA Y CINCO";
            datos[436] = "CUATROCIENTOS TREINTA Y SEIS";
            datos[437] = "CUATROCIENTOS TREINTA Y SIETE";
            datos[438] = "CUATROCIENTOS TREINTA Y OCHO";
            datos[439] = "CUATROCIENTOS TREINTA Y NUEVE";
            datos[440] = "CUATROCIENTOS CUARENTA";
            datos[441] = "CUATROCIENTOS CUARENTA Y UN";
            datos[442] = "CUATROCIENTOS CUARENTA Y DOS";
            datos[443] = "CUATROCIENTOS CUARENTA Y TRES";
            datos[444] = "CUATROCIENTOS CUARENTA Y CUATRO";
            datos[445] = "CUATROCIENTOS CUARENTA Y CINCO";
            datos[446] = "CUATROCIENTOS CUARENTA Y SEIS";
            datos[447] = "CUATROCIENTOS CUARENTA Y SIETE";
            datos[448] = "CUATROCIENTOS CUARENTA Y OCHO";
            datos[449] = "CUATROCIENTOS CUARENTA Y NUEVE";
            datos[450] = "CUATROCIENTOS CINCUENTA";
            datos[451] = "CUATROCIENTOS CINCUENTA Y UN";
            datos[452] = "CUATROCIENTOS CINCUENTA Y DOS";
            datos[453] = "CUATROCIENTOS CINCUENTA Y TRES";
            datos[454] = "CUATROCIENTOS CINCUENTA Y CUATRO";
            datos[455] = "CUATROCIENTOS CINCUENTA Y CINCO";
            datos[456] = "CUATROCIENTOS CINCUENTA Y SEIS";
            datos[457] = "CUATROCIENTOS CINCUENTA Y SIETE";
            datos[458] = "CUATROCIENTOS CINCUENTA Y OCHO";
            datos[459] = "CUATROCIENTOS CINCUENTA Y NUEVE";
            datos[460] = "CUATROCIENTOS SESENTA";
            datos[461] = "CUATROCIENTOS SESENTA Y UN";
            datos[462] = "CUATROCIENTOS SESENTA Y DOS";
            datos[463] = "CUATROCIENTOS SESENTA Y TRES";
            datos[464] = "CUATROCIENTOS SESENTA Y CUATRO";
            datos[465] = "CUATROCIENTOS SESENTA Y CINCO";
            datos[466] = "CUATROCIENTOS SESENTA Y SEIS";
            datos[467] = "CUATROCIENTOS SESENTA Y SIETE";
            datos[468] = "CUATROCIENTOS SESENTA Y OCHO";
            datos[469] = "CUATROCIENTOS SESENTA Y NUEVE";
            datos[470] = "CUATROCIENTOS SETENTA";
            datos[471] = "CUATROCIENTOS SETENTA Y UN";
            datos[472] = "CUATROCIENTOS SETENTA Y DOS";
            datos[473] = "CUATROCIENTOS SETENTA Y TRES";
            datos[474] = "CUATROCIENTOS SETENTA Y CUATRO";
            datos[475] = "CUATROCIENTOS SETENTA Y CINCO";
            datos[476] = "CUATROCIENTOS SETENTA Y SEIS";
            datos[477] = "CUATROCIENTOS SETENTA Y SIETE";
            datos[478] = "CUATROCIENTOS SETENTA Y OCHO";
            datos[479] = "CUATROCIENTOS SETENTA Y NUEVE";
            datos[480] = "CUATROCIENTOS OCHENTA";
            datos[481] = "CUATROCIENTOS OCHENTA Y UN";
            datos[482] = "CUATROCIENTOS OCHENTA Y DOS";
            datos[483] = "CUATROCIENTOS OCHENTA Y TRES";
            datos[484] = "CUATROCIENTOS OCHENTA Y CUATRO";
            datos[485] = "CUATROCIENTOS OCHENTA Y CINCO";
            datos[486] = "CUATROCIENTOS OCHENTA Y SEIS";
            datos[487] = "CUATROCIENTOS OCHENTA Y SIETE";
            datos[488] = "CUATROCIENTOS OCHENTA Y OCHO";
            datos[489] = "CUATROCIENTOS OCHENTA Y NUEVE";
            datos[490] = "CUATROCIENTOS NOVENTA";
            datos[491] = "CUATROCIENTOS NOVENTA Y UN";
            datos[492] = "CUATROCIENTOS NOVENTA Y DOS";
            datos[493] = "CUATROCIENTOS NOVENTA Y TRES";
            datos[494] = "CUATROCIENTOS NOVENTA Y CUATRO";
            datos[495] = "CUATROCIENTOS NOVENTA Y CINCO";
            datos[496] = "CUATROCIENTOS NOVENTA Y SEIS";
            datos[497] = "CUATROCIENTOS NOVENTA Y SIETE";
            datos[498] = "CUATROCIENTOS NOVENTA Y OCHO";
            datos[499] = "CUATROCIENTOS NOVENTA Y NUEVE";
            datos[500] = "QUINIENTOS";
            datos[501] = "QUINIENTOS UN";
            datos[502] = "QUINIENTOS DOS";
            datos[503] = "QUINIENTOS TRES";
            datos[504] = "QUINIENTOS CUATRO";
            datos[505] = "QUINIENTOS CINCO";
            datos[506] = "QUINIENTOS SEIS";
            datos[507] = "QUINIENTOS SIETE";
            datos[508] = "QUINIENTOS OCHO";
            datos[509] = "QUINIENTOS NUEVE";
            datos[510] = "QUINIENTOS DIEZ";
            datos[511] = "QUINIENTOS ONCE";
            datos[512] = "QUINIENTOS DOCE";
            datos[513] = "QUINIENTOS TRECE";
            datos[514] = "QUINIENTOS CATORCE";
            datos[515] = "QUINIENTOS QUINCE";
            datos[516] = "QUINIENTOS DIECISEIS";
            datos[517] = "QUINIENTOS DIECISIETE";
            datos[518] = "QUINIENTOS DIECIOCHO";
            datos[519] = "QUINIENTOS DIECINUEVE";
            datos[520] = "QUINIENTOS VEINTE";
            datos[521] = "QUINIENTOS VEINTIUN";
            datos[522] = "QUINIENTOS VEINTIDÓS";
            datos[523] = "QUINIENTOS VEINTITRÉS";
            datos[524] = "QUINIENTOS VEINTICUATRO";
            datos[525] = "QUINIENTOS VEINTICINCO";
            datos[526] = "QUINIENTOS VEINTISÉIS";
            datos[527] = "QUINIENTOS VEINTISIETE";
            datos[528] = "QUINIENTOS VEINTIOCHO";
            datos[529] = "QUINIENTOS VEINTINUEVE";
            datos[530] = "QUINIENTOS TREINTA";
            datos[531] = "QUINIENTOS TREINTA Y UN";
            datos[532] = "QUINIENTOS TREINTA Y DOS";
            datos[533] = "QUINIENTOS TREINTA Y TRES";
            datos[534] = "QUINIENTOS TREINTA Y CUATRO";
            datos[535] = "QUINIENTOS TREINTA Y CINCO";
            datos[536] = "QUINIENTOS TREINTA Y SEIS";
            datos[537] = "QUINIENTOS TREINTA Y SIETE";
            datos[538] = "QUINIENTOS TREINTA Y OCHO";
            datos[539] = "QUINIENTOS TREINTA Y NUEVE";
            datos[540] = "QUINIENTOS CUARENTA";
            datos[541] = "QUINIENTOS CUARENTA Y UN";
            datos[542] = "QUINIENTOS CUARENTA Y DOS";
            datos[543] = "QUINIENTOS CUARENTA Y TRES";
            datos[544] = "QUINIENTOS CUARENTA Y CUATRO";
            datos[545] = "QUINIENTOS CUARENTA Y CINCO";
            datos[546] = "QUINIENTOS CUARENTA Y SEIS";
            datos[547] = "QUINIENTOS CUARENTA Y SIETE";
            datos[548] = "QUINIENTOS CUARENTA Y OCHO";
            datos[549] = "QUINIENTOS CUARENTA Y NUEVE";
            datos[550] = "QUINIENTOS CINCUENTA";
            datos[551] = "QUINIENTOS CINCUENTA Y UN";
            datos[552] = "QUINIENTOS CINCUENTA Y DOS";
            datos[553] = "QUINIENTOS CINCUENTA Y TRES";
            datos[554] = "QUINIENTOS CINCUENTA Y CUATRO";
            datos[555] = "QUINIENTOS CINCUENTA Y CINCO";
            datos[556] = "QUINIENTOS CINCUENTA Y SEIS";
            datos[557] = "QUINIENTOS CINCUENTA Y SIETE";
            datos[558] = "QUINIENTOS CINCUENTA Y OCHO";
            datos[559] = "QUINIENTOS CINCUENTA Y NUEVE";
            datos[560] = "QUINIENTOS SESENTA";
            datos[561] = "QUINIENTOS SESENTA Y UN";
            datos[562] = "QUINIENTOS SESENTA Y DOS";
            datos[563] = "QUINIENTOS SESENTA Y TRES";
            datos[564] = "QUINIENTOS SESENTA Y CUATRO";
            datos[565] = "QUINIENTOS SESENTA Y CINCO";
            datos[566] = "QUINIENTOS SESENTA Y SEIS";
            datos[567] = "QUINIENTOS SESENTA Y SIETE";
            datos[568] = "QUINIENTOS SESENTA Y OCHO";
            datos[569] = "QUINIENTOS SESENTA Y NUEVE";
            datos[570] = "QUINIENTOS SETENTA";
            datos[571] = "QUINIENTOS SETENTA Y UN";
            datos[572] = "QUINIENTOS SETENTA Y DOS";
            datos[573] = "QUINIENTOS SETENTA Y TRES";
            datos[574] = "QUINIENTOS SETENTA Y CUATRO";
            datos[575] = "QUINIENTOS SETENTA Y CINCO";
            datos[576] = "QUINIENTOS SETENTA Y SEIS";
            datos[577] = "QUINIENTOS SETENTA Y SIETE";
            datos[578] = "QUINIENTOS SETENTA Y OCHO";
            datos[579] = "QUINIENTOS SETENTA Y NUEVE";
            datos[580] = "QUINIENTOS OCHENTA";
            datos[581] = "QUINIENTOS OCHENTA Y UN";
            datos[582] = "QUINIENTOS OCHENTA Y DOS";
            datos[583] = "QUINIENTOS OCHENTA Y TRES";
            datos[584] = "QUINIENTOS OCHENTA Y CUATRO";
            datos[585] = "QUINIENTOS OCHENTA Y CINCO";
            datos[586] = "QUINIENTOS OCHENTA Y SEIS";
            datos[587] = "QUINIENTOS OCHENTA Y SIETE";
            datos[588] = "QUINIENTOS OCHENTA Y OCHO";
            datos[589] = "QUINIENTOS OCHENTA Y NUEVE";
            datos[590] = "QUINIENTOS NOVENTA";
            datos[591] = "QUINIENTOS NOVENTA Y UN";
            datos[592] = "QUINIENTOS NOVENTA Y DOS";
            datos[593] = "QUINIENTOS NOVENTA Y TRES";
            datos[594] = "QUINIENTOS NOVENTA Y CUATRO";
            datos[595] = "QUINIENTOS NOVENTA Y CINCO";
            datos[596] = "QUINIENTOS NOVENTA Y SEIS";
            datos[597] = "QUINIENTOS NOVENTA Y SIETE";
            datos[598] = "QUINIENTOS NOVENTA Y OCHO";
            datos[599] = "QUINIENTOS NOVENTA Y NUEVE";
            datos[600] = "SEISCIENTOS";
            datos[601] = "SEISCIENTOS UN";
            datos[602] = "SEISCIENTOS DOS";
            datos[603] = "SEISCIENTOS TRES";
            datos[604] = "SEISCIENTOS CUATRO";
            datos[605] = "SEISCIENTOS CINCO";
            datos[606] = "SEISCIENTOS SEIS";
            datos[607] = "SEISCIENTOS SIETE";
            datos[608] = "SEISCIENTOS OCHO";
            datos[609] = "SEISCIENTOS NUEVE";
            datos[610] = "SEISCIENTOS DIEZ";
            datos[611] = "SEISCIENTOS ONCE";
            datos[612] = "SEISCIENTOS DOCE";
            datos[613] = "SEISCIENTOS TRECE";
            datos[614] = "SEISCIENTOS CATORCE";
            datos[615] = "SEISCIENTOS QUINCE";
            datos[616] = "SEISCIENTOS DIECISEIS";
            datos[617] = "SEISCIENTOS DIECISIETE";
            datos[618] = "SEISCIENTOS DIECIOCHO";
            datos[619] = "SEISCIENTOS DIECINUEVE";
            datos[620] = "SEISCIENTOS VEINTE";
            datos[621] = "SEISCIENTOS VEINTIUN";
            datos[622] = "SEISCIENTOS VEINTIDÓS";
            datos[623] = "SEISCIENTOS VEINTITRÉS";
            datos[624] = "SEISCIENTOS VEINTICUATRO";
            datos[625] = "SEISCIENTOS VEINTICINCO";
            datos[626] = "SEISCIENTOS VEINTISÉIS";
            datos[627] = "SEISCIENTOS VEINTISIETE";
            datos[628] = "SEISCIENTOS VEINTIOCHO";
            datos[629] = "SEISCIENTOS VEINTINUEVE";
            datos[630] = "SEISCIENTOS TREINTA";
            datos[631] = "SEISCIENTOS TREINTA Y UN";
            datos[632] = "SEISCIENTOS TREINTA Y DOS";
            datos[633] = "SEISCIENTOS TREINTA Y TRES";
            datos[634] = "SEISCIENTOS TREINTA Y CUATRO";
            datos[635] = "SEISCIENTOS TREINTA Y CINCO";
            datos[636] = "SEISCIENTOS TREINTA Y SEIS";
            datos[637] = "SEISCIENTOS TREINTA Y SIETE";
            datos[638] = "SEISCIENTOS TREINTA Y OCHO";
            datos[639] = "SEISCIENTOS TREINTA Y NUEVE";
            datos[640] = "SEISCIENTOS CUARENTA";
            datos[641] = "SEISCIENTOS CUARENTA Y UN";
            datos[642] = "SEISCIENTOS CUARENTA Y DOS";
            datos[643] = "SEISCIENTOS CUARENTA Y TRES";
            datos[644] = "SEISCIENTOS CUARENTA Y CUATRO";
            datos[645] = "SEISCIENTOS CUARENTA Y CINCO";
            datos[646] = "SEISCIENTOS CUARENTA Y SEIS";
            datos[647] = "SEISCIENTOS CUARENTA Y SIETE";
            datos[648] = "SEISCIENTOS CUARENTA Y OCHO";
            datos[649] = "SEISCIENTOS CUARENTA Y NUEVE";
            datos[650] = "SEISCIENTOS CINCUENTA";
            datos[651] = "SEISCIENTOS CINCUENTA Y UN";
            datos[652] = "SEISCIENTOS CINCUENTA Y DOS";
            datos[653] = "SEISCIENTOS CINCUENTA Y TRES";
            datos[654] = "SEISCIENTOS CINCUENTA Y CUATRO";
            datos[655] = "SEISCIENTOS CINCUENTA Y CINCO";
            datos[656] = "SEISCIENTOS CINCUENTA Y SEIS";
            datos[657] = "SEISCIENTOS CINCUENTA Y SIETE";
            datos[658] = "SEISCIENTOS CINCUENTA Y OCHO";
            datos[659] = "SEISCIENTOS CINCUENTA Y NUEVE";
            datos[660] = "SEISCIENTOS SESENTA";
            datos[661] = "SEISCIENTOS SESENTA Y UN";
            datos[662] = "SEISCIENTOS SESENTA Y DOS";
            datos[663] = "SEISCIENTOS SESENTA Y TRES";
            datos[664] = "SEISCIENTOS SESENTA Y CUATRO";
            datos[665] = "SEISCIENTOS SESENTA Y CINCO";
            datos[666] = "SEISCIENTOS SESENTA Y SEIS";
            datos[667] = "SEISCIENTOS SESENTA Y SIETE";
            datos[668] = "SEISCIENTOS SESENTA Y OCHO";
            datos[669] = "SEISCIENTOS SESENTA Y NUEVE";
            datos[670] = "SEISCIENTOS SETENTA";
            datos[671] = "SEISCIENTOS SETENTA Y UN";
            datos[672] = "SEISCIENTOS SETENTA Y DOS";
            datos[673] = "SEISCIENTOS SETENTA Y TRES";
            datos[674] = "SEISCIENTOS SETENTA Y CUATRO";
            datos[675] = "SEISCIENTOS SETENTA Y CINCO";
            datos[676] = "SEISCIENTOS SETENTA Y SEIS";
            datos[677] = "SEISCIENTOS SETENTA Y SIETE";
            datos[678] = "SEISCIENTOS SETENTA Y OCHO";
            datos[679] = "SEISCIENTOS SETENTA Y NUEVE";
            datos[680] = "SEISCIENTOS OCHENTA";
            datos[681] = "SEISCIENTOS OCHENTA Y UN";
            datos[682] = "SEISCIENTOS OCHENTA Y DOS";
            datos[683] = "SEISCIENTOS OCHENTA Y TRES";
            datos[684] = "SEISCIENTOS OCHENTA Y CUATRO";
            datos[685] = "SEISCIENTOS OCHENTA Y CINCO";
            datos[686] = "SEISCIENTOS OCHENTA Y SEIS";
            datos[687] = "SEISCIENTOS OCHENTA Y SIETE";
            datos[688] = "SEISCIENTOS OCHENTA Y OCHO";
            datos[689] = "SEISCIENTOS OCHENTA Y NUEVE";
            datos[690] = "SEISCIENTOS NOVENTA";
            datos[691] = "SEISCIENTOS NOVENTA Y UN";
            datos[692] = "SEISCIENTOS NOVENTA Y DOS";
            datos[693] = "SEISCIENTOS NOVENTA Y TRES";
            datos[694] = "SEISCIENTOS NOVENTA Y CUATRO";
            datos[695] = "SEISCIENTOS NOVENTA Y CINCO";
            datos[696] = "SEISCIENTOS NOVENTA Y SEIS";
            datos[697] = "SEISCIENTOS NOVENTA Y SIETE";
            datos[698] = "SEISCIENTOS NOVENTA Y OCHO";
            datos[699] = "SEISCIENTOS NOVENTA Y NUEVE";
            datos[700] = "SETECIENTOS";
            datos[701] = "SETECIENTOS UN";
            datos[702] = "SETECIENTOS DOS";
            datos[703] = "SETECIENTOS TRES";
            datos[704] = "SETECIENTOS CUATRO";
            datos[705] = "SETECIENTOS CINCO";
            datos[706] = "SETECIENTOS SEIS";
            datos[707] = "SETECIENTOS SIETE";
            datos[708] = "SETECIENTOS OCHO";
            datos[709] = "SETECIENTOS NUEVE";
            datos[710] = "SETECIENTOS DIEZ";
            datos[711] = "SETECIENTOS ONCE";
            datos[712] = "SETECIENTOS DOCE";
            datos[713] = "SETECIENTOS TRECE";
            datos[714] = "SETECIENTOS CATORCE";
            datos[715] = "SETECIENTOS QUINCE";
            datos[716] = "SETECIENTOS DIECISEIS";
            datos[717] = "SETECIENTOS DIECISIETE";
            datos[718] = "SETECIENTOS DIECIOCHO";
            datos[719] = "SETECIENTOS DIECINUEVE";
            datos[720] = "SETECIENTOS VEINTE";
            datos[721] = "SETECIENTOS VEINTIUN";
            datos[722] = "SETECIENTOS VEINTIDÓS";
            datos[723] = "SETECIENTOS VEINTITRÉS";
            datos[724] = "SETECIENTOS VEINTICUATRO";
            datos[725] = "SETECIENTOS VEINTICINCO";
            datos[726] = "SETECIENTOS VEINTISÉIS";
            datos[727] = "SETECIENTOS VEINTISIETE";
            datos[728] = "SETECIENTOS VEINTIOCHO";
            datos[729] = "SETECIENTOS VEINTINUEVE";
            datos[730] = "SETECIENTOS TREINTA";
            datos[731] = "SETECIENTOS TREINTA Y UN";
            datos[732] = "SETECIENTOS TREINTA Y DOS";
            datos[733] = "SETECIENTOS TREINTA Y TRES";
            datos[734] = "SETECIENTOS TREINTA Y CUATRO";
            datos[735] = "SETECIENTOS TREINTA Y CINCO";
            datos[736] = "SETECIENTOS TREINTA Y SEIS";
            datos[737] = "SETECIENTOS TREINTA Y SIETE";
            datos[738] = "SETECIENTOS TREINTA Y OCHO";
            datos[739] = "SETECIENTOS TREINTA Y NUEVE";
            datos[740] = "SETECIENTOS CUARENTA";
            datos[741] = "SETECIENTOS CUARENTA Y UN";
            datos[742] = "SETECIENTOS CUARENTA Y DOS";
            datos[743] = "SETECIENTOS CUARENTA Y TRES";
            datos[744] = "SETECIENTOS CUARENTA Y CUATRO";
            datos[745] = "SETECIENTOS CUARENTA Y CINCO";
            datos[746] = "SETECIENTOS CUARENTA Y SEIS";
            datos[747] = "SETECIENTOS CUARENTA Y SIETE";
            datos[748] = "SETECIENTOS CUARENTA Y OCHO";
            datos[749] = "SETECIENTOS CUARENTA Y NUEVE";
            datos[750] = "SETECIENTOS CINCUENTA";
            datos[751] = "SETECIENTOS CINCUENTA Y UN";
            datos[752] = "SETECIENTOS CINCUENTA Y DOS";
            datos[753] = "SETECIENTOS CINCUENTA Y TRES";
            datos[754] = "SETECIENTOS CINCUENTA Y CUATRO";
            datos[755] = "SETECIENTOS CINCUENTA Y CINCO";
            datos[756] = "SETECIENTOS CINCUENTA Y SEIS";
            datos[757] = "SETECIENTOS CINCUENTA Y SIETE";
            datos[758] = "SETECIENTOS CINCUENTA Y OCHO";
            datos[759] = "SETECIENTOS CINCUENTA Y NUEVE";
            datos[760] = "SETECIENTOS SESENTA";
            datos[761] = "SETECIENTOS SESENTA Y UN";
            datos[762] = "SETECIENTOS SESENTA Y DOS";
            datos[763] = "SETECIENTOS SESENTA Y TRES";
            datos[764] = "SETECIENTOS SESENTA Y CUATRO";
            datos[765] = "SETECIENTOS SESENTA Y CINCO";
            datos[766] = "SETECIENTOS SESENTA Y SEIS";
            datos[767] = "SETECIENTOS SESENTA Y SIETE";
            datos[768] = "SETECIENTOS SESENTA Y OCHO";
            datos[769] = "SETECIENTOS SESENTA Y NUEVE";
            datos[770] = "SETECIENTOS SETENTA";
            datos[771] = "SETECIENTOS SETENTA Y UN";
            datos[772] = "SETECIENTOS SETENTA Y DOS";
            datos[773] = "SETECIENTOS SETENTA Y TRES";
            datos[774] = "SETECIENTOS SETENTA Y CUATRO";
            datos[775] = "SETECIENTOS SETENTA Y CINCO";
            datos[776] = "SETECIENTOS SETENTA Y SEIS";
            datos[777] = "SETECIENTOS SETENTA Y SIETE";
            datos[778] = "SETECIENTOS SETENTA Y OCHO";
            datos[779] = "SETECIENTOS SETENTA Y NUEVE";
            datos[780] = "SETECIENTOS OCHENTA";
            datos[781] = "SETECIENTOS OCHENTA Y UN";
            datos[782] = "SETECIENTOS OCHENTA Y DOS";
            datos[783] = "SETECIENTOS OCHENTA Y TRES";
            datos[784] = "SETECIENTOS OCHENTA Y CUATRO";
            datos[785] = "SETECIENTOS OCHENTA Y CINCO";
            datos[786] = "SETECIENTOS OCHENTA Y SEIS";
            datos[787] = "SETECIENTOS OCHENTA Y SIETE";
            datos[788] = "SETECIENTOS OCHENTA Y OCHO";
            datos[789] = "SETECIENTOS OCHENTA Y NUEVE";
            datos[790] = "SETECIENTOS NOVENTA";
            datos[791] = "SETECIENTOS NOVENTA Y UN";
            datos[792] = "SETECIENTOS NOVENTA Y DOS";
            datos[793] = "SETECIENTOS NOVENTA Y TRES";
            datos[794] = "SETECIENTOS NOVENTA Y CUATRO";
            datos[795] = "SETECIENTOS NOVENTA Y CINCO";
            datos[796] = "SETECIENTOS NOVENTA Y SEIS";
            datos[797] = "SETECIENTOS NOVENTA Y SIETE";
            datos[798] = "SETECIENTOS NOVENTA Y OCHO";
            datos[799] = "SETECIENTOS NOVENTA Y NUEVE";
            datos[800] = "OCHOCIENTOS";
            datos[801] = "OCHOCIENTOS UN";
            datos[802] = "OCHOCIENTOS DOS";
            datos[803] = "OCHOCIENTOS TRES";
            datos[804] = "OCHOCIENTOS CUATRO";
            datos[805] = "OCHOCIENTOS CINCO";
            datos[806] = "OCHOCIENTOS SEIS";
            datos[807] = "OCHOCIENTOS SIETE";
            datos[808] = "OCHOCIENTOS OCHO";
            datos[809] = "OCHOCIENTOS NUEVE";
            datos[810] = "OCHOCIENTOS DIEZ";
            datos[811] = "OCHOCIENTOS ONCE";
            datos[812] = "OCHOCIENTOS DOCE";
            datos[813] = "OCHOCIENTOS TRECE";
            datos[814] = "OCHOCIENTOS CATORCE";
            datos[815] = "OCHOCIENTOS QUINCE";
            datos[816] = "OCHOCIENTOS DIECISEIS";
            datos[817] = "OCHOCIENTOS DIECISIETE";
            datos[818] = "OCHOCIENTOS DIECIOCHO";
            datos[819] = "OCHOCIENTOS DIECINUEVE";
            datos[820] = "OCHOCIENTOS VEINTE";
            datos[821] = "OCHOCIENTOS VEINTIUN";
            datos[822] = "OCHOCIENTOS VEINTIDÓS";
            datos[823] = "OCHOCIENTOS VEINTITRÉS";
            datos[824] = "OCHOCIENTOS VEINTICUATRO";
            datos[825] = "OCHOCIENTOS VEINTICINCO";
            datos[826] = "OCHOCIENTOS VEINTISÉIS";
            datos[827] = "OCHOCIENTOS VEINTISIETE";
            datos[828] = "OCHOCIENTOS VEINTIOCHO";
            datos[829] = "OCHOCIENTOS VEINTINUEVE";
            datos[830] = "OCHOCIENTOS TREINTA";
            datos[831] = "OCHOCIENTOS TREINTA Y UN";
            datos[832] = "OCHOCIENTOS TREINTA Y DOS";
            datos[833] = "OCHOCIENTOS TREINTA Y TRES";
            datos[834] = "OCHOCIENTOS TREINTA Y CUATRO";
            datos[835] = "OCHOCIENTOS TREINTA Y CINCO";
            datos[836] = "OCHOCIENTOS TREINTA Y SEIS";
            datos[837] = "OCHOCIENTOS TREINTA Y SIETE";
            datos[838] = "OCHOCIENTOS TREINTA Y OCHO";
            datos[839] = "OCHOCIENTOS TREINTA Y NUEVE";
            datos[840] = "OCHOCIENTOS CUARENTA";
            datos[841] = "OCHOCIENTOS CUARENTA Y UN";
            datos[842] = "OCHOCIENTOS CUARENTA Y DOS";
            datos[843] = "OCHOCIENTOS CUARENTA Y TRES";
            datos[844] = "OCHOCIENTOS CUARENTA Y CUATRO";
            datos[845] = "OCHOCIENTOS CUARENTA Y CINCO";
            datos[846] = "OCHOCIENTOS CUARENTA Y SEIS";
            datos[847] = "OCHOCIENTOS CUARENTA Y SIETE";
            datos[848] = "OCHOCIENTOS CUARENTA Y OCHO";
            datos[849] = "OCHOCIENTOS CUARENTA Y NUEVE";
            datos[850] = "OCHOCIENTOS CINCUENTA";
            datos[851] = "OCHOCIENTOS CINCUENTA Y UN";
            datos[852] = "OCHOCIENTOS CINCUENTA Y DOS";
            datos[853] = "OCHOCIENTOS CINCUENTA Y TRES";
            datos[854] = "OCHOCIENTOS CINCUENTA Y CUATRO";
            datos[855] = "OCHOCIENTOS CINCUENTA Y CINCO";
            datos[856] = "OCHOCIENTOS CINCUENTA Y SEIS";
            datos[857] = "OCHOCIENTOS CINCUENTA Y SIETE";
            datos[858] = "OCHOCIENTOS CINCUENTA Y OCHO";
            datos[859] = "OCHOCIENTOS CINCUENTA Y NUEVE";
            datos[860] = "OCHOCIENTOS SESENTA";
            datos[861] = "OCHOCIENTOS SESENTA Y UN";
            datos[862] = "OCHOCIENTOS SESENTA Y DOS";
            datos[863] = "OCHOCIENTOS SESENTA Y TRES";
            datos[864] = "OCHOCIENTOS SESENTA Y CUATRO";
            datos[865] = "OCHOCIENTOS SESENTA Y CINCO";
            datos[866] = "OCHOCIENTOS SESENTA Y SEIS";
            datos[867] = "OCHOCIENTOS SESENTA Y SIETE";
            datos[868] = "OCHOCIENTOS SESENTA Y OCHO";
            datos[869] = "OCHOCIENTOS SESENTA Y NUEVE";
            datos[870] = "OCHOCIENTOS SETENTA";
            datos[871] = "OCHOCIENTOS SETENTA Y UN";
            datos[872] = "OCHOCIENTOS SETENTA Y DOS";
            datos[873] = "OCHOCIENTOS SETENTA Y TRES";
            datos[874] = "OCHOCIENTOS SETENTA Y CUATRO";
            datos[875] = "OCHOCIENTOS SETENTA Y CINCO";
            datos[876] = "OCHOCIENTOS SETENTA Y SEIS";
            datos[877] = "OCHOCIENTOS SETENTA Y SIETE";
            datos[878] = "OCHOCIENTOS SETENTA Y OCHO";
            datos[879] = "OCHOCIENTOS SETENTA Y NUEVE";
            datos[880] = "OCHOCIENTOS OCHENTA";
            datos[881] = "OCHOCIENTOS OCHENTA Y UN";
            datos[882] = "OCHOCIENTOS OCHENTA Y DOS";
            datos[883] = "OCHOCIENTOS OCHENTA Y TRES";
            datos[884] = "OCHOCIENTOS OCHENTA Y CUATRO";
            datos[885] = "OCHOCIENTOS OCHENTA Y CINCO";
            datos[886] = "OCHOCIENTOS OCHENTA Y SEIS";
            datos[887] = "OCHOCIENTOS OCHENTA Y SIETE";
            datos[888] = "OCHOCIENTOS OCHENTA Y OCHO";
            datos[889] = "OCHOCIENTOS OCHENTA Y NUEVE";
            datos[890] = "OCHOCIENTOS NOVENTA";
            datos[891] = "OCHOCIENTOS NOVENTA Y UN";
            datos[892] = "OCHOCIENTOS NOVENTA Y DOS";
            datos[893] = "OCHOCIENTOS NOVENTA Y TRES";
            datos[894] = "OCHOCIENTOS NOVENTA Y CUATRO";
            datos[895] = "OCHOCIENTOS NOVENTA Y CINCO";
            datos[896] = "OCHOCIENTOS NOVENTA Y SEIS";
            datos[897] = "OCHOCIENTOS NOVENTA Y SIETE";
            datos[898] = "OCHOCIENTOS NOVENTA Y OCHO";
            datos[899] = "OCHOCIENTOS NOVENTA Y NUEVE";
            datos[900] = "NOVECIENTOS";
            datos[901] = "NOVECIENTOS UN";
            datos[902] = "NOVECIENTOS DOS";
            datos[903] = "NOVECIENTOS TRES";
            datos[904] = "NOVECIENTOS CUATRO";
            datos[905] = "NOVECIENTOS CINCO";
            datos[906] = "NOVECIENTOS SEIS";
            datos[907] = "NOVECIENTOS SIETE";
            datos[908] = "NOVECIENTOS OCHO";
            datos[909] = "NOVECIENTOS NUEVE";
            datos[910] = "NOVECIENTOS DIEZ";
            datos[911] = "NOVECIENTOS ONCE";
            datos[912] = "NOVECIENTOS DOCE";
            datos[913] = "NOVECIENTOS TRECE";
            datos[914] = "NOVECIENTOS CATORCE";
            datos[915] = "NOVECIENTOS QUINCE";
            datos[916] = "NOVECIENTOS DIECISEIS";
            datos[917] = "NOVECIENTOS DIECISIETE";
            datos[918] = "NOVECIENTOS DIECIOCHO";
            datos[919] = "NOVECIENTOS DIECINUEVE";
            datos[920] = "NOVECIENTOS VEINTE";
            datos[921] = "NOVECIENTOS VEINTIUN";
            datos[922] = "NOVECIENTOS VEINTIDÓS";
            datos[923] = "NOVECIENTOS VEINTITRÉS";
            datos[924] = "NOVECIENTOS VEINTICUATRO";
            datos[925] = "NOVECIENTOS VEINTICINCO";
            datos[926] = "NOVECIENTOS VEINTISÉIS";
            datos[927] = "NOVECIENTOS VEINTISIETE";
            datos[928] = "NOVECIENTOS VEINTIOCHO";
            datos[929] = "NOVECIENTOS VEINTINUEVE";
            datos[930] = "NOVECIENTOS TREINTA";
            datos[931] = "NOVECIENTOS TREINTA Y UN";
            datos[932] = "NOVECIENTOS TREINTA Y DOS";
            datos[933] = "NOVECIENTOS TREINTA Y TRES";
            datos[934] = "NOVECIENTOS TREINTA Y CUATRO";
            datos[935] = "NOVECIENTOS TREINTA Y CINCO";
            datos[936] = "NOVECIENTOS TREINTA Y SEIS";
            datos[937] = "NOVECIENTOS TREINTA Y SIETE";
            datos[938] = "NOVECIENTOS TREINTA Y OCHO";
            datos[939] = "NOVECIENTOS TREINTA Y NUEVE";
            datos[940] = "NOVECIENTOS CUARENTA";
            datos[941] = "NOVECIENTOS CUARENTA Y UN";
            datos[942] = "NOVECIENTOS CUARENTA Y DOS";
            datos[943] = "NOVECIENTOS CUARENTA Y TRES";
            datos[944] = "NOVECIENTOS CUARENTA Y CUATRO";
            datos[945] = "NOVECIENTOS CUARENTA Y CINCO";
            datos[946] = "NOVECIENTOS CUARENTA Y SEIS";
            datos[947] = "NOVECIENTOS CUARENTA Y SIETE";
            datos[948] = "NOVECIENTOS CUARENTA Y OCHO";
            datos[949] = "NOVECIENTOS CUARENTA Y NUEVE";
            datos[950] = "NOVECIENTOS CINCUENTA";
            datos[951] = "NOVECIENTOS CINCUENTA Y UN";
            datos[952] = "NOVECIENTOS CINCUENTA Y DOS";
            datos[953] = "NOVECIENTOS CINCUENTA Y TRES";
            datos[954] = "NOVECIENTOS CINCUENTA Y CUATRO";
            datos[955] = "NOVECIENTOS CINCUENTA Y CINCO";
            datos[956] = "NOVECIENTOS CINCUENTA Y SEIS";
            datos[957] = "NOVECIENTOS CINCUENTA Y SIETE";
            datos[958] = "NOVECIENTOS CINCUENTA Y OCHO";
            datos[959] = "NOVECIENTOS CINCUENTA Y NUEVE";
            datos[960] = "NOVECIENTOS SESENTA";
            datos[961] = "NOVECIENTOS SESENTA Y UN";
            datos[962] = "NOVECIENTOS SESENTA Y DOS";
            datos[963] = "NOVECIENTOS SESENTA Y TRES";
            datos[964] = "NOVECIENTOS SESENTA Y CUATRO";
            datos[965] = "NOVECIENTOS SESENTA Y CINCO";
            datos[966] = "NOVECIENTOS SESENTA Y SEIS";
            datos[967] = "NOVECIENTOS SESENTA Y SIETE";
            datos[968] = "NOVECIENTOS SESENTA Y OCHO";
            datos[969] = "NOVECIENTOS SESENTA Y NUEVE";
            datos[970] = "NOVECIENTOS SETENTA";
            datos[971] = "NOVECIENTOS SETENTA Y UN";
            datos[972] = "NOVECIENTOS SETENTA Y DOS";
            datos[973] = "NOVECIENTOS SETENTA Y TRES";
            datos[974] = "NOVECIENTOS SETENTA Y CUATRO";
            datos[975] = "NOVECIENTOS SETENTA Y CINCO";
            datos[976] = "NOVECIENTOS SETENTA Y SEIS";
            datos[977] = "NOVECIENTOS SETENTA Y SIETE";
            datos[978] = "NOVECIENTOS SETENTA Y OCHO";
            datos[979] = "NOVECIENTOS SETENTA Y NUEVE";
            datos[980] = "NOVECIENTOS OCHENTA";
            datos[981] = "NOVECIENTOS OCHENTA Y UN";
            datos[982] = "NOVECIENTOS OCHENTA Y DOS";
            datos[983] = "NOVECIENTOS OCHENTA Y TRES";
            datos[984] = "NOVECIENTOS OCHENTA Y CUATRO";
            datos[985] = "NOVECIENTOS OCHENTA Y CINCO";
            datos[986] = "NOVECIENTOS OCHENTA Y SEIS";
            datos[987] = "NOVECIENTOS OCHENTA Y SIETE";
            datos[988] = "NOVECIENTOS OCHENTA Y OCHO";
            datos[989] = "NOVECIENTOS OCHENTA Y NUEVE";
            datos[990] = "NOVECIENTOS NOVENTA";
            datos[991] = "NOVECIENTOS NOVENTA Y UN";
            datos[992] = "NOVECIENTOS NOVENTA Y DOS";
            datos[993] = "NOVECIENTOS NOVENTA Y TRES";
            datos[994] = "NOVECIENTOS NOVENTA Y CUATRO";
            datos[995] = "NOVECIENTOS NOVENTA Y CINCO";
            datos[996] = "NOVECIENTOS NOVENTA Y SEIS";
            datos[997] = "NOVECIENTOS NOVENTA Y SIETE";
            datos[998] = "NOVECIENTOS NOVENTA Y OCHO";
            datos[999] = "NOVECIENTOS NOVENTA Y NUEVE";

            string separadordecimales = System.Globalization.NumberFormatInfo.CurrentInfo.NumberDecimalSeparator;
            valor = valor.Replace(".", separadordecimales);

            string valortotal = valor.ToString();

            int posiciondecimal = valortotal.IndexOf(separadordecimales);
            string valordecimal = "";
            if (posiciondecimal >= 0)
            {
                int xdifere = valortotal.Length - (posiciondecimal + 1);
                valordecimal = valortotal.Substring(posiciondecimal + 1, xdifere);
                for (int i = valordecimal.Length; i < System.Globalization.NumberFormatInfo.CurrentInfo.NumberDecimalDigits; i++) valordecimal = valordecimal + "0";
            }

            string valorentero = "";
            valorentero = valor.Trim();
            if (posiciondecimal >= 0) valorentero = valortotal.Substring(0, posiciondecimal);

            string partecentesima = "";
            int contador = 0;

            string valorenletras = "";
            int abaco = 0;
            int[] arreglocentenas = new int[6];

            for (int i = valorentero.Length - 1; i >= 0; i--)
            {
                contador = contador + 1;
                partecentesima = valorentero[i] + partecentesima;

                if (contador == 3 || i == 0)
                {
                    abaco = abaco + 1;
                    if (abaco == 1)
                    {
                        arreglocentenas[1] = Convert.ToInt32(partecentesima);
                        if (Convert.ToInt32(partecentesima) <= 0) valorenletras = valorenletras + "";
                        if (Convert.ToInt32(partecentesima) > 1) valorenletras = valorenletras + " " + datos[Convert.ToInt32(partecentesima)];
                    }

                    if (abaco == 2)
                    {
                        arreglocentenas[2] = Convert.ToInt32(partecentesima);
                        if (Convert.ToInt32(partecentesima) == 1) { valorenletras = "MIL" + valorenletras; }
                        if (Convert.ToInt32(partecentesima) <= 0) { valorenletras = "" + valorenletras; }
                        if (Convert.ToInt32(partecentesima) > 1) valorenletras = datos[Convert.ToInt32(partecentesima)] + " MIL " + valorenletras;
                    }
                    if (abaco == 3)
                    {
                        arreglocentenas[3] = Convert.ToInt32(partecentesima);

                        if (Convert.ToInt32(partecentesima) == 1) valorenletras = datos[Convert.ToInt32(partecentesima)] + " MILLÓN " + valorenletras;
                        if (Convert.ToInt32(partecentesima) <= 0) { valorenletras = "" + valorenletras; }
                        if (Convert.ToInt32(partecentesima) > 1) valorenletras = datos[Convert.ToInt32(partecentesima)] + " MILLONES " + valorenletras;
                    }
                    if (abaco == 4) // miles de millon
                    {
                        arreglocentenas[4] = Convert.ToInt32(partecentesima);

                        //                        if (Convert.ToInt32(partecentesima) == 1) valorenletras = " MIL " + valorenletras;
                        if (Convert.ToInt32(partecentesima) <= 0) { valorenletras = "" + valorenletras; }

                        if (Convert.ToInt32(partecentesima) > 0) valorenletras = datos[Convert.ToInt32(partecentesima)] + " MIL " + valorenletras;
                    }

                    if (abaco == 5)
                    {
                        arreglocentenas[4] = Convert.ToInt32(partecentesima);
                        if (Convert.ToInt32(partecentesima) == 1) valorenletras = " UN BILLÓN " + valorenletras;
                        if (Convert.ToInt32(partecentesima) <= 0) { valorenletras = "" + valorenletras; }
                        if (Convert.ToInt32(partecentesima) > 1) valorenletras = datos[Convert.ToInt32(partecentesima)] + " BILLONES " + valorenletras;
                    }
                    contador = 0;
                    partecentesima = "";
                }
            }

            if (valorenletras.Trim().Length == 0)
            {
                valorentero = "0";
                valorenletras = "CERO";
            }

            if (Convert.ToInt64(valorentero) <= 1) valorenletras = valorenletras + " PESO ";

            string esunvalorcompletoconceros = "S";
            // si es un millon, billon , mil millones cerrrado ,debe colocar la palabre "de pesos"
            if (abaco >= 2)
            {
                for (int i = 1; i <= 2; i++)
                {
                    if (arreglocentenas[i] != 0) esunvalorcompletoconceros = "N";
                }
            }

            if (Convert.ToInt64(valorentero) > 1)
            {
                if (esunvalorcompletoconceros != "S") valorenletras = valorenletras + " PESOS ";
                if (esunvalorcompletoconceros == "S") valorenletras = valorenletras + " DE PESOS ";
            }

            if (valordecimal.Trim().Length > 0) valorenletras = valorenletras + " CON " + valordecimal + " CTVS.";

            return valorenletras;
        }

        public List<string> CalcularFechaDeVencimiento(string fecha, int plazo)
        {
            string mensajedeerror = "";
            List<string> result = new List<string>();
            try
            {
                DateTime fechadevencimiento = Convert.ToDateTime(fecha).AddDays(plazo);

                mensajedeerror = fechadevencimiento.ToString("dd/MM/yyyy");
            }
            catch (Exception ee)
            {
                mensajedeerror = "Fecha de formato invalida";
            }
            result.Add(mensajedeerror);
            return result;
        }

        /// <summary>
        /// el primer PARAMETRO fecha1 es la fecha mayor
        /// EL SEGUNDO PARAMETRO E LA FECHA MENOR
        /// </summary>
        /// <param name="fecha1"></param>
        /// <param name="fecha2"></param>
        /// <returns></returns>
        public int restarfechas(DateTime fecha1, DateTime fecha2)
        {
            int xtotaldias = 0;
            while (fecha2 < fecha1)
            {
                fecha2 = fecha2.AddDays(1);
                xtotaldias = xtotaldias + 1;
            }

            return xtotaldias;
        }

        public string traerparametrowebconfig(string parametro)
        {
            return _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:" + parametro);
        }

        public DateTime DevolverFechaParaGrabarAlServidorDeLaBaseDeDatos(string dia, string mes, string ano)
        {
            string formato = traerparametrowebconfig("formatodefechaparagrabarenlabasededatos").ToUpper();

            string valor = "";
            if (formato == "YMD") valor = ano + "-" + mes + "-" + dia;
            if (formato == "DMY") valor = dia + "-" + mes + "-" + ano;
            if (formato == "MDY") valor = mes + "-" + dia + "-" + ano;

            DateTime fecha = DateTime.Now;

            try
            {
                fecha = Convert.ToDateTime(valor);
            }
            catch (Exception ex)
            {
                return DateTime.Now;
            }

            return fecha;
        }

        public string DevolverFechaCompatibleconlaBD( DateTime? fecha)
        {

            string formato = fecha.Value.ToString(_iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:formatodefechaparalasconsultassql"));

          
            return formato;
        }



        /// <summary>
        /// el premer parametro es la lista        /// el segundo el nombre del spacio de nombres
        /// </summary>
        /// <param name="list"></param>
        /// <param name="Namespace"></param>
        /// <returns></returns>
        public StringBuilder TraerValores(StringBuilder sb, object objeto,string Namespace)
        {


            
            //carga los valores
            Type? _type = Type.GetType(Namespace);
            PropertyInfo[] propInfo = _type.GetProperties();
              string valoresdelcampo = String.Empty;
                foreach (PropertyInfo prop in propInfo)
                {
                    valoresdelcampo += objeto.GetType().GetProperty(prop.Name).GetValue(objeto, null).ToString() + ";";
                }

                string[] valoresdeloscampos = valoresdelcampo.Split(';');
                for (int j = 0; j < valoresdeloscampos.Length - 1; j++)
                {
                    //Append data with separator.
                    sb.Append(valoresdeloscampos[j] + ';');
                }

                //Append new line character.
                sb.Append("\r\n");
          
            return sb;


        }



        public StringBuilder TraerTitulo(StringBuilder sb , string Namespace)
        {

            string[]? titulos = null;
            Type? _type = Type.GetType(Namespace);
            PropertyInfo[] propInfo = _type.GetProperties();
            string titulo = String.Empty;
            foreach (PropertyInfo prop in propInfo)
            {
                titulo += prop.Name + ";";
            }

            titulos=titulo.Split(";");  

            // carga los nombres de los campos como titulos

            for (int i = 0; i < titulos.Length - 1; i++)
            {
                sb.Append(titulos[i] + ';');
            }


            //Append new line character.
            sb.Append("\r\n");

            return sb;
        }




    }
}