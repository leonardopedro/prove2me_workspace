-- Generated from ChapterG.lean — theorem BookProof.ChapterG.exists_complete_gaugeFixing
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.exists_complete_gaugeFixing {X Y : Type*} {π : X → Y}
    (hπ : Function.Surjective π) :
    ∃ S : Set X, IsCompleteGaugeFixing π S ∧ π '' S = Set.univ := by sorry
