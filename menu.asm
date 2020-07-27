.globl main

.text

main: #função inicial com informações iniciais

	#Escreve as informações iniciais
	addi $v0, $zero, 4
	la $a0, msg1
	syscall
	la $a0, msg2
	syscall
	la $a0, msg3
	syscall
	la $a0, msg4
	syscall
	la $a0, msg5
	syscall
	la $a0, msg6
	syscall

	#imprime msg
	addi $v0, $zero, 4
	la $a0, msg7
	syscall
	
	#Lê a variável A
	addi $v0, $zero, 5
	syscall
	add $t0, $v0, $zero

	#imprime msg
	addi $v0, $zero, 4
	la $a0, msg8
	syscall

	#Lê a variável B
	addi $v0, $zero, 5
	syscall
	add $t1, $v0, $zero

loop: #funçao principal do sistema onde fica o menu
	
	#imprime o menu com as possibilidades de operações aritméticas
	addi $v0, $zero, 4
	la $a0, msg9
	syscall
	la $a0, msg10
	syscall
	la $a0, msg11
	syscall
	la $a0, msg12
	syscall
	la $a0, msg13
	syscall
	la $a0, msg14
	syscall
	la $a0, msg15
	syscall
	la $a0, msg16
	syscall
	la $a0, msg17
	syscall

	#Le a variável correspondente a operação a ser realizada
	addi $v0, $zero, 5
	syscall
	add $t2, $v0, $zero

	#Encaminha para a função que realizará a operação desejada
	li $t4, 1 #carrega um valor constante ao registrador t4 
	beq $t2, $t4, adicao #Encaminha para a função adição caso 1
	li $t4, 2
	beq $t2, $t4, subtracao #Encaminha para a função subtração caso 2
	li $t4, 3
	beq $t2, $t4, multiplicacao #Encaminha para a função multiplicação caso 3
	li $t4, 4
	beq $t2, $t4, divisao #Encaminha para a função Divisão caso 4
	li $t4, 5
	beq $t2, $t4, e #Encaminha para a função e caso 5
	li $t4, 6
	beq $t2, $t4, ou #Encaminha para a função ou caso 6
	li $t4, 7
	beq $t2, $t4, exit #Encerra o programa

	#beq faz comparação entre dois registradores para verificar se os valores são iguais 
	#Quando é igual ele executa uma label

	#Exibe msg
	addi $v0, $zero, 4
	la $a0, msg1
	syscall

	j loop #retorna ao inicio caso o usuario digite um numero inválido

adicao:

	#Exibe uma msg
	addi $v0, $zero, 4
	la $a0, msg20
	syscall

	#Faz a soma de A e B
	add $t3, $t0, $t1

	#Exibe o valor de A + B
	addi $v0, $zero, 1
	add $a0, $t3, $zero
	syscall

	#Exibe msgs
	addi $v0, $zero, 4
	la $a0, msg19
	syscall
	la $a0, msg1
	syscall 

	j loop #retorna a função principal

subtracao:


	#Exibe uma msg
	addi $v0, $zero, 4
	la $a0, msg21
	syscall

	#faz a subtração de A e B
	sub $t3, $t0, $t1

	#exibe a subtração de A - B
	addi $v0, $zero, 1
	add $a0, $t3, $zero
	syscall

	#Exibe uma msgs
	addi $v0, $zero, 4
	la $a0, msg19
	syscall 
	la $a0, msg1
	syscall 

	j loop #retorna a função principal

multiplicacao:


	#Exibe uma msg
	addi $v0, $zero, 4
	la $a0, msg24
	syscall


	#Faz a multiplicação de A*B
	mul $t3, $t1, $t0

	#Exibe a multiplicação de A*B
	addi $v0, $zero, 1
	add $a0, $t3, $zero
	syscall

	#Exibe msgs
	addi $v0, $zero, 4
	la $a0, msg19
	syscall 
	la $a0, msg1
	syscall 

	j loop #retorna a função principal
	

divisao:

	#Sai do programa caso haja a solicitação de divisão por zero
	beq $t1, $zero, erro #Quando B = 0 vai para erro

	#Exibe uma msg
	addi $v0, $zero, 4
	la $a0, msg25
	syscall

	#Divide A por B e guarda o valor inteiro do quociente em T3
	div $t0, $t1
	
	mflo $s0 #guarda o quaciente em s0 para valores pequenos
	mfhi $s1 #guarda o resto em s1 para valores pequenos

	#Exibe o quociente A/B
	addi $v0, $zero, 1
	add $a0, $s0, $zero
	syscall

	#Exibe uma msg
	addi $v0, $zero, 4
	la $a0, msg26
	syscall

	#Exibe o resto de A/B
	addi $v0, $zero, 1
	add $a0, $s1, $zero
	syscall

	#Exibe msgs
	addi $v0, $zero, 4
	la $a0, msg19
	syscall 
	la $a0, msg1
	syscall 

	j loop #Retorna a função principal

Maior_que_1:

	#Como sabemos, o resultado de uma operação booleana é verdadeiro ou falso, 0 ou 1.
	#A instrução "and" e "or" realiza essa operação bit a bit, o que significa que o resultado
	#de dois numeros inteiros maiores que 1 será também um número maior que 1, por isso,
	#para deixar no formato verdadeiro ou falso, e sabendo que um número maior que 1 
	#corresponde a um resultado verdadeiro, essa função sempre exibe 1.

	addi $t3, $zero, 1

	#Exibe o resultado de A e B
	addi $v0, $zero, 1
	add $a0, $t3, $zero
	syscall

	#Exibe msgs
	addi $v0, $zero, 4
	la $a0, msg19
	syscall 
	la $a0, msg1
	syscall 

	j loop #retorna a função principal

e:
	#Exibe uma msg
	addi $v0, $zero, 4
	la $a0, msg22
	syscall

	#Realiza a operação lógica "and" entre A e B
	and $t3, $t0, $t1

	#vai para Maior_que_1 caso o resultado seja > 1
	li $t4, 1 #carrega o valor imediato 1
	bgt $t3, $t4, Maior_que_1 #Quando Resul > 1 vai para Maior_que_1

	#Quando o resultado é negativo também vai para a função
	#Maior_que_1 pois corresponde a um resultado verdadeiro
	blt $t3, $zero, Maior_que_1 #Quando Resul < 0 vai para Maior_que_1

	#Exibe o resultado de A e B
	addi $v0, $zero, 1
	add $a0, $t3, $zero
	syscall


	#Exibe msgs
	addi $v0, $zero, 4
	la $a0, msg19
	syscall 
	la $a0, msg1
	syscall 

	j loop #retorna a função principal

ou:

	#Exibe uma msg
	addi $v0, $zero, 4
	la $a0, msg23
	syscall

	#Realiza a operação lógica "or" entre A ou B
	or $t3, $t0, $t1

	#vai para Maior_que_1 caso o resultado seja > 1
	li $t4, 1 #carrega o valor imediato 1
	bgt $t3, $t4, Maior_que_1 #Quando Resul > 1 vai para Maior_que_1

	#Quando o resultado é negativo também vai para a função
	#Maior_que_1 pois corresponde a um resultado verdadeiro
	blt $t3, $zero, Maior_que_1 #Quando Resul < 0 vai para Maior_que_1

	#Exibe o resultado de A ou B
	addi $v0, $zero, 1
	add $a0, $t3, $zero
	syscall

	#Exibe msgs
	addi $v0, $zero, 4
	la $a0, msg19
	syscall 
	la $a0, msg1
	syscall 

	j loop #retorna a função principal

erro:   #Exibe msg de erro e encerra o programa

	#Exibe uma msg
	addi $v0, $zero, 4
	la $a0, msg27
	syscall

	j exit #vai para função que encerra o programa

exit:

	#Encerra o código
	addi $v0, $zero, 10
	syscall

	.data #Define os dados do programa
msg1: .asciiz "---------------------------------------\n"
msg2: .asciiz "Progama para fazer um menu\n"	
msg3: .asciiz "---------------------------------------\n"
msg4: .asciiz "Aluna: Samara Revoredo da Silva\n"
msg5: .asciiz "Mat: 20170041498\n"
msg6: .asciiz "---------------------------------------\n"
msg7: .asciiz "Digite A:\n"
msg8: .asciiz "Digite B:\n"
msg9: .asciiz "Qual operação você gostaria de realizar?\n"
msg10: .asciiz "1 - Adição\n"
msg11: .asciiz "2 - Subtração\n"
msg12: .asciiz "3 - Multiplicação\n"
msg13: .asciiz "4 - Divisão\n"
msg14: .asciiz "5 - AND lógico\n"
msg15: .asciiz "6 - OR lógico\n"
msg16: .asciiz "7 - Sair\n"
msg17: .asciiz "Digite um número de 1 a 7\n"
msg18: .asciiz ","
msg19: .asciiz "\n"
msg20: .asciiz "A + B = "
msg21: .asciiz "A - B = "
msg22: .asciiz "A and B = "
msg23: .asciiz "A or B = "
msg24: .asciiz "A * B = "
msg25: .asciiz "A / B = "
msg26: .asciiz ", resto = "
msg27: .asciiz "Operação inválida (divisão por zero)"