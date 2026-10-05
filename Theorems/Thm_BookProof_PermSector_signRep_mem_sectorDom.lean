-- Generated from ChapterPermutationSectorEsa.lean — theorem BookProof.PermSector.signRep_mem_sectorDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.TensorCore
open BookProof.ChapterWignerLittleGroup
open BookProof.PermSector

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

theorem BookProof.PermSector.signRep_mem_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorDom Hs D₂ n) : (signRep Hs n).act σ x ∈ sectorDom Hs D₂ n := by sorry
