-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.specEntry_not_commute
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution :
    matMul (specEntry (1 : ℝ) (fun i : Fin 2 => if i = 0 then (1 : ℂ) else 0))
        (specEntry (1 : ℝ) (fun _ : Fin 2 => (1 : ℂ)))
      ≠ matMul (specEntry (1 : ℝ) (fun _ : Fin 2 => (1 : ℂ)))
        (specEntry (1 : ℝ) (fun i : Fin 2 => if i = 0 then (1 : ℂ) else 0)) := by

  intro h
  have h01 := congrFun (congrFun h 0) 1
  simp [matMul, specEntry] at h01
