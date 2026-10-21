-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.summable_specGate_of_finite
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution [Finite κ] (lam : κ → ℝ) (v : κ → ι → ℂ) :
    Summable fun k => |lam k| * (∑' p, ‖v k p‖) ^ 2 := Summable.of_finite
