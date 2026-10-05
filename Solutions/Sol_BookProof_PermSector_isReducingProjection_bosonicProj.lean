-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.isReducingProjection_bosonicProj
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_isReducingProjection_avgProj
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : IsReducingProjection (bosonicProj Hs n) := (permRep Hs n).isReducingProjection_avgProj
