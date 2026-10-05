-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.free_remnant_moves_every_point
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3

variable {X : Type*}


open MeasureTheory
open scoped ENNReal




theorem BookProof.ChapterG3.free_remnant_moves_every_point {G Y : Type*} [Group G] [MulAction G Y]
    (hfree : ∀ (g : G) (y : Y), g • y = y → g = 1) {g : G} (hg : g ≠ 1) (y : Y) :
    g • y ≠ y := by sorry
