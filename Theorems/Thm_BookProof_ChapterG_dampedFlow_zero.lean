-- Generated from ChapterG.lean — theorem BookProof.ChapterG.dampedFlow_zero
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.dampedFlow_zero (M : Matrix (Fin 4) (Fin 4) ℝ) :
    NormedSpace.exp ((0 : ℝ) • M) = 1 := by sorry
