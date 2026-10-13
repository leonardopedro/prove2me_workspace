-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.isReducingProjection_bosonicProj
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_isReducingProjection_avgProj
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterTensorGraphCore
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm
open BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : IsReducingProjection (bosonicProj Hs n) := (permRep Hs n).isReducingProjection_avgProj
