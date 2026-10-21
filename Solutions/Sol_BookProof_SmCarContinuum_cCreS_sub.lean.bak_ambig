-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.cCreS_sub
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterRieszFischer
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal
open BookProof.ChapterRieszFischer
open BookProof.SmCar

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f g : Ell2) : cCreS (f - g) = cCreS f - cCreS g := by

  refine ContinuousLinearMap.ext fun ψ => lp.ext (funext fun S => ?_)
  simp only [cCreS_apply, ContinuousLinearMap.sub_apply, lp.coeFn_sub, Pi.sub_apply,
    ← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun i _ => by ring
