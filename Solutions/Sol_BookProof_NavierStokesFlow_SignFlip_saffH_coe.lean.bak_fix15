-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.saffH_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {κ : ℝ} (hκ : 0 ≤ κ) (c : ℝ) (x : maxDom (oscSymbol (affMu κ |c|)))
    (β : ℕ) :
    ((saffH hκ c x : L2I ℕ) : ℕ → ℂ) β
      = (affData hκ (abs_nonneg c)).fst.hFun ((x : L2I ℕ) : ℕ → ℂ) β
        + esgn c * (affData hκ (abs_nonneg c)).snd.hFun ((x : L2I ℕ) : ℕ → ℂ) β := by

  simp only [saffH, LinearMap.add_apply, LinearMap.smul_apply, lp.coeFn_add, lp.coeFn_smul,
    Pi.add_apply, Pi.smul_apply, smul_eq_mul]
  rfl
