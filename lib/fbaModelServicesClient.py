try:
    import json
except ImportError:
    import sys
    sys.path.append('simplejson-2.3.3')
    import simplejson as json
    
import urllib



class fbaModelServices:

    def __init__(self, url):
        if url != None:
            self.url = url

    def get_models(self, input):

        arg_hash = { 'method': 'fbaModelServices.get_models',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def get_fbas(self, input):

        arg_hash = { 'method': 'fbaModelServices.get_fbas',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def get_gapfills(self, input):

        arg_hash = { 'method': 'fbaModelServices.get_gapfills',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def get_gapgens(self, input):

        arg_hash = { 'method': 'fbaModelServices.get_gapgens',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def get_reactions(self, input):

        arg_hash = { 'method': 'fbaModelServices.get_reactions',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def get_compounds(self, input):

        arg_hash = { 'method': 'fbaModelServices.get_compounds',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def get_media(self, input):

        arg_hash = { 'method': 'fbaModelServices.get_media',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def get_biochemistry(self, input):

        arg_hash = { 'method': 'fbaModelServices.get_biochemistry',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def genome_to_workspace(self, input):

        arg_hash = { 'method': 'fbaModelServices.genome_to_workspace',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def genome_to_fbamodel(self, input):

        arg_hash = { 'method': 'fbaModelServices.genome_to_fbamodel',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def export_fbamodel(self, input):

        arg_hash = { 'method': 'fbaModelServices.export_fbamodel',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def runfba(self, input):

        arg_hash = { 'method': 'fbaModelServices.runfba',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def checkfba(self, input):

        arg_hash = { 'method': 'fbaModelServices.checkfba',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def export_fba(self, input):

        arg_hash = { 'method': 'fbaModelServices.export_fba',
                     'params': [input],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def gapfill_model(self, in_model, formulation):

        arg_hash = { 'method': 'fbaModelServices.gapfill_model',
                     'params': [in_model, formulation],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def gapfill_check_results(self, in_gapfill):

        arg_hash = { 'method': 'fbaModelServices.gapfill_check_results',
                     'params': [in_gapfill],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def gapfill_to_html(self, in_gapfill):

        arg_hash = { 'method': 'fbaModelServices.gapfill_to_html',
                     'params': [in_gapfill],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def gapfill_integrate(self, in_gapfill, in_model):

        arg_hash = { 'method': 'fbaModelServices.gapfill_integrate',
                     'params': [in_gapfill, in_model],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result']
        else:
            return None

    def gapgen_model(self, in_model, formulation):

        arg_hash = { 'method': 'fbaModelServices.gapgen_model',
                     'params': [in_model, formulation],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def gapgen_check_results(self, in_gapgen):

        arg_hash = { 'method': 'fbaModelServices.gapgen_check_results',
                     'params': [in_gapgen],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def gapgen_to_html(self, in_gapgen):

        arg_hash = { 'method': 'fbaModelServices.gapgen_to_html',
                     'params': [in_gapgen],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result'][0]
        else:
            return None

    def gapgen_integrate(self, in_gapgen, in_model):

        arg_hash = { 'method': 'fbaModelServices.gapgen_integrate',
                     'params': [in_gapgen, in_model],
                     'version': '1.1'
                     }

        body = json.dumps(arg_hash)
        resp_str = urllib.urlopen(self.url, body).read()
        resp = json.loads(resp_str)

        if 'result' in resp:
            return resp['result']
        else:
            return None




        