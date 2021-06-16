from web3 import Web3
import json
w3 = Web3(Web3.HTTPProvider('https://mainnet.infura.io/v3/a1645c2c8ac0400a9c6162eb42965edd'))
print(w3.eth.get_block('latest'))




userAddress = '0x2dFEA75b7489E5483b69AED98E69e36F2b07A4fe'

from flask import Flask, render_template
from flask_bootstrap import Bootstrap

def create_app():
  app = Flask(__name__)
  Bootstrap(app)

  return app

app = create_app()



@app.route('/')
def home():
   return render_template('home.html', address=userAddress)

@app.route('/buyStock/<price>')
def background_process_test(price):
    f = open('../artifacts/Ballot_metadata.json',)
    json_metadata = json.load(f)
    addr = userAddress
    abi = json_metadata.output.abi
    contract = new web3.eth.Contract(abi, addr)
    return ("bought stock")


if __name__ == '__main__':
   app.run()