-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.sblockFun_embFun
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_hFun_zero
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_embFun_of_ne
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}
variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (j : J) (a : ℕ → ℂ) :
    sblockFun κ c hκ (embFun j a)
      = embFun j (fun n => (affData (hκ j) (abs_nonneg (c j))).fst.hFun a n
          + esgn (c j) * (affData (hκ j) (abs_nonneg (c j))).snd.hFun a n) := by

  funext q
  obtain ⟨m, j'⟩ := q
  by_cases hj : j' = j
  · subst hj
    simp only [sblockFun, embFun_self]
  · simp only [sblockFun, hFun_zero, mul_zero, add_zero, embFun_of_ne _ _ hj]
