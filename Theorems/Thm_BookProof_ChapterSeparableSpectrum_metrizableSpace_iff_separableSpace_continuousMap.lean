-- Generated from ChapterSeparableSpectrum.lean — theorem BookProof.ChapterSeparableSpectrum.metrizableSpace_iff_separableSpace_continuousMap
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterAbelianDirectSum
import Definitions.Def_ChapterStandardBorelClassification
import Mathlib
import Definitions.Def_ChapterSeparableSpectrum
open BookProof.ChapterSeparableSpectrum

variable (Y : Type*) [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]


noncomputable section

open MeasureTheory TopologicalSpace WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianDirectSum
open BookProof.ChapterStandardBorelClassification

theorem BookProof.ChapterSeparableSpectrum.metrizableSpace_iff_separableSpace_continuousMap :
    MetrizableSpace Y ↔ SeparableSpace C(Y, ℂ) := by sorry
