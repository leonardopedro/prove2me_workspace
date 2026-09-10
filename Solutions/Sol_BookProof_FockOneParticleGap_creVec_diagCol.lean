-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.creVec_diagCol
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (k : ℕ) (x : FockAlg) :
    creVec (diagCol e k) x = ((e k : ℝ) : ℂ) • creA k x := by

  classical
  rw [creVec_apply]
  by_cases h : ((e k : ℝ) : ℂ) = 0
  · rw [show (diagCol e k) = 0 by simp [diagCol, h]]
    simp [h]
  · rw [show (diagCol e k).support = {k} from Finsupp.support_single_ne_zero k h]
    simp [diagCol]
