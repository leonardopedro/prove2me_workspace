-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.farisLavine_without_symmetry_forces_trivial
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.farisLavine_without_symmetry_forces_trivial
    (crit : ∀ (H' N' : F →ₗ[ℂ] F) (a b : ℝ),
      (∀ v : F, ‖H' v‖ ≤ a * ‖N' v‖) →
      (∀ v : F, ‖(inner ℂ v (H' (N' v) - N' (H' v)) : ℂ)‖ ≤ b * ‖(inner ℂ v (N' v) : ℂ)‖) →
      HasZeroDeficiency H') (v : F) : v = 0 := by sorry
