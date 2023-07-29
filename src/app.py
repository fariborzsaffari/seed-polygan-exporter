from flask import Flask,jsonify
from prometheus_client import start_http_server, Gauge
from controller import GetBalance


app = Flask(__name__)

balances_metric = Gauge('matic_balance', 'Balance of POLYGAN wallet', ['wallet_address'])

@app.route('/metrics')
def metrics():
    
    bscbalance = GetBalance()
    balances=bscbalance.get_balance()

    for address, balance in balances.items():
        if balance is not None:
            balances_metric.labels(wallet_address=address).set(balance)

    return str(balances_metric.collect())

if __name__ == '__main__':
    # Start Prometheus metrics server on port 8000
    start_http_server(8015)
    # Start Flask web server
    app.run(host="0.0.0.0",port=5005)
