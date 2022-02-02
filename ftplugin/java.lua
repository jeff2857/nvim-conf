local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/path/to/workspace-root/' .. project_name

local config = {
    cmd = {
        '/usr/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', '~/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',

        '-configuration', '~/jdtls/config_linux',
        '-data', workspace_dir,
    },

    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
}

require('jdtls').start_or_attach(config)
