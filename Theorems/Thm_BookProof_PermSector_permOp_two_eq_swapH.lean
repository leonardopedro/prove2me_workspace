-- Generated from ChapterPermutationSectorEsa.lean — theorem BookProof.PermSector.permOp_two_eq_swapH
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterTensorGraphCore
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.TensorCore
open BookProof.PermSector

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

theorem BookProof.PermSector.permOp_two_eq_swapH (x : (Hs.pow 2).carrier) :
    permOp Hs 2 (Equiv.swap 0 1) x = BookProof.TwoParticleSector.swapH Hs x := by sorry
