-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.diagMax_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_quadForm_nonneg
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_add_one_surjective
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_commForm_self
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_of_farisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
[him]
  ring

theorem solution (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) :
    EssentiallySelfAdjointOn (maxDom c :=
  ) (diagMax c) :=
    essentiallySelfAdjointOn_of_farisLavine (diagMax c) (diagMax c) 0
      (diagMax_symmetricOn c) (diagMax_symmetricOn c) le_rfl (diagMax_quadForm_nonneg c hc)
      (diagMax_add_one_surjective c hc)
      (fun x => by rw [commFor
