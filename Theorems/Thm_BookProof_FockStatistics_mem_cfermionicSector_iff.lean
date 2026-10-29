-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.mem_cfermionicSector_iff
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterWignerOrbitClassification
open BookProof.TensorCore
open BookProof.ChapterWignerLittleGroup



open BookProof.ReducedEsa

noncomputable section

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)

theorem BookProof.FockStatistics.mem_cfermionicSector_iff (n : ℕ) {x : fockSector Hs n} :
    x ∈ sector (cfermionicProj Hs n) ↔ ∀ σ : Equiv.Perm (Fin n), (csignRep Hs n).act σ x = x := by sorry
