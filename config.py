import logging
from collections import OrderedDict

dgl_mode = True

bind_nonsecure = True
bind_address = ""
bind_port = 8080

logging_config = {
    "level": logging.INFO,
    "format": "%(asctime)s %(levelname)s: %(message)s"
}

password_db = "/data/webserver/passwd.db3"
settings_db = "/data/webserver/user_settings.db3"

static_path = "./webserver/static"
template_path = "./webserver/templates/"

server_socket_path = None

game_data_no_cache = True
watch_socket_dirs = False
use_game_yaml = True

games = OrderedDict([
    ("dcss-web", dict(
        name = "DCSS",
        crawl_binary = "/app/bin/crawl",
        rcfile_path = "/data/rcs/",
        macro_path = "/data/rcs/",
        morgue_path = "/data/rcs/%n",
        inprogress_path = "/data/rcs/running",
        ttyrec_path = "/data/rcs/ttyrecs/%n",
        socket_path = "/data/rcs",
        client_path = "/app/webserver/game_data/",
        morgue_url = None,
        show_save_info = True,
        send_json_options = True,
    )),
])

dgl_status_file = "/data/rcs/status"
milestone_file = ["./milestones"]
status_file_update_rate = 5
recording_term_size = (80, 24)
max_connections = 100
init_player_program = "./util/webtiles-init-player.sh"

ssl_options = None
connection_timeout = 600
max_idle_time = 5 * 60 * 60
use_gzip = True
http_connection_timeout = None
http_xheaders = None
kill_timeout = 10

nick_regex = r"^[a-zA-Z0-9]{3,20}$"
max_passwd_length = 20
allow_password_reset = False
lobby_url = None

crypt_algorithm = "6"  # SHA-512
crypt_salt_length = 16
login_token_lifetime = 7

uid = None
gid = None
umask = None
chroot = None
pidfile = None
daemon = False
player_url = None
development_mode = False
no_cache = False
autologin = None
