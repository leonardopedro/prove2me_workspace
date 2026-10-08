-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.numberDensityOp_basis
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow


open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]

theorem BookProof.NavierStokesFlow.FockOfFock.numberDensityOp_basis (dens : M → Ω → ℝ) (ξ : Ω) (n : Conf M) :
    numberDensityOp dens ξ (fockBasis n) = ((confDensity dens n ξ : ℝ) : ℂ) • fockBasis n := by sorry
