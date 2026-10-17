# Завдання 3 і 4

require "yaml"
require "time"
require "date"
require "fileutils"
require "tempfile"
require "tmpdir"


# Спосіб 1 - ручний безпечний запис
def update_last_run_v1(path)
  config = YAML.load_file(path, permitted_classes: [Time, Date]) || {}
  config["last_run_at"] = Time.now.iso8601

  tmp_path = "#{path}.tmp.#{Process.pid}"
  begin
    File.write(tmp_path, YAML.dump(config))
    File.rename(tmp_path, path)          # атомарна операція в межах ФС
  ensure
    File.delete(tmp_path) if File.exist?(tmp_path)
  end
  config
end

# Спосіб 2 - через бібліотеку Tempfile
def update_last_run_v2(path)
  dir = File.dirname(path)
  config = nil

  File.open(path, "r") do |f|
    f.flock(File::LOCK_SH)                # розділюване блокування на читання
    config = YAML.load(f.read, permitted_classes: [Time, Date]) || {}
  end
  config["last_run_at"] = Time.now.iso8601

  # тимчасовий файл у тій самій директорії, щоб mv був атомарним
  tmp = Tempfile.new(["config", ".yml"], dir)
  begin
    tmp.write(YAML.dump(config))
    tmp.flush
    tmp.fsync
    tmp.close
    FileUtils.mv(tmp.path, path)
  ensure
    tmp.close! unless tmp.closed? && !File.exist?(tmp.path)
  end
  config
end


DATE_PREFIX = /\A\d{4}-\d{2}-\d{2}_/

# Спосіб 1 - імперативний
def rename_with_date_v1(dir)
  today = Date.today.strftime("%Y-%m-%d")
  renamed = []
  Dir.glob("*.txt", base: dir).sort.each do |name|
    next if name.match?(DATE_PREFIX)
    new_name = "#{today}_#{name}"
    target   = File.join(dir, new_name)
    if File.exist?(target)
      warn "Пропущено #{name}: #{new_name} уже існує"
      next
    end
    FileUtils.mv(File.join(dir, name), target)
    renamed << [name, new_name]
  end
  renamed
end

# Спосіб 2 - функціональний ланцюжок
def rename_with_date_v2(dir)
  today = Date.today.strftime("%Y-%m-%d")
  Dir.glob(File.join(dir, "*.txt"))
     .sort
     .reject { |p| File.basename(p).match?(DATE_PREFIX) }
     .filter_map do |path|
       new_path = File.join(File.dirname(path), "#{today}_#{File.basename(path)}")
       next warn("Пропущено #{path}: ціль уже існує") if File.exist?(new_path)
       FileUtils.mv(path, new_path)
       [File.basename(path), File.basename(new_path)]
     end
end

if __FILE__ == $PROGRAM_NAME
  Dir.mktmpdir("lab2") do |dir|
    puts "=== Завдання 3 ==="
    cfg = File.join(dir, "config.yml")
    File.write(cfg, YAML.dump(
      "database" => { "host" => "localhost", "port" => 5432, "name" => "app_db" },
      "last_run_at" => "2000-01-01T00:00:00+00:00"
    ))
    puts "До:\n#{File.read(cfg)}"
    update_last_run_v1(cfg)
    puts "Після способу 1:\n#{File.read(cfg)}"
    sleep 1
    update_last_run_v2(cfg)
    puts "Після способу 2:\n#{File.read(cfg)}"
    puts "Залишкових тимчасових файлів: #{Dir.children(dir).reject { |f| f == 'config.yml' }.inspect}"

    puts "\n=== Завдання 4 ==="
    txt_dir = File.join(dir, "docs")
    Dir.mkdir(txt_dir)
    %w[a.txt b.txt c.txt notes.md].each { |f| File.write(File.join(txt_dir, f), f) }
    puts "До:    #{Dir.children(txt_dir).sort.inspect}"
    p rename_with_date_v1(txt_dir)
    puts "Після способу 1: #{Dir.children(txt_dir).sort.inspect}"

    # для способу 2 — додаємо нові файли; вже перейменовані будуть пропущені
    %w[d.txt e.txt].each { |f| File.write(File.join(txt_dir, f), f) }
    p rename_with_date_v2(txt_dir)
    puts "Після способу 2: #{Dir.children(txt_dir).sort.inspect}"
  end
end