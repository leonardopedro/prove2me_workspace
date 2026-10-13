-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.norm_specEntry
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFockQuadraticEsa
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
