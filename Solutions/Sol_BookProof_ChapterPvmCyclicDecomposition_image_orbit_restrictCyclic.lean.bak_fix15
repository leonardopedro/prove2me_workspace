-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.image_orbit_restrictCyclic
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_mem_cyclicSubspace_self
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_restrictCyclic_apply
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
    (Subtype.val '' pvmOrbit (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩)
      = pvmOrbit P ψ := by

  ext y
  constructor
  · rintro ⟨z, ⟨E, hE, rfl⟩, rfl⟩
    exact ⟨E, hE, restrictCyclic_apply P ψ hE _⟩
  · rintro ⟨E, hE, rfl⟩
    exact ⟨(restrictCyclic P ψ).p E ⟨ψ, mem_cyclicSubspace_self P ψ⟩, ⟨E, hE, rfl⟩,
      restrictCyclic_apply P ψ hE _⟩
