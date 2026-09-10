-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.iInf_le_confEnergy
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {e : ℕ → ℝ} (he : ∀ k, 0 ≤ e k) {β : Conf} (hβ : β ≠ 0) :
    (⨅ k, e k) ≤ confEnergy e β := by

  classical
  have hbdd : BddBelow (Set.range e) := ⟨0, by rintro x ⟨k, rfl⟩; exact he k⟩
  obtain ⟨k0, hk0⟩ : ∃ k, k ∈ β.support := by
    by_contra hc
    push_neg at hc
    exact hβ (Finsupp.ext fun k => by
      simpa using Finsupp.notMem_support_iff.mp (hc k))
  have hterm : e k0 ≤ (β k0 : ℝ) * e k0 := by
    have h1 : (1 : ℝ) ≤ (β k0 : ℝ) := by
      have h2 : 1 ≤ β k0 := Nat.one_le_iff_ne_zero.mpr (Finsupp.mem_support_iff.mp hk0)
      exact_mod_cast h2
    nlinarith [he k0]
  have hsum : (β k0 : ℝ) * e k0 ≤ confEnergy e β :=
    Finset.single_le_sum (f := fun k => (β k : ℝ) * e k)
      (fun k _ => mul_nonneg (by positivity) (he k)) hk0
  exact le_trans (le_trans (ciInf_le hbdd k0) hterm) hsum
