-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.confNumber_pos
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {β : Conf} (h : β ≠ 0) : 1 ≤ confNumber β := by

  classical
  obtain ⟨k, hk⟩ : ∃ k, β k ≠ 0 := by
    by_contra hc
    push_neg at hc
    exact h (Finsupp.ext fun k => by simpa using hc k)
  have hmem : k ∈ β.support := Finsupp.mem_support_iff.mpr hk
  have hle : β k ≤ confNumber β :=
    Finset.single_le_sum (f := fun k => β k) (fun _ _ => Nat.zero_le _) hmem
  omega
