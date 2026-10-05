-- Generated from ChapterPermutationSectorEsa.lean — theorem BookProof.PermSector.good_swap0
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.PermSector

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

theorem BookProof.PermSector.good_swap0 : ∀ (n : ℕ) (p : Fin (n + 1)),
    Good Hs D₂ A D (n + 1) (swap0 (domSpace Hs D₂) (n + 1) p) (swap0 Hs (n + 1) p) := by sorry
