-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.faithful_remnant_nontrivial
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3



open MeasureTheory
open scoped ENNReal



variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {G Y : Type*} [Group G] [MulAction G Y]
    [FaithfulSMul G Y] [Nontrivial G] : ∃ (g : G) (y : Y), g • y ≠ y := by

  obtain ⟨g, hg⟩ := exists_ne (1 : G)
  by_contra h
  push_neg at h
  exact hg (eq_of_smul_eq_smul (fun y => by rw [one_smul]; exact h g y))
