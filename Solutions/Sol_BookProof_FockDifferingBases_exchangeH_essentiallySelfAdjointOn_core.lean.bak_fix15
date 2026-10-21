-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.exchangeH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_balanced_xIdx
import Theorems.Thm_BookProof_FockDifferingBases_balancedH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) (p q : κ → ι) (g : κ → ℂ)
    (hsum : Summable fun k => ‖g k‖) (hres : ∀ k, ω (p k) = ω (q k)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((exchangeH hω p q g hsum).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) := balancedH_essentiallySelfAdjointOn_core hω _ _ g _ hsum (fun k => balanced_xIdx (hres k))
