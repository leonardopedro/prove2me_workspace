-- Generated from ChapterFockInteractionStability.lean — solution of BookProof.FockInteractionStability.gap_persists_pos
import Mathlib
import Definitions.Def_ChapterFockInteractionStability
open BookProof.FockInteractionStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap
open BookProof.FarisLavine BookProof.NavierStokesFlow



variable {E : Type*} [NormedAddCommGroup E]

variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution {mu a b : ℝ} (hmu : 0 < mu) (ha : a < 1) (hb : b < (1 - a) * mu) :
    0 < (1 - a) * mu - b := by

  have : 0 < (1 - a) * mu := mul_pos (by linarith) hmu
  linarith
