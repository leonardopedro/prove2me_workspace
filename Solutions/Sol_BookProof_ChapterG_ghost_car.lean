-- Generated from ChapterG.lean — solution of BookProof.ChapterG.ghost_car
import Mathlib
import Definitions.Def_ChapterG
open MeasureTheory
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]

set_option maxHeartbeats 1000000 in
theorem solution :
    ghostAnnih * ghostCreat + ghostCreat * ghostAnnih = (1 : Matrix (Fin 2) (Fin 2) A) := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostAnnih, ghostCreat]
