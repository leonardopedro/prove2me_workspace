-- Generated from ChapterG2.lean — solution of BookProof.ChapterG2.brstIm_le_brstKer
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG
open BookProof.ChapterG2



open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω]
variable {A : Type*} [CommRing A] (Q : A)

set_option maxHeartbeats 1000000 in
theorem solution : brstIm Q ≤ brstKer Q := by

  intro v hv; simp_all [ brstIm, brstKer,BRST ] ;
  rcases hv with ⟨ y, rfl ⟩ ; simp [ Matrix.vecHead ]
