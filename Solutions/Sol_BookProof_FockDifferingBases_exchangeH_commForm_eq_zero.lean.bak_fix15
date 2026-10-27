-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.exchangeH_commForm_eq_zero
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_balanced_xIdx
import Theorems.Thm_BookProof_FockDifferingBases_balancedH_commForm_eq_zero
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) (p q : κ → ι) (g : κ → ℂ)
    (hsum : Summable fun k => ‖g k‖) (hres : ∀ k, ω (p k) = ω (q k))
    (x : maxDom (sig ω)) :
    commForm (exchangeH hω p q g hsum) (diagMax (sig ω)) x = 0 := balancedH_commForm_eq_zero hω _ _ g _ hsum (fun k => balanced_xIdx (hres k)) x
