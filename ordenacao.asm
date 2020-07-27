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
	li $t2, 4 #carrega o parâmetro para multiplicação
	lw $s1, TAM #Inicia um variável com tamanho do vetor

for:	#Função principal que vai fazer a ordenação

	#Condição de saida do for i >= tamanho
	bgeu $t0, $s1, fim 

	addi $t1, $t0, 1 #Inicia o indice j = i+1

	comp: #Compara todos os elementos posteriores do vetor
		#Condição de saida da função
		bgeu $t1, $s1, inc_for
	
		#Como o vetor lê as posições de 4 em 4, faz-se uma multiplicação
		mul $t3, $t0, $t2 #multiplica o indice i por quatro
		mul $t4, $t1, $t2 #multiplica o indice j por quatro

		lw $t5, A($t3)	#Pega o valor do Array na posição i
		lw $t6, A($t4)  #Pega o valor do Array na posição j
	
		#Se o valor na posição j for menor que na posição i faz a troca
		bgt $t5, $t6, troca 

		addi $t1, $t1, 1 #j = j+1

		j comp #retorna a função comp

		troca: #faz a troca de dois valores do vetor
			add $t7, $t5, $zero #aux = A[i]
			add $t5, $t6, $zero #A[i] = A[j]
			add $t6, $t7, $zero #A[j] = aux
	
			sw $t5, A($t3) #Escreve o novo valor no array
			sw $t6, A($t4) #Escreve o novo valor no array

			addi $t1, $t1, 1 #j = j+1
	
			j comp #retorna n função comp

inc_for: #Faz o incremento e retorna ao for 

	addi $t0, $t0, 1 #i = i+1
	j for #retorna ao for

fim:	#Exibe o array após a ordenação  
	add $t0, $zero, $zero #Zera o indice i

	#exibe uma msg
	addi $v0, $zero, 4
	la $a0, msg7
	syscall

	exibir: #entra num laço para exibir todos os elementos do array

		bgeu $t0, $s1, exit #Se i >= tamanho, encerra o programa
	 		
		mul $t3, $t0, $t2 #multiplica o indice i por quatro

		#Exibe o elemento A[i]
		addi $v0, $zero, 1
		lw $a0, A($t3)
		syscall

		#Exibe uma msg
		addi $v0, $zero, 4
		la $a0, msg5
		syscall

		addi $t0, $t0, 1 #i = i+1

		j exibir #Cria um laço

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
msg2: .asciiz "Programa para fazer a ordenação de um vetor\n"	
msg3: .asciiz "Aluna: Samara Revoredo da Silva\n"
msg4: .asciiz "Mat: 20170041498\n"
msg5: .asciiz " "
msg6: .asciiz "\n"
msg7: .asciiz "Vetor Ordenado: "
msg8: .asciiz "Vetor: "
A: .word 3, 9, 17, 2, 51, 37, 13, 4, 8, 41, 67, 10 
TAM: .word 12
