-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.reduceGenerator_eq_compress_entry
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {m : ℕ}


noncomputable section

open Filter Topology

theorem BookProof.ChapterH6.reduceGenerator_eq_compress_entry (m : ℕ)
    (V : EuclideanSpace ℂ (Fin m) →L[ℂ] E) (X : E →L[ℂ] E) (i j : Fin m) :
    reduceGenerator m V X i j
      = inner ℂ (EuclideanSpace.single i (1 : ℂ))
          (compress V X (EuclideanSpace.single j (1 : ℂ))) := by sorry
