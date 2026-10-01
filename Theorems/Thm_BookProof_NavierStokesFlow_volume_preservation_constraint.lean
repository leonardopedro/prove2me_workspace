-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.volume_preservation_constraint
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.volume_preservation_constraint {d : ℕ} (f : (Fin d → ℝ) →ₗ[ℝ] (Fin d → ℝ))
    (hdet : LinearMap.det f = 1) (s : Set (Fin d → ℝ)) :
    MeasureTheory.volume (f '' s) = MeasureTheory.volume s := by sorry
