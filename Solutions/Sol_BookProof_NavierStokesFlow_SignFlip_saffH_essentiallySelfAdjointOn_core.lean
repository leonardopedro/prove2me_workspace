-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.saffH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_essentiallySelfAdjointOn_of_intertwine
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_flipU_mem_finiteModes
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_saffH_eq_affH
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_saffH_conj_flip
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_affH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {κ : ℝ} (hκ : 0 ≤ κ) (c : ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((saffH hκ c).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (affMu κ |c|))))) := by

  rcases lt_or_ge c 0 with hc | hc
  · refine essentiallySelfAdjointOn_of_intertwine (flipU (fun n : ℕ => n))
      ((affH hκ (abs_nonneg c)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (affMu κ |c|))))) _
      (fun v => flipU_mem_finiteModes _ v.2) (fun v => ?_)
      (affH_essentiallySelfAdjointOn_core hκ (abs_nonneg c))
    exact saffH_conj_flip hκ hc _
  · rw [saffH_eq_affH hκ hc]
    exact affH_essentiallySelfAdjointOn_core hκ (abs_nonneg c)
