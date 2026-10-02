-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.mulSymbolOp_symmetric
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
 * z) by ring,
    ← Complex.normSq_eq_conj_mul_self]
  push_cast
  ring

theorem solution (lam s : ℕ → ℝ) (hs : ∀ n, |s n| :=
  ≤ |lam n|) :
      SymmetricOn (mulSymbolDomain lam) (mulSymbolOp lam s hs) := by
    intro x y
    rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
    refine tsum_congr fun n => ?_
    simp only [mulSymbolOp
