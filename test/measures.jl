module TestMeasures
    using Base.Test
    using BioEnergeticFoodWebs

    # Internal functions

    i = ones(10)
    @test_approx_eq BioEnergeticFoodWebs.shannon(i) 1.0

    i = zeros(100).+0.001
    i[1] = 1.0
    @test_approx_eq_eps BioEnergeticFoodWebs.shannon(i) 0.0 0.2

    @test isnan(BioEnergeticFoodWebs.shannon(vec([1.0])))
    @test isnan(BioEnergeticFoodWebs.shannon(vec([-1.0])))


    i = ones(5)
    @test BioEnergeticFoodWebs.coefficient_of_variation(i) == 0.0

    i = collect(linspace(0.0, 1.0, 3))
    @test_approx_eq BioEnergeticFoodWebs.coefficient_of_variation(i) 1+1/(4*length(i))

    # Test the total biomass thing
    B = eye(10)
    A = eye(10)
    p = Dict{Symbol, Any}(:B => B, :A => A)
    @test total_biomass(p, last=10) == 1.0
    @test_throws AssertionError total_biomass(p, last=1000)
    @test population_biomass(p, last=10)[1] == 0.1

    # Population stability
    @test isnan(population_stability(p, last=1))
    @test_approx_eq_eps population_stability(p, last=2) -1.59099  0.01
    @test species_richness(p, last=1) == 1.0
    @test species_persistence(p, last=1) == 0.1

end
