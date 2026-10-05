-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.saffH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_conj_esgn
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_shiftH_symmetricOn
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {κ : ℝ} (hκ : 0 ≤ κ) (c : ℝ) :
    SymmetricOn (maxDom (oscSymbol (affMu κ |c|))) (saffH hκ c) := by

  intro x y
  have h₁ := ShiftData.shiftH_symmetricOn (affData hκ (abs_nonneg c)).fst x y
  have h₂ := ShiftData.shiftH_symmetricOn (affData hκ (abs_nonneg c)).snd x y
  change (inner ℂ (saffH hκ c x : L2I ℕ) (y : L2I ℕ) : ℂ)
    = inner ℂ (x : L2I ℕ) (saffH hκ c y : L2I ℕ)
  change (inner ℂ ((affData hκ (abs_nonneg c)).fst.shiftH x
      + esgn c • (affData hκ (abs_nonneg c)).snd.shiftH x) (y : L2I ℕ) : ℂ)
    = inner ℂ (x : L2I ℕ) ((affData hκ (abs_nonneg c)).fst.shiftH y
      + esgn c • (affData hκ (abs_nonneg c)).snd.shiftH y)
  simp only [inner_add_left, inner_add_right, inner_smul_left, inner_smul_right, conj_esgn]
  first | linear_combination h₁ + esgn c * h₂ | trace_state
