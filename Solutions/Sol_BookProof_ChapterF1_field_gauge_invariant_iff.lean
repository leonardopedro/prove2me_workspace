-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.field_gauge_invariant_iff
import Mathlib
import Definitions.Def_ChapterF1
import Theorems.Thm_BookProof_ChapterG2_brst_physical_iff_gauge_invariant
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (Q : ℂ[X]) (a : ℂ[X]) :
    (![a, 0] ∈ BookProof.ChapterG2.brstKer Q) ↔ Q * a = 0 := BookProof.ChapterG2.brst_physical_iff_gauge_invariant Q a
