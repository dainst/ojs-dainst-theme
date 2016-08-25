/**
 * temp fixes
 */
var hardcodedId = {
	list: {
		"239": "5770dffb2dc30a7433c729f7",
		"240": "5770df7b2dc30a7433c729f0",
		"241": "5770df872dc30a7433c729f1",
		//"221/189": "5770e01e2dc30a7433c729f9",
		"248":	"5770df4c2dc30a7433c729ed"
	},
	get: function() {
		var url = window.location.href.split('#')[0].split('/'); 
		//console.log(url[url.length-2] + '/' + url[url.length-1], this.list[url[url.length-2] + '/' + url[url.length-1]]);
		return this.list[(url[url.length - 2] == 'view') ? url[url.length - 1] : url[url.length - 2]];

	}
}

/*
{ "_id" : ObjectId("5770dffb2dc30a7433c729f7"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_eck_neulesung_2000.txt" },
{ "_id" : ObjectId("5770e01e2dc30a7433c729f9"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_worrle_pergamon_2000.txt" },
{ "_id" : ObjectId("5770e03e2dc30a7433c729fb"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_domingo_ptolemaios_2000.txt" },
{ "_id" : ObjectId("5770e05b2dc30a7433c729fd"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_muller_archiereus_2000.txt" },
{ "_id" : ObjectId("5770e07e2dc30a7433c729fe"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_dietz_kaiser_2000.txt" },
{ "_id" : ObjectId("5770e0a62dc30a7433c72a01"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_habicht_beitrage_2000.txt" },
{ "_id" : ObjectId("5770df242dc30a7433c729eb"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_jehne_wirkungsweise_2000.txt" },
{ "_id" : ObjectId("5770df4c2dc30a7433c729ed"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_habicht_chronologie_2000.txt" },
{ "_id" : ObjectId("5770df5c2dc30a7433c729ee"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_funke_datierung_2000.txt" },
{ "_id" : ObjectId("5770df6f2dc30a7433c729ef"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_weiss_eumeneia_2000.txt" },
{ "_id" : ObjectId("5770df7b2dc30a7433c729f0"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/EN_bremer_demes_2000.txt" },
{ "_id" : ObjectId("5770df872dc30a7433c729f1"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/EN_burton_resolution_2000.txt" },
{ "_id" : ObjectId("5770dfa32dc30a7433c729f2"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_steinhart_peisistratou_2000.txt" },
{ "_id" : ObjectId("5770dfb42dc30a7433c729f3"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_eck_latein_2000.txt" },
{ "_id" : ObjectId("5770dfc72dc30a7433c729f4"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_hennig_strassen_2000.txt" },
{ "_id" : ObjectId("5770dfdb2dc30a7433c729f5"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_girardet_caesar_2000.txt" },
{ "_id" : ObjectId("5770dff12dc30a7433c729f6"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_stylow_accitani_2000.txt" },
{ "_id" : ObjectId("5770e00d2dc30a7433c729f8"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_deininger_germaniam_2000.txt" },
{ "_id" : ObjectId("5770e0492dc30a7433c729fc"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_kyrieleis_doppelgesicht_2000.txt" },
{ "_id" : ObjectId("5770e08a2dc30a7433c729ff"), "txt_path" : "/home/nlp-data/idai_journals/chiron/txt/DE_wachtel_frigeridus_2000.txt" },
*/