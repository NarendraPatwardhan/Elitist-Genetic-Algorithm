function [fxbest,xbest] = elitist_genetic_algorithm(funchandle,xrange)
population_size = 50;
max_iterations = 1000;
num_variables = size(xrange,2);
num_bits = ceil(log2(max(xrange/2)))+1;
population = initiate_population(population_size,num_variables,num_bits);
warning('off','map:removing:combntns')
for iter = 1:max_iterations
    fitness_matrix = calculate_fitness(funchandle,population);
    population = generate_new_population(population, fitness_matrix);
    population = crossover(population);
    population = mutate(population);
end

[fxbest,xbest] = show_result(funchandle,population);
xbest = genotype_to_phenotype(xbest);
end

function population = initiate_population(population_size,num_variables,num_bits)
population = round(rand(num_variables,num_bits,population_size));
end

function phenotype = genotype_to_phenotype(genotype)
sign_matrix = (-1).^(genotype(:,1,:)+1);
phenotype = sign_matrix .* sum(genotype(:,2:end,:).*(2.^(size(genotype,2)-1:-1:1)),2);
end

function [fitness_matrix] = calculate_fitness(funchandle,population)
fitness_matrix = sum(funchandle(genotype_to_phenotype(population)),1);
end

function new_population = generate_new_population(population, fitness_matrix)
new_population = zeros(size(population));
[~,idx] = sort(fitness_matrix,3);
idx2 = idx(:,:);
half_size = round(size(population,3)/2);
rand_indices = randi([1,size(population,3)-1],half_size,1);
new_population(:,:,1:half_size) = population(:,:,idx(1:half_size));
new_population(:,:,half_size+1:end) = population(:,:,rand_indices);
end

function population = crossover(population)
combinations = combntns(1:size(population,3),2);
for combination = 1:size(combinations,1)
    if rand < 0.85
        cut_at = randi(size(population,2));
        first_parent = population(:,:,combinations(combination,1));
        second_parent = population(:,:,combinations(combination,2));
        first_child = [first_parent(:,1:cut_at) second_parent(:,cut_at+1:end)];
        second_child = [second_parent(:,1:cut_at) first_parent(:,cut_at+1:end)];
        population(:,:,combinations(combination,1)) = first_child;
        population(:,:,combinations(combination,2)) = second_child;
    end
end
end

function population = mutate(population)
for individual = 1:size(population,3)
    size_individual = size(population(:,:,individual));
    mutation_probability = rand(size_individual) < 0.001;
    population(:,:,individual) = bitxor(population(:,:,individual),mutation_probability);
end
end

function [best_fitness,best_individual] = show_result(funchandle,population)
fitness_matrix = sum(funchandle(genotype_to_phenotype(population)));
[~,arg_best_fitness] = min(fitness_matrix);
best_individual = population(:,:,arg_best_fitness);
best_fitness = sum(funchandle(genotype_to_phenotype(best_individual)));
end
