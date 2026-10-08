-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.faithful_remnant_nontrivial
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3


open MeasureTheory
open scoped ENNReal



variable {X : Type*}


theorem BookProof.ChapterG3.faithful_remnant_nontrivial {G Y : Type*} [Group G] [MulAction G Y]
    [FaithfulSMul G Y] [Nontrivial G] : ∃ (g : G) (y : Y), g • y ≠ y := by sorry
