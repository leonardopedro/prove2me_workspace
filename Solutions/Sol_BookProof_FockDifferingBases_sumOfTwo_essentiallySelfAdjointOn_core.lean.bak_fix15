-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.sumOfTwo_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_spectralFamily_finite_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_FockDifferingBases_summable_pairData
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (lam₁ lam₂ : ℝ) (v₁ v₂ : ι → ℂ)
    (hv₁ : Summable fun p => ‖v₁ p‖) (hv₂ : Summable fun p => ‖v₂ p‖) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((exchangeH (ω := spectralFamily_finite_essentiallySelfAdjointOn_core (summable_pairData hv₁ hv₂)
