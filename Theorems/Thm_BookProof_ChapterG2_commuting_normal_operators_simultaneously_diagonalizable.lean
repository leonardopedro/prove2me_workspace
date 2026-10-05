-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.commuting_normal_operators_simultaneously_diagonalizable
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]
variable {A : Type*} [CommRing A] (Q : A)
variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.commuting_normal_operators_simultaneously_diagonalizable
    {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [FiniteDimensional ℂ H]
    {ι : Type*} [Finite ι]
    (T : ι → H →ₗ[ℂ] H) (h_symm : ∀ i, (T i).IsSymmetric)
    (h_comm : ∀ i j, i ≠ j → Commute (T i) (T j)) :
    ⨆ (χ : ι → ℂ), ⨅ i, Module.End.eigenspace (T i) (χ i) = ⊤ := by sorry
