-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.sum_pearcyVec
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


theorem BookProof.ChapterNumericalRangeCrouzeix.sum_pearcyVec {A : E →L[ℂ] E} {w : ℂ} {n : ℕ} (hn : 0 < n)
    (hw : IsPrimitiveRoot w n) (z : ℂ) (y : E) :
    ∑ k ∈ Finset.range n, pearcyVec A (w ^ k * z) n y = (n : ℂ) • y := by sorry
