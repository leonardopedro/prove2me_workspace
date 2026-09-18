-- Generated from ChapterH6.lean — solution of BookProof.ChapterH6.reduceGenerator_eq_compress_entry
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6



noncomputable section

open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ)
    (V : EuclideanSpace ℂ (Fin m) →L[ℂ] E) (X : E →L[ℂ] E) (i j : Fin m) :
    reduceGenerator m V X i j
      = inner ℂ (EuclideanSpace.single i (1 : ℂ))
          (compress V X (EuclideanSpace.single j (1 : ℂ))) := by

  rw [reduceGenerator, compress]
  simp only [Matrix.of_apply, ContinuousLinearMap.coe_comp', Function.comp_apply]
  exact (ContinuousLinearMap.adjoint_inner_right V _ _).symm
