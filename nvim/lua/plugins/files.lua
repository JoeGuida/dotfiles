local function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

local function find_cmake_target(start_dir)
    print("finding cmake target...")
    local dir = start_dir
    local prev = nil

    while dir ~= prev do
        prev = dir
        local cmake = dir .. "/CMakeLists.txt"

        if vim.fn.filereadable(cmake) == 1 then
            local lines = vim.fn.readfile(cmake)

            for _, line in ipairs(lines) do
                local target = line:match(
                    "add_library%s*%(([%w_%-]+)"
                )

                if not target then
                    target = line:match(
                        "add_executable%s*%(([%w_%-]+)"
                    )
                end

                if target then
                    print("cmake target found")
                    return target
                end
            end
        end

        dir = vim.fn.fnamemodify(dir, ":h")
    end

    print("no cmake target found, setting target to default: PROJECT")
    return "PROJECT"
end

local function has_main(filepath)
    local f = io.open(filepath, 'r')
    if not f then
        return false
    end

    local content = f:read('*a')
    f:close()

    return content:match('int%s+main%s*%(%)') ~= nil
end

local function insert_hpp_template()
    if vim.fn.line('$') ~= 1 or vim.fn.getline(1) ~= '' then
        return
    end

    local filepa = vim.fn.expand('%:p')
    local dir = vim.fn.expand('%:p:h')
    local filename = vim.fn.expand('%:t:r')
    local struct_name = capitalize(filename)

    local target = find_cmake_target(dir)

    local guard = (
        target .. '_' .. vim.fn.expand('%:t')
    ):upper():gsub('%.', '_')

    local lines = {
        '#ifndef ' .. guard,
        '#define ' .. guard,
        '',
        'struct ' .. struct_name .. ' {',
        '',
        '};',
        '',
        '#endif',
        ''
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

local function insert_cmake_template()
    if vim.fn.line('$') ~= 1 or vim.fn.getline(1) ~= '' then
        return
    end

    local target = vim.fn.expand('%:p:h:t')

    local include = vim.fn.expand('%:p:h') .. '/include'
    local src = vim.fn.expand('%:p:h') .. '/src'

    local has_include = vim.fn.isdirectory(include) == 1
    local has_src = vim.fn.isdirectory(src) == 1

    local lines = {
        'cmake_minimum_required(VERSION 4.0)',
        'project(' .. target .. ')',
        '',
        'set(CMAKE_CXX_STANDARD 23)',
        'set(CMAKE_CXX_STANDARD_REQUIRED True)',
        'set(CMAKE_CXX_EXTENSIONS OFF)',
        '',
    }

    -- check for int main()
    local files = has_src and vim.fn.readdir(src) or {}
    local is_executable = false
    if has_src then
        for _, name in ipairs(files) do
            if has_main(src .. '/' .. name) then
                is_executable = true
                break
            end
        end
    end

    local is_library = not is_executable

    if is_executable then
        if has_src then
            table.insert(lines, 'add_executable(' .. target)
            for _, name in ipairs(files) do
                table.insert(lines, '    src/' .. name)
            end
            table.insert(lines, ')')
            table.insert(lines, '')
        else
            table.insert(lines, 'add_executable(' .. target .. ')')
            table.insert(lines, '')
        end
    end

    if is_library then
        if has_src then
            table.insert(lines, 'add_library(' .. target .. ' STATIC')
            local files = vim.fn.readdir(src)
            for _, name in ipairs(files) do
                table.insert(lines, '    src/' .. name)
            end
            table.insert(lines, ')')
            table.insert(lines, '')
        else
            table.insert(lines, 'add_library(' .. target .. 'INTERFACE)')
            table.insert(lines, '')
        end
    end

    if has_include then
        table.insert(lines, 'target_include_directories(' .. target .. ' PRIVATE')
        table.insert(lines, '    include')
        table.insert(lines, ')')
        table.insert(lines, '')
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '*.hpp',
    callback = insert_hpp_template,
})

vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = 'CMakeLists.txt',
    callback = insert_cmake_template,
})

return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'md' }
    },
    {
        'kalvinpearce/ShaderHighlight',
        ft = { 'glsl', 'hlsl', 'vert', 'frag' }
    }
}
