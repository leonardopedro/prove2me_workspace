-- Generated from ChapterCyclicDecomposition.lean — solution of BookProof.ChapterCyclicDecomposition.cyclicSubspace_le_orthogonal
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
import Theorems.Thm_BookProof_ChapterCyclicDecomposition_invariant_orthogonal
open BookProof.ChapterCyclicDecomposition



noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

set_option maxHeartbeats 1000000 in
theorem solution {M : Submodule ℂ H} (hM : Invariant T hT M) {v : H}
    (hv : v ∈ Mᗮ) : cyclicSubspace T hT v ≤ Mᗮ := by

  refine Submodule.topologicalClosure_minimal _ (Submodule.span_le.mpr ?_)
    (Submodule.isClosed_orthogonal M)
  rintro _ ⟨g, rfl⟩
  exact invariant_orthogonal T hT hM g v hv
