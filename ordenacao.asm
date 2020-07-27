.globl main

.text

main:
	#Imprime 6 mensagens na tela com informações básicas
	addi $v0, $zero, 4
	la $a0, msg1
	syscall
	la $a0, msg2
	syscall
	la $a0, msg1
	syscall
	la $a0, msg3
	syscall
	la $a0, msg4
	syscall
	la $a0, msg1
	syscall

	#inicia variáveis importantes
	li $t0, 0 #carrega o indice i = 0
	#Inicia a variável s0 com um valor maior que todos do array A
	li $t2, 4 
	lw $s1, TAM

for:	#Função principal que vai fazer a ordenação

	#Condição de saida do for i >= n
	bgeu $t0, $s1, fim

	addi $t1, $t0, 1 #Inicia o indice j = i+1

	comp:
		#Condição de saida da função
		bgeu $t1, $s1, inc_for
	
		mul $t3, $t0, $t2
		mul $t4, $t1, $t2

		lw $t5, A($t3)	
		lw $t6, A($t4)
	
		bgt $t5, $t6, troca

		addi $t1, $t1, 1 

		j comp

		troca:
			add $t7, $t5, $zero
			add $t5, $t6, $zero
			add $t6, $t7, $zero
	
			sw $t5, A($t3)
			sw $t6, A($t4)

			addi $t1, $t1, 1 
	
			j comp

inc_for:

	addi $t0, $t0, 1
	j for

fim:
	add $t0, $zero, $zero

	addi $v0, $zero, 4
	la $a0, msg7
	syscall

	exibir:

		bgeu $t0, $s1, exit
	 		
		mul $t3, $t0, $t2

		#Exibe o resultado de A e B
		addi $v0, $zero, 1
		lw $a0, A($t3)
		syscall

		addi $v0, $zero, 4
		la $a0, msg5
		syscall

		addi $t0, $t0, 1

		j exibir

exit:	
	#dá um enter no console
	addi $v0, $zero, 4
	la $a0, msg6
	syscall

	#Encerra o código
	addi $v0, $zero, 10
	syscall


	.data #Define os dados do programa
msg1: .asciiz "----------------------------------------------\n"
msg2: .asciiz "Progama para fazer a ordenação de um vetor\n"	
msg3: .asciiz "Aluna: Samara Revoredo da Silva\n"
msg4: .asciiz "Mat: 20170041498\n"
msg5: .asciiz " "
msg6: .asciiz "\n"
msg7: .asciiz "Vetor Ordenado: "
msg8: .asciiz "Vetor: "
A: .word 3, 9, 17, 2, 51, 37, 13, 4, 8, 41, 67, 10 
TAM: .word 12
