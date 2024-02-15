class Fumedev < Formula
    include Language::Python::Virtualenv
  
    desc "FumeDev AI pair programmer"
    homepage "https://fumedev.com"
    url "https://github.com/metehanozdev/arm-macos.git" , :using => :git, :branch => "main"
    version "0.0.3"
  
    depends_on "python@3.11"
  
    def install

    venv_dir = libexec/"venv"
    system "python3", "-m", "venv", venv_dir


    system "#{venv_dir}/bin/pip", "install", "-r", buildpath/"requirements.txt"


    libexec.install Dir["*"] 
    chmod 0755, "#{libexec}/start.sh"


    (bin/"fumedev").write <<~EOS
      #!/bin/bash
      source "#{venv_dir}/bin/activate"
      exec "#{libexec}/start.sh" "$@"
    EOS


      chmod 0755, bin/"fumedev"
    end
  
    def caveats;  <<~EOS
    The 'fumedev' command is now available. You may need to add #{HOMEBREW_PREFIX}/bin to your PATH if it's not already there.
    
    To update FumeDev, use:
    brew upgrade fumedev
  EOS
    end
  
    test do
      system "#{bin}/fumedev", "--version"
    end
  end
  