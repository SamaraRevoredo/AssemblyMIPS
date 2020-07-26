.globl main

.text

main:
	#Imprime 6 mensagens na tela com informações básicas

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

	#Inicia as variáveis necessárias para imprimir a sequencia
	add $t1, $zero, $zero #t1: indice i = 0
	add $t2, $zero, $zero #t2: primeiro numero de fibonacci = 0
	addi $t3, $zero, 1 #t3: segundo numero de fibonacci = 1
	add $t4, $zero, $zero #t4: aux = 0
loop:
	#Lê a variavel n, repete se n for menor ou igual a zero
	#t0 = n

	#imprime uma mensagem na tela
	addi $v0, $zero, 4 
	la $a0, msg7
	syscall

	#Carrega o valor do usuário em t0
	addi $v0, $zero, 5
	syscall
	add $t0, $v0, $zero

	#Se n > 0 começa a imprimir a sequencia
	li $t5, 0
	bgt $t0, $t5, Fibonacci1
	j loop #cria um laço na função loop

	#bgt faz uma comparação entre dois registragores para descobrir se o primeiro é maior que o segundo
	#Quando o resultado é positivo ele executa uma label

Fibonacci1: 
	#Funcao que imprime os primeiros numeros de Fibonacci

	#Imprime uma msg na tela
	addi $v0, $zero, 4
	la $a0, msg10
	syscall		

	#Imprime o primeiro numero de Fibonacci t2
	addi $v0, $zero, 1
	add $a0, $t2, $zero
	syscall
	
	#beq faz comparação entre dois registradores para verificar se os valores são iguais
	li $t5, 1 #carrega o resgistrador t5 com 1
	beq $t0, $t5, exit #Verifica se a sequencia acabou, n = 1

	#Imprime um espaço
	addi $v0, $zero, 4
	la $a0, msg8
	syscall	
	

	#Imprime o segundo numero de Fibonacci t2	
	addi $v0, $zero, 1
	add $a0, $t3, $zero
	syscall

	li $t5, 2
	beq $t0, $t5, exit #Verifica se a sequencia acabou, n = 2

	#Imprime um espaço
	addi $v0, $zero, 4
	la $a0, msg8
	syscall	
	
	#Como já foram colocados os dois primeiros numeros n = n-2
	addi $t0,$t0,-2 
	
Fibonacci2:
	#Imprime a sequencia fibonacci de n numeros a partir do terceiro número

	addi $t1, $t1, 1 #Incrementa o indice t1
	
	add $t4, $t3, $zero #aux = t3, Guarda o valor do numero atual
	add $t3, $t3, $t2 #t3 = t3 + t2, Soma o atual com o anterior
	add $t2, $t4, $zero #t2 = aux, coloca o valor atual no anterior

	#Imprime o numero de Fibonacci
	addi $v0, $zero, 1
	add $a0, $t3, $zero
	syscall

	#Imprime uma virgula na tela	
	addi $v0, $zero, 4
	la $a0, msg8
	syscall	

	beq $t1, $t0, exit #condição de saida n = i

	j Fibonacci2 #Cria um laço na função Fibonacci2
exit:
	#Encerra o código

	#dá um enter no console
	addi $v0, $zero, 4
	la $a0, msg9
	syscall

	#Encerra o código
	addi $v0, $zero, 10
	syscall

	.data #Define os dados do programa
msg1: .asciiz "---------------------------------------\n"
msg2: .asciiz "Progama para fazer a sequecia Fibonacci\n"	
msg3: .asciiz "---------------------------------------\n"
msg4: .asciiz "Aluna: Samara Revoredo da Silva\n"
msg5: .asciiz "Mat: 20170041498\n"
msg6: .asciiz "---------------------------------------\n"
msg7: .asciiz "Digite um numero n maior que zero\n"
msg8: .asciiz " "
msg9: .asciiz "\n"
msg10: .asciiz "Sequência de Fibonacci: \n"
