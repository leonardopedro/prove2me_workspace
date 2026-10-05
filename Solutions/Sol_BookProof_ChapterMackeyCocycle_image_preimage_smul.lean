-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.image_preimage_smul
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (g : G) (F : Set X) :
    (fun x : X => g • x) '' ((fun x : X => g • x) ⁻¹' F) = F := by

  ext y
  constructor
  · rintro ⟨x, hx, rfl⟩
    exact hx
  · intro hy
    exact ⟨g⁻¹ • y, by simpa [smul_smul] using hy, by simp [smul_smul]⟩
