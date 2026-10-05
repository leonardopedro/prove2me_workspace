-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.hopCol_not_summable
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_hopCol_apply
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution : ¬ Summable fun k : ℕ => ‖(hopCol k) (k + 1)‖ := by

  intro hsum
  have hone : ∀ k : ℕ, ‖(hopCol k) (k + 1)‖ = 1 := by
    intro k
    rw [hopCol_apply, if_pos (Or.inl rfl)]
    simp
  have h := hsum.tendsto_atTop_zero
  simp only [hone] at h
  have h3 := tendsto_nhds_unique h (tendsto_const_nhds (x := (1:ℝ)) (f := Filter.atTop))
  norm_num at h3
