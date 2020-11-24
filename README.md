# Desafio iOS

## Criando um App de Scroll Infinito pra NASA

### **Descrição do aplicativo**
O desafio é criar um aplicativo para mostrar as fotos de um dos conteúdos mais populares da NASA, o que queremos é que você construa um aplicativo de Scroll Infinito para que possamos apreciar este maravilhoso conteúdo.

### **Recursos**
-   **Visuais**: Optamos  por não dar uma linha de design e fica a critério do candidato qual design escolher.
-   **API**. Exemplo de chamada na API:  `https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY`

|Parameter  |Type 		|Default 	| Description |
|-----------|-----------|-----------|-----------------------------------------------|
|date		|YYY-MM-DD	|today 		|The date of the APOD image to retrieve			|
|hd			|bool		|False      |Retrieve the URL for the high resolution image |
|api_key	|string		|DEMO_KEY	|api.nasa.gov key for expanded usage			|

-   **Ref. conteúdo**: [https://apod.nasa.gov/apod/](https://apod.nasa.gov/apod/ "https://apod.nasa.gov/apod/")

### **Não pode faltar**
-   Linguagem Swift
-   Gerenciamento de dependências "Cocoapods/Carthage"
-   Mapeamento JSON utilizando protocolo Codable


### **Plus**

-   Tela com gestos para ampliar a foto do dia / 🤖 DEV MARK : OK
-   Apresentar os vídeos / 🤖 DEV MARK : O URL que vem da API, leva para a página do youtube. Adaptei a LIB (YoutubeSourceParserKit) para o Swift 5, mas não consegui pegar o URL puro do vídeo.
-   Testes unitários
-   Testes de Interface
-   Testes funcionais
-   Cache de imagens e da API / 🤖 DEV MARK : OK
-   Suporte a mudanças de orientação das telas sem perder estado / 🤖 DEV MARK : OK

🤖 DEV MARK : EXTRA - Utilizei o ContextMenu com LongPress para salvar a imagem na galeria do celular.


### **Como enviar?**

A solução precisa ser enviada via pull request para este repositório.

1.  Faça o fork desse repositório
2.  Desenvolva
3.  Execute os commits, de forma "organizada e semântica"
4.  Use Github, para realizar Pull Request.

Se possível deixe o fork público para facilitar a inspeção do código.


### **O que será avaliado?**

- Qualidade do código  
• Comentários  
• Organização  
• Semântica  
• Código idiomático com base na linguagem  
• Descrição dos commits  

- Arquitetura  
• Qual a arquitetura escolhida   / 🤖 DEV MARK : Utilizei MVC (Hoje trabalho com Viper, tenho conhecimento de quase todas as arquiteturas.)
• Implementação  

- Otimização de recursos  
• Cache de API / 🤖 DEV MARK : Toda a request foi feita de forma nativa.
• Cache de Imagens / 🤖 DEV MARK : Para exibição das imagens foi utilizado o SDWebImage.

- UX  
• Fluidez na utilização do app  


### **Dica**
Não existe uma api para trazer mais de um conteúdo por vez, como fazer? / 🤖 DEV MARK : Segundo a documentação, existe uma forma de passar a Data Inicial / Data final. Mas como foi passado um endpoint específico, resolvi aplicar de uma forma requisitando ele e realizando a paginação.
