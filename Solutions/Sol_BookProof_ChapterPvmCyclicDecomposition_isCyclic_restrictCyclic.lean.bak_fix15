-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.isCyclic_restrictCyclic
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_mem_cyclicSubspace_self
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_image_orbit_restrictCyclic
open BookProof.ChapterPvmCyclicDecomposition



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (P : Pvm X H) (ψ : H) :
    IsCyclic (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩ := by

  have hmap : Submodule.map (cyclicSubspace P ψ).subtype
      (Submodule.span ℂ (pvmOrbit (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩))
      = Submodule.span ℂ (pvmOrbit P ψ) := by
    rw [Submodule.map_span, Submodule.coe_subtype, image_orbit_restrictCyclic]
  intro x
  rw [Metric.mem_closure_iff]
  intro ε hε
  have hx : (x : H) ∈ closure ((Submodule.span ℂ (pvmOrbit P ψ) : Submodule ℂ H) : Set H) := by
    have hx2 : (x : H) ∈
        (((Submodule.span ℂ (pvmOrbit P ψ)).topologicalClosure : Submodule ℂ H) : Set H) := x.2
    rwa [Submodule.topologicalClosure_coe] at hx2
  obtain ⟨y, hy, hdist⟩ := Metric.mem_closure_iff.mp hx ε hε
  rw [← hmap] at hy
  obtain ⟨z, hz, rfl⟩ := hy
  refine ⟨z, hz, ?_⟩
  rw [Subtype.dist_eq]
  exact hdist
