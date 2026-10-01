-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.mulHamiltonian_commForm
import Mathlib
import Definitions.Def_ChapterFarisLavine
import Theorems.Thm_BookProof_FarisLavine_conj_mul_ofReal₂
import Theorems.Thm_BookProof_FarisLavine_commForm_eq
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

set_option maxHeartbeats 1000000 in
lex.ofReal_re]
  exact mul_nonneg (abs_nonneg _) (Complex.normSq_nonneg _)

theorem solution (lam : ℕ → ℝ) (x : mulSymb := 
