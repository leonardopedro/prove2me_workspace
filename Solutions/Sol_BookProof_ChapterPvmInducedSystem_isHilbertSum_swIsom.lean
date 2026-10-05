-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.isHilbertSum_swIsom
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_orthogonalFamily_swIsom
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
theorem solution {P : Pvm X H} {S : Set H} (hS : OrthCyclicFamily P S)
    (hdense : Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H)) :
    IsHilbertSum ℂ (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H)))
      (fun ψ : S => swIsom P (ψ : H)) := by

  refine IsHilbertSum.mk (orthogonalFamily_swIsom hS) ?_
  have hsub : Submodule.span ℂ (familyOrbit P S)
      ≤ ⨆ ψ : S, LinearMap.range (swIsom P (ψ : H)).toLinearMap := by
    rw [Submodule.span_le]
    rintro v hv
    obtain ⟨ψ, hψ, hv⟩ := Set.mem_iUnion₂.mp hv
    obtain ⟨E, hE, rfl⟩ := hv
    refine Submodule.mem_iSup_of_mem ⟨ψ, hψ⟩ ?_
    exact ⟨indicatorConstLp 2 hE (measure_ne_top (pvmMeasure P ψ) E) (1 : ℂ),
      swCLM_indicator P ψ hE⟩
  intro v _
  have hv : v ∈ closure ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H) :=
    hdense v
  have hmono : closure ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H)
      ⊆ closure ((⨆ ψ : S, LinearMap.range (swIsom P (ψ : H)).toLinearMap : Submodule ℂ H) :
        Set H) := closure_mono (fun w hw => hsub hw)
  have := hmono hv
  rwa [← Submodule.topologicalClosure_coe] at this
