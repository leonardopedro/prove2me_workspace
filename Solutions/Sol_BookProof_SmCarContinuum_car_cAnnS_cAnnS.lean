-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.car_cAnnS_cAnnS
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_car_cCreS_cCreS
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f g : Ell2) (ψ : CFock) :
    cAnnS f (cAnnS g ψ) + cAnnS g (cAnnS f ψ) = 0 := by

  have hop : (cCreS g).comp (cCreS f) + (cCreS f).comp (cCreS g) = 0 := by
    refine ContinuousLinearMap.ext fun φ => ?_
    simpa using car_cCreS_cCreS g f φ
  have hadj := congrArg ContinuousLinearMap.adjoint hop
  rw [map_add, ContinuousLinearMap.adjoint_comp, ContinuousLinearMap.adjoint_comp,
    map_zero] at hadj
  have h2 := congrArg (fun T : CFock →L[ℂ] CFock => T ψ) hadj
  simpa [cAnnS] using h2
