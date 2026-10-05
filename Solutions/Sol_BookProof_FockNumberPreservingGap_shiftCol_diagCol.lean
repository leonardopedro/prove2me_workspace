-- Generated from ChapterFockNumberPreservingGap.lean — solution of BookProof.FockNumberPreservingGap.shiftCol_diagCol
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
open BookProof.FockNumberPreservingGap



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (mu : ℝ) :
    shiftCol (diagCol e) mu = diagCol fun k => e k - mu := by

  funext k
  refine Finsupp.ext fun j => ?_
  simp only [shiftCol, diagCol, Finsupp.sub_apply, Finsupp.smul_apply, Finsupp.single_apply,
    smul_eq_mul]
  split_ifs with h
  · push_cast; ring
  · ring
