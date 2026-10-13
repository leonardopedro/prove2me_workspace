-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.good_refl
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
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

theorem solution (n : ℕ) :
    Good Hs D₂ A D n (LinearIsometryEquiv.refl ℂ _) (LinearIsometryEquiv.refl ℂ _) where
  incl _ := rfl
  der _ := rfl
  core _ ht := ht
