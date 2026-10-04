-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.faithful_remnant_nontrivial
import Mathlib
import Definitions.Def_ChapterG3
import Definitions.Def_ChapterA4
open BookProof.ChapterG3

variable {X : Type*}


open MeasureTheory
open scoped ENNReal




theorem BookProof.ChapterG3.faithful_remnant_nontrivial {G Y : Type*} [Group G] [MulAction G Y]
    [FaithfulSMul G Y] [Nontrivial G] : ∃ (g : G) (y : Y), g • y ≠ y := by sorry
