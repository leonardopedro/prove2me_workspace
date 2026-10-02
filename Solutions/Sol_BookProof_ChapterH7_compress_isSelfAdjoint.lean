-- Generated from ChapterH7.lean — solution of BookProof.ChapterH7.compress_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterH7
open BookProof.ChapterH7



noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E) (hX : IsSelfAdjoint X) :
    IsSelfAdjoint (compress V X) := by

  have hadj : ContinuousLinearMap.adjoint X = X :=
    (ContinuousLinearMap.star_eq_adjoint X).symm.trans hX
  have hstar : star (compress V X) = compress V X := by
    rw [ContinuousLinearMap.star_eq_adjoint, compress, ContinuousLinearMap.adjoint_comp,
      ContinuousLinearMap.adjoint_comp, ContinuousLinearMap.adjoint_adjoint, hadj,
      ContinuousLinearMap.comp_assoc]
  exact hstar
