-- Generated from ChapterG.lean — theorem BookProof.ChapterG.BRST_nilpotent
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.BRST_nilpotent (Q : A) : BRST Q * BRST Q = (0 : Matrix (Fin 2) (Fin 2) A) := by sorry
