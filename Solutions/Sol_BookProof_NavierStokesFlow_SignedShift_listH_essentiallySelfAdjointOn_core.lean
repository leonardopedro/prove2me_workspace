-- Generated from ChapterNavierStokesSignedShift.lean — solution of BookProof.NavierStokesFlow.SignedShift.listH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_listH_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_listH_relative_bound
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_listH_commForm_bound
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift










open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.AffineFiber

variable {ι : Type*}



variable {sym : ι → ℝ} (S : SignedHop ι sym)


































variable {sym : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (L : List (SignedHop ι sym)) (hsym : ∀ β, 1 ≤ sym β) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((listH L).comp (Submodule.inclusion (finiteModes_le_maxDom sym))) := by

  obtain ⟨a, b, _, _, hrel⟩ := listH_relative_bound L
  obtain ⟨cst, hcst, hcomm⟩ := listH_commForm_bound L hsym
  exact essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds sym
    (fun β => le_trans zero_le_one (hsym β)) (listH L) a b cst
    (listH_symmetricOn L) hcst hrel hcomm
