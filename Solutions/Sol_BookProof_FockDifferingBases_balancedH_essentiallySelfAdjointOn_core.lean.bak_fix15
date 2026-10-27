-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.balancedH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_balancedH_symmetricOn
import Theorems.Thm_BookProof_FockDifferingBases_balancedH_norm_le
import Theorems.Thm_BookProof_FockDifferingBases_balancedH_commForm_eq_zero
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
import Theorems.Thm_BookProof_OperatorSeries_essentiallySelfAdjointOn_finiteModes_of_bounds
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι)
    (g : κ → ℂ) (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2) (hsum : Summable fun k => ‖g k‖)
    (hbal : ∀ k, Balanced ω (P k) (Q k)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((balancedH hω P Q g hPQ hsum).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) := by

  refine essentiallySelfAdjointOn_finiteModes_of_bounds (sig ω) (fun b => sig_nonneg hω b)
    _ (1 + ∑' k, 4 * ‖g k‖) 0 le_rfl (balancedH_symmetricOn hω P Q g hPQ hsum)
    (balancedH_norm_le hω P Q g hPQ hsum) (fun x => ?_)
  rw [balancedH_commForm_eq_zero hω P Q g hPQ hsum hbal x]
  simp
