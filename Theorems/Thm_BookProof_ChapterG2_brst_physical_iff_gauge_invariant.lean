-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.brst_physical_iff_gauge_invariant
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω]
variable {A : Type*} [CommRing A] (Q : A)

theorem BookProof.ChapterG2.brst_physical_iff_gauge_invariant (a : A) :
    (![a, 0] ∈ brstKer Q) ↔ Q * a = 0 := by sorry
