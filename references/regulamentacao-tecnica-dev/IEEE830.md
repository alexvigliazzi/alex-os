# IEEE830

> Fonte: `IEEE830.pdf`

 IEEE Std 830 Prática Recomendada
Para Especificações de Exigências de
              Software
         Standard Internacional




              André Gonçalves
                        IST
           Universidade Técnica de Lisboa

              Fernando Martins
                Paulo Carreira
                       FCUL
              Universidade de Lisboa

                 Pedro Lopes
                Sérgio Nunes
IEEE Std 830 Prática Recomendada Para Especificações de Exigências de Software: Standard In-
ternacional
por André Gonçalves, Fernando Martins, Paulo Carreira, Pedro Lopes, e Sérgio Nunes

Publicado Abril, 2004

Norma IEEE Std 830-1998

Este documento foi elaborado sobre a norma IEEE Std 830-1998, "IEEE Recommended Practice for Software
Requirements Specifications".
Este documento descreve o conteúdo e a qualidade de uma boa especificação de exigências de software (EES) e
apresenta exemplos de possíveis tipos de estruturas de documentos EES. Esta prática recomendada é orientada à
especificação de exigências de software a serem desenvolvidas, mas também pode ser aplicado na assistência de
selecção de produtos comerciais ou desenvolvidos pela própria empresa. Linhas de orientação gerais para
conformidade com a norma IEEE/EIA 12207.1-1997 também são disponibilizadas.
Este documento é assim uma recomendação prática da implementação da norma em questão e tem a finalidade de
definir o standard para definição de exigências.




Avisos legais

Este documento é uma tradução do standard IEEE STD 830 e não tem sobre o mesmo qualquer direito.
Todos os direitos reservados. Este documento está protegido pelas leis internacionais e pelos acordos de autoria.
Todos os produtos mencionados aqui são apenas usados para fins de identificação e são marcas registadas dos seus legais detentores.
Índice
1. Objectivo ....................................................................................................................................................................1
         1.1. Escopo ............................................................................................................................................................1
2. Referências.................................................................................................................................................................2
3. Definições ...................................................................................................................................................................4
         3.1. Contracto ........................................................................................................................................................4
         3.2. Cliente ............................................................................................................................................................4
         3.3. Fornecedor......................................................................................................................................................4
         3.4. Utilizador........................................................................................................................................................4
4. Considerações para a produção de um bom documento de EES .........................................................................5
         4.1. Natureza do documento de EES.....................................................................................................................5
         4.2. Ambiente do documento de EES ...................................................................................................................5
         4.3. Características de um bom documento de EES..............................................................................................6
         4.4. Preparação conjunta do documento de EES.................................................................................................11
         4.5. Evolução do documento de EES ..................................................................................................................11
         4.6. Prototipagem ................................................................................................................................................12
         4.7. Incorporação do desenho no documento de EES .........................................................................................12
         4.8. Incorporação de exigências do projecto no documento de EES ..................................................................13
5. As partes de um documento de EES .....................................................................................................................14
         5.1. Introdução (Secção 1 do documento de EES) ..............................................................................................14
         5.2. Descrição geral (Secção 2 do documento de EES) ......................................................................................16
         5.3. Exigências específicas (Secção 3 do documento de EES) ...........................................................................20
         5.4. Informação de suporte ..................................................................................................................................25
A. Modelos de EES......................................................................................................................................................27
         A.1. Modelo de Secção 3 do EES organizada por modo: Versão 1 ....................................................................27
         A.2. Modelo de Secção 3 do EES organizada por modo: Versão 2 ....................................................................27
         A.3. Modelo de Secção 3 do EES organizada por classe de utilizador ...............................................................28
         A.4. Modelo de Secção 3 do EES organizada por objecto..................................................................................28
         A.5. Modelo de Secção 3 do EES organizada por característica ........................................................................29
         A.6. Modelo de Secção 3 do EES organizada por estímulos ..............................................................................29
         A.7. Modelo de Secção 3 do EES organizada por hierarquia funcional .............................................................30
         A.8. Modelo de Secção 3 do EES mostrando multiplas......................................................................................31
B. Modelo de EES .......................................................................................................................................................33
         B.1. Vista geral ....................................................................................................................................................33
         B.2. Correlação....................................................................................................................................................33
         B.3. Mapeamento de conteúdo ............................................................................................................................34
         B.4. Conclusão ....................................................................................................................................................38




                                                                                                                                                                               iii
Lista de Tabelas
5-1. Protótipo da estrutura de um documento de EES ..................................................................................................14
B.1. Resumo das exigências para um SRD (Retirado da Tabela 1 da norma IEEE/EIA 12207.1-1997) .....................34
B.2. Cobertura de exigências genéricas da descrição da norma IEEE Std 830-1998 ...................................................35
B.3. Cobertura de exigências específicas da descrição da norma IEEE Std 830-1998.................................................36



Lista de Exemplos
4-1. Exemplo de uma exigência verificável ..................................................................................................................10




                                                                                                                                                           iv
Capítulo 1. Objectivo
Este documento descreve as abordagens recomendadas para a especificação de requisitos de software, daqui para a
frente referido como "exigências de software". 1 Divide-se em cinco capítulos. A Secção 1.1 explica o escopo desta
prática recomendada. O Capítulo 2 lista as referências feitas a outros standards. O Capítulo 3 disponibiliza definições
de termos usados. O Capítulo 4 dá um enquadramento informativo para escrever uma boa Especificação de
Exigências de Software (EES) - Software Requirements Specification (SRS), no original.2 O Capítulo 5 disserta sobre
cada uma das partes essenciais de um documento de EES. Esta prática recomendada também possui dois anexos, um
disponibilizando formatos alternativos e outro disponibilizando linhas de orientação para conformidade com
IEEE/EIA 12207.1-1997.


1.1. Escopo
Esta é uma recomendação prática para escrever especificações de requisitos de software. Este documento descreve o
conteúdo e as qualidades de um bom documento de EES e apresenta diversos exemplos.
Esta prática recomendada tem como objectivo a especificação de exigências de software a ser desenvolvido, mas
também pode ser usada na selecção de produtos comerciais de software. No entanto, a sua aplicação a software já
desenvolvido pode ser contra-producente.
Quando o software está embebido em sistemas de grande escala, como sejam equipamentos médicos, então tudo o
que está fora do âmbito deste documento deve ser visto em particular.
Esta recomendação prática descreve o processo da criação de um produto e o conteúdo desse mesmo produto. O
produto é um documento de EES. Estas recomendações práticas podem ser usadas para criar um documento de EES
ou podem ser usadas como modelo para um standard mais específico.
Esta recomendação prática não identifica nenhum método, nomenclatura ou ferramenta específica para a preparação
de um documento de EES.



Notas
1. Nota de Tradução: Neste documento, a palavra "requirement" foi traduzida por exigência, transmitindo o
   carácter de obrigatoriedade que a palavra assume na língua inglesa e libertando-se de qualquer ambiguidade que
   a palavra "requisito", comummente usada em português, pudesse adquirir neste documento.
2. Nota de Tradução: Neste documento, "Software Requirements Specification" foi traduzido por "Especificações
   de Exigências de Software", e, consequentemente, a sigla "SRS" foi traduzida por "EES". Assim, a sigla EES irá
   ser usada ao longo deste documento.




                                                                                                                     1
Capítulo 2. Referências
Este documento deve ser usado em conjunto com as seguintes publicações:

•   ASTM E1340-96, Standard Guide for Rapid Prototyping of Computerized Systems.1
•   IEEE Std 610.12-1990, IEEE Standard Glossary of Software Engineering Terminology. 2
•   IEEE Std 730-1998, IEEE Standard for Software Quality Assurance Plans.
•   IEEE Std 730.1-1995, IEEE Guide for Software Quality Assurance Planning.
•   IEEE Std 828-1998, IEEE Standard for Software Configuration Management Plans. 3
•   IEEE Std 982.1-1988, IEEE Standard Dictionary of Measures to Produce Reliable Software.
•   IEEE Std 982.2-1988, IEEE Guide for the Use of IEEE Standard Dictionary of Measures to Produce Reliable
    Software.
•   IEEE Std 1002-1987 (Reaff 1992), IEEE Standard Taxonomy for Software Engineering Standards.
•   IEEE Std 1012-1998, IEEE Standard for Software Verification and Validation.
•   IEEE Std 1012a-1998, IEEE Standard for Software Verification and Validation: Content Map to IEEE/EIA
    12207.1-1997. 4
•   IEEE Std 1016-1998, IEEE Recommended Practice for Software Design Descriptions. 5
•   IEEE Std 1028-1997, IEEE Standard for Software Reviews.
•   IEEE Std 1042-1987 (Reaff 1993), IEEE Guide to Software Configuration Management.
•   IEEE P1058/D2.1, Draft Standard for Software Project Management Plans, dated 5 August 1998. 6
•   IEEE Std 1058a-1998, IEEE Standard for Software Project Management Plans: Content Map to IEEE/EIA
    12207.1-1997. 7
•   IEEE Std 1074-1997, IEEE Standard for Developing Software Life Cycle Processes.
•   IEEE Std 1233, 1998 Edition, IEEE Guide for Developing System Requirements Specifications. 8


Notas
1. As publicações ASTM estão disponíveis na American Society for Testing and Materials, 100 Barr Harbor Drive,
   West Conshohocken, PA 19428-2959, USA.
2. As publicações IEEE estão disponíveis no Institute of Electrical and Electronics Engineers, 445 Hoes Lane, P.O.
   Box 1331, Piscataway, NJ 08855-1331, USA.
3. À data desta publicação, os standards IEEE Std 828-1998; IEEE Std 1012a-1998; IEEE Std 1016-1998; e IEEE
   Std 1233, Edição de 1998 estão aprovados mas ainda não foram publicados. No entanto, as versões preliminares
   estão disponíveis no IEEE. As publicações estão previstas para o Outono de 1998. Contacte o IEEE Standards
   Department at 1 (732) 562-3800 para mais informação.
4. À data desta publicação, os standards IEEE Std 828-1998; IEEE Std 1012a-1998; IEEE Std 1016-1998; e IEEE
   Std 1233, Edição de 1998 estão aprovados mas ainda não foram publicados. No entanto, as versões preliminares
   estão disponíveis no IEEE. As publicações estão previstas para o Outono de 1998. Contacte o IEEE Standards
   Department at 1 (732) 562-3800 para mais informação.




                                                                                                                 2
                                                                                          Capítulo 2. Referências

5. À data desta publicação, os standards IEEE Std 828-1998; IEEE Std 1012a-1998; IEEE Std 1016-1998; e IEEE
   Std 1233, Edição de 1998 estão aprovados mas ainda não foram publicados. No entanto, as versões preliminares
   estão disponíveis no IEEE. As publicações estão previstas para o Outono de 1998. Contacte o IEEE Standards
   Department at 1 (732) 562-3800 para mais informação.
6. Até à aprovação do IEEE P1058 pelo IEEE-SA Standards Board, este standard irá ser integrado com o IEEE Std
   1058a-1998 e publicado como IEEE Std 1058, Edição de 1998. É esperada a sua aprovação a 8 de Dezembro de
   1998.

7. À data de edição deste standard, o IEEE Std 1058a-1998 está aprovado mas ainda não foi publicado. A versão
   preliminar deste , está disponível através do IEEE. Espera-se a sua publicação em Dezembro de 1998. Contacte o
   IEEE Standards Department através do telefone 1 (732) 562-3800 para mais informações.

8. À data desta publicação, os standards IEEE Std 828-1998; IEEE Std 1012a-1998; IEEE Std 1016-1998; e IEEE
   Std 1233, Edição de 1998 estão aprovados mas ainda não foram publicados. No entanto, as versões preliminares
   estão disponíveis no IEEE. As publicações estão previstas para o Outono de 1998. Contacte o IEEE Standards
   Department através do telefone 1 (732) 562-3800 para mais informação.




                                                                                                               3
Capítulo 3. Definições
Em geral, os termos usados nesta prática recomendada estão conformes com as definições disponibilizadas no
documento IEEE Std 610.12-1990. As definições abaixo são os termos chave usados nesta prática recomendada.


3.1. Contracto
Um documento legal de obrigações com o qual o cliente e o fornecedor concordam. Isto inclui as exigências técnicas
e organizacionais, o custo e o calendário para um produto. Um contracto pode ainda conter informação informal, mas
útil, tal como os compromissos ou expectativas das partes envolvidas.



3.2. Cliente
A pessoa, ou pessoas, que pagam o produto e normalmente (mas não obrigatoriamente) decidem as exigências. No
contexto de uma prática recomendada, o cliente e o fornecedor podem ser membros de uma mesma organização.



3.3. Fornecedor
A pessoa, ou pessoas, que produzem um produto para um cliente. No contexto desta prática recomendada, o cliente e
o fornecedor podem ser membros de uma mesma organização.



3.4. Utilizador
A pessoa, ou pessoas, que vão operar ou interagir com o produto. Os utilizadores e os clientes são, comummente, as
mesmas pessoas.




                                                                                                                 4
Capítulo 4. Considerações para a produção de
um bom documento de EES
Este ponto disponibiliza alguma informação base que deve ser considerada aquando da escrita de um documento de
EES. Isto inclui o seguinte:

  a. Natureza do documento de EES;
  b. Ambiente do documento de EES;
  c. Características de um bom documento de EES;
 d. Preparação conjunta do documento de EES;
  e. Evolução do documento de EES;
  f. Prototipagem;
 g. Incorporação do desenho no documento de EES;
 h. Incorporação das exigências do projecto no documento de EES;


4.1. Natureza do documento de EES
O documento de EES é uma especificação particular de um software, produto, programa ou conjunto de programas
que executam certas funções num ambiente específico. O documento de EES pode ser escrito por um ou mais
representantes do fornecedor, um ou mais representantes do cliente, ou por ambos. A Secção 4.2 recomenda ambos.
Quem escreve um documento de EES deve sempre ter em conta os seguintes pontos base:

  a. Funcionalidade. O que deve fazer o software?
  b. Interfaces externas. Como interage o software com as pessoas, com o hardware do sistema, com outro hardware,
     e com outro software?
  c. Performance. Qual é a velocidade, disponibilidade, tempo de resposta, tempo de recuperação das várias funções
     do software, etc.?
 d. Atributos. Quais as considerações relativas à portabilidade, correcção, mantenabilidade, segurança, etc.?
  e. Restrições de desenho impostas numa implementação. Existem exigências padrão, linguagem de
     implementação, políticas para integridade da base de dados, limites de recursos, ambientes operacionais, etc.?
Quem escreve um documento de EES deve evitar introduzir exigências de desenho ou de projecto no documento de
EES.
Para conteúdos recomendados, consulte o Capítulo 5.



4.2. Ambiente do documento de EES
É importante ter em conta o papel que o documento de EES possui no plano de todo o projecto, que é definido no
documento IEEE Std 610.12-1990. O software pode conter essencialmente toda a funcionalidade do projecto ou
pode ser parte integrante de um sistema maior. Neste último caso, tipicamente existe um documento de EES que




                                                                                                                      5
                                          Capítulo 4. Considerações para a produção de um bom documento de EES

documenta as interfaces entre o sistema e esta parte do software, impondo assim exigências externas de performance
e funcionalidade do software. Claro que o documento de EES deve estar em concordância e expandir estas
exigências de sistema.
O documento IEEE Std 1074-1997 descreve os passos do ciclo da vida de um software e as entradas que cada passo
comporta. Outros padrões, tais como os listados no Capítulo 2, estão relacionados com outras partes do ciclo de vida
do software e podem complementar as exigências.
Como o documento de EES tem um papel específico no processo de desenvolvimento de software, quem escreve o
documento de EES deve ter cuidado para não passar os limites desse papel. Isto quer dizer que:

  a. O documento de EES deve definir correctamente todas as exigências do software. Uma exigência do software
     pode existir devido à natureza da tarefa a ser resolvida ou devido a uma característica particular do projecto.
  b. O documento de EES não deve descrever nenhum detalhe de desenho ou implementação. Estes devem ser
     descritos na fase de desenho do projecto.
  c. O documento de EES não deve impor restrições adicionais ao software. Estas estão devidamente especificadas
     noutros documentos tais como o plano de garantia de qualidade do software.
Por isso, um documento de EES correctamente escrito limita a fronteira de desenhos válidos, mas não vincula
nenhum desenho particular.



4.3. Características de um bom documento de EES
Um documento de EES deve ser:

  a. Correcto;
  b. Não ambíguo;
  c. Completo;
 d. Consistente;
  e. Classificável por importância e/ou estabilidade;
  f. Verificável;
 g. Modificável;
 h. Rastreável;


4.3.1. Correcto
Um documento de EES está correcto se e só se, todas as exigências expressas nele serão correspondidas pelo
software.
Não existe nenhuma ferramenta ou procedimento que assegure a correcção. O documento de EES deve ser
comparado com outras especificação aplicáveis, tais como as exigências de especificações do sistema, com outra
documentação do projecto e com outros standards aplicáveis, para garantir que está em concordância.
Alternativamente, o cliente pode determinar se o documento de EES reflecte correctamente as suas necessidades
actuais. O rastreio facilita este procedimento e torna-o menos permissivo a erros. (Ver a Secção 4.3.8)




                                                                                                                       6
                                          Capítulo 4. Considerações para a produção de um bom documento de EES

4.3.2. Não ambíguo
Um documento de EES é não ambíguo se e só se todas as exigências expressas nele têm apenas uma única
interpretação. Como mínimo, isto requer que cada característica do produto final seja descrita usando termos simples
e únicos.
Nas situações em que um termo ao ser utilizado em determinado contexto possa adquirir múltiplos significados, esse
termo deve ser incluído num glossário onde o seu significado é tornado mais específico.
Um documento de EES é uma parte importante do processo de exigências do ciclo de vida do software, sendo
também utilizado nas fases de desenho, implementação, monitorização do projecto, verificação e validação, e na fase
de treino tal como descrito no standard IEEE-std-1074-1997. O documento de EES não pode conter ambiguidades,
quer para quem o cria quer para quem o utiliza. No entanto, frequentemente estes dois grupos de pessoas não
possuem o mesmo background e por essa razão tendem a não descrever as exigências de software da mesma forma.
Representações que melhorem a especificação de exigências para a equipa de desenvolvimento tendem a ser
contra-productivos porque diminuem a compreensão do documento pelos utilizadores e vice-versa.
Da Secção 4.3.2.1 até à Secção 4.3.2.3 encontra-se as recomendações para evitar ambiguidades.


4.3.2.1. Problemas da língua natural
As exigências são normalmente escritas em língua natural (por exemplo Português ou Inglês). A língua natural é
propícia a ambiguidades. Uma língua natural de um documento de EES deve ser revista por alguém independente
para identificar o uso de ambiguidades da linguagem, que devem ser corrigidas.


4.3.2.2. Linguagens de especificação de exigências
Um modo de contornar a ambiguidade inerente da linguagem natural consiste em escrever um documento de EES
numa linguagem especial, orientada para especificação de exigências. O processador desta linguagem tem a
capacidade de detectar automaticamanente muitos erros lexicais, sintácticos e semânticos.
Uma desvantagem destas linguagens é o tempo necessário para as aprender. Acresce ainda que os utilizadores não
técnicos acham estas linguagens incompreensíveis. Estas linguagens têm tendência a servir para especificar certos
tipos de exigências, e exigências de domínios específicos que são utilizadas para certos tipos de sistemas. Por isso,
estas linguagens podem influenciar as exigências de formas por vezes subtis.


4.3.2.3. Ferramentas de representação
De uma forma geral, os métodos e linguagens de exigências bem como as respectivas ferramentas que as suportam
podem ser agrupadas em três categorias - Objectos, processos e comportamentais. As aproximações orientadas aos
objectos organizam as exigências em termos de objectos do mundo real, dos seus atributos, e dos serviços que
oferecem. As aproximações baseadas em processos organizam as exigências em hierarquias de funções que
comunicam através de fluxo de dados. Finalmente, as aproximações comportamentais descrevem o comportamento
externo do sistema em termos de noções abstractas (por exemplo, através do cálculo de predicados), através de
funções matemáticas, ou através de máquinas de estados.
O grau até ao qual estas ferramentas e métodos se constituem úteis na preparação de um documento de EES depende
do tamanho e da complexidade do programa. Este standard não pretende descrever ou sugerir nenhuma ferramenta
em particular.




                                                                                                                        7
                                          Capítulo 4. Considerações para a produção de um bom documento de EES

Ao utilizar qualquer uma destas aproximações recomenda-se que se conserve a utilização da linguagem natural.
Desta forma, os clientes que não estejam familiarizados com notações podem também compreender o documento de
EES.




4.3.3. Completo
Um documento de EES é considera-se completo, se, e só se, inclui os seguintes elementos:

  a. Todas as exigências significantes, quer se prendam com a funcionalidade, o desempenho, restrições de desenho,
     atributos, ou interfaces externas (em particular, quaisquer exigências externas impostas por especificações de
     sistemas) estão reconhecidas e tratadas.
  b. Estão definidas as respostas do software a todas as classes realizáveis de entradas de dados em todas as classes
     de situações.
  c. Legendas e referências completas para todas as figuras, tabelas e diagramas do documento de EES bem como a
     definição de todos os termos e unidades de medida.


4.3.3.1. Utilização de TDBs
Qualquer documento de EES que utilize a frase "a determinar" ou "to be determined" (TBD) não está completo. O
acrónimo TBD é no entanto necessário ocasionalmente e deve ser acompanhado por:

  a. Uma descrição das condições que causam o TBD (por exemplo, explicação de porque não é conhecida a
     resposta) de forma a que a situação possa ser resolvida.
  b. Uma descrição do que deve ser feito para eliminar o TBD, quem é responsável pela sua eliminação, e até quando
     deve ser eliminado.




4.3.4. Consistência
Consistência refere-se à consistência interna. Se um documento de EES não está de acordo com um documento de
mais alto nível, tal como seja uma especificação de exigências de sistema, então ele não está correcto (veja a Secção
4.3.1).


4.3.4.1. Consistência interna
Um documento de EES é internamente consistente se, e só se, nenhum sub-conjunto individual de exigências
descrito nele entra em conflito. Existem três tipos de conflitos possíveis num documento de EES, como se segue:

  a. As características dos objectos do mundo real podem entrar em conflito. Por exemplo:

      1. O formato de um relatório de saída pode ser descrito numa exigência como tabular mas noutra como textual;
      2. Uma exigência pode afirmar que todos os leds são verdes enquanto outra pode afirmar que todos os leds
         devem ser vermelhos.

  b. Podem existir conflitos entre duas acções especificadas. Por exemplo:



                                                                                                                        8
                                         Capítulo 4. Considerações para a produção de um bom documento de EES

      1. Uma exigência pode especificar que um programa deve adicionar dois valores enquanto outra pode
         especificar que devem ser multiplicados;
      2. Uma exigência pode afirmar que "A" deve sempre seguir "B", enquanto outra pode exigir que "A" e "B"
         ocorram simultaneamente.

  c. Duas ou mais exigências podem descrever o mesmo objecto do mundo real mas usam diferentes termos para
     esse objecto. Por exemplo, um pedido de entrada por parte do utilizador num programa pode chamar-se
     "prompt" numa exigência, enquanto noutro pode chamar-se "indicador". A utilização de terminologia standard e
     definições assentes em glossários promove a consistência.




4.3.5. Classificação por importância e/ou estabilidade
Um documento de EES encontra-se classificado por importância e/ou estabilidade se cada exigência nele contido tem
associada um identificador de estabilidade e/ou importância.
Tipicamente, as exigências de um produto de software não são da mesma importância. Algumas exigências podem
ser essenciais, especialmente para aplicações críticas, enquanto que outras podem ser apenas desejáveis.
Cada exigência de um documento de EES deve conter identificações que tornem estas diferenças claras e explícitas.
Esta identificação ajuda a:

  a. Fazer com que os clientes olhem para cada exigência com maior atenção. Como resultado, algumas assunções
     escondidas que o possa fazer são clarificadas.
  b. Fazer com que as equipas de desenvolvimento possam tomar decisões de desenho mais correctas e empregar
     níveis de esforço distintos nas diferentes partes do projecto.


4.3.5.1. Grau de estabilidade
Um método para classificação das exigências utiliza a dimensão da estabilidade. A estabilidade pode ser expressa em
termos do número de modificações esperadas a uma exigência, baseado na experiência ou em conhecimento de
eventos futuros que afectem a organização, as funções ou as pessoas apoiadas pelo software.


4.3.5.2. Grau de necessidade
Uma outra forma de classificar as exigências consiste em distingui-las como essenciais, condicionais e opcionais.

  a. Essenciais. Implicam que o software não será aceite a não ser que essas exigências sejam implementadas da
     forma acordada.
  b. Condicionais. Implicam que as exigências constituem melhorias ao produto de software mas a sua ausência não
     o torna inaceitável.
  c. Opcionais. Implica que estas exigências se refiram a funcionalidades que podem não ser necessárias. Estas
     exigências dão ao fornecedor a oportunidade de propor algo que exceda o documento de EES.




                                                                                                                    9
                                         Capítulo 4. Considerações para a produção de um bom documento de EES

4.3.6. Verificável
Um documento de EES diz-se verificável se, e só se, cada exigência especificada é verificável. Uma exigência é
verificável, se e só se, existe um processo finito e de custo aceitável através do qual uma pessoa ou uma máquina
pode verificar que o produto de software cumpre essa exigência. Em geral uma exigência ambígua não é verificável.
Exigências não verificáveis incluem por norma frases tais como "trabalha bem", "boa interface" ou "irá acontecer
normalmente". Estas exigências não podem ser verificados pois não é possível definir os termos "bom", "bem" ou
"normalmente". A exigência "O programa nunca entrará num ciclo infinito" embora esteja definida objectivamente,
não é verificável, pois testar esta qualidade é teoricamente impossível.

Exemplo 4-1. Exemplo de uma exigência verificável

O resultado do programa é produzido em menos de 20 segundos a partir do momento da recepção do evento
"arranque".



Esta exigência é verificável porque utiliza termos e quantidades mensuráveis.
Se não é possível descrever um processo para determinar se o software implementa uma exigência, então essa
exigência deve ser removida ou revista.



4.3.7. Modificável
Um documento de EES diz-se modificável se, e só se, a sua estrutura e estilo são tais que mudanças a exigências
podem ser efectuadas de forma fácil, completa e consistente, preservando simultaneamente estrutura e estilo. Para ser
modificável, um documento de EES geralmente requer as seguintes características:

  a. Uma estrutura coerente, uma organização que o torne de fácil utilização com um índice (tabela de conteúdos),
     um índice remissivo e referências cruzadas;
  b. Não contenha redundâncias (isto é, a mesma exigência não deve estar definida em mais do que um local do
     documento);
  c. Expresse cada exigência de forma separada. A definição de uma exigência não deve estar misturada ou dispersa
     em outras exigências.
A redundância em si mesma não é um erro, mas leva à ocorrência de erros. A redundância pode ocasionalmente
ajudar a tornar um documento de EES mais legível, mas o problema surge quando o documento é actualizado. Por
exemplo, uma exigência pode ser alterada em apenas um dos locais onde aparece. O documento de EES fica então
inconsistente. Quando a redundância for mesmo necessária, devem utilizar-se referências cruzadas para tornar o
documento modificável.



4.3.8. Rastreável
Um documento de EES diz-se rastreável se cada uma das suas exigências é clara e facilitadora da identificação da
mesma exigência em versões futuras do desenvolvimento ou da documentação. São recomendados os seguintes dois
tipos de rastreio:




                                                                                                                    10
                                          Capítulo 4. Considerações para a produção de um bom documento de EES

  a. Rastreio para trás (i. e. para estádios anteriores do desenvolvimento). Isto depende do facto de cada exigência
     explicitamente referir a sua fonte em outros documentos que dão origem ao requisito.
  b. Rastreio para a frente (i. e. para todos os documentos que emanam do documento de EES, sejam eles código ou
     documentação propriamente dita). Isto depende do facto de cada exigência no documento de EES ter um nome
     ou um número de referência únicos.
O rastreio para a frente num documento de EES é especialmente importante quando o produto de software entra na
fase de operação e manutenção. À medida que o código e o desenho vão sendo modificados, torna-se essencial
possuir meios para aferir acerca do conjunto completo de exigências que podem ser afectados por essas modificações.




4.4. Preparação conjunta do documento de EES
O processo de desenvolvimento de software deve começar com o acordo por parte do cliente e do fornecedor acerca
daquilo que o software, uma vez completo, deve fazer. Este acordo, sob a forma de um documento de EES, deve ser
preparado de forma conjunta. Isto é importante pois usualmente nem o cliente nem o fornecedor estão
completamente qualificados para escrever um bom documento de EES de uma forma unilateral.

  a. Os clientes normalmente não compreendem o suficiente dos processos de desenho e desenvolvimento de
     software para escrever este documento.
  b. Os fornecedores normalmente não compreendem os problemas e os negócios dos clientes o suficiente para
     escreverem o documento de exigências de forma satisfatória.
Assim sendo, o cliente e o fornecedor devem trabalhar de forma conjunta para produzir um documento de exigências
bem escrito e completo.
O caso em que o software e o sistema onde se enquadra estão a ser elaborados simultaneamente constituiu uma
situação especial. Neste caso a funcionalidade, as interfaces, o desempenho, outros atributos e restrições do software
não são predefinidos, mas sim definidos de forma conjunta, ficando sujeitos à negociação e à mudança. Isto torna
mais difícil, mas não menos importante, o alcance das características expressas na Secção 4.3. Em particular, se um
documento de EES não está de acordo com a especificação do seu sistema de acolhimento, está incorrecto.
A presente recomendação de prática (este standard) não discute um estilo específico, uso de linguagem, ou técnicas
de boa escrita. Reveste-se da maior importância no entanto que um documento de EES esteja bem escrito. Livros
sobre escrita técnica devem ser utilizados para melhorar as capacidades de escrita de exigências.



4.5. Evolução do documento de EES
O documento de EES pode necessitar de evoluir à medida que o desenvolvimento do produto de software avança.
Pode ser impossível especificar todos os detalhes na altura em que o projecto é iniciado (por exemplo, pode ser
impossível definir todos os formatos de ecrã de uma aplicação interactiva durante a fase de requisitos). Mudanças
subsequentes do documento podem ser encaradas como deficiências ou imprecisões descobertas no documento de
EES.
As duas principais considerações a ter neste processo são:




                                                                                                                       11
                                           Capítulo 4. Considerações para a produção de um bom documento de EES

  a. As exigências devem ser especificadas da forma mais completa e aprofundada possível a partir do conhecimento
     disponível num determinado momento (pode implicar pesquisa), ainda que revisões evolutivas se prevejam
     inevitáveis. O facto de que a descrição está incompleta deve ser anotado.
  b. Um processo formal de modificações deve ser iniciado para identificar, controlar, rastrear e reportar as
     modificações projectadas. As modificações aprovadas nas exigências devem ser incorporadas no documento de
     EES de forma a
      1. Providenciar um historial de modificações auditável, preciso e completo.
      2. Permitir a revisão de porções correntes ou já substituídas do documento de EES.



4.6. Prototipagem
A prototipagem é utilizada frequentemente durante a fase de desenvolvimento de exigências. Várias ferramentas
podem ser utilizadas de forma a permitir a criação de um protótipo que exiba algumas características do sistema, de
forma rápida e fácil. Consulte também a norma ASTM E1340-96.
Um protótipo é útil pelas seguintes razões:

  a. O cliente tem maior probabilidade de reagir ao olhar para o protótipo do que ao ler o documento de exigências.
     Assim, um protótipo permite respostas rápidas.
  b. O protótipo exibe aspectos do comportamento do sistema que ainda não haviam sido previstos. Assim,
     produzem-se não apenas novas respostas mas novas perguntas. Isto acelera a convergência do documento de
     EES.
  c. Um documento de EES desenvolvido com base em prototipagem tende a sofrer menos modificações durante o
     seu desenvolvimento, encurtando desta forma o tempo de desenvolvimento.



4.7. Incorporação do desenho no documento de EES
Uma exigência especifica uma função externamente visível ou um atributo de um sistema. O desenho descreve um
sub-componente particular do sistema e/ou as suas interfaces com outros sub-componentes. Quem escreve
documentos de EES deve distinguir claramente entre a definição de restrições de desenho e o vínculo a um desenho
específico. Note-se que cada exigência de um documento de EES limita as alternativas de desenho. Isto não significa,
no entanto, que qualquer exigência seja desenho.
O documento de EES deve especificar quais as funções que devem ser levadas a cabo em que dados, de forma a
produzir que resultados, em que local, e para quem. O documento de EES deve focar-se em serviços a desempenhar.
O documento de EES não deve normalmente especificar os seguintes itens de desenho:

  a. Subdivisão do software por módulos;
  b. Alocação de funções a módulos;
  c. Descrever o fluxo de informação ou controlo entre módulos;
  d. Escolha de estruturas de dados;




                                                                                                                 12
                                             Capítulo 4. Considerações para a produção de um bom documento de EES

4.7.1. Exigências de desenho necessárias
Existem casos especiais em que as exigências podem restringir severamente o desenho. Por exemplo, exigências de
segurança ou salvaguarda podem reflectir-se directamente no desenho, despoletando a necessidade de:

  a. Manter certas funcionalidades em módulos separados;
  b. Limitar a comunicação entre algumas áreas do programa;
  c. Verificar a integridade de variáveis críticas;
Exemplos de restrições de desenho válidas são: restrições físicas; restrições de desempenho; standards de
desenvolvimento de software; standards de certificação de qualidade de software.
Assim sendo, as exigências devem ser sempre especificadas de um ponto de vista puramente externo. Quando forem
utilizados modelos para ilustrar as exigências, deve ser lembrado que o modelo apenas indica o comportamento
externo, e não especifica o desenho.




4.8. Incorporação de exigências do projecto no documento de EES
O documento de EES deve focar-se no produto de software e não no processo de produção do produto de software.
As exigências do projecto representam um entendimento entre o cliente e o fornecedor sobre questões contratuais
relacionadas com o processo de software e assim não podem ser incluídas nas exigências. Nestes itens incluem-se
referências a:

  a. Custo;
  b. Datas de entrega;
  c. Procedimentos de reporte;
 d. Métodos de desenvolvimento de software;
  e. Certificação de qualidade;
  f. Critérios de verificação e validação;
 g. Procedimentos de aceitação;
Exigências do projecto são especificados em outros documentos, tipicamente num plano de desenvolvimento de
software e num plano de certificação de qualidade de software.




                                                                                                                  13
Capítulo 5. As partes de um documento de EES
Esta cláusula discute cada um dos componentes essenciais de um documento de EES. Estas partes são apresentadas
na Tabela 1, delineando uma estrutura que pode servir de exemplo para a escrita de documentos de EES.
Se bem que um documento de EES não tenha de seguir esta estrutura ou utilizar os nomes aqui sugeridos para os
seus componentes, um bom documento de exigências deve incluir toda a informação aqui descrita.

Tabela 5-1. Protótipo da estrutura de um documento de EES

   1. Introdução
           1.1. Propósito

          1.2. Âmbito

          1.3. Definições, acrónimos e abreviaturas

          1.4. Referências

          1.5. Organização



   2. Descrição geral
          2.1. Perspectiva do produto

          2.2. Funcionalidades do produto

          2.3. Características do utilizador

          2.4. Restrições

          2.5. Assunções e dependências



   3. Exigências específicas (Ver da Secção 5.3.1 até à Secção 5.3.8 para explicações acerca das exigências
 específicas. Nos apêndices, ver também o Apêndice A onde se encontram diferentes formas de organizar esta
 secção do documento de exigências.)

   4. Apêndices

   5. Índice remissivo




5.1. Introdução (Secção 1 do documento de EES)
A introdução do documento de EES deve providenciar uma visão geral sobre o documento inteiro. Deve por isso




                                                                                                                14
                                                                        Capítulo 5. As partes de um documento de EES

conter as seguintes sub-secções:

  a. Propósito;
  b. Âmbito;
  c. Definições, acrónimos e abreviaturas;
 d. Referências;
  e. Organização;


5.1.1. Propósito (Secção 1.1 do documento de EES)
Esta secção deve:

  a. Delinear o propósito do documento de EES;
  b. Especificar a audiência alvo do documento de EES.



5.1.2. Âmbito (Secção 1.2 do documento de EES)
Esta secção deve:

  a. Identificar o produto de software a desenvolver pelo seu nome;
  b. Explicar o que o produto irá fazer, e se necessário, o que não irá fazer;
  c. Descrever a aplicação do software, incluindo benefícios relevantes e objectivos;
 d. Ser consistente com outros documentos similares ou de mais alto nível (por exemplo, a especificação das
    exigências do sistema), caso existam.



5.1.3. Definições, acrónimos e abreviaturas (Secção 1.3 do documento de EES)
Esta sub-secção deve fornecer as definições de todos os termos, acrónimos e abreviaturas necessários à interpretação
do documento de EES. Esta informação pode ser fornecida por referência a um ou mais apêndices do documento de
EES ou por referência a outros documentos.



5.1.4. Referências (Secção 1.4 do documento de EES)
Esta secção deve:

  a. Fornecer uma lista completa de todos os outros documentos referenciados pelo documento de EES;
  b. Identificar cada documento pelo seu título, número de relatório (quando aplicável), data e organização que o
     publica;
  c. Especificar as fontes de onde as referências podem ser obtidas;
Esta informação pode ser fornecida por referência a um apêndice ou a outro documento.




                                                                                                                    15
                                                                    Capítulo 5. As partes de um documento de EES

5.1.5. Organização (Secção 1.5 do documento de EES)
Esta secção deve:

  a. Descrever o conteúdo do documento de EES;
  b. Explicar a organização do documento de EES;




5.2. Descrição geral (Secção 2 do documento de EES)
Esta secção do documento de EES deve descrever os factores gerais que afectam o produto e as suas exigências. Esta
secção não enumera exigências específicas. Ao invés, fornece um contexto para essas exigências (que são definidas
em detalhe na Secção 3 do documento de EES), e facilita a sua compreensão (ver a Secção 5.3).
Esta secção consiste habitualmente em 6 sub-secções:

  a. Perspectiva do produto;
  b. Funções do produto;
  c. Características do utilizador;
 d. Restrições;
  e. Assunções e dependências;
  f. Divisão e atribuição das exigências.


5.2.1. Perspectiva do produto (Secção 2.1 do documento de EES)
Esta sub-secção do documento de EES deve colocar o produto em perspectiva relativamente a outros produtos
relacionados. Se o produto é independente e totalmente auto-contido, isso deve ser explicitado aqui. Se o documento
de EES define um produto que forma parte de um sistema maior, como é frequentemente o caso, então esta
sub-secção deve relacionar as exigências do sistema envolvente com a funcionalidade do software e deve identificar
interfaces entre o sistema e o software.
Um diagrama de blocos mostrando os componentes principais do sistema envolvente, interligações e interfaces
externas poderá ser útil.
Esta sub-secção deve também descrever a operação do software dentro de várias restrições. Por exemplo, estas
restrições podem incluir

  a. Interfaces de sistema;
  b. Interfaces com o utilizador;
  c. Interfaces de hardware;
 d. Interfaces de software;
  e. Interfaces de comunicação;
  f. Memória;
 g. Operações;




                                                                                                                 16
                                                                        Capítulo 5. As partes de um documento de EES

    h. Adaptações ao local de instalação;


5.2.1.1. Interfaces de sistema
Aqui deve ser listada cada interface de sistema e identificada a funcionalidade do software que cumpre a exigência
do sistema.


5.2.1.2. Interfaces com o utilizador
Aqui deve ser especificado o seguinte:

    a. As características lógicas de cada interface entre o produto de software e os seus utilizadores. Isto inclui as
       características de configuração (por exemplo, formatos de ecrã necessários, disposição de página ou janela,
       conteúdo de quaisquer relatórios ou menus, ou disponibilidade de teclas de função programáveis) necessárias
       para cumprir as exigências de software.
    b. Todos os aspectos de optimização da interface com a pessoa que deve usar o sistema. Isto pode consistir
       simplesmente de uma lista do que se deve ou não fazer no modo como o sistema aparece ao utilizador. Um
       exemplo pode ser a exigência para uma opção de mensagens de erro longas ou curtas. Tal como todas as outras,
       estas exigências devem ser verificáveis, por exemplo, "um funcionário dactilógrafo de grau 4 consegue fazer a
       função X em Z minutos após 1 hora de treino" em vez de "um dactilógrafo pode fazer a função X". Isto pode
       também ser especificado na secção de Atributos do sistema de software (ver Secção 5.3.6), sob uma sub-secção
       intitulada Facilidade de Utilização.


5.2.1.3. Interfaces de hardware
Aqui devem ser especificadas as características lógicas de cada interface entre o produto de software e os
componentes de hardware do sistema. Isto inclui características de configuração (número de portos, conjuntos de
instruções, etc.). Cobre também assuntos como os dispositivos a suportar, como estes devem ser suportados, e
protocolos.


5.2.1.4. Interfaces de software
Aqui deve ser especificado o uso de outros produtos de software necessários (por exemplo, um sistema de gestão de
base de dados, um sistema operativo, ou um pacote matemático), e interfaces com outros sistemas aplicacionais (por
exemplo, a ligação entre um sistema de vendas e o sistema de contabilidade). Para cada produto de software
necessário deve ser fornecido o seguinte:

•   Nome;
•   Mnemónica;
•   Número de especificação;
•   Número de versão;
•   Fonte.
Para cada interface, o seguinte deve ser fornecido:




                                                                                                                         17
                                                                       Capítulo 5. As partes de um documento de EES

•   Uma discussão sobre a função do software com que é feita a interface e a sua relação com este produto de
    software;
•   Definição da interface em termos de conteúdo e formato de mensagens. Não é necessário detalhar interfaces que
    estejam bem documentadas, mas deve existir uma referência para o documento que define a interface.


5.2.1.5. Interfaces de comunicação
Aqui devem ser especificadas as várias interfaces de comunicação, tais como protocolos de rede, etc..


5.2.1.6. Memória
Aqui devem ser especificados os limites e quaisquer outras características aplicáveis da memória primária e
secundária.


5.2.1.7. Operações
Aqui devem ser especificadas as operações normais e especiais requeridas pelo utilizador, tais como

    a. Os vários modos de operação na organização que utiliza o software (por exemplo, operações iniciadas pelos
       utilizadores);
    b. Períodos de operação interactiva e períodos de operação não supervisionada;
    c. Funções de suporte a processamento de dados;
    d. Operações de cópia de segurança e restauro.

      Nota: Isto é por vezes especificado como parte da secção Interface com o Utilizador




5.2.1.8. Exigências de adaptação ao local
Aqui deve-se:

    a. Definir as exigências para quaisquer dados ou sequências de inicialização que sejam específicos a um local de
       instalação, missão ou modo de operação (por exemplo, limites de segurança, etc.);
    b. Especificar as características relacionadas com um local de instalação ou missão que devem ser modificadas para
       adaptar o sofware a uma instalação em particular;




5.2.2. Funções do produto (Secção 2.2 do documento de EES)
Esta sub-secção do documento de EES deve fornecer um resumo das principais funções que o software vai
desempenhar. Por exemplo, um documento de EES para um programa de contabilidade pode usar esta secção para
referir manutenção de contas de cliente, balanços e preparação de recibos, sem mencionar as vastas quantidades de
detalhe que cada uma dessas funções necessita.




                                                                                                                       18
                                                                      Capítulo 5. As partes de um documento de EES

Por vezes o resumo de funções que é necessário para esta secção pode ser retirado directamente da secção de
especificação de alto nível (caso exista) que atribui funções particulares ao produto de software. Note-se que, para
bem da clareza:

  a. As funções devem ser organizadas de um modo que torne a lista de funções compreensível para o cliente, ou
     quem quer que esteja a ler o documento pela primeira vez.
  b. Métodos textuais ou gráficos podem ser usados para mostrar as diferentes funções e as suas inter-relações. Tais
     diagramas não se destinam a mostrar o desenho técnico do produto, mas simplesmente a mostrar as relações
     lógicas entre variáveis.



5.2.3. Características do utilizador (Secção 2.3 do documento de EES)
Esta sub-secção do documento de EES deve descrever as características gerais dos utilizadores alvo do produto,
incluindo nível de formação, experiência e proficiência técnica. Não deve ser usada para ditar exigências específicas,
mas sim para fornecer as razões pelas quais certas exigências específicas são mais tarde determinados na Secção 3 do
documento de EES (ver a Secção 5.3).



5.2.4. Restrições (Secção 2.4 do documento de EES)
Esta sub-secção do documento de EES deve fornecer uma descrição geral de quaisquer outros itens que limitem as
opções de desenvolvimento. Estes incluem:

  a. Regulamentos;
  b. Limitações de hardware;
  c. Interfaces com outras aplicações;
  d. Operação em paralelo;
  e. Funções de auditoria;
  f. Funções de controlo;
  g. Exigências de alto nível da linguagem;
  h. Protocolos de signal handshake;
  i. Exigências de fiabilidade;
  j. Criticalidade da aplicação;
  k. Considerações de segurança.



5.2.5. Assunções e dependências (Secção 2.5 do documento de EES)
Esta sub-secção do documento de EES deve listar cada um dos factores que afectam as exigências ditadas no
documento de EES. Estes factores não são restrições de desenho do software mas sim factores que, ao mudarem,
afectam as exigências presentes no documento de EES. Por exemplo, pode ser assumido que um determinado
sistema operativo estará disponível no hardware designado para o produto de software. Se mais tarde se verificasse
que tal sistema operativo não está de facto disponível, o documento de EES teria então de ser alterado.




                                                                                                                       19
                                                                     Capítulo 5. As partes de um documento de EES

5.2.6. Divisão e atribuição das exigências (Secção 2.6 do documento de EES)
Esta sub-secção do documento de EES deve identificar as exigências que podem ser adiadas para versões futuras do
sistema.




5.3. Exigências específicas (Secção 3 do documento de EES)
Esta secção do documento de EES deve conter todas as exigências de software a um nível de detalhe suficiente para
permitir que seja feito o desenho de um sistema que satisfaz as exigências, e que sejam feitos testes que mostrem que
o sistema satisfaz essas mesmas exigências. Ao longo desta secção, cada exigência que é ditada deve ser
externamente perceptível por utilizadores, operadores ou outros sistemas externos. Estas exigências devem incluir no
mínimo uma descrição de cada entrada (estímulo) ao sistema, cada saída (resposta) do sistema, e todas as funções
levadas a cabo pelo sistema em resposta a uma entrada ou em suporte de uma saída. Uma vez que esta é
frequentemente a parte maior e mais importante do documento de EES, aplicam-se os seguintes princípios:

  a. Exigências específicas devem ser ditadas de acordo com todas as características descritas na Secção 4.3;
  b. Exigências específicas devem fazer referência a documentos anteriores que estejam relacionados;
  c. Todas as exigências devem ser unicamente identificáveis;
  d. Deve ser dada atenção cuidada à organização das exigências, de forma a maximizar a legibilidade.
Antes de examinar formas específicas de organizar as exigências é útil entender os vários itens em que consiste a
exigência, como é descrito da Secção 5.3.1 até à Secção 5.3.7.


5.3.1. Interfaces externas
Esta deve ser uma descrição detalhada de todas as entradas e saídas do sistema de software. Deve complementar as
descrições de interfaces da Secção 5.2 e não deve repetir informação lá detalhada.
Deve cobrir quer conteúdo quer formato, da seguinte maneira:

  a. Nome do item;
  b. Descrição do objectivo;
  c. Fonte da entrada ou destino da saída;
  d. Intervalo de validade, precisão e/ou tolerância;
  e. Unidades de medida;
  f. Temporizações;
  g. Relação com outras entradas/saídas;
  h. Formato/organização de ecrã;
  i. Formato/organização de janela;
  j. Formatos de dados;
  k. Formatos de comandos;
  l. Mensagens finais.




                                                                                                                    20
                                                                     Capítulo 5. As partes de um documento de EES

5.3.2. Funções
As exigências funcionais devem definir as acções fundamentais que devem ter lugar no software ao aceitar e
processar as entradas e ao processar e gerar as saídas. Estes são geralmente listados usando frases na forma "O
sistema deve...".
Estas incluem:

  a. Validações da entrada;
  b. Sequências exactas de operação;
  c. Reacções a situações anormais, incluindo:
      1. Overflow
      2. Falhas de comunicação
      3. Tratamento e recuperação de erros

  d. Efeitos dos parâmetros;
  e. Relação de entradas com saídas, incluindo
      1. Sequências de entrada/saída
      2. Formulas de conversão da entrada para a saída

Pode ser apropriado dividir as exigências funcionais em sub-funções ou sub-processos. Isto não implica que o
desenho do software também venha a ser dividido da mesma forma.



5.3.3. Exigências de desempenho
Esta sub-secção deve especificar exigências numéricas estáticas e exigências numéricas dinâmicas impostas ao
software ou à interacção humana com o software como um todo. Exigências numéricas estáticas podem incluir os
seguintes pontos:

  a. O número de terminais a suportar;
  b. O número de utilizadores simultâneos a suportar;
  c. Quantidades e tipos de informação a processar.
As exigências numéricas estáticas são por vezes identificadas sob uma secção separada intitulada Capacidade.
As exigências numéricas dinâmicas podem incluir, por exemplo, o número de transacções e tarefas e a quantidade de
dados a processar num determinado período de tempo, em condições de carga normal e carga máxima.
Todas estas exigências devem ser definidas em termos quantificáveis. Por exemplo, "95% das transacções devem ser
processadas em menos de 1 segundo" em vez de "O operador não deve ter de esperar que a transacção complete".

     Nota: Limites numéricos aplicáveis a uma função específica são normalmente especificados como parte de um
     sub-parágrafo de descrição do processamento dessa função.




                                                                                                                  21
                                                                      Capítulo 5. As partes de um documento de EES

5.3.4. Exigências lógicas da base de dados
Aqui devem ser especificadas as exigências lógicas sobre qualquer informação que deva ser colocada numa base de
dados. Isto pode incluir o seguinte:

  a. Tipos de informação usados pelas várias funções;
  b. Frequência de uso;
  c. Capacidades de acesso;
  d. Entidades e relações;
  e. Restrições de integridade;
  f. Exigências de retenção dos dados.



5.3.5. Restrições de desenho
Aqui devem ser especificadas restrições ao desenho que possam ser impostas por outras normas, limitações de
hardware, etc.


5.3.5.1. Obediência a normas
Esta sub-secção deve especificar as exigências derivadas de normas ou regulamentos existentes. Podem incluir os
seguintes:

  a. Formato de relatórios;
  b. Nomeação de dados;
  c. Procedimentos contabilísticos;
  d. Rastreio e auditoria.
Por exemplo, pode-se especificar aqui a exigência de que o software faça o rastreio da actividade de processamento.
Tal rastreio pode ser necessário em algumas aplicações para estar em conformidade com normas reguladoras ou
financeiras. Uma exigência de rastreio e auditoria pode, por exemplo, ditar que todas as alterações a uma base de
dados de pagamentos sejam gravadas num ficheiro de rastreio com os valores antes e depois da transacção.




5.3.6. Atributos do sistema de software
Existe um número de atributos do software que podem servir de exigências. É importante que os atributos requeridos
sejam especificados de modo a que o seu cumprimento possa ser objectivamente verificado. Da Secção 5.3.6.1 até à
Secção 5.3.6.5 é fornecida uma lista parcial de exemplos.


5.3.6.1. Fiabilidade
Deve especificar os factores necessários para estabelecer a fiabilidade exigida ao sistema de software no acto da
entrega.




                                                                                                                    22
                                                                       Capítulo 5. As partes de um documento de EES

5.3.6.2. Disponibilidade
Deve especificar os factores necessários para garantir um nível definido de disponibilidade para todo o sistema, tais
como o ponto de verificação, recuperação, e reinício.


5.3.6.3. Segurança
Deve especificar os factores que protejam o software do acesso, do uso, da modificação, da destruição, ou da
divulgação acidental ou maliciosa.
As exigências específicas nesta área podem incluir a necessidade de:

  a. Utilizar determinadas técnicas de codificação usando uma determinada cifra;
  b. Manter um histórico ou registo de dados especifico;
  c. Atribuir determinadas funções a módulos diferentes;
  d. Restringir comunicações entre algumas áreas do programa;
  e. Verificar a integridade de dados e variáveis críticas.


5.3.6.4. Capacidade de manutenção
Deve especificar os atributos do software que se relacionam com a facilidade de manutenção do mesmo. Pode haver
determinadas exigências para a modularidade, relações, complexidade, etc. As exigências não devem ser colocadas
aqui apenas porque são geralmente consideradas boas práticas de desenho.


5.3.6.5. Portabilidade
Deve especificar os atributos do software que se relacionam com a facilidade de mover o software para outras
máquinas e/ou sistemas operativos. Pode incluir o seguinte:

  a. Percentagem de componentes com código dependente da máquina;
  b. Percentagem de código dependente da máquina;
  c. Usar uma linguagem provadamente portavel;
  d. Usar um compilador ou um subconjunto específico da linguagem;
  e. Usar um sistema operativo específico.




5.3.7. Organização das exigências especificas
As exigências detalhadas tendem a ser extensivas quando se trata de um sistema não trivial. Por esta razão
recomenda-se uma consideração cuidadosa por forma a organizar as exigências de uma forma simples de
compreender. Não existe uma organização óptima para todos os sistemas. Diferentes classes de sistemas inclinam-se
para diferentes organizações de exigências na Secção 3 de um documento de EES. Algumas dessas organizações são
descritas da Secção 5.3.7.1 até à Secção 5.3.7.7.




                                                                                                                    23
                                                                    Capítulo 5. As partes de um documento de EES

5.3.7.1. Modo de sistema
Alguns sistemas comportam-se de maneiras diferentes dependendo do modo de operação. Por exemplo, um sistema
de controlo pode ter um conjunto de diferentes funções dependendo do seu modo: treino, normal ou emergência.
Quando se organiza esta secção pelo modo devem ser usados os esboços da Secção A.1 ou da Secção A.2 do presente
documento. A escolha depende de as interfaces e a performance serem ou não dependentes do modo de operação.


5.3.7.2. Classe do utilizador
Alguns sistemas providenciam diferentes conjuntos de funções para diferentes classes de utilizadores. Por exemplo,
um sistema de controlo de um elevador apresenta diferentes capacidades para os passageiros, para os trabalhadores
de manutenção e para os bombeiros. Quando se organiza esta secção pela classe do utilizador deve ser usado o
esboço da Secção A.3.


5.3.7.3. Objectos
Objectos são entidades reais que tem correspondência no sistema. Por exemplo, num sistema de monitorização de
pacientes os objectos incluem pacientes, sensores, enfermeiras, quartos, medicamentos, etc. Associado a cada
objecto está um conjunto de atributos desse objecto e funções efectuadas por esse objecto. Essas funções são também
designadas por serviços, métodos ou processos. Quando se organiza esta secção por objecto deve ser usado o esboço
da Secção A.4. Note que conjuntos de objectos podem partilhar atributos e serviços. Estes são agrupados em classes.


5.3.7.4. Característica
Uma característica é um serviço do sistema desejado externamente, que pode necessitar de uma sequência de
entradas para efectuar o resultado desejado. Por exemplo, num sistema telefónico as características incluem a
chamada local, o reencaminhamento da chamada, e a chamada de conferência. Cada característica é descrita
geralmente numa sequência de pares de resposta-estímulo. Ao organizar esta secção por característica deve ser usado
o esboço da Secção A.5.


5.3.7.5. Estímulos
Alguns sistemas podem ser melhor organizados descrevendo as suas funções em termos de estímulos. Por exemplo,
um sistema de aterragem automático pode ser organizado em secções por perda de energia, mudança repentina de
rolamento, velocidade vertical excessiva, etc. Ao organizar esta secção por estímulo deve ser usado o esboço da
Secção A.6.


5.3.7.6. Resposta
Alguns sistemas podem ser melhor organizados descrevendo todas as funções que sustentam a geração de uma
resposta. Por exemplo, as funções de um sistema de pessoal podem ser organizadas em secções de acordo com
funções associadas com a geração de cheques de pagamento, de listas de empregados, etc. Deve ser utilizado o
esboço da Secção A.6 (com todas as ocorrências de estímulos substituídas por respostas).




                                                                                                                24
                                                                    Capítulo 5. As partes de um documento de EES

5.3.7.7. Hierarquia funcional
Quando nenhum dos esquemas organizacionais anteriores provam ser úteis, a funcionalidade total pode ser
organizada numa hierarquia de funções organizadas por entradas comuns, saídas comuns ou dados internos comuns.
Diagramas de fluxo de dados e dicionários de dados podem ser usados para mostrar relacionamentos entre as funções
e os dados. Quando se organiza esta secção pela hierarquia funcional deve ser usado o esboço da Secção A.7.




5.3.8. Comentários adicionais
Sempre que é contemplado um documento de EES novo, várias das técnicas organizacionais dadas na Secção 5.3.7.7
podem ser empregues. Nestes casos, organizam-se as exigências específicas para as múltiplas hierarquias ligadas às
necessidades específicas do sistema que está a ser especificado. Por exemplo, ver a Secção A.8 para uma organização
que combina classes de utilizador e características. Quaisquer exigências adicionais podem ser postas numa secção
separada no fim do documento de EES.
Existem muitas notações, métodos e ferramentas de apoio automatizado disponíveis para ajudar na documentação de
exigências. Na maior parte, a sua utilidade é uma função da organização. Por exemplo, ao organizar por modo,
máquinas de estados finitas e tabelas de estados podem ser úteis; ao organizar por objecto, análise orientada a
objectos por ser útil; ao organizar por característica, sequências de resposta de estímulos podem ser úteis; e ao
organizar por hierarquia funcional, diagramas de fluxo de dados e dicionários de dados podem ser úteis.
Em todos os esboços que vão da Secção A.1 até à Secção A.8 as secções chamadas "Exigência funcional i" podem
ser descritas na língua natural, em pseudocódigo, numa linguagem de definição do sistema ou em quatro sub-secções
chamadas: Introdução, Entradas, Processamento e Saídas.




5.4. Informação de suporte
A informação de suporte torna o documento de EES mais simples de usar. Ela inclui o seguinte:

 1. Tabela de conteúdos
 2. Índice remissivo
 3. Apêndices


5.4.1. Tabela de conteúdos e índice remissivo
A tabela de conteúdos e o índice remissivo são deveras importantes de devem seguir práticas de composição gerais.



5.4.2. Apêndices
Os apêndices nem sempre são considerados parte do documento de EES própriamente dito, e não são sempre
necessários. Eles podem incluir:

 1. Uma amostra de formatos de entrada/saída, descrições de estudos de análise de custos ou resultados de
    questionários;




                                                                                                                25
                                                                    Capítulo 5. As partes de um documento de EES

 2. Informação de suporte ou de fundo que possa ajudar os leitores do documento de EES;
 3. Uma descrição dos problemas a serem resolvidos pelo software;
 4. Instruções de empacotamento especiais para o código e para os suportes de distribuição, por forma a satizfazer
    exigências de segurança, exportação, carregamento inicial ou outras.
Quando são incluídos apêndices, o documento de EES deve explicitamente referir se estes devem ser considerados
parte integrante das exigências.




                                                                                                                 26
Apêndice A. Modelos de EES
(Informativo)


A.1. Modelo de Secção 3 do EES organizada por modo: Versão 1
3. Requisitos Específicos
3.1 Requisitos de Interface Externos
3.1.1 Interfaces de Utilizador
3.1.2 Interfaces de Hardware
3.1.3 Interfaces de Software
3.1.4 Interfaces de Comunicação
3.2 Requisitos Funcionais
3.2.1 Modo 1
3.2.1.1 Requisito Funcional 1.1
...
...
...
3.2.1.n Requisito Funcional 1.n
3.2.2 Modo 2
...
...
...
3.2.m Modo m
3.2.m.1 Requisito Funcional m.1
...
...
...
3.2.m.n Requisito Funcional m.n
3.3 Requisitos de Performance
3.4 Restrições de Desenho
3.5 Atributos do Sistema de Software
3.6 Outros requisitos


A.2. Modelo de Secção 3 do EES organizada por modo: Versão 2
3. Requisitos Específicos
3.1. Requisitos Funcionais
3.1.1 Modo 1
3.1.1.1 Interfaces Externas
3.1.1.1.1 Interfaces de Utilizador
3.1.1.1.2 Interfaces de Hardware
3.1.1.1.3 Interfaces de Software
3.1.1.1.4 Interfaces de Comunicação
3.1.1.2 Requisitos Funcionais
3.1.1.2.1 Requisitos Funcional 1
...
...
...
3.1.1.2.n Requisito Funcional n
3.1.1.3 Performance
3.1.2 Modo 2
...
...
...
3.1.m Modo m
3.2 Restrições de Desenho




                                                               27
                                                            Apêndice A. Modelos de EES

3.3 Atributos do Sistema de Software
3.4 Outros Requisitos


A.3. Modelo de Secção 3 do EES organizada por classe de utilizador
3. Requisitos Específicos
3.1 Requisitos de Interface Externos
3.1.1 Interfaces de Utilizador
3.1.2 Interfaces de Hardware
3.1.3 interfaces de Software
3.1.4 Interfaces de Comunicação
3.2 Requisitos Funcionais
3.2.1 Classe de Utilizador 1
3.2.1.1 Requisito Funcional 1.1
...
...
...
3.2.1.n Requisito Funcional 1.n
3.2.2 Classe de Utilizador 2
...
...
...
3.2.m Classe de Utilizador m
3.2.m.1 Requisito Funcional m.1
...
...
...
3.2.m.n Requisito Funcional m.n
3.3 Requisitos de Performance
3.4 Restrições de Desenho
3.5 Atributos do Sistema de Software
3.6 Outros requisitos


A.4. Modelo de Secção 3 do EES organizada por objecto
3. Requisitos Específicos
3.1 Requisitos de Interface Externos
3.1.1 Interfaces de Utilizador
3.1.2 Interfaces de Hardware
3.1.3 Interfaces de Software
3.1.4 Interfaces de Comunicação
3.2 Classes/Objectos
3.2.1 Classe/Objecto 1
3.2.1.1 Atributos (directos ou herdados)
3.2.1.1.1 Atributo 1
...
...
...
3.2.1.1.n Atributo n
3.2.1.2 Funções (serviços, métodos, directos ou herdados)
3.2.1.2.1 Requisito Funcional 1.1
...
...
...
3.2.1.2.m Requisito Funcional 1.m
3.2.1.3 Mensagens (Comunicações enviadas ou recebidas)
3.2.2 Classe/Objecto 2
...
...



                                                                                   28
                                                 Apêndice A. Modelos de EES

...
3.2.p Classe/Objecto p
3.3 Requisitos de Performance
3.4 Restrições de Desenho
3.5 Atributos do Sistema de Software
3.6 Outros Requisitos


A.5. Modelo de Secção 3 do EES organizada por característica
3. Requisitos Específicos
3.1 Requisitos de Interface Externos
3.1.1 Interfaces de Utilizador
3.1.2 Interfaces de Hardware
3.1.3 Interfaces de Software
3.1.4 Interfaces de Comunicação
3.2 Características de sistema
3.2.1 Característica de sistema 1
3.2.1.1 Introdução/Objectivo da característica
3.2.1.2 Estímulo/Sequência de resposta
3.2.1.3 Requisitos Funcionais Associados
3.2.1.3.1 Requisito Funcional 1
...
...
...
3.2.1.3.n Requisito Funcional n
3.2.2 Característica de sistema 2
...
...
...
3.2.m Característica de sistema m
...
...
...
3.3 Requisitos de Performance
3.4 Restrições de Desenho
3.5 Atributos do Sistema de Software
3.6 Outros Requisitos


A.6. Modelo de Secção 3 do EES organizada por estímulos
3. Requisitos Específicos
3.1 Requisitos de Interface Externos
3.1.1 Interfaces de Utilizador
3.1.2 Interfaces de Hardware
3.1.3 Interfaces de Software
3.1.4 Interfaces de Comunicação
3.2 Requisitos Funcionais
3.2.1 Estímulo 1
3.2.1.1 Requisito Funcional 1.1
...
...
...
3.2.1.n Requisito Funcional 1.n
3.2.2 Estímulo 2
...
...
...
3.2.m Estímulo m
3.2.m.1 Requisito Funcional m.1




                                                                        29
                                                 Apêndice A. Modelos de EES

...
...
...
3.2.m.n Requisito Funcional m.n
3.3 Requisitos de Performance
3.4 Restrições de Desenho
3.5 Atributos do Sistema de Software
3.6 Outros Requisitos


A.7. Modelo de Secção 3 do EES organizada por hierarquia funcional
3. Requisitos Específicos
3.1 Requisitos de Interface Externos
3.1.1 Interfaces de Utilizador
3.1.2 Interfaces de Hardware
3.1.3 Interfaces de Software
3.1.4 Interfaces de Comunicação
3.2 Requisitos Funcionais
3.2.1 Fluxos de Informação
3.2.1.1 Diagrama de fluxo de dados 1
3.2.1.1.1 Entidades de Dados
3.2.1.1.2 Processos Pertinentes
3.2.1.1.3 Topologia
3.2.1.2 Diagrama de fluxo de dados 2
3.2.1.2.1 Entidades de Dados
3.2.1.2.2 Processos Pertinentes
3.2.1.2.3 Topologia
...
...
...
...
3.2.1.n Diagrama de fluxo de dados n
3.2.1.n.1 Entidades de Dados
3.2.1.n.2 Processos Pertinentes
3.2.1.n.3 Topologia
3.2.2 Descrição de Processos
3.2.2.1 Processo 1
3.2.2.1.1 Entidades de dados de entrada
3.2.2.1.2 Algoritmo ou fórmula do processo
3.2.2.1.3 Entidades de dados afectadas
3.2.2.2 Processo 2
3.2.2.2.1 Entidades de dados de entrada
3.2.2.2.2 Algoritmo ou fórmula do processo
3.2.2.2.3 Entidades de dados afectadas
...
...
...
3.2.2.m Processo m
3.2.2.m.1 Entidades de dados de entrada
3.2.2.m.2 Algoritmo ou fórmula do processo
3.2.2.m.3 Entidades de dados afectadas
3.2.3 Especificação de construções de dados
3.2.3.1 Construção 1
3.2.3.1.1 Tipo de registo
3.2.3.1.2 Campos constituintes
3.2.3.2 Construção 2
3.2.3.2.1 Tipo de registo
3.2.3.2.2 Campos constituintes
...
...




                                                                        30
                                                   Apêndice A. Modelos de EES

...
3.2.3.p Construção p
3.2.3.p.1 Tipo de registo
3.2.3.p.2 Campos constituintes
3.2.4 Dicionário dos dados
3.2.4.1 Elemento de dados 1
3.2.4.1.1 Nome
3.2.4.1.2 Representação
3.2.4.1.3 Unidades/Formato
3.2.4.1.4 Precisão/Exactidão
3.2.4.1.5 Intervalo de valores
3.2.4.2 Elemento de dados 2
3.2.4.2.1 Nome
3.2.4.2.2 Representação
3.2.4.2.3 Unidades/Formato
3.2.4.2.4 Precisão/Exactidão
3.2.4.2.5 Intervalo de valores
...
...
...
3.2.4.q Elemento de dados q
3.2.4.q.1 Nome
3.2.4.q.2 Representação
3.2.4.q.3 Unidades/Formato
3.2.4.q.4 Precisão/Exactidão
3.2.4.q.5 Intervalo de valores
3.3 Exigências de desempenho
3.4 Restrições de Desenho
3.5 Atributos do Sistema de Software
3.6 Outros Requisitos


A.8. Modelo de Secção 3 do EES mostrando multiplas
3. Exigências Específicas
3.1 Requisitos de Interface Externos
3.1.1 Interfaces de Utilizador
3.1.2 Interfaces de Hardware
3.1.3 Interfaces de Software
3.1.4 Interfaces de Comunicação
3.2 Exigências Funcionais
3.2.1 Classe de utilizador 1
3.2.1.1 Característica 1.1
3.2.1.1.1 Introdução/Objectivo da característica
3.2.1.1.2 Estímulo/Sequência de resposta
3.2.1.1.3 Exigências Funcionais Associadas
3.2.1.2 Característica 1.2
3.2.1.2.1 Introdução/Objectivo da característica
3.2.1.2.2 Estímulo/Sequência de resposta
3.2.1.2.3 Exigências Funcionais Associadas
...
...
...
3.2.1.m Característica 1.m
3.2.1.m.1 Introdução/Objectivo da característica
3.2.1.m.2 Estímulo/Sequência de resposta
3.2.1.m.3 Exigências Funcionais Associadas
3.2.2 Classe de utilizador 2
...
...
...




                                                                          31
                                       Apêndice A. Modelos de EES

3.2.n Classe de utilizador n
...
...
...
3.3 Exigências de desempenho
3.4 Restrições de Desenho
3.5 Atributos do Sistema de Software
3.6 Outros Requisitos




                                                              32
Apêndice B. Modelo de EES
(Informativo)


B.1. Vista geral
O comité de padrões da tecnologia de programação, Software Engineering Standards Committee (SESC), da IEEE
Computer Society endossou a política de adoptar padrões internacionais. Em 1995, o padrão internacional, ISO/IEC
12207, processos do ciclo de vida da tecnologia de Software de Informação, foi terminado. O padrão estabelece uma
estrutura comum para processos do ciclo de vida do software, com terminologia bem definida, que pode referenciada
pela indústria do software.
Em 1995 o SESC avaliou o ISO/IEC 12207 e decidiu que esse padrão deveria ser adoptado e usado como base para
processos de ciclo de vida dentro da IEEE Software Engineering Collection. A adaptação do ISO/IEC 12207 pela
IEEE é o IEEE/EIA 12207.0-1996. Este contém a norma ISO/IEC 12207 e as seguintes adições: melhoramento da
abordagem de conformidade, objectivos do processo do ciclo de vida, objectivos dos dados do ciclo de vida, e erratas.
A implementação da norma ISO/IEC 12207 dentro da IEEE inclui também o seguinte:

•   IEEE/EIA 12207.1-1997, guia da IEEE/EIA para processos do ciclo de vida do Tecnologia de Software de
    informação - dados do ciclo de vida;
•   IEEE/EIA 12207.2-1997, guia da IEEE/EIA para processos do ciclo de vida do Tecnologia de Software de
    informação - considerações da execução; e
•   As adições a 11 padrões de SESC (isto é, IEEE Stds 730, 828, 829, 830, 1012, 1016, 1058, 1062, 1219, 1233,
    1362) para definir a correlação entre os dados produzidos por padrões existentes de SESC e pelos dados
    produzidos pela aplicação da norma IEEE/EIA 12207.1-1997.

      Nota: Embora a norma IEEE/EIA 12207.1-1997 seja apenas um guia, contém indicações para a sua aplicação
      como sendo um padrão com conformidade de exigências específicas. Este apêndice trata a norma
      12207.1-1997 como um padrão.




B.1.1. Escopo e finalidade
A norma IEEE Std 830-1998 e a norma IEEE/EIA 12207.1-1997 colocam exigências no Documento Descritivo de
Exigências de Software. A finalidade deste apêndice é explicar o relacionamento entre as duas normas das exigências
de modo que os utilizadores possam produzir os originais pretendidos que respeitam as ambas as normas o possam
fazer.




B.2. Correlação
Esta cláusula explica o relacionamento entre a norma IEEE Std 830-1998, a norma IEEE/EIA 12207.0-1996 e a
norma IEEE/EIA 12207.1-1997 nas seguintes áreas: terminologia, processo, e dados do ciclo de vida.




                                                                                                                  33
                                                                                     Apêndice B. Modelo de EES

B.2.1. Correlação de terminologia
Tanto esta norma recomendada como a norma IEEE/EIA 12207.0-1996, têm uma semântica similar para os termos
chave do software, das exigências, da especificação, do fornecedor, do colaborador, e de quem faz a manutenção.
Esta norma recomendada usa o termo "cliente" onde a norma IEEE/EIA 12207.0-1996 usa o "comprador", e esta
norma recomendada usa o "utilizador" onde a norma IEEE/EIA 12207.0-1996 usa o "operador".



B.2.2. Correlação de processo
IEEE/EIA 12207.0-1996 usa uma aproximação orientada ao processo de modo a definir a descrição de um conjunto
de exigências para o software. Esta prática recomendada, usa uma aproximação orientada ao produto, onde o produto
é uma descrição das exigências do software (SRD). Existem etapas naturais de processo, nomeadamente as etapas de
criação de cada parcela do SRD. Estas podem ser correlacionadas com as exigências no processo da norma
IEEE/EIA 12207.0-1996. A diferença é que esta prática está focalizada no desenvolvimento de exigências do
software visto que a norma IEEE/EIA 12207.0-1996 fornece uma vista global do ciclo de vida e menciona a análise
de exigências do software como a parte de seu processo do desenvolvimento. Esta prática fornece um nível mais
elevado no detalhe em o que é envolvido na preparação de um SRD.



B.2.3. Correlação do ciclo de vida dos dados
IEEE/EIA 12207.0-1996 parte do ponto de vista que as exigências do software são derivados das exigências do
sistema. Consequentemente, usa o termo, "descrição" em vez de "especificação" para descrever as exigências do
software. Num sistema em que o software é um componente, cada componente requer a sua própria especificação,
haveria uma especificação de exigências do sistema (documento de EES) e um ou mais SRDs. Se o termo
especificação de exigências do software fosse usado, haveria confusão entre um documento de EES que se refere a
um sistema ou a um componente. No caso onde há um sistema de software autónomo, a norma IEEE/EIA
12207.1-1997 indica "se o software for um sistema autónomo, então este documento deve ser uma especificação".




B.3. Mapeamento de conteúdo
Esta cláusula fornece os detalhes que indicam uma reivindicação de que um documento de EES que obedece a esta
prática recomendada atinja também "concordância com o documento" SRD descrito na norma IEEE/EIA
12207.1-1997. As exigências para concordância com o documento são resumidas numa única linha da Tabela 1 da
norma IEEE/EIA 12207.1-1997. Essa linha é reproduzida na tabela B.1.

Tabela B.1. Resumo das exigências para um SRD (Retirado da Tabela 1 da norma IEEE/EIA 12207.1-1997)

Artigo da          Cláusula           Tipo               Cláusula           Referências
Informação         IEEE/EIA                              IEEE/EIA
                   12207.0-1996                          12207.1-1997
Descrição Das      5.1.1.4,           Descrição (Veja 6.22                  IEEE Std 830-1998;
Exigências Do      5.3.4.1,5.3.4.2    nota 6.22.1 da                        EIA/IEEEJ-STD-016, F.2.3, F.2.4;
Software                              norma IEEE/EIA                        MIL-STD 961D. Veja ISO/IEC 5806,
                                      12207.1-1997)                         5807, 6593, 8631, 8790 e 11411 para
                                                                            orientação no uso de notações.




                                                                                                              34
                                                                                        Apêndice B. Modelo de EES

As exigências para a conformidade do original são discutidas nas seguintes cláusulas secundárias:

•    Secção B.3.1 discute a conformidade com as exigências de informação notáveis na coluna 2 da tabela B.1 como
     prescrito por 5.1.1.4, por 5.3.4.1, e por 5.3.4.2 da norma IEEE/EIA 12207.0-1996
•    Secção B.3.2 discute a conformidade com as linhas gerais do conteúdo genérico (o "tipo" de documento) visível
     na coluna 3 da tabela B.1 como uma "descrição". O conteúdo genérico das linhas gerais para uma "descrição"
     aparecem em 5.1 da norma IEEE/EIA 12207.1-1997.
•    Secção B.3.3 discute a conformidade com as exigências específicas para uma descrição das exigências do software
     notável na coluna 4 da tabela B.1 como prescrito por 6.22 da norma IEEE/EIA 12207.1-1997.
•    Secção B.3.4 discute a conformidade com os objectivos dos dados do ciclo de vida do Anexo H da norma
     IEEE/EIA 12207.0-1996 como descritos em 4.2 da norma IEEE/EIA 12207.1-1997.


B.3.1. Conformidade com exigências de informação da norma IEEE/EIA
12207.0-1996
As exigências de informação para um SRD são aquelas prescritas por 5.1.1.4, por 5.3.4.1, e por 5.3.4.2 de IEEE/EIA
12207.0-1996. As exigências são substantivamente idênticas àquelas consideradas em B.3.3 desta prática
recomendada.



B.3.2. Conformidade com as linhas genéricas da norma IEEE/EIA 12207.1-1997
De acordo com a norma IEEE/EIA 12207.1-1997, as linhas genéricas para um SRD é geralmente uma descrição,
como prescrito por 5.1 de IEEE/EIA 12207.1-1997. Uma descrição concordante conseguirá a finalidade indicada em
5.1.1 e incluirá a informação listada em 5.1.2 da norma IEEE/EIA 12207.1-1997.
A finalidade de uma descrição é:

•    IEEE/EIA 12207.1-1997, sub-cláusula 5.1.1: Finalidade: Descrever uma função, um projecto, um desempenho, ou
     um processo de planeamento ou real.
Um SRD concordante com esta prática recomendada conseguiria a finalidade indicada.
Toda a descrição ou especificação concordante com a norma IEEE/EIA 12207.1-1997 satisfará as exigências
genéricas fornecidas em 5.1.2 daquela norma. A tabela B.2 de lista genérica de práticas recomendadas contento os
artigos e, onde apropriado, as referências genéricas da cláusula desta prática recomendada que requer a mesma
informação.

Tabela B.2. Cobertura de exigências genéricas da descrição da norma IEEE Std 830-1998

    Índice Genérico da norma             Cláusulas correspondentes da          Adições às exigências da
    IEEE/EIA 12207.1-1997                norma IEEE Std 830-1998               norma IEEE Std 830-1998
     a. Data de edição e de status       -                                     A data de edição e o estado será
                                                                               fornecida.
     b. Escopo                           Secção 5.1.1 - Propósito              -
     c. Relativo à organização           -                                     A organização será identificada
     d. Referências                      Secção 5.1.4 - Referências            -




                                                                                                                   35
                                                                                         Apêndice B. Modelo de EES

    Índice Genérico da norma              Cláusulas correspondentes da          Adições às exigências da
    IEEE/EIA 12207.1-1997                 norma IEEE Std 830-1998               norma IEEE Std 830-1998
      e. Contexto                         Secção 1.1 - Escopo                   -
      f. Notação para a descrição         Secção 4.3 - Características de um    -
                                          bom documento de EES
      g. Corpo                            Capítulo 5 - As partes de um          -
                                          documento de EES
      h. Sumário                          Secção 5.1.1 - Propósito              -
      i. Glossário                        Secção 5.1.3 - Definições             -
      j. Histórico                        -                                     Histórico de um SRD deverá ser
                                                                                providenciado ou referenciado.



B.3.3. Conformidade com as exigências específicas da norma IEEE/EIA
12207.1-1997
As exigências específicas para um SRD na norma IEEE/EIA 12207.1-1997 são prescritas por 6.22 da norma
IEEE/EIA 12207.1-1997. Um SRD concordante conseguirá a finalidade indicada em 6.22.1 da norma IEEE/EIA
12207.1-1997.
A finalidade do SRD é:

•    IEEE/EIA 12207.1-1997, cláusula secundária 6.22.1: Finalidade: Especifique as exigências para um artigo do
     software e os métodos ser usado assegurar-se de que cada exigência esteja atingida. Usado como a base para o
     projecto e testar da qualificação de um artigo do software.
Um documento de EES concordante com esta norma, encontra-se com as exigências adicionais da tabela B.3 desta
norma, conseguiria a finalidade indicada.
Um SRD que obedece com a norma IEEE/EIA 12207.1-1997 satisfará as exigências específicas fornecidas em 6.22.3
e em 6.22.4 daquela norma. Tabela B.3 desta norma recomendada, lista os artigos especificos e, onde apropriado,
referências a cláusulas desta norma recomendada que requer a mesma informação.
Um SRD especificou concordar as exigências indicadas ou referidas na tabela B.3 desta prática recomendada será
avaliado considerando os critérios fornecidos em 5.3.4.2 de IEEE/EIA 12207.0-1996.

Tabela B.3. Cobertura de exigências específicas da descrição da norma IEEE Std 830-1998

    Índice Genérico da norma              Cláusulas correspondentes da          Adições às exigências da
    IEEE/EIA 12207.1-1997                 norma IEEE Std 830-1998               norma IEEE Std 830-1998
      a. Informação genérica da           Veja a tabela B.2                     -
    descrição
      b. Identificação e vista geral do   Secção 5.1.1 - Propósito              -
    sistema




                                                                                                                    36
                                                                                       Apêndice B. Modelo de EES

Índice Genérico da norma               Cláusulas correspondentes da           Adições às exigências da
IEEE/EIA 12207.1-1997                  norma IEEE Std 830-1998                norma IEEE Std 830-1998
   c. Funcionalidade do artigo do      Secção 5.3.2 - Funções                 As características físicas e as
software incluindo:                    Secção 5.3.3 - Exigências de           circunstâncias ambientais devem ser
  • Exigências de desempenho           desempenho                             fornecidas.

   •   Características físicas

   •   Circunstâncias ambientais

  d. Exigências para as interfaces     Secção 5.3.1 - Interfaces externas     -
externas ao item do software
  e. Exigências de qualificação.       -                                      As exigências a serem usadas para
                                                                              testar a qualificação devem ser
                                                                              fornecidas (ou referenciadas).
  f. Especificações de segurança       Secção 5.2.4 - Restrições              -
  g. Especificações da segurança e da Secção 5.3.6.3 - Segurança              -
privacidade
  h. Factores humanos que projectam Secção 5.2.3 - Características do         -
exigências                          utilizador
                                    Secção 5.2.1.2 - Interfaces com o
                                    utilizador
  i. Definição de dados e exigências   Secção 5.3.4 - Exigências lógicas da   -
da base de dados                       base de dados
  j. Exigências de instalação e        Secção 5.2.1.8 - Exigências de         Exigências de instalação e aceitação
aceitação no local de operação         adaptação ao local                     no local da operação.
  k. Exigências de instalação e        -                                      Exigências de instalação e aceitação
aceitação no local de manutenção                                              no local de manutenção.
   l. Exigências da documentação do -                                         Exigências da documentação do
utilizador                                                                    utilizador.
 m. Exigências das operações e         Secção 5.2.1.7 - Operações             Exigências das execuções por parte
execuções por parte do utilizador                                             do utilizador.
  n. Exigências da manutenção por      Secção 5.3.6.4 - Capacidade de         -
parte do utilizador                    manutenção
  o. Características da qualidade do   Secção 5.3.6 - Atributos do sistema    -
software                               de software
  p. Restrições de desenho e           Secção 5.2.4 - Restrições              -
implementação
  q. Exigências de recursos do         Secção 5.3.3 - Exigências de           Exigências de recursos do
computador                             desempenho                             computador.
  r. Exigências de empacotamento       -                                      Exigências de empacotamento.
  s. Precedência e criticalidade das   Secção 5.2.6 - Divisão e atribuição    -
exigências                             das exigências
  t. Rastreio de exigências            Secção 4.3.8 - Rastreável              -




                                                                                                                   37
                                                                                        Apêndice B. Modelo de EES

Índice Genérico da norma               Cláusulas correspondentes da           Adições às exigências da
IEEE/EIA 12207.1-1997                  norma IEEE Std 830-1998                norma IEEE Std 830-1998
  u. Racionalização                    Secção 5.2.5 - Assunções e             -
                                       dependências
 Os artigos a) a f) abaixo são de      -                                      Suporte ao ciclo de vida dos
 6.22.4 a. Suporte ao ciclo de vida                                           objectivos dos dados do Anexo H da
 dos objectivos dos dados do Anexo                                            norma IEEE/EIA 12207.0-1996.
 H da norma IEEE/EIA
 12207.0-1996

  b. Descreva todas as funções         Secção 4.3 - Características de um     -
usando notação bem definida            bom documento de EES
  c. Não definir nenhuma exigência     Secção 4.3 - Características de um     -
que esteja em conflito                 bom documento de EES
  d. Terminologia e definições         Secção 5.1.3 - Definições, acrónimos -
padrão do utilizador                   e abreviaturas
  e. Defina cada exigência de modo a Secção 4.3 - Características de um       -
prevenir inconsistências             bom documento de EES
  f. Identificar cada exigência        Secção 4.3 - Características de um     -
univocamente                           bom documento de EES



B.3.4. Conformidade com objectivos dos dados do ciclo de vida
Além às exigências satisfeitas, os dados do ciclo de vida serão controlados de acordo com os objectivos fornecidos
no Anexo H da norma IEEE/EIA 12207.0-1996.




B.4. Conclusão
A análise sugere que todo o documento de EES que obedece a esta norma e as adições mostradas na tabela B.2 e na
tabela B.3 obedece também às exigências de um SRD na norma IEEE/EIA 12207.1-1997. Em adição, para obedecer
à norma IEEE/EIA 12207.1-1997, um documento de EES suportará os objectivos dos dados do ciclo de vida do
Anexo H da norma IEEE/EIA 12207.0-1996.




                                                                                                                 38
