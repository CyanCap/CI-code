clear;clc;
% �����������  
cities = [0.5,0.5; 0.3,0.4; 0.9,0.6; 0.7,0.8; 0.2,0.9];  
  
% �����Ŵ��㷨����  
pop_size = 50; % ��Ⱥ��ģ  
num_gen = 100; % ��������  
mutation_rate = 0.1; % ������  
  
% ��ʼ����Ⱥ  
pop = init_pop(pop_size, cities);  
  
% ��������  
for i = 1:num_gen  
    % ������Ӧ��  
    fitness = calculate_fitness(pop, cities);  
      
    % ѡ�����  
    parents = selection(pop, fitness);  
      
    % �������  
    offspring = crossover(parents);  
      
    % �������  
    offspring = mutation(offspring, mutation_rate);  
      
    % ������Ⱥ  
    pop = update_pop(pop, offspring);  
end  
  
% ��������·�����ܾ���  
[optimal_path, optimal_distance] = calculate_optimal(pop);  
disp(['����·����', num2str(optimal_path)]);  
disp(['�ܾ��룺', num2str(optimal_distance)]);  
  
% ��ʼ����Ⱥ����  
function pop = init_pop(pop_size, cities)  
    pop = zeros(pop_size, numel(cities));  
    for i = 1:pop_size  
        pop(i, :) = randperm(numel(cities));  
    end  
end  
  
% ������Ӧ�Ⱥ���  
function fitness = calculate_fitness(pop, cities)  
    fitness = zeros(size(pop));  
    for i = 1:size(pop, 1)  
        path = pop(i, :);  
        distance = calculate_distance(path, cities);  
        fitness(i) = -distance; % ע��ʹ�ø�ֵ����Ϊ�Ŵ��㷨����Сֵ  
    end  
end  
  
% ѡ���������  
function parents = selection(pop, fitness)  
    % ������ʹ�����̶�ѡ��  
    total_fitness = sum(fitness);  
    p = fitness / total_fitness;  
    q = cumsum(p);  
    parents = zeros(size(pop));  
    for i = 1:size(pop, 1)  
        r = rand();  
        for j = 1:numel(q)  
            if r <= q(j)  
                parents(i, :) = pop(j, :);  
                break;  
            end  
        end  
    end  
end  
  
% �����������  
function offspring = crossover(parents)  
    % ������ʹ�ò���ӳ�佻�淨��PMX��  
    num_pairs = floor(size(parents, 1) / 2);  
    offspring = zeros(size(parents));  
    for i = 1:num_pairs  
        parent1 = parents(i, :); parent2 = parents(i + num_pairs, :); % ȡ������������  
        alpha = rand(); beta = rand(); % ���Ʋ�������Ҫ���е������Ż�  
        g1 = sort([parent1(1), parent2(1)]); g2 = sort([parent1(end), parent2(end)]); % ѡ�񽻲��λ��  
        offspring1 = parent1; offspring2 = parent2; % �Ӵ���ʼ��  
        offspring1(beta*(1:numel(parent1)) + alpha*(g1+1):beta*(numel(parent1)+g2)+alpha) = parent2(g1+1:g2); % �Ӵ�1�Ľ������  
        offspring2(beta*(1:numel(parent2)) + alpha*(g1+1):beta*(numel(parent2)+g2)+alpha) = parent1(g1+1:g2); % �Ӵ�2�Ľ������  
        offspring((i-1)*2+1, :) = offspring1; offspring((i-1)*2+2, :) = offspring2; % �������Ӵ����뵽�����  
    end
end
