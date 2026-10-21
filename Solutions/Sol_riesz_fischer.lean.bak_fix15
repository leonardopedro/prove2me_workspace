-- Generated from ChapterPaFreeCompletion.lean — solution of riesz_fischer
import Mathlib
import Definitions.Def_ChapterPaFreeCompletion
import Theorems.Thm_BookProof_ChapterRieszFischer_ell2_completeSpace
import Theorems.Thm_BookProof_ChapterRieszFischer_riesz_fischer_hasSum



open Set
open Filter
open BookProof.ChapterRieszFischer

set_option maxHeartbeats 1000000 in
theorem solution :
    CompleteSpace Ell2 ∧
      ∀ f : Ell2, HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i)) f := ⟨ell2_completeSpace, riesz_fischer_hasSum⟩
