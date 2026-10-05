-- Generated from ChapterG.lean — theorem BookProof.ChapterG.dampedFlow_add
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.dampedFlow_add (M : Matrix (Fin 4) (Fin 4) ℝ) (s t : ℝ) :
    NormedSpace.exp ((s + t) • M) = NormedSpace.exp (s • M) * NormedSpace.exp (t • M) := by sorry
