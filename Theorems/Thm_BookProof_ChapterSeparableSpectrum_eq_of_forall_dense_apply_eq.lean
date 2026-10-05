-- Generated from ChapterSeparableSpectrum.lean — theorem BookProof.ChapterSeparableSpectrum.eq_of_forall_dense_apply_eq
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

theorem BookProof.ChapterSeparableSpectrum.eq_of_forall_dense_apply_eq {D : Set C(Y, ℂ)} (hD : Dense D) {y₁ y₂ : Y}
    (h : ∀ d ∈ D, (d : C(Y, ℂ)) y₁ = d y₂) : y₁ = y₂ := by sorry
