-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.dGamma_diagCol_apply
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_dGamma_diagCol_single
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (u : FockAlg) (β : Conf) :
    dGamma (diagCol e) u β = ((confEnergy e β : ℝ) : ℂ) * u β := by

  classical
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg =>
    rw [map_add, Finsupp.add_apply, hf, hg, Finsupp.add_apply]
    ring
  | single γ c =>
    rw [dGamma_diagCol_single]
    by_cases h : β = γ
    · subst h; simp
    · simp [h]
