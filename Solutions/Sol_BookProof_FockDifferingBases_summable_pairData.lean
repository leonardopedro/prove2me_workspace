-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.summable_pairData
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {v₁ v₂ : ι → ℂ} (hv₁ : Summable fun p => ‖v₁ p‖)
    (hv₂ : Summable fun p => ‖v₂ p‖) (k : Fin 2) :
    Summable fun p => ‖(![v₁, v₂] : Fin 2 → ι → ℂ) k p‖ := by

  fin_cases k
  · simpa using hv₁
  · simpa using hv₂
