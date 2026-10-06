-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.hasAdLambda_sum
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.hasAdLambda_sum {ι : Type*} (s : Finset ι)
    (G A : ι → Matrix (Fin 4) (Fin 4) ℝ) (h : ∀ i ∈ s, HasAdLambda (G i) (A i)) :
    HasAdLambda (∑ i ∈ s, G i) (∑ i ∈ s, A i) := by sorry
