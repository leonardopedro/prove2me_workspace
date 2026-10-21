-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.exists_unit_rayleigh_lt
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_rayleighInfOn_le_maxminLevel
import Theorems.Thm_BookProof_RitzMinMax_rayleighSetOn_nonempty
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) {S : Submodule ℂ F} {k : ℕ}
    (hrank : Module.finrank ℂ S = k + 1) {ε : ℝ} (hε : 0 < ε) :
    ∃ x ∈ S, ‖x‖ = 1 ∧ rayleighVal R x < maxminLevel R k + ε := by

  have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
  have hne := rayleighSetOn_nonempty R hpos
  have hle := rayleighInfOn_le_maxminLevel R hrank
  have hlt : sInf (rayleighSetOn R S) < maxminLevel R k + ε := by
    have : rayleighInfOn R S = sInf (rayleighSetOn R S) := rfl
    linarith [this ▸ hle]
  obtain ⟨t, ht, htlt⟩ := exists_lt_of_csInf_lt hne hlt
  obtain ⟨x, hx, hx1, rfl⟩ := ht
  exact ⟨x, hx, hx1, htlt⟩
