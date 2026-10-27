-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.confEnergy_eq_sum
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution {ω : M → ℝ} {n : Conf M} {S : Finset M} (hS : n.support ⊆ S) :
    confEnergy ω n = ∑ m ∈ S, (n m : ℝ) * ω m :=
  Finset.sum_subset hS fun m _ hm => by
      have hn : n m = 0 := by simpa using hm
      simp [hn]
