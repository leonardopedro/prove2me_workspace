-- Generated from ChapterA4.lean — theorem BookProof.energyTransform_symm
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





theorem BookProof.energyTransform_symm
    (Θ : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] P)
    (fourierTime : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] (Lp F 2 (volume : Measure E))) :
    (energyTransform E F Θ fourierTime).symm = conjugateₗᵢ Θ fourierTime.symm := by sorry
