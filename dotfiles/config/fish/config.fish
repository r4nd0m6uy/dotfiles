set -x PATH $PATH ~/bin

function m
  make -j(cat /proc/cpuinfo | grep processor | wc -l) $argv
end

