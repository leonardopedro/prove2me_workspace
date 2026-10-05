-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.trial_support_subset
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (k n : ℕ) (c : ℝ) :
    (trial k n c).support ⊆ {confAt k n, confAt k (n + 3)} := by

  classical
  intro γ hγ
  by_contra hcon
  simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hcon
  have : trial k n c γ = 0 := by
    simp [trial, Ne.symm hcon.1, Ne.symm hcon.2]
  exact (Finsupp.mem_support_iff.mp hγ) this
