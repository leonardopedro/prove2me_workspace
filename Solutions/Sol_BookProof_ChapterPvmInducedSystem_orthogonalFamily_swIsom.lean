-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.orthogonalFamily_swIsom
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_inner_swIsom_eq_zero
open BookProof.ChapterPvmInducedSystem



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {P : Pvm X H} {S : Set H} (hS : OrthCyclicFamily P S) :
    OrthogonalFamily ℂ (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H)))
      (fun ψ : S => swIsom P (ψ : H)) := by

  intro x y hxy u v
  exact inner_swIsom_eq_zero
    (hS.orth (x : H) x.2 (y : H) y.2 (Subtype.coe_injective.ne hxy)) u v
