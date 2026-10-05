-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.exists_ne_zero_hfermionicFockDom
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier)



open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

theorem BookProof.FockStatistics.exists_ne_zero_hfermionicFockDom (n : ℕ) (f : Fin n → Hs.carrier)
    (hfD : ∀ i, f i ∈ D) (hf0 : ∀ i, f i ≠ 0)
    (hortho : ∀ i j, i ≠ j → (inner ℂ (f i) (f j) : ℂ) = 0) :
    ∃ x : hfermionicFockDom Hs D, x ≠ 0 := by sorry
