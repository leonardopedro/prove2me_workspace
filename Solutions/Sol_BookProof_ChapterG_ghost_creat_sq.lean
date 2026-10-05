-- Generated from ChapterG.lean — solution of BookProof.ChapterG.ghost_creat_sq
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]

set_option maxHeartbeats 1000000 in
theorem solution : ghostCreat * ghostCreat = (0 : Matrix (Fin 2) (Fin 2) A) := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostCreat, Matrix.mul_apply, Fin.sum_univ_two]
