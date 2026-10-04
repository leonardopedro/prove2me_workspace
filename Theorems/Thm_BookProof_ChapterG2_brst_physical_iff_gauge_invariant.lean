-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.brst_physical_iff_gauge_invariant
import Mathlib
import Definitions.Def_ChapterG2
import Definitions.Def_ChapterA4
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]
variable {A : Type*} [CommRing A] (Q : A)


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.brst_physical_iff_gauge_invariant (a : A) :
    (![a, 0] ∈ brstKer Q) ↔ Q * a = 0 := by sorry
