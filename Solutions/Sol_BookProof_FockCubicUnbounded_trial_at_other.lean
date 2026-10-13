-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.trial_at_other
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_confAt_injective
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterTempleSeparationNecessary
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockSecondQuantization
open BookProof.TempleSeparationNecessary

set_option maxHeartbeats 1000000 in
theorem solution {k n : ℕ} {c : ℝ} {m : ℕ} (h1 : m ≠ n) (h2 : m ≠ n + 3) :
    trial k n c (confAt k m) = 0 := by

  have hne1 : confAt k n ≠ confAt k m := fun h => h1 (confAt_injective k h).symm
  have hne2 : confAt k (n + 3) ≠ confAt k m := fun h => h2 (confAt_injective k h).symm
  simp [trial, hne1, hne2]
