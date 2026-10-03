-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.velocityOp_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_velocityOp_isSymmetric
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
noncomputable def continuityHamiltonian (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  -/
  
  /-- The **Weyl-symmetrized continuity generator** `H = ½ (p·v + v·p)` on
  `ℓ
