-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.mem_smul_image_iff
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution (g : G) (E : Set X) (x : X) :
    x ∈ (fun y : X => g • y) '' E ↔ g⁻¹ • x ∈ E := by

  constructor
  · rintro ⟨y, hy, rfl⟩
    simpa [smul_smul] using hy
  · intro h
    exact ⟨g⁻¹ • x, h, by simp [smul_smul]⟩
