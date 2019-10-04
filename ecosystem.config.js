module.exports = {
  apps: [
    {
      name: 'App management server',
      script: 'node app.js',
      args: ['appName=Users', 'port=3000'],
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '1G'
    }
  ]
};
