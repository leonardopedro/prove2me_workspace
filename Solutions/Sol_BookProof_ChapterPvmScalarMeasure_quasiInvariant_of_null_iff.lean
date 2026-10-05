-- Generated from ChapterPvmScalarMeasure.lean — solution of BookProof.ChapterPvmScalarMeasure.quasiInvariant_of_null_iff
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
import Theorems.Thm_BookProof_ChapterPvmScalarMeasure_p_image_eq_zero
open BookProof.ChapterPvmScalarMeasure



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {G : Type*} [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (T : ContinuousImprimitivitySystem G X H)
    {μ : Measure X} (hnull : ∀ E : Set X, MeasurableSet E → (μ E = 0 ↔ T.P.p E = 0)) :
    QuasiInvariant μ G := by

  refine ⟨T.measurable, fun g => ?_⟩
  refine Measure.AbsolutelyContinuous.mk fun E hE hzero => ?_
  have hpre : (fun x : X => g • x) ⁻¹' E = (fun x => g⁻¹ • x) '' E := by
    ext x
    constructor
    · intro hx
      exact ⟨g • x, hx, by simp [smul_smul]⟩
    · rintro ⟨y, hy, rfl⟩
      simpa [smul_smul] using hy
  have hmeas : MeasurableSet ((fun x : X => g⁻¹ • x) '' E) := by
    rw [← hpre]
    exact hE.preimage (T.measurable g)
  rw [Measure.map_apply (T.measurable g) hE, hpre]
  refine (hnull _ hmeas).mpr ?_
  exact p_image_eq_zero T g⁻¹ hE ((hnull E hE).mp hzero)
