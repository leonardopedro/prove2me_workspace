-- Generated from ChapterG.lean — theorem BookProof.ChapterG.swap_mem_gaugeGroup
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.swap_mem_gaugeGroup {X Y : Type*} [DecidableEq X] {π : X → Y}
    {x x' : X} (h : π x = π x') :
    Equiv.swap x x' ∈ gaugeGroup π := by sorry
