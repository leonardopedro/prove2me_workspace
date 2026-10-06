-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.hasDerivAt_duhamel
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open NormedSpace



theorem BookProof.BrstLeakage.hasDerivAt_duhamel (X Y : E →L[ℂ] E) (t s : ℝ) (x : E) :
    HasDerivAt (fun u : ℝ => (exp ((t - u) • X)) ((exp (u • Y)) x))
      ((exp ((t - s) • X)) ((Y - X) ((exp (s • Y)) x))) s := by sorry
