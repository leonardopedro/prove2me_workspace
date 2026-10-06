-- Generated from ChapterRieszFischer.lean — solution of BookProof.ChapterRieszFischer.riesz_fischer_hasSum
import Mathlib
import Definitions.Def_ChapterRieszFischer
open BookProof.ChapterRieszFischer



open Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (f : Ell2) :
    HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i)) f := lp.hasSum_single (by simp) f
