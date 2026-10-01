-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.abs_abs_le
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

set_option maxHeartbeats 1000000 in
e (lam : ℕ → ℝ) : ∀ n, |(|lam n|)| ≤ |lam n| := fun n => by simp

/-- The comparison operator `N = |lam|`. -/
noncomputable de := f mulComparison (lam : ℕ → ℝ) : mulSymbolDomain la
