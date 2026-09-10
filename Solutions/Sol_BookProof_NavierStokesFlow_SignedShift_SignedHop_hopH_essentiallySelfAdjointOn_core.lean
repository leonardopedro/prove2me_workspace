-- Generated from ChapterNavierStokesSignedShift.lean — solution of BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_hopH_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_hopH_relative_bound
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_hopH_commForm_bound
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift
open BookProof.NavierStokesFlow.SignedShift.SignedHop










open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.AffineFiber

variable {ι : Type*}



variable {sym : ι → ℝ} (S : SignedHop ι sym)

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((hopH S).comp (Submodule.inclusion (finiteModes_le_maxDom sym))) :=
  essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds sym
      (fun β => le_trans zero_le_one (S.sym_ge_one β))
      (hopH S) (1 / 2) (8 * S.K ^ 2) (2 * S.step * (1 / 4 + S.K))
      (hopH_symmetricOn S) (by nlinarith [S.step_nonneg, S.K_nonneg])
      (hopH_relative_bound S) (hopH_commForm_bound S)
