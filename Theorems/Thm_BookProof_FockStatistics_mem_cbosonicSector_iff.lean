-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.mem_cbosonicSector_iff
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterGroupAverageEsa
open BookProof.TensorCore
open BookProof.ChapterWignerLittleGroup
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)



open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

theorem BookProof.FockStatistics.mem_cbosonicSector_iff (n : ℕ) {x : fockSector Hs n} :
    x ∈ sector (cbosonicProj Hs n) ↔ ∀ σ : Equiv.Perm (Fin n), (cpermRep Hs n).act σ x = x := by sorry
