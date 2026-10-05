-- Generated from ChapterSeparableSpectrum.lean — solution of BookProof.ChapterSeparableSpectrum.metrizableSpace_iff_separableSpace_continuousMap
import Mathlib
import Definitions.Def_ChapterSeparableSpectrum
import Theorems.Thm_BookProof_ChapterSeparableSpectrum_metrizableSpace_of_separable_continuousMap
import Theorems.Thm_BookProof_ChapterSeparableSpectrum_separableSpace_continuousMap_of_metrizable
open BookProof.ChapterSeparableSpectrum



noncomputable section

open MeasureTheory TopologicalSpace WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianDirectSum
open BookProof.ChapterStandardBorelClassification

variable (Y : Type*) [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]

set_option maxHeartbeats 1000000 in
theorem solution :
    MetrizableSpace Y ↔ SeparableSpace C(Y, ℂ) :=
  ⟨fun _ => separableSpace_continuousMap_of_metrizable Y,
      fun _ => metrizableSpace_of_separable_continuousMap Y⟩
