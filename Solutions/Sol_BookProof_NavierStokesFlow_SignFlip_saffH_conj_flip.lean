-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.saffH_conj_flip
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_flipU_mem_maxDom
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_hFun_flip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_saffH_coe
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_PairShift_pairH_coe
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {κ : ℝ} (hκ : 0 ≤ κ) {c : ℝ} (hc : c < 0)
    (x : maxDom (oscSymbol (affMu κ |c|))) :
    (flipU (fun n : ℕ => n) (affH hκ (abs_nonneg c) x) : L2I ℕ)
      = (saffH hκ c ⟨flipU (fun n : ℕ => n) (x : L2I ℕ),
          flipU_mem_maxDom _ (oscSymbol (affMu κ |c|)) x.2⟩ : L2I ℕ) := by

  refine lp.ext (funext fun β => ?_)
  have hx : ((⟨flipU (fun n : ℕ => n) (x : L2I ℕ),
      flipU_mem_maxDom _ (oscSymbol (affMu κ |c|)) x.2⟩ :
        maxDom (oscSymbol (affMu κ |c|))) : L2I ℕ) = flipU (fun n : ℕ => n) (x : L2I ℕ) := rfl
  have hfun : ((flipU (fun n : ℕ => n) (x : L2I ℕ) : L2I ℕ) : ℕ → ℂ)
      = flipFun (fun n : ℕ => n) ((x : L2I ℕ) : ℕ → ℂ) := rfl
  have hp₁ : ∀ β : ℕ, (affData hκ (abs_nonneg c)).fst.shift β = β + 2 := fun _ => rfl
  have hp₂ : ∀ β : ℕ, (affData hκ (abs_nonneg c)).snd.shift β = β + 1 := fun _ => rfl
  rw [saffH_coe, hx, hfun, hFun_flip _ (fun n : ℕ => n) 2 hp₁,
    hFun_flip _ (fun n : ℕ => n) 1 hp₂]
  have hcoord : ((affH hκ (abs_nonneg c) x : L2I ℕ) : ℕ → ℂ) β
      = (affData hκ (abs_nonneg c)).fst.hFun ((x : L2I ℕ) : ℕ → ℂ) β
        + (affData hκ (abs_nonneg c)).snd.hFun ((x : L2I ℕ) : ℕ → ℂ) β :=
    PairShift.pairH_coe (affData hκ (abs_nonneg c)) x β
  rw [flipU_coe, hcoord, esgn_of_neg hc]
  ring
