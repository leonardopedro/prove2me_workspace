-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.confEnergy_add
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution (ω₁ ω₂ : M → ℝ) (n : Conf M) :
    confEnergy (ω₁ + ω₂) n = confEnergy ω₁ n + confEnergy ω₂ n := by

  simp only [confEnergy, Pi.add_apply, mul_add]
  exact Finset.sum_add_distrib
