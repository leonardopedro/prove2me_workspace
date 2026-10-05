-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.range_swIsom
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_swCLM_mem_cyclicSubspace
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
theorem solution (P : Pvm X H) (ψ : H) :
    LinearMap.range (swIsom P ψ).toLinearMap = cyclicSubspace P ψ := by

  refine le_antisymm ?_ ?_
  · rintro _ ⟨f, rfl⟩
    exact swCLM_mem_cyclicSubspace P ψ f
  · have hclosed : IsClosed (Set.range (swIsom P ψ)) :=
      (swIsom P ψ).isometry.isClosedEmbedding.isClosed_range
    have hle : (Submodule.span ℂ (pvmOrbit P ψ))
        ≤ LinearMap.range (swIsom P ψ).toLinearMap := by
      refine Submodule.span_le.mpr ?_
      rintro _ ⟨E, hE, rfl⟩
      exact ⟨indicatorConstLp 2 hE (measure_ne_top (pvmMeasure P ψ) E) (1 : ℂ),
        swCLM_indicator P ψ hE⟩
    intro v hv
    have hv' : v ∈ closure ((Submodule.span ℂ (pvmOrbit P ψ) : Submodule ℂ H) : Set H) := by
      have : v ∈ (((Submodule.span ℂ (pvmOrbit P ψ)).topologicalClosure : Submodule ℂ H) :
          Set H) := hv
      rwa [Submodule.topologicalClosure_coe] at this
    exact closure_minimal (fun w hw => hle hw) hclosed hv'
