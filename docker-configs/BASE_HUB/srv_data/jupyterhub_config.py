# jupyterhub_config.py

c = get_config()


c.JupyterHub.debug_proxy = True
c.JupyterHub.log_level = 'DEBUG'

# Change from JupyterHub to JupyterLab
c.Spawner.default_url = '/lab'
c.Spawner.debug = True

# c.Spawner.args = ['--NotebookApp.allow_origin=*', '--log-level=DEBUG']
# c.Spawner.args = [ '--log-level=DEBUG']

# add custom spawner that will load the user Conda Env
# c.LocalProcessSpawner.cmd = "/opt/ilci/hub/bin/user-hub"

# Authenticate users with PAM
# c.JupyterHub.authenticator_class = 'jupyterhub.auth.PAMAuthenticator'
# c.PAMAuthenticator.service = 'login'

# Specify users and admin
# c.Authenticator.whitelist = {'zoe', 'john'}

# Set up the admin users
c.Authenticator.admin_users = {"admin"}

# Authenticate users with Native Authenticator
c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator'

# Allow anyone to sign-up without approval
c.NativeAuthenticator.open_signup = True
c.NativeAuthenticator.allowed_users = {"admin"}



