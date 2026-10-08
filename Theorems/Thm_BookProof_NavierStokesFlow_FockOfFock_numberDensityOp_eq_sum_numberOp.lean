-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.numberDensityOp_eq_sum_numberOp
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FockSecondQuantization
open BookProof.GhostField
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow


open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]

theorem BookProof.NavierStokesFlow.FockOfFock.numberDensityOp_eq_sum_numberOp (dens : M → Ω → ℝ) (ξ : Ω) {n : Conf M} {S : Finset M}
    (hS : n.support ⊆ S) :
    numberDensityOp dens ξ (fockBasis n)
      = ∑ m ∈ S, ((dens m ξ : ℝ) : ℂ) • numberOp m (fockBasis n) := by sorry
