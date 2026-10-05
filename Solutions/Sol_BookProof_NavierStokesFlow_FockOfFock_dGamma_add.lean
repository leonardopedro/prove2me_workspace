-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.dGamma_add
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_confEnergy_add
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution (ω₁ ω₂ : M → ℝ) : dGamma (ω₁ + ω₂) = dGamma ω₁ + dGamma ω₂ := by

  ext f n
  simp only [dGamma, lpDiag_coe, LinearMap.add_apply, Submodule.coe_add, lp.coeFn_add,
    Pi.add_apply, confEnergy_add, Complex.ofReal_add]
  ring
