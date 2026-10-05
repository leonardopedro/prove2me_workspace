-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.shiftH_flip
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_flipU_mem_maxDom
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_negOne_pow_eq
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_hFun_flip
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (S : ShiftData ι) (p : ι → ℕ) (k : ℕ)
    (hp : ∀ β, p (S.shift β) = p β + k) (x : maxDom S.sym) :
    (flipU p (ShiftData.shiftH S x) : L2I ι)
      = (-1 : ℂ) ^ k • (ShiftData.shiftH S ⟨flipU p (x : L2I ι),
          flipU_mem_maxDom p S.sym x.2⟩ : L2I ι) := by

  refine lp.ext (funext fun β => ?_)
  have hX : ((⟨flipU p (x : L2I ι), flipU_mem_maxDom p S.sym x.2⟩ :
      maxDom S.sym) : L2I ι) = flipU p (x : L2I ι) := rfl
  simp only [flipU_coe, ShiftData.shiftH_coe, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul]
  have hfun : ((flipU p (x : L2I ι) : L2I ι) : ι → ℂ) = flipFun p ((x : L2I ι) : ι → ℂ) := rfl
  rw [hfun, hFun_flip S p k hp]
  rcases negOne_pow_eq k with hB | hB <;> rw [hB] <;> ring
