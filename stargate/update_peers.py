import requests
from bs4 import BeautifulSoup

CONFIG_PATH = 'stargate/config.toml'

def main():
    print("Scraping new peers...")
    peers = []
    for page in range(1, 7):
        print("Page {}...".format(page))
        result = requests.get("https://api.atlas.cosmos.network/api/v1/nodes/search?page={}&limit=100&order=id".format(page))
        for peer in result.json()['results']:
            if peer['node_id'] != '' and peer['network'] == 'cosmoshub-4':
                addr = "{}@{}:{}".format(peer['node_id'], peer['address'], peer['p2p_port'])
                peers.append(addr)

    print("Downloaded {}".format(len(peers)))
    peer_string = ",".join(peers)
    
    with open(CONFIG_PATH, 'r') as file:
        data = file.readlines()

    data[183] = "seeds = \"{}\"\n".format(peer_string)

    with open(CONFIG_PATH, 'w') as file:
        file.writelines(data)


if __name__ == "__main__":
    main()