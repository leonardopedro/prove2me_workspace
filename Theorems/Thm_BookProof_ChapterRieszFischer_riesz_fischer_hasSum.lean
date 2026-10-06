-- Generated from ChapterRieszFischer.lean — theorem BookProof.ChapterRieszFischer.riesz_fischer_hasSum
import Mathlib
import Definitions.Def_ChapterRieszFischer
open BookProof.ChapterRieszFischer


open Filter
open scoped ENNReal

theorem BookProof.ChapterRieszFischer.riesz_fischer_hasSum (f : Ell2) :
    HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i)) f := by sorry
