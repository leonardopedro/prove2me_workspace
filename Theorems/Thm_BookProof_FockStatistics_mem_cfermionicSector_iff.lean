-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.mem_cfermionicSector_iff
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterA4
open BookProof.TensorCore
open BookProof.ChapterWignerLittleGroup
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)



open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

theorem BookProof.FockStatistics.mem_cfermionicSector_iff (n : ℕ) {x : fockSector Hs n} :
    x ∈ sector (cfermionicProj Hs n) ↔ ∀ σ : Equiv.Perm (Fin n), (csignRep Hs n).act σ x = x := by sorry
