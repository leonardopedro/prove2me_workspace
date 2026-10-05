-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.hTwoLevel_oneParticle
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_dGamma_basis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]

set_option maxHeartbeats 1000000 in
theorem solution (ext : J → ℝ) (eps : K → ℝ) (j : J) (c : Conf K) :
    hTwoLevel ext eps (fockBasis (Finsupp.single (j, c) 1))
      = (((ext j + confEnergy eps c : ℝ)) : ℂ) • fockBasis (Finsupp.single (j, c) 1) := by

  rw [hTwoLevel, dGamma_basis]
  congr 2
  simp [confEnergy, twoLevelSymbol, Finsupp.support_single_ne_zero _ (one_ne_zero)]
