-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.ikebeKato_momentum
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_quadForm_nonneg
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_add_one_surjective
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_exists_finiteModes_graph_approx
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_commForm_self
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_core_of_farisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat BookProof.FarisLavine

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((diagMax c).comp (Submodule.inclusion (finiteModes_le_maxDom c))) := by

  refine essentiallySelfAdjointOn_core_of_farisLavine (finiteModes_le_maxDom c)
    (diagMax c) (diagMax c) 1 0 0 (diagMax_symmetricOn c) (diagMax_symmetricOn c) le_rfl
    (diagMax_quadForm_nonneg c hc) (diagMax_add_one_surjective c hc)
    (fun x => by rw [commForm_self]; simp)
    (fun x => by simp) ?_
  intro x ε hε
  obtain ⟨y, hy1, hy2, hy3⟩ := exists_finiteModes_graph_approx c x ε hε
  exact ⟨y, hy1, hy2, hy3⟩
