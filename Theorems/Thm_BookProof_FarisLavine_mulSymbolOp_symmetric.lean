-- Generated from ChapterFarisLavine.lean — theorem BookProof.FarisLavine.mulSymbolOp_symmetric
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

 * z) by ring,
    ← Complex.normSq_eq_conj_mul_self]
  push_cast
  ring

theorem BookProof.FarisLavine.mulSymbolOp_symmetric (lam s : ℕ → ℝ) (hs : ∀ n, |s n| := by sorry
