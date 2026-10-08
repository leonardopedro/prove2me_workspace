-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.confEnergy_eq_sum
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock


open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]

theorem BookProof.NavierStokesFlow.FockOfFock.confEnergy_eq_sum {ω : M → ℝ} {n : Conf M} {S : Finset M} (hS : n.support ⊆ S) :
    confEnergy ω n = ∑ m ∈ S, (n m : ℝ) * ω m := by sorry
