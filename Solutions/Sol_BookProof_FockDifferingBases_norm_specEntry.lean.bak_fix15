-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.norm_specEntry
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) (v : ι → ℂ) (p q : ι) :
    ‖specEntry lam v p q‖ = |lam| * (‖v p‖ * ‖v q‖) := by

  simp [specEntry, Complex.norm_real, Real.norm_eq_abs]
