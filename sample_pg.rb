# pgライブラリを使用する
require 'pg'

# PG::connect(dbname: "goya")により、rubyからgoyaDBに接続し
# 接続したという情報をconnectionという名前の変数に格納する
connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"
begin
  # connection変数を使いPostgreSQLを操作する
  # .execで、goyaDBに"select weight, give_for from crops;"
  # のSQLの命令文を直接実行し、その結果をresult変数に格納する
  result = connection.exec("select length, give_for, quality from crops;")
  # 取り出した各行を処理する
  result.each do |record|
      # 各行を取り出し、putsでターミナル上に出力する
    puts "大きさ:#{record["length"]} 譲渡先:#{record["give_for"]} 重さ:#{record["weight"]} 品質:#{record["quality"]} 日付:#{record["date"]}"
  end
  result = connection.exec("select * from crops where give_for!='自家消費';")
  result.each do |record|
    puts "大きさ:#{record["length"]} 譲渡先:#{record["give_for"]} 重さ:#{record["weight"]} 品質:#{record["quality"]} 日付:#{record["date"]}"
  end
  result = connection.exec("select * from crops where quality=false;")
  result.each do |record|
    puts "大きさ:#{record["length"]} 譲渡先:#{record["give_for"]} 重さ:#{record["weight"]} 品質:#{record["quality"]} 日付:#{record["date"]}"
  end
ensure
  # 最後に.finishでデータベースへのコネクションを切断する
  connection.finish
end