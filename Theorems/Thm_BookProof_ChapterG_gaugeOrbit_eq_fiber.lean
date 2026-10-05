-- Generated from ChapterG.lean — theorem BookProof.ChapterG.gaugeOrbit_eq_fiber
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.gaugeOrbit_eq_fiber {X Y : Type*} (π : X → Y) (x : X) :
    MulAction.orbit (gaugeGroup π) x = π ⁻¹' {π x} := by sorry
