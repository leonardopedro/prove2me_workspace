-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.support_hopCol_subset
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_hopCol_apply
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : (hopCol k).support ⊆ {k + 1, k - 1} := by

  classical
  intro j hj
  have hne : (hopCol k) j ≠ 0 := Finsupp.mem_support_iff.mp hj
  rw [hopCol_apply] at hne
  by_cases h : j = k + 1 ∨ k = j + 1
  · rcases h with h | h
    · simp [h]
    · have : j = k - 1 := by omega
      simp [this]
  · rw [if_neg h] at hne
    exact absurd rfl hne
