task :default => [:clean, :view]

task :weave do
  system "R.exe CMD Sweave *.Rnw"
end

task :compile => [:weave] do
  system "pdflatex.exe *.tex"
end

task :view => [:compile] do
  system "chrome.exe"
end

task :clean do

end
