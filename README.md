# Projeto Nginx  
## Programa de Bolsas Compass.uol 

### Descrição 

Principal Objetivo é monitorar o serviço NGINX a cada 5 minutos em uma máquina Linux, no WSL. Esta atividade foi feita no Ubuntu 24.04. 

### Intrução de instalação do wsl! 
•	Clique no botão do Windows, digite Powershell e execute o programa. Você deve ver uma interface de linha de comando.
•	Primeiro vamos ver as versões disponíveis. Digite wsl --list --online e aperte enter. Vai aparecer uma lista das distribuições Linux na loja online.
•	Queremos uma versão do Ubuntu superior ao 20.04, como requisitado na atividade. Digite e execute wsl --install Ubuntu-24.04 ou a versão desejada

Configuração do ambiente Ubuntu (ou quaisquer outras destribuições)

### Atualizando e instalando pacotes
Com o Linux instalado na máquina e acessando o terminal, antes de tudo, precisamos atualizar nosso ambiente. Para isso, dois comandos são necessários:
~$ sudo apt update
~$ sudo apt upgrade 

### Instalação do Nginx 
~$ sudo apt install nginx 
•	Agora iremos criar uma pasta para o projeto. 
~$ mkdir nginx2 && cd nginx2  
Comando para criar o diretório e acessá-lo.

• Crie um arquivo com o nome da sua escolha, mas precisa terminar com .sh
~$ nginx_script.sh && touch nginx_script.sh 

• Agora com um editor de arquivos, como o vim ou nano, edite o arquivo para colocar o script nele. 
~$ nano nginx_script.sh

Para que o Nginx seja realizado de forma automatica, utilizaremos a ferramenta cron que permite que possa ser agendado tarefas para ser executadas em momentos específicos. Vamos acessar a tabela do cron, pelo crontab. O comando pode ser usado em qualquer diretório.
$ crontab -e

•Quando executado pela primeira vez, o sistema pergunta qual editor de texto deseja usar. Eu escolhi o nano, mas fica a seu critério. Agora adicione a seguinte linha no editor:
*/5 * * * * bash /nginx2/Atividade-Linux-Nginx/nginx_script.sh

Basicamente, estamos dizendo pro cron que ele precisa entrar no nosso diretório do projeto e executar o script, a cada 5 minutos. Pra finalizar, precisamos dar as permisões de leitura / escrita / execução (read / write / execute ) para o arquivo, afim de fazê-lo funcionar normalmente.

~/nginx2$ sudo chmod 777 script.sh 


•Se o seu serviço NGINX estiver online, o script gerará um arquivo como online.log. Para testar se o script gera o arquivo offline.log, precisamos desligar o serviço. Para isso, execute o seguinte comando e aguarde até a próxima execução do script.
~$ sudo systemctl stop nginx 

•Se tudo estiver funcionando, o projeto estará em perfeito estado. 

### Versionamento
Para o versionamento, usaremos o Git e GitHub. Precisaremos nos identificar pro Git, criar uma chave SSH, conectar o Git da máquina com o GitHub, criar um repositório no GitHub e cloná-lo na nossa máquina Linux, fazer as alterações e ajustes e subir os arquivos no repositório remoto, ou seja, no GitHub.

Fazendo o cadastro
Para realizarmos esse processo, precisamos primeiro nos identificar. Por isso, dois comandos são necessários: um para nome e outro para email. Neste caso, use os seus dados do Github.

~$ git config --global user.name nome-do-usuario
~$ git config --global user.name email@gmail.com


### Geração da Chave SSH
Precisamos gerar uma chave SSH para fazer a conexão remotamente O comando abaixo gerará um par de chaves, pública e privada, onde usaremos a chave pública no GitHub.
~$ ssh-keygen -t ed25519 -C "email@gmail.com"

Substitua o email@gmail.com pelo seu email do GitHub. Isso é apenas um comentário ou descrição para a sua chave SSH, mas normalmente é usado um email.

O sistema vai pedir um caminho para salvar o arquivo e uma frase-passe (uma senha, basicamente), Não é necessário fornecer. Deixe em branco e aperte o Enter em todas as vezes que lhe for solicitado. Vai parecer uma frase como: Your identification has been saved in /home/Claydie/.ssh/id_ed25519. Você precisa ir no seu diretório home, depois no diretório oculto .ssh e pegar a chave pública.

~$ cat /home/nome-de-usuario/.ssh/id_ed25519.pub

Substitua  pelo seu nome de usuário.
Copie o texto que será exibido (exceto o email no final).
Registrando Nova Chave SSH
No seu navegador, entre no gitHub.com, clique na sua foto de perfil no canto superior direito e clique em Configurações(settings). Após, clique em *SSH and GPG Keys, localizado no menu à esquerda, na seção Access. Na página, clique no botão verde New SSH Key. Dê um título para a chave, cole a chave copiada anteriormente no campo Key e salve clicando em Add SSH Key. Insira sua senha ou realize a verificação em duas etapas do GitHub. Sua chave estará registrada. No topo, deve aparecer uma mensagem como: You have successfully added the key 'teste_ssh'., informando que a chave com o nome escolhido foi adicionada.
Agora precisamos testar essa conexão. Na máquina linux digite o seguinte comando:
~$ ssh -T git@github.com

Aparecerá uma mensagem:
The authenticity of host 'github.com (20.201.28.151)' can't be established.
ECDSA key fingerprint is SHA256:<hash da chave pública do servidor>.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
Quando você tenta conectar ao GitHub via SSH pela primeira vez, o sistema mostra essa mensagem por conta da autenticidade do host, como medida de segurança. Digite yes para darmos continuidade.
Clonando um repositório
Agora, no seu GitHub, crie um repositório e adicione um README vazio à ele. Na página do seu repositório, aperte no botão verde <> Code. No tab Local na seção Clone, aperte em SSH e copie o texto informado. O formato deve ser esse:
git@github.com:ctrl-brokencode/git_teste.git

De volta no terminal, no seu diretório home, execute o seguinte comando para fazer uma cópia do repositório remoto na sua máquina:

~$ git clone git@github.com:ctrl-brokencode/git_teste.git

Se você der um ls, você vai ver um novo diretório, que é o repositório clonado.

⚠ ATENÇÃO: Como vamos subir esse mesmo diretório remotamente, precisamos passar tudo que temos no nosso diretório local pro repositório clonado. OU SEJA, os arquivos, como o do script e os dos logs, precisam ser copiados ou movidos do diretório que criamos no começo da atividade  para o repositório que clonamos agora. Você também precisará alterar o crontab com o novo caminho do arquivo.

### Subindo os novos arquivos
Para subir os arquivos, precisamos primeiro realizar as alterações. Se você der um git status, você verá que o arquivo do script está como untracked. Se você alterar o texto do README.md, vai ver que este vai estar como modified. Precisamos atualizar essas modificações com git add . Isso fará com que as alterações estejam prontas para serem "commitadas". Para commitar, dê um git commit -m e a mensagem da sua preferência, entre aspas. Exemplo:
~/git_teste$ git add .
~/git_teste$ git commit -m "subindo o script e alterando o README"

Para finalizar, o comando seguinte irá subir os arquivos locais para o repositório no GitHub.

~$ git push

### Conclusão
Concluido o projeto com exito e gradidão por todo conhecimento adquirido até aqui.





