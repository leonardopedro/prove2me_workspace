-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.spectralFamily_finite_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_spectralFamily_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_FockDifferingBases_summable_specGate_of_finite
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution [Finite κ] {lam : κ → ℝ}
    {v : κ → ι → ℂ} (hv : ∀ k, Summable fun p => ‖v k p‖) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((exchangeH (ω := spectralFamily_essentiallySelfAdjointOn_core hv (summable_specGate_of_finite lam v)
