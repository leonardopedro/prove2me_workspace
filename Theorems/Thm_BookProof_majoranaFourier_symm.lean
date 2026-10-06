-- Generated from ChapterA4.lean — theorem BookProof.majoranaFourier_symm
import Mathlib
import Definitions.Def_ChapterA4
open BookProof

variable {R E E' : Type*} [Semiring R]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E'] [Module R E] [Module R E']
variable (E F : Type*) [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
    [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
    [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
variable {P : Type*} [NormedAddCommGroup P] [InnerProductSpace ℝ P]



open MeasureTheory





theorem BookProof.majoranaFourier_symm
    (Θ : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] P) :
    (majoranaFourier E F Θ).symm = conjugateₗᵢ Θ (pauliFourier E F).symm := by sorry
