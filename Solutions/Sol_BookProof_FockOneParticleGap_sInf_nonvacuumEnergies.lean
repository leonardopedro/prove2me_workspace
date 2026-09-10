-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.sInf_nonvacuumEnergies
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_confEnergy_single
import Theorems.Thm_BookProof_FockOneParticleGap_confEnergy_nonneg
import Theorems.Thm_BookProof_FockOneParticleGap_iInf_le_confEnergy
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {e : ℕ → ℝ} (he : ∀ k, 0 ≤ e k) :
    sInf (nonvacuumEnergies e) = ⨅ k, e k := by

  classical
  have hbdd : BddBelow (nonvacuumEnergies e) := by
    refine ⟨0, ?_⟩
    rintro x ⟨β, -, rfl⟩
    exact confEnergy_nonneg he _
  have hmem : ∀ k, e k ∈ nonvacuumEnergies e :=
    fun k => ⟨Finsupp.single k 1, by simp, (confEnergy_single e k).symm⟩
  refine le_antisymm (le_ciInf fun k => csInf_le hbdd (hmem k)) ?_
  refine le_csInf ⟨e 0, hmem 0⟩ ?_
  rintro x ⟨β, hβ, rfl⟩
  exact iInf_le_confEnergy he hβ
