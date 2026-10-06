-- Generated from ChapterPaFreeCompletion.lean — theorem riesz_fischer
import Mathlib
import Definitions.Def_ChapterPaFreeCompletion
import Definitions.Def_ChapterRieszFischer
import Definitions.Def_ChapterA4
open BookProof.ChapterRieszFischer


open Set
open Filter
open BookProof.ChapterRieszFischer

theorem riesz_fischer :
    CompleteSpace Ell2 ∧
      ∀ f : Ell2, HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i)) f := by sorry
