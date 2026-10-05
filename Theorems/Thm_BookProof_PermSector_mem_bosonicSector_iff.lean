-- Generated from ChapterPermutationSectorEsa.lean — theorem BookProof.PermSector.mem_bosonicSector_iff
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterMaschkeFiniteGroup
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.TensorCore
open BookProof.ChapterWignerLittleGroup
open BookProof.PermSector

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

theorem BookProof.PermSector.mem_bosonicSector_iff (n : ℕ) {x : (Hs.pow n).carrier} :
    x ∈ sector (bosonicProj Hs n) ↔ ∀ σ : Equiv.Perm (Fin n), permOp Hs n σ x = x := by sorry
