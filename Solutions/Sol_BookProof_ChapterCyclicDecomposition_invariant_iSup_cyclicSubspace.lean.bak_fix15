-- Generated from ChapterCyclicDecomposition.lean — solution of BookProof.ChapterCyclicDecomposition.invariant_iSup_cyclicSubspace
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
import Theorems.Thm_BookProof_ChapterCyclicDecomposition_invariant_cyclicSubspace
open BookProof.ChapterCyclicDecomposition



noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

set_option maxHeartbeats 1000000 in
theorem solution (S : Set H) :
    Invariant T hT (⨆ x ∈ S, cyclicSubspace T hT x).topologicalClosure := by

  intro g v hv
  have hle : (⨆ x ∈ S, cyclicSubspace T hT x)
      ≤ ((⨆ x ∈ S, cyclicSubspace T hT x).topologicalClosure).comap
          (cfcHom hT g).toLinearMap := by
    refine iSup_le fun x => iSup_le fun hx => ?_
    intro w hw
    simp only [Submodule.mem_comap, ContinuousLinearMap.coe_coe]
    refine Submodule.le_topologicalClosure _ ?_
    have : cfcHom hT g w ∈ cyclicSubspace T hT x :=
      invariant_cyclicSubspace T hT x g w hw
    exact le_iSup₂ (f := fun x (_ : x ∈ S) => cyclicSubspace T hT x) x hx this
  have hclosed : IsClosed
      (((⨆ x ∈ S, cyclicSubspace T hT x).topologicalClosure).comap
        (cfcHom hT g).toLinearMap : Set H) :=
    (Submodule.isClosed_topologicalClosure _).preimage (cfcHom hT g).continuous
  exact Submodule.topologicalClosure_minimal _ hle hclosed hv
