-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.dGamma_add
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_confEnergy_add
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpDiag_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization

variable {M : Type*} [DecidableEq M]


@[simp] private theorem lpDiag_coe (c : ι → ℝ) (f : lpFiniteModes ι) (i : ι) :
    (((lpDiag c f : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i
      = (c i : ℂ) * ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i := rfl

set_option maxHeartbeats 1000000 in

theorem solution (ω₁ ω₂ : M → ℝ) : dGamma (ω₁ + ω₂) = dGamma ω₁ + dGamma ω₂ := by
  ext f n
  simp only [dGamma, lpDiag_coe, LinearMap.add_apply, Submodule.coe_add, lp.coeFn_add,
    Pi.add_apply, confEnergy_add, Complex.ofReal_add]
  ring

omit [DecidableEq M] in
