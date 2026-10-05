-- Generated from ChapterCyclicDirectSum.lean — theorem BookProof.ChapterCyclicDirectSum.starProjection_eq_of_hasSum
import Definitions.Def_ChapterCyclicDecomposition
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
open BookProof.ChapterCyclicDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition


theorem BookProof.ChapterCyclicDirectSum.starProjection_eq_of_hasSum {ι : Type*} {V : ι → Submodule ℂ H}
    [∀ i, (V i).HasOrthogonalProjection]
    (hV : OrthogonalFamily ℂ (fun i => (V i)) fun i => (V i).subtypeₗᵢ)
    {c : ι → H} (hc : ∀ i, c i ∈ V i) {v : H} (h : HasSum c v) (j : ι) :
    (V j).starProjection v = c j := by sorry
